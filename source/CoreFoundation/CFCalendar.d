module CoreFoundation.CFCalendar;

public import CoreFoundation.CFBase;
public import CoreFoundation.CFDate;
public import CoreFoundation.CFLocale;

extern (C):

struct __CFCalendar;
alias CFCalendarRef = __CFCalendar*;

CFTypeID CFCalendarGetTypeID();

CFCalendarRef CFCalendarCopyCurrent();

CFCalendarRef CFCalendarCreateWithIdentifier(
    CFAllocatorRef allocator,
    CFCalendarIdentifier identifier);

CFCalendarIdentifier CFCalendarGetIdentifier(CFCalendarRef calendar);

CFLocaleRef CFCalendarCopyLocale(CFCalendarRef calendar);

void CFCalendarSetLocale(CFCalendarRef calendar, CFLocaleRef locale);

CFTimeZoneRef CFCalendarCopyTimeZone(CFCalendarRef calendar);

void CFCalendarSetTimeZone(CFCalendarRef calendar, CFTimeZoneRef tz);

CFIndex CFCalendarGetFirstWeekday(CFCalendarRef calendar);

void CFCalendarSetFirstWeekday(CFCalendarRef calendar, CFIndex wkdy);

CFIndex CFCalendarGetMinimumDaysInFirstWeek(CFCalendarRef calendar);

void CFCalendarSetMinimumDaysInFirstWeek(CFCalendarRef calendar, CFIndex mwd);

alias __CF_OPTIONS_CFCalendarUnit = int;

enum CFCalendarUnit
{
    kCFCalendarUnitEra = 1UL << 1,
    kCFCalendarUnitYear = 1UL << 2,
    kCFCalendarUnitMonth = 1UL << 3,
    kCFCalendarUnitDay = 1UL << 4,
    kCFCalendarUnitHour = 1UL << 5,
    kCFCalendarUnitMinute = 1UL << 6,
    kCFCalendarUnitSecond = 1UL << 7,
    kCFCalendarUnitWeek = 256,
    kCFCalendarUnitWeekday = 1UL << 9,
    kCFCalendarUnitWeekdayOrdinal = 1UL << 10,
    kCFCalendarUnitQuarter = 2048,
    kCFCalendarUnitWeekOfMonth = 4096,
    kCFCalendarUnitWeekOfYear = 8192,
    kCFCalendarUnitYearForWeekOfYear = 16384
}

CFRange CFCalendarGetMinimumRangeOfUnit(
    CFCalendarRef calendar,
    CFCalendarUnit unit);

CFRange CFCalendarGetMaximumRangeOfUnit(
    CFCalendarRef calendar,
    CFCalendarUnit unit);

CFRange CFCalendarGetRangeOfUnit(
    CFCalendarRef calendar,
    CFCalendarUnit smallerUnit,
    CFCalendarUnit biggerUnit,
    CFAbsoluteTime at);

CFIndex CFCalendarGetOrdinalityOfUnit(
    CFCalendarRef calendar,
    CFCalendarUnit smallerUnit,
    CFCalendarUnit biggerUnit,
    CFAbsoluteTime at);

Boolean CFCalendarGetTimeRangeOfUnit(
    CFCalendarRef calendar,
    CFCalendarUnit unit,
    CFAbsoluteTime at,
    CFAbsoluteTime* startp,
    CFTimeInterval* tip);

Boolean CFCalendarComposeAbsoluteTime(
    CFCalendarRef calendar,
    CFAbsoluteTime* at,
    const(char)* componentDesc,
    ...);

Boolean CFCalendarDecomposeAbsoluteTime(
    CFCalendarRef calendar,
    CFAbsoluteTime at,
    const(char)* componentDesc,
    ...);

enum
{
    kCFCalendarComponentsWrap = 1UL << 0
}

Boolean CFCalendarAddComponents(
    CFCalendarRef calendar,
    CFAbsoluteTime* at,
    CFOptionFlags options,
    const(char)* componentDesc,
    ...);

Boolean CFCalendarGetComponentDifference(
    CFCalendarRef calendar,
    CFAbsoluteTime startingAT,
    CFAbsoluteTime resultAT,
    CFOptionFlags options,
    const(char)* componentDesc,
    ...);

