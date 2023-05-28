module CoreFoundation.CFURLAccess;

public import CoreFoundation.CFArray;
public import CoreFoundation.CFBase;
public import CoreFoundation.CFData;
public import CoreFoundation.CFDictionary;
public import CoreFoundation.CFURL;

extern (C):

Boolean CFURLCreateDataAndPropertiesFromResource(
    CFAllocatorRef alloc,
    CFURLRef url,
    CFDataRef* resourceData,
    CFDictionaryRef* properties,
    CFArrayRef desiredProperties,
    SInt32* errorCode);

Boolean CFURLWriteDataAndPropertiesToResource(
    CFURLRef url,
    CFDataRef dataToWrite,
    CFDictionaryRef propertiesToWrite,
    SInt32* errorCode);

Boolean CFURLDestroyResource(CFURLRef url, SInt32* errorCode);

CFTypeRef CFURLCreatePropertyFromResource(
    CFAllocatorRef alloc,
    CFURLRef url,
    CFStringRef property,
    SInt32* errorCode);

alias __CF_ENUM_CFURLError = int;

enum CFURLError
{
    kCFURLUnknownError = -10L,
    kCFURLUnknownSchemeError = -11L,
    kCFURLResourceNotFoundError = -12L,
    kCFURLResourceAccessViolationError = -13L,
    kCFURLRemoteHostUnavailableError = -14L,
    kCFURLImproperArgumentsError = -15L,
    kCFURLUnknownPropertyKeyError = -16L,
    kCFURLPropertyKeyUnavailableError = -17L,
    kCFURLTimeoutError = -18L
}

extern __gshared const CFStringRef kCFURLFileExists;
extern __gshared const CFStringRef kCFURLFileDirectoryContents;
extern __gshared const CFStringRef kCFURLFileLength;
extern __gshared const CFStringRef kCFURLFileLastModificationTime;
extern __gshared const CFStringRef kCFURLFilePOSIXMode;
extern __gshared const CFStringRef kCFURLFileOwnerID;
extern __gshared const CFStringRef kCFURLHTTPStatusCode;
extern __gshared const CFStringRef kCFURLHTTPStatusLine;

