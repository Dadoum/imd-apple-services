module fake.iokit;

import file = std.file;
import std.string;

import slf4d;

import corefoundation;
import fake.windows_stubs;

__gshared static CFDictionaryRef data;

shared static this() {
    auto dataBytes = cast(ubyte[]) file.read("./data.plist");
    auto plistData = CFDataCreate(null, dataBytes.ptr, cast(CFIndex) dataBytes.length);
    scope(exit) CFRelease(plistData);
    data = cast(CFDictionaryRef) CFPropertyListCreateWithData(null, plistData, CFPropertyListMutabilityOptions.kCFPropertyListImmutable, null, null);
}

bool ITER_93_SHOULD_RETURN_MAC = false;

extern(C):

CFTypeRef IORegistryEntryCreateCFProperty(uint entry, CFStringRef key, CFAllocatorRef allocator, uint options) {
    getLogger().traceF!"IORegistryEntryCreateCFProperty: '%s', length: %d"(key.toString(), CFStringGetLength(key));
    // CFShow(key);

    // auto iokit = cast(CFDictionaryRef) CFDictionaryGetValue(data, CFSTR!("iokit"));
    // auto val = CFDictionaryGetValue(iokit, key);
    // return val;
    ubyte[] dataTest = [0x0];
    return CFDataCreate(null, dataTest.ptr, cast(CFIndex) dataTest.length);
}

void IOObjectRelease() {
    getLogger().trace("IOObjectRelease");
}

CFMutableDictionaryRef IOServiceMatching(const char *name) {
    getLogger().traceF!"IOServiceMatching: %s"(name.fromStringz());
    CFStringRef nameStr = CFStringCreateWithCString(kCFAllocatorDefault, name, CFStringBuiltInEncodings.kCFStringEncodingUTF8);
    // Create a CFMutableDictionaryRef
    CFMutableDictionaryRef matching = CFDictionaryCreateMutable(
        kCFAllocatorDefault,
        0,
        &kCFTypeDictionaryKeyCallBacks,
        &kCFTypeDictionaryValueCallBacks
    );
    // Add the name to the dictionary
    CFDictionaryAddValue(matching, CFSTR!("IOProviderClass"), nameStr);
    // Return the dictionary
    return matching;
}

uint IOServiceGetMatchingService(uint, CFDictionaryRef matching) {
    getLogger().trace("IOServiceMatching ");
    return 92;
}

uint IOServiceGetMatchingServices(uint masterPort, CFDictionaryRef matching, uint *existing) {
    getLogger().trace("IOServiceGetMatchingServices");
    // printf("IOServiceGetMatchingServices called with port: %d matching: \n",
    //        masterPort);
    // CFShow(matching);
    if (CFSTR_CMP(cast(CFStringRef) CFDictionaryGetValue(matching, CFSTR!("IOProviderClass")),
    CFSTR!("IOEthernetInterface"))) {
        // printf("IOServiceGetMatchingServices returning 0\n");
        ITER_93_SHOULD_RETURN_MAC = true;
        *existing = 93;
        return 0;
    }
    return -1;
}

uint IOIteratorNext(uint iterator) {
    getLogger().trace("IOIteratorNext");
    if (iterator == 93 && ITER_93_SHOULD_RETURN_MAC) {
        ITER_93_SHOULD_RETURN_MAC = false;
        return 94;
    }
    return 0;
}

uint IORegistryEntryGetParentEntry(uint entry, uint, uint *parent) {
    getLogger().trace("IORegistryEntryGetParentEntry");
    // Set parent to entry + 100
    *parent = entry + 100;
    // printf("IORegistryEntryGetParentEntry returning 0\n");
    return 0;
}

uint IORegistryEntryFromPath(uint mach_port, char* str) {
    getLogger().traceF!"IORegistryEntryFromPath: %s"(str.fromStringz);
    return 1;
}