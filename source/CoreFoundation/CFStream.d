module CoreFoundation.CFStream;

public import CoreFoundation.CFBase;
public import CoreFoundation.CFError;
public import CoreFoundation.CFRunLoop;
public import CoreFoundation.CFSocket;
public import CoreFoundation.CFURL;

extern (C):

struct CFStreamError
{
    CFIndex domain;
    SInt32 error;
}

alias CFStreamPropertyKey = const(__CFString)*;

alias __CF_ENUM_CFStreamStatus = int;

enum CFStreamStatus
{
    kCFStreamStatusNotOpen = 0,
    kCFStreamStatusOpening = 1,
    kCFStreamStatusOpen = 2,
    kCFStreamStatusReading = 3,
    kCFStreamStatusWriting = 4,
    kCFStreamStatusAtEnd = 5,
    kCFStreamStatusClosed = 6,
    kCFStreamStatusError = 7
}

alias __CF_OPTIONS_CFStreamEventType = int;

enum CFStreamEventType
{
    kCFStreamEventNone = 0,
    kCFStreamEventOpenCompleted = 1,
    kCFStreamEventHasBytesAvailable = 2,
    kCFStreamEventCanAcceptBytes = 4,
    kCFStreamEventErrorOccurred = 8,
    kCFStreamEventEndEncountered = 16
}

struct CFStreamClientContext
{
    CFIndex version_;
    void* info;
    void* function(void* info) retain;
    void function(void* info) release;
    CFStringRef function(void* info) copyDescription;
}

struct __CFReadStream;
alias CFReadStreamRef = __CFReadStream*;
struct __CFWriteStream;
alias CFWriteStreamRef = __CFWriteStream*;

alias CFReadStreamClientCallBack = void function(CFReadStreamRef stream, CFStreamEventType type, void* clientCallBackInfo);
alias CFWriteStreamClientCallBack = void function(CFWriteStreamRef stream, CFStreamEventType type, void* clientCallBackInfo);

CFTypeID CFReadStreamGetTypeID();
CFTypeID CFWriteStreamGetTypeID();

extern __gshared CFStreamPropertyKey kCFStreamPropertyDataWritten;

CFReadStreamRef CFReadStreamCreateWithBytesNoCopy(
    CFAllocatorRef alloc,
    const(UInt8)* bytes,
    CFIndex length,
    CFAllocatorRef bytesDeallocator);

CFWriteStreamRef CFWriteStreamCreateWithBuffer(
    CFAllocatorRef alloc,
    UInt8* buffer,
    CFIndex bufferCapacity);

CFWriteStreamRef CFWriteStreamCreateWithAllocatedBuffers(
    CFAllocatorRef alloc,
    CFAllocatorRef bufferAllocator);

CFReadStreamRef CFReadStreamCreateWithFile(
    CFAllocatorRef alloc,
    CFURLRef fileURL);
CFWriteStreamRef CFWriteStreamCreateWithFile(
    CFAllocatorRef alloc,
    CFURLRef fileURL);
void CFStreamCreateBoundPair(
    CFAllocatorRef alloc,
    CFReadStreamRef* readStream,
    CFWriteStreamRef* writeStream,
    CFIndex transferBufferSize);

extern __gshared CFStreamPropertyKey kCFStreamPropertyAppendToFile;

extern __gshared CFStreamPropertyKey kCFStreamPropertyFileCurrentOffset;

extern __gshared CFStreamPropertyKey kCFStreamPropertySocketNativeHandle;

extern __gshared CFStreamPropertyKey kCFStreamPropertySocketRemoteHostName;

extern __gshared CFStreamPropertyKey kCFStreamPropertySocketRemotePortNumber;

extern __gshared const int kCFStreamErrorDomainSOCKS;

extern __gshared CFStringRef kCFStreamPropertySOCKSProxy;

extern __gshared CFStringRef kCFStreamPropertySOCKSProxyHost;

extern __gshared CFStringRef kCFStreamPropertySOCKSProxyPort;

extern __gshared CFStringRef kCFStreamPropertySOCKSVersion;

extern __gshared CFStringRef kCFStreamSocketSOCKSVersion4;

extern __gshared CFStringRef kCFStreamSocketSOCKSVersion5;

extern __gshared CFStringRef kCFStreamPropertySOCKSUser;

extern __gshared CFStringRef kCFStreamPropertySOCKSPassword;

extern __gshared const int kCFStreamErrorDomainSSL;

extern __gshared CFStringRef kCFStreamPropertySocketSecurityLevel;

extern __gshared CFStringRef kCFStreamSocketSecurityLevelNone;

