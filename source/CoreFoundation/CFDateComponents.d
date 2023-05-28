module CoreFoundation.CFDateComponents;

public import CoreFoundation.CFBase;
public import CoreFoundation.CFCalendar;
public import CoreFoundation.CFDate;

extern (C):

enum
{
    CFDateComponentUndefined = long.max
}

enum
{
    kCFCalendarUnitNanosecond = 1 << 15,
    kCFCalendarUnitCalendar = 1 << 20,
    kCFCalendarUnitTimeZone = 1 << 21,
    kCFCalendarUnitLeapMonth = 1 << 30
}

struct __CFDateComponents;
alias CFDateComponentsRef = __CFDateComponents*;

CFDateComponentsRef CFDateComponentsCreate(CFAllocatorRef allocator);

CFIndex CFDateComponentsGetValue(
    CFDateComponentsRef dateComp,
    CFCalendarUnit unit);

void CFDateComponentsSetValue(
    CFDateComponentsRef dateComp,
    CFCalendarUnit unit,
    CFIndex value);

CFCalendarRef CFDateComponentsCopyCalendar(CFDateComponentsRef dateComp);

void CFDateComponentsSetCalendar(
    CFDateComponentsRef dateComp,
    CFCalendarRef calendar);

CFTimeZoneRef CFDateComponentsCopyTimeZone(CFDateComponentsRef dateComp);

void CFDateComponentsSetTimeZone(
    CFDateComponentsRef dateComp,
    CFTimeZoneRef timeZone);

Boolean CFDateComponentsIsLeapMonthSet(CFDateComponentsRef dc);

Boolean CFDateComponentsIsLeapMonth(CFDateComponentsRef dc);

Boolean CFDateComponentsIsValidDate(CFDateComponentsRef dateComp);

Boolean CFDateComponentsIsValidDateInCalendar(
    CFDateComponentsRef dateComp,
    CFCalendarRef calendar);

Boolean CFDateComponentsDateMatchesComponents(
    CFDateComponentsRef dateComp,
    CFCalendarRef calendar,
    CFDateRef date);

CFDateRef CFCalendarCreateDateFromComponents(
    CFAllocatorRef allocator,
    CFCalendarRef calendar,
    CFDateComponentsRef dateComp);

CFIndex CFCalendarGetComponentFromDate(
    CFCalendarRef calendar,
    CFCalendarUnit unit,
    CFDateRef date);

CFDateComponentsRef CFCalendarCreateDateComponentsFromDate(
    CFAllocatorRef allocator,
    CFCalendarRef calendar,
    CFCalendarUnit units,
    CFDateRef date);

CFDateComponentsRef CFDateComponentsCreateCopy(
    CFAllocatorRef allocator,
    CFDateComponentsRef dc);

