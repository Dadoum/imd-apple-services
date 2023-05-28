module CoreFoundation.CFSocket;

public import CoreFoundation.CFBase;
public import CoreFoundation.CFData;
public import CoreFoundation.CFDate;
public import CoreFoundation.CFRunLoop;

extern (C):

struct __CFSocket;
alias CFSocketRef = __CFSocket*;

alias __CF_ENUM_CFSocketError = int;

enum CFSocketError
{
    kCFSocketSuccess = 0,
    kCFSocketError = -1L,
    kCFSocketTimeout = -2L
}

struct CFSocketSignature
{
    SInt32 protocolFamily;
    SInt32 socketType;
    SInt32 protocol;
    CFDataRef address;
}

alias __CF_OPTIONS_CFSocketCallBackType = int;

enum CFSocketCallBackType
{
    kCFSocketNoCallBack = 0,
    kCFSocketReadCallBack = 1,
    kCFSocketAcceptCallBack = 2,
    kCFSocketDataCallBack = 3,
    kCFSocketConnectCallBack = 4,
    kCFSocketWriteCallBack = 8
}

enum
{
    kCFSocketAutomaticallyReenableReadCallBack = 1,
    kCFSocketAutomaticallyReenableAcceptCallBack = 2,
    kCFSocketAutomaticallyReenableDataCallBack = 3,
    kCFSocketAutomaticallyReenableWriteCallBack = 8,
    kCFSocketLeaveErrors = 64,
    kCFSocketCloseOnInvalidate = 128
}

alias CFSocketCallBack = void function(CFSocketRef s, CFSocketCallBackType type, CFDataRef address, const(void)* data, void* info);

struct CFSocketContext
{
    CFIndex version_;
    void* info;
    const(void)* function(const(void)* info) retain;
    void function(const(void)* info) release;
    CFStringRef function(const(void)* info) copyDescription;
}

alias CFSocketNativeHandle = int;

CFTypeID CFSocketGetTypeID();

CFSocketRef CFSocketCreate(CFAllocatorRef allocator, SInt32 protocolFamily, SInt32 socketType, SInt32 protocol, CFOptionFlags callBackTypes, CFSocketCallBack callout, const(CFSocketContext)* context);
CFSocketRef CFSocketCreateWithNative(CFAllocatorRef allocator, CFSocketNativeHandle sock, CFOptionFlags callBackTypes, CFSocketCallBack callout, const(CFSocketContext)* context);
CFSocketRef CFSocketCreateWithSocketSignature(CFAllocatorRef allocator, const(CFSocketSignature)* signature, CFOptionFlags callBackTypes, CFSocketCallBack callout, const(CFSocketContext)* context);

CFSocketRef CFSocketCreateConnectedToSocketSignature(CFAllocatorRef allocator, const(CFSocketSignature)* signature, CFOptionFlags callBackTypes, CFSocketCallBack callout, const(CFSocketContext)* context, CFTimeInterval timeout);

CFSocketError CFSocketSetAddress(CFSocketRef s, CFDataRef address);
CFSocketError CFSocketConnectToAddress(CFSocketRef s, CFDataRef address, CFTimeInterval timeout);
void CFSocketInvalidate(CFSocketRef s);

Boolean CFSocketIsValid(CFSocketRef s);
CFDataRef CFSocketCopyAddress(CFSocketRef s);
CFDataRef CFSocketCopyPeerAddress(CFSocketRef s);
void CFSocketGetContext(CFSocketRef s, CFSocketContext* context);
CFSocketNativeHandle CFSocketGetNative(CFSocketRef s);

CFRunLoopSourceRef CFSocketCreateRunLoopSource(CFAllocatorRef allocator, CFSocketRef s, CFIndex order);

CFOptionFlags CFSocketGetSocketFlags(CFSocketRef s);
void CFSocketSetSocketFlags(CFSocketRef s, CFOptionFlags flags);
void CFSocketDisableCallBacks(CFSocketRef s, CFOptionFlags callBackTypes);
void CFSocketEnableCallBacks(CFSocketRef s, CFOptionFlags callBackTypes);

CFSocketError CFSocketSendData(CFSocketRef s, CFDataRef address, CFDataRef data, CFTimeInterval timeout);

CFSocketError CFSocketRegisterValue(const(CFSocketSignature)* nameServerSignature, CFTimeInterval timeout, CFStringRef name, CFPropertyListRef value);
CFSocketError CFSocketCopyRegisteredValue(const(CFSocketSignature)* nameServerSignature, CFTimeInterval timeout, CFStringRef name, CFPropertyListRef* value, CFDataRef* nameServerAddress);

CFSocketError CFSocketRegisterSocketSignature(const(CFSocketSignature)* nameServerSignature, CFTimeInterval timeout, CFStringRef name, const(CFSocketSignature)* signature);
CFSocketError CFSocketCopyRegisteredSocketSignature(const(CFSocketSignature)* nameServerSignature, CFTimeInterval timeout, CFStringRef name, CFSocketSignature* signature, CFDataRef* nameServerAddress);

CFSocketError CFSocketUnregister(const(CFSocketSignature)* nameServerSignature, CFTimeInterval timeout, CFStringRef name);

void CFSocketSetDefaultNameRegistryPortNumber(UInt16 port);
UInt16 CFSocketGetDefaultNameRegistryPortNumber();

extern __gshared const CFStringRef kCFSocketCommandKey;
extern __gshared const CFStringRef kCFSocketNameKey;
extern __gshared const CFStringRef kCFSocketValueKey;
extern __gshared const CFStringRef kCFSocketResultKey;
extern __gshared const CFStringRef kCFSocketErrorKey;
extern __gshared const CFStringRef kCFSocketRegisterCommand;
extern __gshared const CFStringRef kCFSocketRetrieveCommand;

