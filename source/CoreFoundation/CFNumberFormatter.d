module CoreFoundation.CFNumberFormatter;

public import CoreFoundation.CFBase;
public import CoreFoundation.CFLocale;
public import CoreFoundation.CFNumber;

extern (C):

alias CFNumberFormatterKey = const(__CFString)*;

struct __CFNumberFormatter;
alias CFNumberFormatterRef = __CFNumberFormatter*;

CFTypeID CFNumberFormatterGetTypeID();

alias __CF_ENUM_CFNumberFormatterStyle = int;

enum CFNumberFormatterStyle
{
    kCFNumberFormatterNoStyle = 0,
    kCFNumberFormatterDecimalStyle = 1,
    kCFNumberFormatterCurrencyStyle = 2,
    kCFNumberFormatterPercentStyle = 3,
    kCFNumberFormatterScientificStyle = 4,
    kCFNumberFormatterSpellOutStyle = 5,
    kCFNumberFormatterOrdinalStyle = 6,
    kCFNumberFormatterCurrencyISOCodeStyle = 8,
    kCFNumberFormatterCurrencyPluralStyle = 9,
    kCFNumberFormatterCurrencyAccountingStyle = 10
}

CFNumberFormatterRef CFNumberFormatterCreate(
    CFAllocatorRef allocator,
    CFLocaleRef locale,
    CFNumberFormatterStyle style);

CFLocaleRef CFNumberFormatterGetLocale(CFNumberFormatterRef formatter);

CFNumberFormatterStyle CFNumberFormatterGetStyle(
    CFNumberFormatterRef formatter);

CFStringRef CFNumberFormatterGetFormat(CFNumberFormatterRef formatter);

void CFNumberFormatterSetFormat(
    CFNumberFormatterRef formatter,
    CFStringRef formatString);

CFStringRef CFNumberFormatterCreateStringWithNumber(
    CFAllocatorRef allocator,
    CFNumberFormatterRef formatter,
    CFNumberRef number);

CFStringRef CFNumberFormatterCreateStringWithValue(
    CFAllocatorRef allocator,
    CFNumberFormatterRef formatter,
    CFNumberType numberType,
    const(void)* valuePtr);

alias __CF_OPTIONS_CFNumberFormatterOptionFlags = int;

enum CFNumberFormatterOptionFlags
{
    kCFNumberFormatterParseIntegersOnly = 1
}

CFNumberRef CFNumberFormatterCreateNumberFromString(
    CFAllocatorRef allocator,
    CFNumberFormatterRef formatter,
    CFStringRef string,
    CFRange* rangep,
    CFOptionFlags options);

Boolean CFNumberFormatterGetValueFromString(
    CFNumberFormatterRef formatter,
    CFStringRef string,
    CFRange* rangep,
    CFNumberType numberType,
    void* valuePtr);

void CFNumberFormatterSetProperty(
    CFNumberFormatterRef formatter,
    CFNumberFormatterKey key,
    CFTypeRef value);

CFTypeRef CFNumberFormatterCopyProperty(
    CFNumberFormatterRef formatter,
    CFNumberFormatterKey key);

extern __gshared const CFNumberFormatterKey kCFNumberFormatterCurrencyCode;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterDecimalSeparator;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterCurrencyDecimalSeparator;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterAlwaysShowDecimalSeparator;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterGroupingSeparator;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterUseGroupingSeparator;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterPercentSymbol;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterZeroSymbol;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterNaNSymbol;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterInfinitySymbol;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterMinusSign;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterPlusSign;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterCurrencySymbol;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterExponentSymbol;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterMinIntegerDigits;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterMaxIntegerDigits;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterMinFractionDigits;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterMaxFractionDigits;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterGroupingSize;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterSecondaryGroupingSize;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterRoundingMode;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterRoundingIncrement;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterFormatWidth;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterPaddingPosition;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterPaddingCharacter;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterDefaultFormat;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterMultiplier;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterPositivePrefix;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterPositiveSuffix;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterNegativePrefix;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterNegativeSuffix;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterPerMillSymbol;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterInternationalCurrencySymbol;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterCurrencyGroupingSeparator;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterIsLenient;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterUseSignificantDigits;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterMinSignificantDigits;
extern __gshared const CFNumberFormatterKey kCFNumberFormatterMaxSignificantDigits;

alias __CF_ENUM_CFNumberFormatterRoundingMode = int;

enum CFNumberFormatterRoundingMode
{
    kCFNumberFormatterRoundCeiling = 0,
    kCFNumberFormatterRoundFloor = 1,
    kCFNumberFormatterRoundDown = 2,
    kCFNumberFormatterRoundUp = 3,
    kCFNumberFormatterRoundHalfEven = 4,
    kCFNumberFormatterRoundHalfDown = 5,
    kCFNumberFormatterRoundHalfUp = 6
}

alias __CF_ENUM_CFNumberFormatterPadPosition = int;

enum CFNumberFormatterPadPosition
{
    kCFNumberFormatterPadBeforePrefix = 0,
    kCFNumberFormatterPadAfterPrefix = 1,
    kCFNumberFormatterPadBeforeSuffix = 2,
    kCFNumberFormatterPadAfterSuffix = 3
}

Boolean CFNumberFormatterGetDecimalInfoForCurrencyCode(
    CFStringRef currencyCode,
    int* defaultFractionDigits,
    double* roundingIncrement);

