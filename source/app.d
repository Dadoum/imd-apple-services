import std.array;
import std.base64;
import std.format;
import std.net.curl;
import std.range: chunks;
import std.stdio;

import slf4d;

import plist;
import plist.types;

import corefoundation;
import dyldlibrary;

alias NACInit_t = extern(C) int function(const void* cert_bytes, int cert_len, ubyte** out_validation_ctx,
	ubyte **out_request_bytes, int *out_request_len);
alias NACKeyEstablishment_t = extern(C) int function(void* validation_ctx, void* response_bytes, int response_len);
alias NACSign_t = extern(C) int function(void* validation_ctx, void* unk_bytes, int unk_len,
	ubyte** validation_data, int* validation_data_len);
alias NACFree_t = extern(C) int function(void* ptr);
alias NACCleanup_t = extern(C) int function(void* ptr);

void main(string[] args)
{
	import fake.iokit;
	import file = std.file;

	auto dataStr = cast(string) file.read("./data.plist");
	auto dataPlist = new Plist();
	dataPlist.read(dataStr);
	data = cast(PlistElementDict) dataPlist[0];

	import slf4d.default_provider;
	auto provider = new shared DefaultProvider(true, Levels.TRACE);
	configureLoggingProvider(provider);

	DyldLibrary lib = new DyldLibrary("./IMDAppleServices");
	auto nacInit = cast(NACInit_t) (lib.allocation.ptr + 0xB1DB0);
	auto nacKeyEstablishment = cast(NACKeyEstablishment_t) (lib.allocation.ptr + 0xB1DD0);
	auto nacSign = cast(NACSign_t) (lib.allocation.ptr + 0xB1DF0);
	auto nacFree = cast(NACFree_t) (lib.allocation.ptr + 0xB1E10);
	auto nacCleanup = cast(NACCleanup_t) (lib.allocation.ptr + 0xB1E30);

	auto log = getLogger();
	stdout.flush();

	HTTP conn = HTTP();
	conn.handle.set(CurlOption.ssl_verifypeer, 0);
	conn.addRequestHeader("Content-Type", "application/x-apple-plist");
	conn.addRequestHeader("User-Agent", "CFNetwork/1404.0.5 Darwin/22.3.0");

	log.trace("Requesting certificate to Apple...");
	stdout.flush();
	auto certPlistStr = cast(string) get("http://static.ess.apple.com/identity/validation/cert-1.0.plist", conn);
	log.trace("Parsing it...");
	stdout.flush();
	auto certPlist = new Plist();
	certPlist.read(certPlistStr);
	auto cert = (cast(PlistElementData) (cast(PlistElementDict) (certPlist[0]))["cert"]).value;
	auto dataPtr = cert.ptr;
	auto dataLength = cert.length;
	log.trace("Parsed it.");
	stdout.flush();

	ubyte* validation_ctx;
	ubyte* request_bytes;
	int request_len;
	log.debugF!"nacInit: %d"(nacInit(dataPtr, cast(int) dataLength, &validation_ctx, &request_bytes, &request_len));
	stdout.flush();
	scope(exit) nacFree(request_bytes);
	scope(exit) nacCleanup(validation_ctx);

	auto secondRequestPlist = format!`<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>session-info-request</key>
	<data>
	%s
	</data>
</dict>
</plist>`(Base64.encode(request_bytes[0..request_len]).chunks(68).join("\n\t"));

	auto response1 = cast(string) post(
		"https://identity.ess.apple.com/WebObjects/TDIdentityService.woa/wa/initializeValidation",
		secondRequestPlist,
		conn
	);

	auto sessionPlist = new Plist();
	sessionPlist.read(response1);
	auto session = (cast(PlistElementData) (cast(PlistElementDict) (sessionPlist[0]))["session-info"]).value;

	getLogger().debugF!"nacSubmit: %d"(nacKeyEstablishment(validation_ctx, cast(void*) session.ptr, cast(int) session.length));

	ubyte* validationPtr;
	int validationLength;
	getLogger().debugF!"nacSign: %d"(nacSign(validation_ctx, null, 0, &validationPtr, &validationLength));
	scope(exit) nacFree(validationPtr);

	getLogger().infoF!"validation data: %s"(Base64.encode(validationPtr[0..validationLength]));
	// getLogger().infoF!"validation context: %s"(Base64.encode(validation_ctx[0..824])); +/
}
