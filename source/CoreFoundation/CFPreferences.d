module CoreFoundation.CFPreferences;

public import CoreFoundation.CFArray;
public import CoreFoundation.CFBase;
public import CoreFoundation.CFDictionary;

extern (C):

extern __gshared const CFStringRef kCFPreferencesAnyApplication;
extern __gshared const CFStringRef kCFPreferencesCurrentApplication;
extern __gshared const CFStringRef kCFPreferencesAnyHost;
extern __gshared const CFStringRef kCFPreferencesCurrentHost;
extern __gshared const CFStringRef kCFPreferencesAnyUser;
extern __gshared const CFStringRef kCFPreferencesCurrentUser;

CFPropertyListRef CFPreferencesCopyAppValue(
    CFStringRef key,
    CFStringRef applicationID);

Boolean CFPreferencesGetAppBooleanValue(
    CFStringRef key,
    CFStringRef applicationID,
    Boolean* keyExistsAndHasValidFormat);

CFIndex CFPreferencesGetAppIntegerValue(
    CFStringRef key,
    CFStringRef applicationID,
    Boolean* keyExistsAndHasValidFormat);

void CFPreferencesSetAppValue(
    CFStringRef key,
    CFPropertyListRef value,
    CFStringRef applicationID);

void CFPreferencesAddSuitePreferencesToApp(
    CFStringRef applicationID,
    CFStringRef suiteID);

void CFPreferencesRemoveSuitePreferencesFromApp(
    CFStringRef applicationID,
    CFStringRef suiteID);

Boolean CFPreferencesAppSynchronize(CFStringRef applicationID);

CFPropertyListRef CFPreferencesCopyValue(
    CFStringRef key,
    CFStringRef applicationID,
    CFStringRef userName,
    CFStringRef hostName);

CFDictionaryRef CFPreferencesCopyMultiple(
    CFArrayRef keysToFetch,
    CFStringRef applicationID,
    CFStringRef userName,
    CFStringRef hostName);

void CFPreferencesSetValue(
    CFStringRef key,
    CFPropertyListRef value,
    CFStringRef applicationID,
    CFStringRef userName,
    CFStringRef hostName);

void CFPreferencesSetMultiple(
    CFDictionaryRef keysToSet,
    CFArrayRef keysToRemove,
    CFStringRef applicationID,
    CFStringRef userName,
    CFStringRef hostName);

Boolean CFPreferencesSynchronize(
    CFStringRef applicationID,
    CFStringRef userName,
    CFStringRef hostName);

CFArrayRef CFPreferencesCopyApplicationList(
    CFStringRef userName,
    CFStringRef hostName);

CFArrayRef CFPreferencesCopyKeyList(
    CFStringRef applicationID,
    CFStringRef userName,
    CFStringRef hostName);

