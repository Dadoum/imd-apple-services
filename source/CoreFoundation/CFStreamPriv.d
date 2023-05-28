module CoreFoundation.CFStreamPriv;

public import CoreFoundation.CFArray;
public import CoreFoundation.CFBase;
public import CoreFoundation.CFDate;
public import CoreFoundation.CFError;
public import CoreFoundation.CFRunLoop;
public import CoreFoundation.CFSocket;
public import CoreFoundation.CFStream;

extern (C):

struct _CFStream;

struct _CFStreamClient
{
    CFStreamClientContext cbContext;
    void function(_CFStream*, CFStreamEventType, void*) cb;
    CFOptionFlags when;
    CFRunLoopSourceRef rlSource;
    CFMutableArrayRef runLoopsAndModes;
    CFOptionFlags whatToSignal;
}

struct _CFStreamCallBacks
{
    CFIndex version_;
    void* function(_CFStream* stream, void* info) create;
    void function(_CFStream* stream, void* info) finalize;
    CFStringRef function(_CFStream* stream, void* info) copyDescription;

    Boolean function(_CFStream* stream, CFErrorRef* error, Boolean* openComplete, void* info) open;
    Boolean function(_CFStream* stream, CFErrorRef* error, void* info) openCompleted;
    CFIndex function(CFReadStreamRef stream, UInt8* buffer, CFIndex bufferLength, CFErrorRef* error, Boolean* atEOF, void* info) read;
    const(UInt8)* function(CFReadStreamRef sream, CFIndex maxBytesToRead, CFIndex* numBytesRead, CFErrorRef* error, Boolean* atEOF, void* info) getBuffer;
    Boolean function(CFReadStreamRef, CFErrorRef* error, void* info) canRead;
    CFIndex function(CFWriteStreamRef, const(UInt8)* buffer, CFIndex bufferLength, CFErrorRef* error, void* info) write;
    Boolean function(CFWriteStreamRef, CFErrorRef* error, void* info) canWrite;
    void function(_CFStream* stream, void* info) close;

    CFTypeRef function(_CFStream* stream, CFStringRef propertyName, void* info) copyProperty;
    Boolean function(_CFStream* stream, CFStringRef propertyName, CFTypeRef propertyValue, void* info) setProperty;
    void function(_CFStream* stream, CFOptionFlags events, void* info) requestEvents;
    void function(_CFStream* stream, CFRunLoopRef runLoop, CFStringRef runLoopMode, void* info) schedule;
    void function(_CFStream* stream, CFRunLoopRef runLoop, CFStringRef runLoopMode, void* info) unschedule;
}

void* _CFStreamGetInfoPointer(_CFStream* stream);

CFReadStreamRef _CFReadStreamCreateFromFileDescriptor(
    CFAllocatorRef alloc,
    int fd);

CFWriteStreamRef _CFWriteStreamCreateFromFileDescriptor(
    CFAllocatorRef alloc,
    int fd);

Boolean __CFSocketGetBytesAvailable(CFSocketRef s, CFIndex* ctBytesAvailable);

CFIndex __CFSocketRead(
    CFSocketRef s,
    UInt8* buffer,
    CFIndex length,
    int* error);

void __CFSocketSetSocketReadBufferAttrs(
    CFSocketRef s,
    CFTimeInterval timeout,
    CFIndex length);

extern __gshared const CFStringRef kCFStreamPropertySocketSSLContext;

extern __gshared const CFStringRef _kCFStreamPropertyFileNativeHandle;

extern __gshared const CFStringRef _kCFStreamPropertyHTTPTrailer;
