module CoreFoundation.CFMessagePort;

public import CoreFoundation.CFBase;
public import CoreFoundation.CFData;
public import CoreFoundation.CFDate;
public import CoreFoundation.CFRunLoop;

extern (C):

struct __CFMessagePort;
alias CFMessagePortRef = __CFMessagePort*;

enum
{
    kCFMessagePortSuccess = 0,
    kCFMessagePortSendTimeout = -1,
    kCFMessagePortReceiveTimeout = -2,
    kCFMessagePortIsInvalid = -3,
    kCFMessagePortTransportError = -4,
    kCFMessagePortBecameInvalidError = -5
}

struct CFMessagePortContext
{
    CFIndex version_;
    void* info;
    const(void)* function(const(void)* info) retain;
    void function(const(void)* info) release;
    CFStringRef function(const(void)* info) copyDescription;
}

alias CFMessagePortCallBack = const(__CFData)* function(CFMessagePortRef local, SInt32 msgid, CFDataRef data, void* info);

alias CFMessagePortInvalidationCallBack = void function(CFMessagePortRef ms, void* info);

CFTypeID CFMessagePortGetTypeID();

CFMessagePortRef CFMessagePortCreateLocal(CFAllocatorRef allocator, CFStringRef name, CFMessagePortCallBack callout, CFMessagePortContext* context, Boolean* shouldFreeInfo);
CFMessagePortRef CFMessagePortCreateRemote(CFAllocatorRef allocator, CFStringRef name);

Boolean CFMessagePortIsRemote(CFMessagePortRef ms);
CFStringRef CFMessagePortGetName(CFMessagePortRef ms);
Boolean CFMessagePortSetName(CFMessagePortRef ms, CFStringRef newName);
void CFMessagePortGetContext(CFMessagePortRef ms, CFMessagePortContext* context);
void CFMessagePortInvalidate(CFMessagePortRef ms);
Boolean CFMessagePortIsValid(CFMessagePortRef ms);
CFMessagePortInvalidationCallBack CFMessagePortGetInvalidationCallBack(CFMessagePortRef ms);
void CFMessagePortSetInvalidationCallBack(CFMessagePortRef ms, CFMessagePortInvalidationCallBack callout);

SInt32 CFMessagePortSendRequest(CFMessagePortRef remote, SInt32 msgid, CFDataRef data, CFTimeInterval sendTimeout, CFTimeInterval rcvTimeout, CFStringRef replyMode, CFDataRef* returnData);

CFRunLoopSourceRef CFMessagePortCreateRunLoopSource(CFAllocatorRef allocator, CFMessagePortRef local, CFIndex order);

