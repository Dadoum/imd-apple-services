module CoreFoundation.CFDateIntervalFormatter;

public import CoreFoundation.CFBase;
public import CoreFoundation.CFCalendar;
public import CoreFoundation.CFDate;
public import CoreFoundation.CFDateInterval;
public import CoreFoundation.CFLocale;

extern (C):

struct __CFDateIntervalFormatter;
alias CFDateIntervalFormatterRef = __CFDateIntervalFormatter*;

alias __CF_ENUM_CFDateIntervalFormatterStyle = int;

enum CFDateIntervalFormatterStyle
{
    kCFDateIntervalFormatterNoStyle = 0,
    kCFDateIntervalFormatterShortStyle = 1,
    kCFDateIntervalFormatterMediumStyle = 2,
    kCFDateIntervalFormatterLongStyle = 3,
    kCFDateIntervalFormatterFullStyle = 4
}

alias __CF_ENUM__CFDateIntervalFormatterBoundaryStyle = int;

enum _CFDateIntervalFormatterBoundaryStyle
{
    kCFDateIntervalFormatterBoundaryStyleDefault = 0
}

CFDateIntervalFormatterRef CFDateIntervalFormatterCreate(CFAllocatorRef allocator, CFLocaleRef locale, CFDateIntervalFormatterStyle dateStyle, CFDateIntervalFormatterStyle timeStyle);
CFDateIntervalFormatterRef CFDateIntervalFormatterCreateCopy(CFAllocatorRef allocator, CFDateIntervalFormatterRef formatter);

CFLocaleRef CFDateIntervalFormatterCopyLocale(CFDateIntervalFormatterRef formatter);
void CFDateIntervalFormatterSetLocale(CFDateIntervalFormatterRef formatter, CFLocaleRef locale);

CFCalendarRef CFDateIntervalFormatterCopyCalendar(CFDateIntervalFormatterRef formatter);
void CFDateIntervalFormatterSetCalendar(CFDateIntervalFormatterRef formatter, CFCalendarRef calendar);

CFTimeZoneRef CFDateIntervalFormatterCopyTimeZone(CFDateIntervalFormatterRef formatter);
void CFDateIntervalFormatterSetTimeZone(CFDateIntervalFormatterRef formatter, CFTimeZoneRef timeZone);

CFStringRef CFDateIntervalFormatterCopyDateTemplate(CFDateIntervalFormatterRef formatter);
void CFDateIntervalFormatterSetDateTemplate(CFDateIntervalFormatterRef formatter, CFStringRef dateTemplate);

CFDateIntervalFormatterStyle CFDateIntervalFormatterGetDateStyle(CFDateIntervalFormatterRef formatter);
void CFDateIntervalFormatterSetDateStyle(CFDateIntervalFormatterRef formatter, CFDateIntervalFormatterStyle dateStyle);

CFDateIntervalFormatterStyle CFDateIntervalFormatterGetTimeStyle(CFDateIntervalFormatterRef formatter);
void CFDateIntervalFormatterSetTimeStyle(CFDateIntervalFormatterRef formatter, CFDateIntervalFormatterStyle timeStyle);

CFStringRef CFDateIntervalFormatterCreateStringFromDateToDate(CFDateIntervalFormatterRef formatter, CFDateRef fromDate, CFDateRef toDate);
CFStringRef CFDateIntervalFormatterCreateStringFromDateInterval(CFDateIntervalFormatterRef formatter, CFDateIntervalRef interval);

_CFDateIntervalFormatterBoundaryStyle _CFDateIntervalFormatterGetBoundaryStyle(CFDateIntervalFormatterRef formatter);
void _CFDateIntervalFormatterSetBoundaryStyle(CFDateIntervalFormatterRef formatter, _CFDateIntervalFormatterBoundaryStyle boundaryStyle);

void _CFDateIntervalFormatterInitializeFromCoderValues(
    CFDateIntervalFormatterRef formatter,
    long dateStyle,
    long timeStyle,
    CFStringRef dateTemplate,
    CFStringRef dateTemplateFromStyles,
    Boolean modified,
    Boolean useTemplate,
    CFLocaleRef locale,
    CFCalendarRef calendar,
    CFTimeZoneRef timeZone);

void _CFDateIntervalFormatterCopyCoderValues(
    CFDateIntervalFormatterRef formatter,
    long* dateStyle,
    long* timeStyle,
    CFStringRef* dateTemplate,
    CFStringRef* dateTemplateFromStyles,
    Boolean* modified,
    Boolean* useTemplate,
    CFLocaleRef* locale,
    CFCalendarRef* calendar,
    CFTimeZoneRef* timeZone);

