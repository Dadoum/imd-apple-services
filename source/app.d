import std.base64;
import std.net.curl;

import slf4d;

import corefoundation;
import dyldlibrary;

alias NACInit_t = extern(C) int function(const void* cert_bytes, int cert_len, ubyte** out_validation_ctx,
	ubyte **out_request_bytes, int *out_request_len);
alias NACKeyEstablishment_t = extern(C) int function(void* validation_ctx, void* response_bytes, int response_len);
alias NACSign_t = extern(C) int function(void* validation_ctx, void* unk_bytes, int unk_len,
	ubyte** validation_data, int* validation_data_len);
alias NACFree_t = extern(C) int function(void* ptr);
alias NACCleanup_t = extern(C) int function(void* ptr);

extern (C) {
	version (CMake) {
		int NACInit(NACInit_t func, const void* cert_bytes, int cert_len, ubyte** out_validation_ctx, ubyte **out_request_bytes, int *out_request_len);
		int NACKeyEstablishment(NACKeyEstablishment_t func, void* validation_ctx, void* response_bytes, int response_len);
		int NACSign(NACSign_t func, void* validation_ctx, void* unk_bytes, int unk_len, ubyte** validation_data, int* validation_data_len);
		int NACFree(NACFree_t func, void *ptr);
		int NACCleanup(NACCleanup_t func, void *ptr);
	} else {
		version(Windows) {
			static assert(false, "Use CMake for Windows support.");
		}

		int NACInit(NACInit_t func, const void* cert_bytes, int cert_len, ubyte** out_validation_ctx, ubyte **out_request_bytes, int *out_request_len) { return func(__traits(parameters)[1..$]); }
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

	import std.stdio;
	auto log = getLogger();
	stdout.flush();

	HTTP conn = HTTP();
	conn.handle.set(CurlOption.ssl_verifypeer, 0);
	conn.addRequestHeader("Content-Type", "application/x-apple-plist");
	conn.addRequestHeader("User-Agent", "CFNetwork/1404.0.5 Darwin/22.3.0");

	log.trace("Requesting certificate to Apple...");
	stdout.flush();
	auto certPlistStr = get("http://static.ess.apple.com/identity/validation/cert-1.0.plist", conn);
	import plist;
	log.trace("Parsing it...");
	stdout.flush();
	auto certPlist = Plist.fromMemory(cast(ubyte[]) certPlistStr).dict();
	auto cert = certPlist["cert"].data().native();
	auto dataPtr = cert.ptr;
	auto dataLength = cert.length;
	log.trace("Parsed it.");
	stdout.flush();

	ubyte* validation_ctx;
	ubyte* request_bytes;
	int request_len;
	// getLogger().debugF!"nacInit: %d"(tchak(dataPtr, cast(int) dataLength, &validation_ctx, &request_bytes, &request_len));
	import std.traits;
	log.debugF!"nacInit: %d"(nacInit(dataPtr, cast(int) dataLength, &validation_ctx, &request_bytes, &request_len));
	stdout.flush();
	scope(exit) nacFree(request_bytes);
	scope(exit) nacCleanup(validation_ctx);

	auto secondRequest = new PlistDict();
	secondRequest["session-info-request"] = request_bytes[0..request_len].pl;
	auto secondRequestPlist = secondRequest.toXml();

	auto response1 = cast(ubyte[]) post(
		"https://identity.ess.apple.com/WebObjects/TDIdentityService.woa/wa/initializeValidation",
		secondRequestPlist,
		conn
	);

	auto sessionPlist = Plist.fromMemory(response1).dict();
	auto session = sessionPlist["session-info"].data().native();

	getLogger().debugF!"nacSubmit: %d"(nacKeyEstablishment(validation_ctx, cast(void*) session.ptr, cast(int) session.length));

	ubyte* validationPtr;
	int validationLength;
	getLogger().debugF!"nacSign: %d"(nacSign(validation_ctx, null, 0, &validationPtr, &validationLength));
	scope(exit) nacFree(validationPtr);

	auto data = new Data([]);
	getLogger().infoF!"validation data: %s %s"(Base64.encode(validationPtr[0..validationLength]), typeid(Data) == typeid(data));
	// getLogger().infoF!"validation context: %s"(Base64.encode(validation_ctx[0..824])); +/
}
