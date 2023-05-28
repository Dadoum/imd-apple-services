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

shared static this() {
    symbols = [
        "malloc": &malloc,
        "free": cast(void*) &free,
        "__memset_chk": cast(void*) &__memset_chk,
        "__bzero": cast(void*) &bzero,
        "memcpy": cast(void*) &memcpy,
        "arc4random": cast(void*) &arc4randomHook,

        "sysctlbyname": cast(void*) &sysctlbyname,

        "kDADiskDescriptionVolumeUUIDKey": cast(void*) &kDADiskDescriptionVolumeUUIDKey,
        "IORegistryEntryFromPath": cast(void*) &IORegistryEntryFromPath,
        "IORegistryEntryCreateCFProperty": cast(void*) &IORegistryEntryCreateCFProperty,
        "IOObjectRelease": cast(void*) &IOObjectRelease,
        "statfs$INODE64": cast(void*) &__darwin_statfs64,
        "DASessionCreate": cast(void*) &DASessionCreate,
        "DADiskCreateFromBSDName": cast(void*) &DADiskCreateFromBSDName,
        "DADiskCopyDescription": cast(void*) &DADiskCopyDescription,
        "IOServiceMatching": cast(void*) &IOServiceMatching,
        "IOServiceGetMatchingService": cast(void*) &IOServiceGetMatchingService,
        "IOIteratorNext": cast(void*) &IOIteratorNext,
        "IORegistryEntryGetParentEntry": cast(void*) &IORegistryEntryGetParentEntry,
        "IOServiceGetMatchingServices": cast(void*) &IOServiceGetMatchingServices,

        "kCFTypeDictionaryKeyCallBacks": cast(void*) &kCFTypeDictionaryKeyCallBacks,
        "kCFTypeDictionaryValueCallBacks": cast(void*) &kCFTypeDictionaryValueCallBacks,
        "kCFAllocatorDefault": cast(void*) &kCFAllocatorDefault,
        "kCFBooleanTrue": cast(void*) &kCFBooleanTrue,

        "CFDictionarySetValue": cast(void*) &CFDictionarySetValue,
        "CFGetTypeID": cast(void*) &CFGetTypeID,
        "CFDataGetLength": cast(void*) &CFDataGetLength,
        "CFDataGetBytes": cast(void*) &CFDataGetBytes,
        "CFDictionaryCreateMutable": cast(void*) &CFDictionaryCreateMutable,
        "CFDictionaryGetValue": cast(void*) &CFDictionaryGetValue,
        "CFRelease": cast(void*) &CFRelease,
        "CFGetTypeID": cast(void*) &CFGetTypeID,
        "CFStringGetTypeID": cast(void*) &CFStringGetTypeID,
        "CFDataGetTypeID": cast(void*) &CFDataGetTypeID,
        "CFStringGetLength": cast(void*) &CFStringGetLength,
        "CFStringGetMaximumSizeForEncoding": cast(void*) &CFStringGetMaximumSizeForEncoding,
        "CFStringGetCString": cast(void*) &CFStringGetCString,
        "CFUUIDCreateString": cast(void*) &CFUUIDCreateString, // +/
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
