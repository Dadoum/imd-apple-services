module CoreFoundation.CFNumber;

public import CoreFoundation.CFBase;

extern (C):

struct __CFBoolean;
alias CFBooleanRef = const(__CFBoolean)*;

extern __gshared const CFBooleanRef kCFBooleanTrue;
extern __gshared const CFBooleanRef kCFBooleanFalse;

CFTypeID CFBooleanGetTypeID();

Boolean CFBooleanGetValue(CFBooleanRef boolean);

alias __CF_ENUM_CFNumberType = int;

enum CFNumberType
{
    kCFNumberSInt8Type = 1,
    kCFNumberSInt16Type = 2,
    kCFNumberSInt32Type = 3,
    kCFNumberSInt64Type = 4,
    kCFNumberFloat32Type = 5,
    kCFNumberFloat64Type = 6,

    kCFNumberCharType = 7,
    kCFNumberShortType = 8,
    kCFNumberIntType = 9,
    kCFNumberLongType = 10,
    kCFNumberLongLongType = 11,
    kCFNumberFloatType = 12,
    kCFNumberDoubleType = 13,

    kCFNumberCFIndexType = 14,
    kCFNumberNSIntegerType = 15,
    kCFNumberCGFloatType = 16,
    kCFNumberMaxType = 16
}

struct __CFNumber;
alias CFNumberRef = const(__CFNumber)*;

extern __gshared const CFNumberRef kCFNumberPositiveInfinity;
extern __gshared const CFNumberRef kCFNumberNegativeInfinity;
extern __gshared const CFNumberRef kCFNumberNaN;

CFTypeID CFNumberGetTypeID();

CFNumberRef CFNumberCreate(
    CFAllocatorRef allocator,
    CFNumberType theType,
    const(void)* valuePtr);

CFNumberType CFNumberGetType(CFNumberRef number);

CFIndex CFNumberGetByteSize(CFNumberRef number);

Boolean CFNumberIsFloatType(CFNumberRef number);

Boolean CFNumberGetValue(
    CFNumberRef number,
    CFNumberType theType,
    void* valuePtr);

CFComparisonResult CFNumberCompare(
    CFNumberRef number,
    CFNumberRef otherNumber,
    void* context);

