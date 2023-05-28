module CoreFoundation.CFUserNotification;

public import CoreFoundation.CFBase;
public import CoreFoundation.CFDate;
public import CoreFoundation.CFDictionary;
public import CoreFoundation.CFRunLoop;
public import CoreFoundation.CFURL;

extern (C):

struct __CFUserNotification;
alias CFUserNotificationRef = __CFUserNotification*;

alias CFUserNotificationCallBack = void function(CFUserNotificationRef userNotification, CFOptionFlags responseFlags);

CFTypeID CFUserNotificationGetTypeID();

CFUserNotificationRef CFUserNotificationCreate(
    CFAllocatorRef allocator,
    CFTimeInterval timeout,
    CFOptionFlags flags,
    SInt32* error,
    CFDictionaryRef dictionary);

SInt32 CFUserNotificationReceiveResponse(
    CFUserNotificationRef userNotification,
    CFTimeInterval timeout,
    CFOptionFlags* responseFlags);

CFStringRef CFUserNotificationGetResponseValue(
    CFUserNotificationRef userNotification,
    CFStringRef key,
    CFIndex idx);

CFDictionaryRef CFUserNotificationGetResponseDictionary(
    CFUserNotificationRef userNotification);

SInt32 CFUserNotificationUpdate(
    CFUserNotificationRef userNotification,
    CFTimeInterval timeout,
    CFOptionFlags flags,
    CFDictionaryRef dictionary);

SInt32 CFUserNotificationCancel(CFUserNotificationRef userNotification);

CFRunLoopSourceRef CFUserNotificationCreateRunLoopSource(
    CFAllocatorRef allocator,
    CFUserNotificationRef userNotification,
    CFUserNotificationCallBack callout,
    CFIndex order);

SInt32 CFUserNotificationDisplayNotice(
    CFTimeInterval timeout,
    CFOptionFlags flags,
    CFURLRef iconURL,
    CFURLRef soundURL,
    CFURLRef localizationURL,
    CFStringRef alertHeader,
    CFStringRef alertMessage,
    CFStringRef defaultButtonTitle);

SInt32 CFUserNotificationDisplayAlert(
    CFTimeInterval timeout,
    CFOptionFlags flags,
    CFURLRef iconURL,
    CFURLRef soundURL,
    CFURLRef localizationURL,
    CFStringRef alertHeader,
    CFStringRef alertMessage,
    CFStringRef defaultButtonTitle,
    CFStringRef alternateButtonTitle,
    CFStringRef otherButtonTitle,
    CFOptionFlags* responseFlags);

enum
{
    kCFUserNotificationStopAlertLevel = 0,
    kCFUserNotificationNoteAlertLevel = 1,
    kCFUserNotificationCautionAlertLevel = 2,
    kCFUserNotificationPlainAlertLevel = 3
}

enum
{
    kCFUserNotificationDefaultResponse = 0,
    kCFUserNotificationAlternateResponse = 1,
    kCFUserNotificationOtherResponse = 2,
    kCFUserNotificationCancelResponse = 3
}

enum
{
    kCFUserNotificationNoDefaultButtonFlag = 32,
    kCFUserNotificationUseRadioButtonsFlag = 64
}

CFOptionFlags CFUserNotificationCheckBoxChecked(CFIndex i);
CFOptionFlags CFUserNotificationSecureTextField(CFIndex i);
CFOptionFlags CFUserNotificationPopUpSelection(CFIndex n);

extern __gshared const CFStringRef kCFUserNotificationIconURLKey;

extern __gshared const CFStringRef kCFUserNotificationSoundURLKey;

extern __gshared const CFStringRef kCFUserNotificationLocalizationURLKey;

extern __gshared const CFStringRef kCFUserNotificationAlertHeaderKey;

extern __gshared const CFStringRef kCFUserNotificationAlertMessageKey;

extern __gshared const CFStringRef kCFUserNotificationDefaultButtonTitleKey;

extern __gshared const CFStringRef kCFUserNotificationAlternateButtonTitleKey;

extern __gshared const CFStringRef kCFUserNotificationOtherButtonTitleKey;

extern __gshared const CFStringRef kCFUserNotificationProgressIndicatorValueKey;

extern __gshared const CFStringRef kCFUserNotificationPopUpTitlesKey;

extern __gshared const CFStringRef kCFUserNotificationTextFieldTitlesKey;

extern __gshared const CFStringRef kCFUserNotificationCheckBoxTitlesKey;

extern __gshared const CFStringRef kCFUserNotificationTextFieldValuesKey;

extern __gshared const CFStringRef kCFUserNotificationPopUpSelectionKey;

extern __gshared const CFStringRef kCFUserNotificationAlertTopMostKey;

extern __gshared const CFStringRef kCFUserNotificationKeyboardTypesKey;

