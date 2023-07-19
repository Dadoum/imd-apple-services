module symbols;

import std.format;
import std.string;
import std.typecons;
import std.stdio: stderr, stdout, writeln;

import slf4d;

import corefoundation;

import fake.c;
import fake.diskarbitration;
import fake.iokit;

template traceFunctionCall(alias U) {
    import std.traits;
    enum functionName = __traits(identifier, U);
    extern(C) ReturnType!U traceFunctionCall(Parameters!U params) {
        auto log = getLogger();
        import std.stdio;
        log.info("= Entered "~functionName~" =====");
        stdout.flush();
        scope(exit) {
            log.info("= Exitted "~functionName~" =====");
            stdout.flush();
        }
        return U(params);
    }
}

static bool kCFBooleanTrue = true;

shared static this() {
    symbols = [
        "malloc": &malloc,
        "free": cast(void*) &free,
        "__memset_chk": cast(void*) &memset,
        "__bzero": cast(void*) &__bzero_impl,
        "memcpy": cast(void*) &memcpy,
        "arc4random": cast(void*) &arc4randomHook,
        "statfs$INODE64": cast(void*) &__darwin_statfs64,

        "sysctlbyname": cast(void*) &sysctlbyname,

        "IORegistryEntryFromPath": cast(void*) &traceFunctionCall!IORegistryEntryFromPath,
        "IORegistryEntryCreateCFProperty": cast(void*) &traceFunctionCall!IORegistryEntryCreateCFProperty,
        "IOObjectRelease": cast(void*) &traceFunctionCall!IOObjectRelease,
        "DASessionCreate": cast(void*) &traceFunctionCall!DASessionCreate,
        "DADiskCreateFromBSDName": cast(void*) &traceFunctionCall!DADiskCreateFromBSDName,
        "DADiskCopyDescription": cast(void*) &traceFunctionCall!DADiskCopyDescription,
        "IOServiceMatching": cast(void*) &traceFunctionCall!IOServiceMatching,
        "IOServiceGetMatchingService": cast(void*) &traceFunctionCall!IOServiceGetMatchingService,
        "IOIteratorNext": cast(void*) &traceFunctionCall!IOIteratorNext,
        "IORegistryEntryGetParentEntry": cast(void*) &traceFunctionCall!IORegistryEntryGetParentEntry,
        "IOServiceGetMatchingServices": cast(void*) &traceFunctionCall!IOServiceGetMatchingServices,

        "kDADiskDescriptionVolumeUUIDKey": cast(void*) &kDADiskDescriptionVolumeUUIDKey,
        "kCFTypeDictionaryKeyCallBacks": cast(void*) null,
        "kCFTypeDictionaryValueCallBacks": cast(void*) null,
        "kCFBooleanTrue": cast(void*) &kCFBooleanTrue,

        "CFDataGetLength": cast(void*) &traceFunctionCall!CFDataGetLength,
        "CFDataGetBytes": cast(void*) &traceFunctionCall!CFDataGetBytes,
        "CFDataGetTypeID": cast(void*) &traceFunctionCall!CFDataGetTypeID,

        "CFDictionaryCreateMutable": cast(void*) &traceFunctionCall!CFDictionaryCreateMutable,
        "CFDictionaryGetValue": cast(void*) &traceFunctionCall!CFDictionaryGetValue,
        "CFDictionarySetValue": cast(void*) &traceFunctionCall!CFDictionarySetValue,

        "CFStringGetTypeID": cast(void*) &traceFunctionCall!CFStringGetTypeID,
        "CFStringGetLength": cast(void*) &traceFunctionCall!CFStringGetLength,
        "CFStringGetMaximumSizeForEncoding": cast(void*) &traceFunctionCall!CFStringGetMaximumSizeForEncoding,
        "CFStringGetCString": cast(void*) &traceFunctionCall!CFStringGetCString,

        "CFUUIDCreateString": cast(void*) &traceFunctionCall!CFUUIDCreateString,

        "CFRelease": cast(void*) &traceFunctionCall!CFRelease,
        "CFGetTypeID": cast(void*) &traceFunctionCall!CFGetTypeID,
        // +/
    ];
}

__gshared static void*[string] symbols;

Nullable!(void*) symbolReplacement(string symbol) {
    auto sym = symbol in symbols;
    if (sym) {
        return nullable(*sym);
    } else {
        return Nullable!(void*).init;
    }
}

noreturn undefinedSymbol(immutable char* symbol) {
    throw new UndefinedSymbolException(symbol.fromStringz());
}

class UndefinedSymbolException: Exception {
    this(string symbolName, string file = __FILE__, size_t line = __LINE__) {
        super(format!"`%s` has been called, but it is undefined. Aborting."(symbolName), file, line);
    }
}
