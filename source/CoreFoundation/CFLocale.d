module CoreFoundation.CFLocale;

public import CoreFoundation.CFArray;
public import CoreFoundation.CFBase;
public import CoreFoundation.CFDictionary;
public import CoreFoundation.CFNotificationCenter;

extern (C):

alias CFLocaleIdentifier = const(__CFString)*;
alias CFLocaleKey = const(__CFString)*;

struct __CFLocale;
alias CFLocaleRef = const(__CFLocale)*;

CFTypeID CFLocaleGetTypeID();

CFLocaleRef CFLocaleGetSystem();

CFLocaleRef CFLocaleCopyCurrent();

CFArrayRef CFLocaleCopyAvailableLocaleIdentifiers();

CFArrayRef CFLocaleCopyISOLanguageCodes();

CFArrayRef CFLocaleCopyISOCountryCodes();

CFArrayRef CFLocaleCopyISOCurrencyCodes();

CFArrayRef CFLocaleCopyCommonISOCurrencyCodes();

CFArrayRef CFLocaleCopyPreferredLanguages();

CFLocaleIdentifier CFLocaleCreateCanonicalLanguageIdentifierFromString(
    CFAllocatorRef allocator,
    CFStringRef localeIdentifier);

CFLocaleIdentifier CFLocaleCreateCanonicalLocaleIdentifierFromString(
    CFAllocatorRef allocator,
    CFStringRef localeIdentifier);

CFLocaleIdentifier CFLocaleCreateCanonicalLocaleIdentifierFromScriptManagerCodes(
    CFAllocatorRef allocator,
    LangCode lcode,
    RegionCode rcode);

CFLocaleIdentifier CFLocaleCreateLocaleIdentifierFromWindowsLocaleCode(
    CFAllocatorRef allocator,
    uint lcid);

uint CFLocaleGetWindowsLocaleCodeFromLocaleIdentifier(
    CFLocaleIdentifier localeIdentifier);

alias __CF_ENUM_CFLocaleLanguageDirection = int;

enum CFLocaleLanguageDirection
{
    kCFLocaleLanguageDirectionUnknown = 0,
    kCFLocaleLanguageDirectionLeftToRight = 1,
    kCFLocaleLanguageDirectionRightToLeft = 2,
    kCFLocaleLanguageDirectionTopToBottom = 3,
    kCFLocaleLanguageDirectionBottomToTop = 4
}

CFLocaleLanguageDirection CFLocaleGetLanguageCharacterDirection(
    CFStringRef isoLangCode);

CFLocaleLanguageDirection CFLocaleGetLanguageLineDirection(
    CFStringRef isoLangCode);

CFDictionaryRef CFLocaleCreateComponentsFromLocaleIdentifier(
    CFAllocatorRef allocator,
    CFLocaleIdentifier localeID);

CFLocaleIdentifier CFLocaleCreateLocaleIdentifierFromComponents(
    CFAllocatorRef allocator,
    CFDictionaryRef dictionary);

CFLocaleRef CFLocaleCreate(
    CFAllocatorRef allocator,
    CFLocaleIdentifier localeIdentifier);

CFLocaleRef CFLocaleCreateCopy(CFAllocatorRef allocator, CFLocaleRef locale);

CFLocaleIdentifier CFLocaleGetIdentifier(CFLocaleRef locale);

CFTypeRef CFLocaleGetValue(CFLocaleRef locale, CFLocaleKey key);

CFStringRef CFLocaleCopyDisplayNameForPropertyValue(
    CFLocaleRef displayLocale,
    CFLocaleKey key,
    CFStringRef value);

extern __gshared const CFNotificationName kCFLocaleCurrentLocaleDidChangeNotification;

extern __gshared const CFLocaleKey kCFLocaleIdentifier;
extern __gshared const CFLocaleKey kCFLocaleLanguageCode;
extern __gshared const CFLocaleKey kCFLocaleCountryCode;
extern __gshared const CFLocaleKey kCFLocaleScriptCode;
extern __gshared const CFLocaleKey kCFLocaleVariantCode;

extern __gshared const CFLocaleKey kCFLocaleExemplarCharacterSet;
extern __gshared const CFLocaleKey kCFLocaleCalendarIdentifier;
extern __gshared const CFLocaleKey kCFLocaleCalendar;
extern __gshared const CFLocaleKey kCFLocaleCollationIdentifier;
extern __gshared const CFLocaleKey kCFLocaleUsesMetricSystem;
extern __gshared const CFLocaleKey kCFLocaleMeasurementSystem;
extern __gshared const CFLocaleKey kCFLocaleDecimalSeparator;
extern __gshared const CFLocaleKey kCFLocaleGroupingSeparator;
extern __gshared const CFLocaleKey kCFLocaleCurrencySymbol;
extern __gshared const CFLocaleKey kCFLocaleCurrencyCode;
extern __gshared const CFLocaleKey kCFLocaleCollatorIdentifier;
extern __gshared const CFLocaleKey kCFLocaleQuotationBeginDelimiterKey;
extern __gshared const CFLocaleKey kCFLocaleQuotationEndDelimiterKey;
extern __gshared const CFLocaleKey kCFLocaleAlternateQuotationBeginDelimiterKey;
extern __gshared const CFLocaleKey kCFLocaleAlternateQuotationEndDelimiterKey;

alias CFCalendarIdentifier = const(__CFString)*;

extern __gshared const CFCalendarIdentifier kCFGregorianCalendar;
extern __gshared const CFCalendarIdentifier kCFBuddhistCalendar;
extern __gshared const CFCalendarIdentifier kCFChineseCalendar;
extern __gshared const CFCalendarIdentifier kCFHebrewCalendar;
extern __gshared const CFCalendarIdentifier kCFIslamicCalendar;
extern __gshared const CFCalendarIdentifier kCFIslamicCivilCalendar;
extern __gshared const CFCalendarIdentifier kCFJapaneseCalendar;
extern __gshared const CFCalendarIdentifier kCFRepublicOfChinaCalendar;
extern __gshared const CFCalendarIdentifier kCFPersianCalendar;
extern __gshared const CFCalendarIdentifier kCFIndianCalendar;
extern __gshared const CFCalendarIdentifier kCFISO8601Calendar;
extern __gshared const CFCalendarIdentifier kCFIslamicTabularCalendar;
extern __gshared const CFCalendarIdentifier kCFIslamicUmmAlQuraCalendar;