extern __gshared CFStringRef kCFStreamSocketSecurityLevelSSLv2;

extern __gshared CFStringRef kCFStreamSocketSecurityLevelSSLv3;

extern __gshared CFStringRef kCFStreamSocketSecurityLevelTLSv1;

extern __gshared CFStringRef kCFStreamSocketSecurityLevelNegotiatedSSL;

extern __gshared CFStringRef kCFStreamPropertyShouldCloseNativeSocket;

void CFStreamCreatePairWithSocket(
    CFAllocatorRef alloc,
    CFSocketNativeHandle sock,
    CFReadStreamRef* readStream,
    CFWriteStreamRef* writeStream);
void CFStreamCreatePairWithSocketToHost(
    CFAllocatorRef alloc,
    CFStringRef host,
    UInt32 port,
    CFReadStreamRef* readStream,
    CFWriteStreamRef* writeStream);
void CFStreamCreatePairWithPeerSocketSignature(
    CFAllocatorRef alloc,
    const(CFSocketSignature)* signature,
    CFReadStreamRef* readStream,
    CFWriteStreamRef* writeStream);

CFStreamStatus CFReadStreamGetStatus(CFReadStreamRef stream);
CFStreamStatus CFWriteStreamGetStatus(CFWriteStreamRef stream);

CFErrorRef CFReadStreamCopyError(CFReadStreamRef stream);
CFErrorRef CFWriteStreamCopyError(CFWriteStreamRef stream);

Boolean CFReadStreamOpen(CFReadStreamRef stream);
Boolean CFWriteStreamOpen(CFWriteStreamRef stream);

void CFReadStreamClose(CFReadStreamRef stream);
void CFWriteStreamClose(CFWriteStreamRef stream);

Boolean CFReadStreamHasBytesAvailable(CFReadStreamRef stream);

CFIndex CFReadStreamRead(
    CFReadStreamRef stream,
    UInt8* buffer,
    CFIndex bufferLength);

const(UInt8)* CFReadStreamGetBuffer(
    CFReadStreamRef stream,
    CFIndex maxBytesToRead,
    CFIndex* numBytesRead);

Boolean CFWriteStreamCanAcceptBytes(CFWriteStreamRef stream);

CFIndex CFWriteStreamWrite(
    CFWriteStreamRef stream,
    const(UInt8)* buffer,
    CFIndex bufferLength);

CFTypeRef CFReadStreamCopyProperty(
    CFReadStreamRef stream,
    CFStreamPropertyKey propertyName);
CFTypeRef CFWriteStreamCopyProperty(
    CFWriteStreamRef stream,
    CFStreamPropertyKey propertyName);

Boolean CFReadStreamSetProperty(
    CFReadStreamRef stream,
    CFStreamPropertyKey propertyName,
    CFTypeRef propertyValue);
Boolean CFWriteStreamSetProperty(
    CFWriteStreamRef stream,
    CFStreamPropertyKey propertyName,
    CFTypeRef propertyValue);

Boolean CFReadStreamSetClient(
    CFReadStreamRef stream,
    CFOptionFlags streamEvents,
    CFReadStreamClientCallBack clientCB,
    CFStreamClientContext* clientContext);
Boolean CFWriteStreamSetClient(
    CFWriteStreamRef stream,
    CFOptionFlags streamEvents,
    CFWriteStreamClientCallBack clientCB,
    CFStreamClientContext* clientContext);

void CFReadStreamScheduleWithRunLoop(
    CFReadStreamRef stream,
    CFRunLoopRef runLoop,
    CFRunLoopMode runLoopMode);
void CFWriteStreamScheduleWithRunLoop(
    CFWriteStreamRef stream,
    CFRunLoopRef runLoop,
    CFRunLoopMode runLoopMode);

void CFReadStreamUnscheduleFromRunLoop(
    CFReadStreamRef stream,
    CFRunLoopRef runLoop,
    CFRunLoopMode runLoopMode);
void CFWriteStreamUnscheduleFromRunLoop(
    CFWriteStreamRef stream,
    CFRunLoopRef runLoop,
    CFRunLoopMode runLoopMode);

alias __CF_ENUM_CFStreamErrorDomain = int;

enum CFStreamErrorDomain
{
    kCFStreamErrorDomainCustom = -1L,
    kCFStreamErrorDomainPOSIX = 1,
    kCFStreamErrorDomainMacOSStatus = 2
}

CFStreamError CFReadStreamGetError(CFReadStreamRef stream);
CFStreamError CFWriteStreamGetError(CFWriteStreamRef stream);

