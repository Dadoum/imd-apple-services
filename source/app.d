import std.stdio: stderr, writeln;
import std.net.curl;

import slf4d;

import corefoundation;
import dyldlibrary;

void main(string[] args)
{
	import slf4d.default_provider;
	auto provider = new shared DefaultProvider(true, Levels.TRACE);
	configureLoggingProvider(provider);

	DyldLibrary lib = new DyldLibrary("/home/dadoum/Téléchargements/IMDAppleServices");
	alias NACInit_t = extern(C) int function(const void *cert_bytes, int cert_len, void **out_validation_ctx,
		void **out_request_bytes, int *out_request_len);
	auto nacInit = cast(NACInit_t) (lib.allocation.ptr + 0xB1DB0);
	auto hell = "hello".ptr;

	auto certPlistStr = get("http://static.ess.apple.com/identity/validation/cert-1.0.plist");
	auto certPlistData = CFDataCreate(null, cast(const(ubyte)*) certPlistStr.ptr, certPlistStr.length);
	scope(exit) CFRelease(certPlistData);
	auto certPlist = cast(CFDictionaryRef) CFPropertyListCreateWithData(null, certPlistData, CFPropertyListMutabilityOptions.kCFPropertyListImmutable, null, null);
	scope(exit) CFRelease(certPlist);
	auto cert = cast(CFDataRef) CFDictionaryGetValue(certPlist, CFSTR!("cert"));
	auto dataPtr = CFDataGetBytePtr(cert);
	auto dataLength = CFDataGetLength(cert);

	getLogger().info("Running NACInit.");

	void* validation_ctx;
	void* request_bytes;
	int request_len;
	getLogger().debugF!"returned %d"(nacInit(dataPtr, cast(int) dataLength, &validation_ctx, &request_bytes, &request_len));
}
