module CoreFoundation.CFBase;

import core.stdc.config;

extern (C):

alias Boolean = ubyte;

alias UInt8 = ubyte;
alias SInt8 = byte;
alias UInt16 = ushort;
alias SInt16 = short;
alias UInt32 = uint;
alias SInt32 = int;
alias UInt64 = c_ulong;
alias SInt64 = c_long;
alias OSStatus = int;

alias Float32 = float;
alias Float64 = double;
alias UniChar = ushort;
alias UniCharCount = c_ulong;
alias StringPtr = ubyte*;
alias ConstStringPtr = const(ubyte)*;
alias Str255 = ubyte[256];
alias ConstStr255Param = const(ubyte)*;
alias OSErr = short;
alias RegionCode = short;
alias LangCode = short;
alias ScriptCode = short;
alias FourCharCode = uint;
alias OSType = uint;
alias Byte = ubyte;
alias SignedByte = byte;

alias UTF32Char = uint;
alias UTF16Char = ushort;
alias UTF8Char = ubyte;

extern __gshared double kCFCoreFoundationVersionNumber;

alias CFTypeID = c_ulong;
alias CFOptionFlags = c_ulong;
alias CFHashCode = c_ulong;
alias CFIndex = c_long;

alias CFTypeRef = const(void)*;

struct __CFString;
alias CFStringRef = const(__CFString)*;
alias CFMutableStringRef = __CFString*;

alias CFPropertyListRef = const(void)*;

alias __CF_ENUM_CFComparisonResult = int;

enum CFComparisonResult
{
    kCFCompareLessThan = -1L,
    kCFCompareEqualTo = 0,
    kCFCompareGreaterThan = 1
}

alias CFComparatorFunction = CFComparisonResult function(const(void)* val1, const(void)* val2, void* context);

extern __gshared const CFIndex kCFNotFound;

struct CFRange
{
    CFIndex location;
    CFIndex length;
}

CFRange CFRangeMake(CFIndex loc, CFIndex len);

CFRange __CFRangeMake(CFIndex loc, CFIndex len);

struct __CFNull;
alias CFNullRef = const(__CFNull)*;

CFTypeID CFNullGetTypeID();

extern __gshared const CFNullRef kCFNull;

struct __CFAllocator;
alias CFAllocatorRef = const(__CFAllocator)*;

extern __gshared const CFAllocatorRef kCFAllocatorDefault;

extern __gshared const CFAllocatorRef kCFAllocatorSystemDefault;

extern __gshared const CFAllocatorRef kCFAllocatorMalloc;

extern __gshared const CFAllocatorRef kCFAllocatorMallocZone;

extern __gshared const CFAllocatorRef kCFAllocatorNull;

extern __gshared const CFAllocatorRef kCFAllocatorUseContext;

alias CFAllocatorRetainCallBack = const(void)* function(const(void)* info);
alias CFAllocatorReleaseCallBack = void function(const(void)* info);
alias CFAllocatorCopyDescriptionCallBack = const(__CFString)* function(const(void)* info);
alias CFAllocatorAllocateCallBack = void* function(CFIndex allocSize, CFOptionFlags hint, void* info);
alias CFAllocatorReallocateCallBack = void* function(void* ptr, CFIndex newsize, CFOptionFlags hint, void* info);
alias CFAllocatorDeallocateCallBack = void function(void* ptr, void* info);
alias CFAllocatorPreferredSizeCallBack = c_long function(CFIndex size, CFOptionFlags hint, void* info);

struct CFAllocatorContext
{
    CFIndex version_;
    void* info;
    CFAllocatorRetainCallBack retain;
    CFAllocatorReleaseCallBack release;
    CFAllocatorCopyDescriptionCallBack copyDescription;
    CFAllocatorAllocateCallBack allocate;
    CFAllocatorReallocateCallBack reallocate;
    CFAllocatorDeallocateCallBack deallocate;
    CFAllocatorPreferredSizeCallBack preferredSize;
}

CFTypeID CFAllocatorGetTypeID();

void CFAllocatorSetDefault(CFAllocatorRef allocator);

CFAllocatorRef CFAllocatorGetDefault();

CFAllocatorRef CFAllocatorCreate(
    CFAllocatorRef allocator,
    CFAllocatorContext* context);

void* CFAllocatorAllocate(
    CFAllocatorRef allocator,
    CFIndex size,
    CFOptionFlags hint);

void* CFAllocatorReallocate(
    CFAllocatorRef allocator,
    void* ptr,
    CFIndex newsize,
    CFOptionFlags hint);

void CFAllocatorDeallocate(CFAllocatorRef allocator, void* ptr);

CFIndex CFAllocatorGetPreferredSizeForSize(
    CFAllocatorRef allocator,
    CFIndex size,
    CFOptionFlags hint);

void CFAllocatorGetContext(
    CFAllocatorRef allocator,
    CFAllocatorContext* context);

CFTypeID CFGetTypeID(CFTypeRef cf);

CFStringRef CFCopyTypeIDDescription(CFTypeID type_id);

CFTypeRef CFRetain(CFTypeRef cf);

void CFRelease(CFTypeRef cf);

CFTypeRef CFAutorelease(CFTypeRef arg);

CFIndex CFGetRetainCount(CFTypeRef cf);

Boolean CFEqual(CFTypeRef cf1, CFTypeRef cf2);

CFHashCode CFHash(CFTypeRef cf);

CFStringRef CFCopyDescription(CFTypeRef cf);

CFAllocatorRef CFGetAllocator(CFTypeRef cf);

CFTypeRef CFMakeCollectable(CFTypeRef cf);

