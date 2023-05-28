module CoreFoundation.CFRuntime;

import core.stdc.stdint;

import CoreFoundation.CoreFoundation;

extern (C):

Boolean _CFAllocatorIsSystemDefault(CFAllocatorRef allocator);

enum
{
    _kCFRuntimeNotATypeID = 0
}

enum
{
    _kCFRuntimeScannedObject = 1UL << 0,
    _kCFRuntimeResourcefulObject = 1UL << 2,
    _kCFRuntimeCustomRefCount = 1UL << 3
}

struct __CFRuntimeClass
{
    CFIndex version_;
    const(char)* className;
    void function(CFTypeRef cf) init;
    CFTypeRef function(CFAllocatorRef allocator, CFTypeRef cf) copy;
    void function(CFTypeRef cf) finalize;
    Boolean function(CFTypeRef cf1, CFTypeRef cf2) equal;
    CFHashCode function(CFTypeRef cf) hash;
    CFStringRef function(CFTypeRef cf, CFDictionaryRef formatOptions) copyFormattingDesc;
    CFStringRef function(CFTypeRef cf) copyDebugDesc;

    void function(CFTypeRef cf) reclaim;

    uint function(intptr_t op, CFTypeRef cf) refcount;
}

alias CFRuntimeClass = __CFRuntimeClass;

CFTypeID _CFRuntimeRegisterClass(const CFRuntimeClass* cls);

const(CFRuntimeClass)* _CFRuntimeGetClassWithTypeID(CFTypeID typeID);

void _CFRuntimeUnregisterClassWithTypeID(CFTypeID typeID);

struct __CFRuntimeBase
{
    uintptr_t _cfisa;
    ubyte[4] _cfinfo;

    uint _rc;
}

alias CFRuntimeBase = __CFRuntimeBase;

CFTypeRef _CFRuntimeCreateInstance(CFAllocatorRef allocator, CFTypeID typeID, CFIndex extraBytes, ubyte* category);

void _CFRuntimeSetInstanceTypeID(CFTypeRef cf, CFTypeID typeID);

void _CFRuntimeInitStaticInstance(void* memory, CFTypeID typeID);

