module fake.iokit;

import file = std.file;
import std.string;

import slf4d;

import plist;

import corefoundation;
import fake.windows_stubs;

__gshared static PlistDict data;

shared static this() {
    auto dataBytes = cast(ubyte[]) file.read("./data.plist");
    data = Plist.fromMemory(dataBytes).dict();
}

bool ITER_93_SHOULD_RETURN_MAC = false;

extern(C):

struct __builtin_CFString {
    int *isa; // point to __CFConstantStringClassReference
    int flags;
    const char *str;
    long length;
}

Object IORegistryEntryCreateCFProperty(uint entry, __builtin_CFString* key, CFAllocatorRef allocator, uint options) {
    auto iokit = data["iokit"].dict();
    import std.stdio;
    getLogger().infoF!"IORegistry prop: %s"(cast(string) key.str[0..key.length]);
    stdout.flush();
    auto val = iokit[cast(string) key.str[0..key.length]];
    import plist.c;
    if (auto data = cast(PlistData) val) {
        return new Data(data.native());
    } else if (auto str = cast(PlistString) val) {
        return new String(str.native());
    }

    assert(false, "Unrecognized plist type.");
}

void IOObjectRelease() {
    getLogger().trace("IOObjectRelease");
}

CFMutableDictionaryRef IOServiceMatching(const char *name) {
    getLogger().traceF!"IOServiceMatching: %s"(name.fromStringz());
    CFStringRef nameStr = CFStringCreateWithCString(null, name, 0);
    // Create a CFMutableDictionaryRef
    CFMutableDictionaryRef matching = CFDictionaryCreateMutable(
        null,
        0,
        null,
        null
    );
    // Add the name to the dictionary
    CFDictionaryAddValue(matching, new String("IOProviderClass"), cast(Object) nameStr);
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
    if (CFSTR_CMP(cast(CFStringRef) CFDictionaryGetValue(matching, new String("IOProviderClass")), new String("IOEthernetInterface"))) {
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