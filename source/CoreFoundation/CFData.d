module CoreFoundation.CFData;

public import CoreFoundation.CFBase;

extern (C):

struct __CFData;
alias CFDataRef = const(__CFData)*;
alias CFMutableDataRef = __CFData*;

CFTypeID CFDataGetTypeID();

CFDataRef CFDataCreate(
    CFAllocatorRef allocator,
    const(UInt8)* bytes,
    CFIndex length);

CFDataRef CFDataCreateWithBytesNoCopy(
    CFAllocatorRef allocator,
    const(UInt8)* bytes,
    CFIndex length,
    CFAllocatorRef bytesDeallocator);

CFDataRef CFDataCreateCopy(CFAllocatorRef allocator, CFDataRef theData);

CFMutableDataRef CFDataCreateMutable(
    CFAllocatorRef allocator,
    CFIndex capacity);

CFMutableDataRef CFDataCreateMutableCopy(
    CFAllocatorRef allocator,
    CFIndex capacity,
    CFDataRef theData);

CFIndex CFDataGetLength(CFDataRef theData);

const(UInt8)* CFDataGetBytePtr(CFDataRef theData);

UInt8* CFDataGetMutableBytePtr(CFMutableDataRef theData);

void CFDataGetBytes(CFDataRef theData, CFRange range, UInt8* buffer);

void CFDataSetLength(CFMutableDataRef theData, CFIndex length);

void CFDataIncreaseLength(CFMutableDataRef theData, CFIndex extraLength);

void CFDataAppendBytes(
    CFMutableDataRef theData,
    const(UInt8)* bytes,
    CFIndex length);

void CFDataReplaceBytes(
    CFMutableDataRef theData,
    CFRange range,
    const(UInt8)* newBytes,
    CFIndex newLength);

void CFDataDeleteBytes(CFMutableDataRef theData, CFRange range);

alias __CF_OPTIONS_CFDataSearchFlags = int;

enum CFDataSearchFlags
{
    kCFDataSearchBackwards = 1UL << 0,
    kCFDataSearchAnchored = 1UL << 1
}

CFRange CFDataFind(
    CFDataRef theData,
    CFDataRef dataToFind,
    CFRange searchRange,
    CFDataSearchFlags compareOptions);

