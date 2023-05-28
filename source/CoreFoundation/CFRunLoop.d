module CoreFoundation.CFRunLoop;

public import CoreFoundation.CFArray;
public import CoreFoundation.CFBase;
public import CoreFoundation.CFDate;

extern (C):

alias CFRunLoopMode = const(__CFString)*;

struct __CFRunLoop;
alias CFRunLoopRef = __CFRunLoop*;

struct __CFRunLoopSource;
alias CFRunLoopSourceRef = __CFRunLoopSource*;

struct __CFRunLoopObserver;
alias CFRunLoopObserverRef = __CFRunLoopObserver*;

struct __CFRunLoopTimer;
alias CFRunLoopTimerRef = __CFRunLoopTimer*;

alias __CF_ENUM_CFRunLoopRunResult = int;

enum CFRunLoopRunResult
{
    kCFRunLoopRunFinished = 1,
    kCFRunLoopRunStopped = 2,
    kCFRunLoopRunTimedOut = 3,
    kCFRunLoopRunHandledSource = 4
}

alias __CF_OPTIONS_CFRunLoopActivity = int;

enum CFRunLoopActivity
{
    kCFRunLoopEntry = 1UL << 0,
    kCFRunLoopBeforeTimers = 1UL << 1,
    kCFRunLoopBeforeSources = 1UL << 2,
    kCFRunLoopBeforeWaiting = 1UL << 5,
    kCFRunLoopAfterWaiting = 1UL << 6,
    kCFRunLoopExit = 1UL << 7,
    kCFRunLoopAllActivities = 0x0FFFFFFFU
}

extern __gshared const CFRunLoopMode kCFRunLoopDefaultMode;
extern __gshared const CFRunLoopMode kCFRunLoopCommonModes;

CFTypeID CFRunLoopGetTypeID();

CFRunLoopRef CFRunLoopGetCurrent();
CFRunLoopRef CFRunLoopGetMain();

CFRunLoopMode CFRunLoopCopyCurrentMode(CFRunLoopRef rl);

CFArrayRef CFRunLoopCopyAllModes(CFRunLoopRef rl);

void CFRunLoopAddCommonMode(CFRunLoopRef rl, CFRunLoopMode mode);

CFAbsoluteTime CFRunLoopGetNextTimerFireDate(CFRunLoopRef rl, CFRunLoopMode mode);

void CFRunLoopRun();
CFRunLoopRunResult CFRunLoopRunInMode(CFRunLoopMode mode, CFTimeInterval seconds, Boolean returnAfterSourceHandled);
Boolean CFRunLoopIsWaiting(CFRunLoopRef rl);
void CFRunLoopWakeUp(CFRunLoopRef rl);
void CFRunLoopStop(CFRunLoopRef rl);

Boolean CFRunLoopContainsSource(CFRunLoopRef rl, CFRunLoopSourceRef source, CFRunLoopMode mode);
void CFRunLoopAddSource(CFRunLoopRef rl, CFRunLoopSourceRef source, CFRunLoopMode mode);
void CFRunLoopRemoveSource(CFRunLoopRef rl, CFRunLoopSourceRef source, CFRunLoopMode mode);

Boolean CFRunLoopContainsObserver(CFRunLoopRef rl, CFRunLoopObserverRef observer, CFRunLoopMode mode);
void CFRunLoopAddObserver(CFRunLoopRef rl, CFRunLoopObserverRef observer, CFRunLoopMode mode);
void CFRunLoopRemoveObserver(CFRunLoopRef rl, CFRunLoopObserverRef observer, CFRunLoopMode mode);

Boolean CFRunLoopContainsTimer(CFRunLoopRef rl, CFRunLoopTimerRef timer, CFRunLoopMode mode);
void CFRunLoopAddTimer(CFRunLoopRef rl, CFRunLoopTimerRef timer, CFRunLoopMode mode);
void CFRunLoopRemoveTimer(CFRunLoopRef rl, CFRunLoopTimerRef timer, CFRunLoopMode mode);

