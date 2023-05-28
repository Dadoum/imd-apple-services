module CoreFoundation.CFDate;

public import CoreFoundation.CFBase;

extern (C):

alias CFTimeInterval = double;
alias CFAbsoluteTime = double;

CFAbsoluteTime CFAbsoluteTimeGetCurrent();

extern __gshared const CFTimeInterval kCFAbsoluteTimeIntervalSince1970;
extern __gshared const CFTimeInterval kCFAbsoluteTimeIntervalSince1904;

struct __CFDate;
alias CFDateRef = const(__CFDate)*;

CFTypeID CFDateGetTypeID();

CFDateRef CFDateCreate(CFAllocatorRef allocator, CFAbsoluteTime at);

CFAbsoluteTime CFDateGetAbsoluteTime(CFDateRef theDate);

CFTimeInterval CFDateGetTimeIntervalSinceDate(
    CFDateRef theDate,
    CFDateRef otherDate);

CFComparisonResult CFDateCompare(
    CFDateRef theDate,
    CFDateRef otherDate,
    void* context);

struct __CFTimeZone;
alias CFTimeZoneRef = const(__CFTimeZone)*;

struct CFGregorianDate
{
    SInt32 year;
    SInt8 month;
    SInt8 day;
    SInt8 hour;
    SInt8 minute;
    double second;
}

struct CFGregorianUnits
{
    SInt32 years;
    SInt32 months;
    SInt32 days;
    SInt32 hours;
    SInt32 minutes;
    double seconds;
}

alias __CF_OPTIONS_CFGregorianUnitFlags = int;

enum CFGregorianUnitFlags
{
    kCFGregorianUnitsYears = 1,
    kCFGregorianUnitsMonths = 2,
    kCFGregorianUnitsDays = 4,
    kCFGregorianUnitsHours = 8,
    kCFGregorianUnitsMinutes = 16,
    kCFGregorianUnitsSeconds = 32,
    kCFGregorianAllUnits = 16777215
}

Boolean CFGregorianDateIsValid(CFGregorianDate gdate, CFOptionFlags unitFlags);

CFAbsoluteTime CFGregorianDateGetAbsoluteTime(
    CFGregorianDate gdate,
    CFTimeZoneRef tz);

CFGregorianDate CFAbsoluteTimeGetGregorianDate(
    CFAbsoluteTime at,
    CFTimeZoneRef tz);

CFAbsoluteTime CFAbsoluteTimeAddGregorianUnits(
    CFAbsoluteTime at,
    CFTimeZoneRef tz,
    CFGregorianUnits units);

CFGregorianUnits CFAbsoluteTimeGetDifferenceAsGregorianUnits(
    CFAbsoluteTime at1,
    CFAbsoluteTime at2,
    CFTimeZoneRef tz,
    CFOptionFlags unitFlags);

SInt32 CFAbsoluteTimeGetDayOfWeek(CFAbsoluteTime at, CFTimeZoneRef tz);

SInt32 CFAbsoluteTimeGetDayOfYear(CFAbsoluteTime at, CFTimeZoneRef tz);

SInt32 CFAbsoluteTimeGetWeekOfYear(CFAbsoluteTime at, CFTimeZoneRef tz);

