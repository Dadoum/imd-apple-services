import std.base64;
import std.net.curl;

import slf4d;

import corefoundation;
import dyldlibrary;

alias NACInit_t = extern(C) int function(const void* cert_bytes, int cert_len, ubyte** out_validation_ctx,
	void **out_request_bytes, int *out_request_len);
alias NACKeyEstablishment_t = extern(C) int function(void* validation_ctx, void* response_bytes, int response_len);
alias NACSign_t = extern(C) int function(void* validation_ctx, void* unk_bytes, int unk_len,
	ubyte** validation_data, int* validation_data_len);
alias NACFree_t = extern(C) int function(void* ptr);
alias NACCleanup_t = extern(C) int function(void* ptr);

extern (C) {
	version (CMake) {
		int NACInit(NACInit_t func, const void* cert_bytes, int cert_len, ubyte** out_validation_ctx, void **out_request_bytes, int *out_request_len);
		int NACKeyEstablishment(NACKeyEstablishment_t func, void* validation_ctx, void* response_bytes, int response_len);
		int NACSign(NACSign_t func, void* validation_ctx, void* unk_bytes, int unk_len, ubyte** validation_data, int* validation_data_len);
		int NACFree(NACFree_t func, void *ptr);
		int NACCleanup(NACCleanup_t func, void *ptr);
	} else {
		version(Windows) {
			static assert(false, "Use CMake for Windows support.");
		}

		int NACInit(NACInit_t func, const void* cert_bytes, int cert_len, ubyte** out_validation_ctx, void **out_request_bytes, int *out_request_len) { return func(__traits(parameters)[1..$]); }
		int NACKeyEstablishment(NACKeyEstablishment_t func, void* validation_ctx, void* response_bytes, int response_len) { return func(__traits(parameters)[1..$]); }
		int NACSign(NACSign_t func, void* validation_ctx, void* unk_bytes, int unk_len, ubyte** validation_data, int* validation_data_len) { return func(__traits(parameters)[1..$]); }
		int NACFree(NACFree_t func, void *ptr) { return func(__traits(parameters)[1..$]); }
		int NACCleanup(NACCleanup_t func, void *ptr) { return func(__traits(parameters)[1..$]); }
	}
}

void main(string[] args)
{
	import slf4d.default_provider;
	auto provider = new shared DefaultProvider(true, Levels.TRACE);
	configureLoggingProvider(provider);

	DyldLibrary lib = new DyldLibrary("./IMDAppleServices");
	auto nacInit = cast(NACInit_t) (lib.allocation.ptr + 0xB1DB0);
	auto nacKeyEstablishment = cast(NACKeyEstablishment_t) (lib.allocation.ptr + 0xB1DD0);
	auto nacSign = cast(NACSign_t) (lib.allocation.ptr + 0xB1DF0);
	auto nacFree = cast(NACFree_t) (lib.allocation.ptr + 0xB1E10);
	auto nacCleanup = cast(NACCleanup_t) (lib.allocation.ptr + 0xB1E30);

	HTTP conn = HTTP();
	conn.handle.set(CurlOption.ssl_verifypeer, 0);
	conn.addRequestHeader("Content-Type", "application/x-apple-plist");
	conn.addRequestHeader("User-Agent", "CFNetwork/1404.0.5 Darwin/22.3.0");

	auto certPlistStr = get("http://static.ess.apple.com/identity/validation/cert-1.0.plist", conn);
	auto certPlistData = CFDataCreate(null, cast(const(ubyte)*) certPlistStr.ptr, cast(CFIndex) certPlistStr.length);
	scope(exit) CFRelease(certPlistData);
	auto certPlist = cast(CFDictionaryRef) CFPropertyListCreateWithData(null, certPlistData, CFPropertyListMutabilityOptions.kCFPropertyListImmutable, null, null);
	scope(exit) CFRelease(certPlist);
	auto cert = cast(CFDataRef) CFDictionaryGetValue(certPlist, CFSTR!("cert"));
	auto dataPtr = CFDataGetBytePtr(cert);
	auto dataLength = CFDataGetLength(cert);

	ubyte* validation_ctx;
	void* request_bytes;
	int request_len;
	// getLogger().debugF!"nacInit: %d"(tchak(dataPtr, cast(int) dataLength, &validation_ctx, &request_bytes, &request_len));
	import std.traits;
	getLogger().debugF!"nacInit: %d"(nacInit(dataPtr, cast(int) dataLength, &validation_ctx, &request_bytes, &request_len));
	scope(exit) nacFree(request_bytes);
	scope(exit) nacCleanup(validation_ctx);

	auto secondRequest = CFDictionaryCreateMutable(
		kCFAllocatorDefault,
		0,
		&kCFTypeDictionaryKeyCallBacks,
		&kCFTypeDictionaryValueCallBacks
	);
	scope(exit) CFRelease(secondRequest);
	CFDictionaryAddValue(secondRequest, CFSTR!"session-info-request", CFDataCreate(null, cast(const(ubyte)*) request_bytes, cast(long) request_len));
	auto secondRequestPlist = CFStringCreateFromExternalRepresentation(null, CFPropertyListCreateXMLData(null, secondRequest), CFStringBuiltInEncodings.kCFStringEncodingUTF8);
	scope(exit) CFRelease(secondRequestPlist);

	auto str = cast(string) post(
		"https://identity.ess.apple.com/WebObjects/TDIdentityService.woa/wa/initializeValidation",
		secondRequestPlist.toString(),
		conn
	);

	auto sessionPlistData = CFDataCreate(null, cast(const(ubyte)*) str.ptr, cast(CFIndex) str.length);
	scope(exit) CFRelease(sessionPlistData);
	auto sessionPlist = cast(CFDictionaryRef) CFPropertyListCreateWithData(null, sessionPlistData, CFPropertyListMutabilityOptions.kCFPropertyListImmutable, null, null);
	scope(exit) CFRelease(sessionPlist);
	auto session = cast(CFDataRef) CFDictionaryGetValue(sessionPlist, CFSTR!("session-info"));
	auto sessionPtr = CFDataGetBytePtr(session);
	auto sessionLength = CFDataGetLength(session);

	getLogger().debugF!"nacSubmit: %d"(nacKeyEstablishment(validation_ctx, cast(void*) sessionPtr, cast(int) sessionLength));

	ubyte* validationPtr;
	int validationLength;
	getLogger().debugF!"nacSign: %d"(nacSign(validation_ctx, null, 0, &validationPtr, &validationLength));
	scope(exit) nacFree(validationPtr);

	getLogger().infoF!"validation data: %s"(Base64.encode(validationPtr[0..validationLength]));
	// getLogger().infoF!"validation context: %s"(Base64.encode(validation_ctx[0..824]));
}