struct CFRunLoopSourceContext
{
    CFIndex version_;
    void* info;
    const(void)* function(const(void)* info) retain;
    void function(const(void)* info) release;
    CFStringRef function(const(void)* info) copyDescription;
    Boolean function(const(void)* info1, const(void)* info2) equal;
    CFHashCode function(const(void)* info) hash;
    void function(void* info, CFRunLoopRef rl, CFRunLoopMode mode) schedule;
    void function(void* info, CFRunLoopRef rl, CFRunLoopMode mode) cancel;
    void function(void* info) perform;
}

struct CFRunLoopSourceContext1
{
    CFIndex version_;
    void* info;
    const(void)* function(const(void)* info) retain;
    void function(const(void)* info) release;
    CFStringRef function(const(void)* info) copyDescription;
    Boolean function(const(void)* info1, const(void)* info2) equal;
    CFHashCode function(const(void)* info) hash;

    void* function(void* info) getPort;
    void function(void* info) perform;
}

CFTypeID CFRunLoopSourceGetTypeID();

CFRunLoopSourceRef CFRunLoopSourceCreate(CFAllocatorRef allocator, CFIndex order, CFRunLoopSourceContext* context);

CFIndex CFRunLoopSourceGetOrder(CFRunLoopSourceRef source);
void CFRunLoopSourceInvalidate(CFRunLoopSourceRef source);
Boolean CFRunLoopSourceIsValid(CFRunLoopSourceRef source);
void CFRunLoopSourceGetContext(CFRunLoopSourceRef source, CFRunLoopSourceContext* context);
void CFRunLoopSourceSignal(CFRunLoopSourceRef source);

struct CFRunLoopObserverContext
{
    CFIndex version_;
    void* info;
    const(void)* function(const(void)* info) retain;
    void function(const(void)* info) release;
    CFStringRef function(const(void)* info) copyDescription;
}

alias CFRunLoopObserverCallBack = void function(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void* info);

CFTypeID CFRunLoopObserverGetTypeID();

CFRunLoopObserverRef CFRunLoopObserverCreate(CFAllocatorRef allocator, CFOptionFlags activities, Boolean repeats, CFIndex order, CFRunLoopObserverCallBack callout, CFRunLoopObserverContext* context);

CFOptionFlags CFRunLoopObserverGetActivities(CFRunLoopObserverRef observer);
Boolean CFRunLoopObserverDoesRepeat(CFRunLoopObserverRef observer);
CFIndex CFRunLoopObserverGetOrder(CFRunLoopObserverRef observer);
void CFRunLoopObserverInvalidate(CFRunLoopObserverRef observer);
Boolean CFRunLoopObserverIsValid(CFRunLoopObserverRef observer);
void CFRunLoopObserverGetContext(CFRunLoopObserverRef observer, CFRunLoopObserverContext* context);

struct CFRunLoopTimerContext
{
    CFIndex version_;
    void* info;
    const(void)* function(const(void)* info) retain;
    void function(const(void)* info) release;
    CFStringRef function(const(void)* info) copyDescription;
}

alias CFRunLoopTimerCallBack = void function(CFRunLoopTimerRef timer, void* info);

CFTypeID CFRunLoopTimerGetTypeID();

CFRunLoopTimerRef CFRunLoopTimerCreate(CFAllocatorRef allocator, CFAbsoluteTime fireDate, CFTimeInterval interval, CFOptionFlags flags, CFIndex order, CFRunLoopTimerCallBack callout, CFRunLoopTimerContext* context);

CFAbsoluteTime CFRunLoopTimerGetNextFireDate(CFRunLoopTimerRef timer);
void CFRunLoopTimerSetNextFireDate(CFRunLoopTimerRef timer, CFAbsoluteTime fireDate);
CFTimeInterval CFRunLoopTimerGetInterval(CFRunLoopTimerRef timer);
Boolean CFRunLoopTimerDoesRepeat(CFRunLoopTimerRef timer);
CFIndex CFRunLoopTimerGetOrder(CFRunLoopTimerRef timer);
void CFRunLoopTimerInvalidate(CFRunLoopTimerRef timer);
Boolean CFRunLoopTimerIsValid(CFRunLoopTimerRef timer);
void CFRunLoopTimerGetContext(CFRunLoopTimerRef timer, CFRunLoopTimerContext* context);

CFTimeInterval CFRunLoopTimerGetTolerance(CFRunLoopTimerRef timer);
void CFRunLoopTimerSetTolerance(CFRunLoopTimerRef timer, CFTimeInterval tolerance);

