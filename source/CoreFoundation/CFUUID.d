module CoreFoundation.CFUUID;

public import CoreFoundation.CFBase;

extern (C):

struct __CFUUID;
alias CFUUIDRef = const(__CFUUID)*;

struct CFUUIDBytes
{
    UInt8 byte0;
    UInt8 byte1;
    UInt8 byte2;
    UInt8 byte3;
    UInt8 byte4;
    UInt8 byte5;
    UInt8 byte6;
    UInt8 byte7;
    UInt8 byte8;
    UInt8 byte9;
    UInt8 byte10;
    UInt8 byte11;
    UInt8 byte12;
    UInt8 byte13;
    UInt8 byte14;
    UInt8 byte15;
}

CFTypeID CFUUIDGetTypeID();

CFUUIDRef CFUUIDCreate(CFAllocatorRef alloc);

CFUUIDRef CFUUIDCreateWithBytes(
    CFAllocatorRef alloc,
    UInt8 byte0,
    UInt8 byte1,
    UInt8 byte2,
    UInt8 byte3,
    UInt8 byte4,
    UInt8 byte5,
    UInt8 byte6,
    UInt8 byte7,
    UInt8 byte8,
    UInt8 byte9,
    UInt8 byte10,
    UInt8 byte11,
    UInt8 byte12,
    UInt8 byte13,
    UInt8 byte14,
    UInt8 byte15);

CFUUIDRef CFUUIDCreateFromString(CFAllocatorRef alloc, CFStringRef uuidStr);

CFStringRef CFUUIDCreateString(CFAllocatorRef alloc, CFUUIDRef uuid);

CFUUIDRef CFUUIDGetConstantUUIDWithBytes(
    CFAllocatorRef alloc,
    UInt8 byte0,
    UInt8 byte1,
    UInt8 byte2,
    UInt8 byte3,
    UInt8 byte4,
    UInt8 byte5,
    UInt8 byte6,
    UInt8 byte7,
    UInt8 byte8,
    UInt8 byte9,
    UInt8 byte10,
    UInt8 byte11,
    UInt8 byte12,
    UInt8 byte13,
    UInt8 byte14,
    UInt8 byte15);

CFUUIDBytes CFUUIDGetUUIDBytes(CFUUIDRef uuid);

CFUUIDRef CFUUIDCreateFromUUIDBytes(CFAllocatorRef alloc, CFUUIDBytes bytes);

