module CoreFoundation.CFTimeZone;

public import CoreFoundation.CFArray;
public import CoreFoundation.CFBase;
public import CoreFoundation.CFData;
public import CoreFoundation.CFDate;
public import CoreFoundation.CFDictionary;
public import CoreFoundation.CFLocale;
public import CoreFoundation.CFNotificationCenter;

extern (C):

CFTypeID CFTimeZoneGetTypeID();

CFTimeZoneRef CFTimeZoneCopySystem();

void CFTimeZoneResetSystem();

CFTimeZoneRef CFTimeZoneCopyDefault();

void CFTimeZoneSetDefault(CFTimeZoneRef tz);

CFArrayRef CFTimeZoneCopyKnownNames();

CFDictionaryRef CFTimeZoneCopyAbbreviationDictionary();

void CFTimeZoneSetAbbreviationDictionary(CFDictionaryRef dict);

CFTimeZoneRef CFTimeZoneCreate(
    CFAllocatorRef allocator,
    CFStringRef name,
    CFDataRef data);

CFTimeZoneRef CFTimeZoneCreateWithTimeIntervalFromGMT(
    CFAllocatorRef allocator,
    CFTimeInterval ti);

CFTimeZoneRef CFTimeZoneCreateWithName(
    CFAllocatorRef allocator,
    CFStringRef name,
    Boolean tryAbbrev);

CFStringRef CFTimeZoneGetName(CFTimeZoneRef tz);

CFDataRef CFTimeZoneGetData(CFTimeZoneRef tz);

CFTimeInterval CFTimeZoneGetSecondsFromGMT(CFTimeZoneRef tz, CFAbsoluteTime at);

CFStringRef CFTimeZoneCopyAbbreviation(CFTimeZoneRef tz, CFAbsoluteTime at);

Boolean CFTimeZoneIsDaylightSavingTime(CFTimeZoneRef tz, CFAbsoluteTime at);

CFTimeInterval CFTimeZoneGetDaylightSavingTimeOffset(
    CFTimeZoneRef tz,
    CFAbsoluteTime at);

CFAbsoluteTime CFTimeZoneGetNextDaylightSavingTimeTransition(
    CFTimeZoneRef tz,
    CFAbsoluteTime at);

alias __CF_ENUM_CFTimeZoneNameStyle = int;

enum CFTimeZoneNameStyle
{
    kCFTimeZoneNameStyleStandard = 0,
    kCFTimeZoneNameStyleShortStandard = 1,
    kCFTimeZoneNameStyleDaylightSaving = 2,
    kCFTimeZoneNameStyleShortDaylightSaving = 3,
    kCFTimeZoneNameStyleGeneric = 4,
    kCFTimeZoneNameStyleShortGeneric = 5
}

CFStringRef CFTimeZoneCopyLocalizedName(
    CFTimeZoneRef tz,
    CFTimeZoneNameStyle style,
    CFLocaleRef locale);

extern __gshared const CFNotificationName kCFTimeZoneSystemTimeZoneDidChangeNotification;

