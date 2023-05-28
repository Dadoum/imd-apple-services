module CoreFoundation.CFDateFormatter;

public import CoreFoundation.CFBase;
public import CoreFoundation.CFDate;
public import CoreFoundation.CFLocale;

extern (C):

alias CFDateFormatterKey = const(__CFString)*;

struct __CFDateFormatter;
alias CFDateFormatterRef = __CFDateFormatter*;

CFStringRef CFDateFormatterCreateDateFormatFromTemplate(
    CFAllocatorRef allocator,
    CFStringRef tmplate,
    CFOptionFlags options,
    CFLocaleRef locale);

CFTypeID CFDateFormatterGetTypeID();

alias __CF_ENUM_CFDateFormatterStyle = int;

enum CFDateFormatterStyle
{
    kCFDateFormatterNoStyle = 0,
    kCFDateFormatterShortStyle = 1,
    kCFDateFormatterMediumStyle = 2,
    kCFDateFormatterLongStyle = 3,
    kCFDateFormatterFullStyle = 4
}

alias __CF_OPTIONS_CFISO8601DateFormatOptions = int;

enum CFISO8601DateFormatOptions
{
    kCFISO8601DateFormatWithYear = 1,
    kCFISO8601DateFormatWithMonth = 2,

    kCFISO8601DateFormatWithWeekOfYear = 4,

    kCFISO8601DateFormatWithDay = 16,

    kCFISO8601DateFormatWithTime = 32,
    kCFISO8601DateFormatWithTimeZone = 64,

    kCFISO8601DateFormatWithSpaceBetweenDateAndTime = 128,
    kCFISO8601DateFormatWithDashSeparatorInDate = 256,
    kCFISO8601DateFormatWithColonSeparatorInTime = 512,
    kCFISO8601DateFormatWithColonSeparatorInTimeZone = 1024,
    kCFISO8601DateFormatWithFractionalSeconds = 2048,

    kCFISO8601DateFormatWithFullDate = 275,
    kCFISO8601DateFormatWithFullTime = 1632,

    kCFISO8601DateFormatWithInternetDateTime = 1907
}

CFDateFormatterRef CFDateFormatterCreateISO8601Formatter(
    CFAllocatorRef allocator,
    CFISO8601DateFormatOptions formatOptions);

CFDateFormatterRef CFDateFormatterCreate(
    CFAllocatorRef allocator,
    CFLocaleRef locale,
    CFDateFormatterStyle dateStyle,
    CFDateFormatterStyle timeStyle);

CFLocaleRef CFDateFormatterGetLocale(CFDateFormatterRef formatter);

CFDateFormatterStyle CFDateFormatterGetDateStyle(CFDateFormatterRef formatter);

CFDateFormatterStyle CFDateFormatterGetTimeStyle(CFDateFormatterRef formatter);

CFStringRef CFDateFormatterGetFormat(CFDateFormatterRef formatter);

void CFDateFormatterSetFormat(
    CFDateFormatterRef formatter,
    CFStringRef formatString);

CFStringRef CFDateFormatterCreateStringWithDate(
    CFAllocatorRef allocator,
    CFDateFormatterRef formatter,
    CFDateRef date);

CFStringRef CFDateFormatterCreateStringWithAbsoluteTime(
    CFAllocatorRef allocator,
    CFDateFormatterRef formatter,
    CFAbsoluteTime at);

CFDateRef CFDateFormatterCreateDateFromString(
    CFAllocatorRef allocator,
    CFDateFormatterRef formatter,
    CFStringRef string,
    CFRange* rangep);

Boolean CFDateFormatterGetAbsoluteTimeFromString(
    CFDateFormatterRef formatter,
    CFStringRef string,
    CFRange* rangep,
    CFAbsoluteTime* atp);

void CFDateFormatterSetProperty(
    CFDateFormatterRef formatter,
    CFStringRef key,
    CFTypeRef value);

CFTypeRef CFDateFormatterCopyProperty(
    CFDateFormatterRef formatter,
    CFDateFormatterKey key);

extern __gshared const CFDateFormatterKey kCFDateFormatterIsLenient;
extern __gshared const CFDateFormatterKey kCFDateFormatterTimeZone;
extern __gshared const CFDateFormatterKey kCFDateFormatterCalendarName;
extern __gshared const CFDateFormatterKey kCFDateFormatterDefaultFormat;
extern __gshared const CFDateFormatterKey kCFDateFormatterTwoDigitStartDate;
extern __gshared const CFDateFormatterKey kCFDateFormatterDefaultDate;
extern __gshared const CFDateFormatterKey kCFDateFormatterCalendar;
extern __gshared const CFDateFormatterKey kCFDateFormatterEraSymbols;
extern __gshared const CFDateFormatterKey kCFDateFormatterMonthSymbols;
extern __gshared const CFDateFormatterKey kCFDateFormatterShortMonthSymbols;
extern __gshared const CFDateFormatterKey kCFDateFormatterWeekdaySymbols;
extern __gshared const CFDateFormatterKey kCFDateFormatterShortWeekdaySymbols;
extern __gshared const CFDateFormatterKey kCFDateFormatterAMSymbol;
extern __gshared const CFDateFormatterKey kCFDateFormatterPMSymbol;
extern __gshared const CFDateFormatterKey kCFDateFormatterLongEraSymbols;
extern __gshared const CFDateFormatterKey kCFDateFormatterVeryShortMonthSymbols;
extern __gshared const CFDateFormatterKey kCFDateFormatterStandaloneMonthSymbols;
extern __gshared const CFDateFormatterKey kCFDateFormatterShortStandaloneMonthSymbols;
extern __gshared const CFDateFormatterKey kCFDateFormatterVeryShortStandaloneMonthSymbols;
extern __gshared const CFDateFormatterKey kCFDateFormatterVeryShortWeekdaySymbols;
extern __gshared const CFDateFormatterKey kCFDateFormatterStandaloneWeekdaySymbols;
extern __gshared const CFDateFormatterKey kCFDateFormatterShortStandaloneWeekdaySymbols;
extern __gshared const CFDateFormatterKey kCFDateFormatterVeryShortStandaloneWeekdaySymbols;
extern __gshared const CFDateFormatterKey kCFDateFormatterQuarterSymbols;
extern __gshared const CFDateFormatterKey kCFDateFormatterShortQuarterSymbols;
extern __gshared const CFDateFormatterKey kCFDateFormatterStandaloneQuarterSymbols;
extern __gshared const CFDateFormatterKey kCFDateFormatterShortStandaloneQuarterSymbols;
extern __gshared const CFDateFormatterKey kCFDateFormatterGregorianStartDate;
extern __gshared const CFDateFormatterKey kCFDateFormatterDoesRelativeDateFormattingKey;

