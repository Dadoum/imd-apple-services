module CoreFoundation.CFError;

public import CoreFoundation.CFBase;
public import CoreFoundation.CFDictionary;

extern (C):

alias CFErrorDomain = const(__CFString)*;

struct __CFError;
alias CFErrorRef = __CFError*;

CFTypeID CFErrorGetTypeID();

extern __gshared const CFErrorDomain kCFErrorDomainPOSIX;
extern __gshared const CFErrorDomain kCFErrorDomainOSStatus;
extern __gshared const CFErrorDomain kCFErrorDomainMach;
extern __gshared const CFErrorDomain kCFErrorDomainCocoa;

extern __gshared const CFStringRef kCFErrorLocalizedDescriptionKey;
extern __gshared const CFStringRef kCFErrorLocalizedFailureKey;
extern __gshared const CFStringRef kCFErrorLocalizedFailureReasonKey;
extern __gshared const CFStringRef kCFErrorLocalizedRecoverySuggestionKey;

extern __gshared const CFStringRef kCFErrorDescriptionKey;

extern __gshared const CFStringRef kCFErrorUnderlyingErrorKey;
extern __gshared const CFStringRef kCFErrorURLKey;
extern __gshared const CFStringRef kCFErrorFilePathKey;

CFErrorRef CFErrorCreate(
    CFAllocatorRef allocator,
    CFErrorDomain domain,
    CFIndex code,
    CFDictionaryRef userInfo);

CFErrorRef CFErrorCreateWithUserInfoKeysAndValues(
    CFAllocatorRef allocator,
    CFErrorDomain domain,
    CFIndex code,
    const(void*)* userInfoKeys,
    const(void*)* userInfoValues,
    CFIndex numUserInfoValues);

CFErrorDomain CFErrorGetDomain(CFErrorRef err);

CFIndex CFErrorGetCode(CFErrorRef err);

CFDictionaryRef CFErrorCopyUserInfo(CFErrorRef err);

CFStringRef CFErrorCopyDescription(CFErrorRef err);

CFStringRef CFErrorCopyFailureReason(CFErrorRef err);

CFStringRef CFErrorCopyRecoverySuggestion(CFErrorRef err);

