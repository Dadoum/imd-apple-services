module CoreFoundation.CFNotificationCenter;

public import CoreFoundation.CFBase;
public import CoreFoundation.CFDictionary;

extern (C):

alias CFNotificationName = const(__CFString)*;

struct __CFNotificationCenter;
alias CFNotificationCenterRef = __CFNotificationCenter*;

alias CFNotificationCallback = void function(CFNotificationCenterRef center, void* observer, CFNotificationName name, const(void)* object, CFDictionaryRef userInfo);

alias __CF_ENUM_CFNotificationSuspensionBehavior = int;

enum CFNotificationSuspensionBehavior
{
    CFNotificationSuspensionBehaviorDrop = 1,

    CFNotificationSuspensionBehaviorCoalesce = 2,

    CFNotificationSuspensionBehaviorHold = 3,

    CFNotificationSuspensionBehaviorDeliverImmediately = 4
}

CFTypeID CFNotificationCenterGetTypeID();

CFNotificationCenterRef CFNotificationCenterGetLocalCenter();

CFNotificationCenterRef CFNotificationCenterGetDarwinNotifyCenter();

void CFNotificationCenterAddObserver(CFNotificationCenterRef center, const(void)* observer, CFNotificationCallback callBack, CFStringRef name, const(void)* object, CFNotificationSuspensionBehavior suspensionBehavior);

void CFNotificationCenterRemoveObserver(CFNotificationCenterRef center, const(void)* observer, CFNotificationName name, const(void)* object);
void CFNotificationCenterRemoveEveryObserver(CFNotificationCenterRef center, const(void)* observer);

void CFNotificationCenterPostNotification(CFNotificationCenterRef center, CFNotificationName name, const(void)* object, CFDictionaryRef userInfo, Boolean deliverImmediately);

enum
{
    kCFNotificationDeliverImmediately = 1UL << 0,
    kCFNotificationPostToAllSessions = 1UL << 1
}

void CFNotificationCenterPostNotificationWithOptions(CFNotificationCenterRef center, CFNotificationName name, const(void)* object, CFDictionaryRef userInfo, CFOptionFlags options);

