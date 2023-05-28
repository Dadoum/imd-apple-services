module CoreFoundation.CFPropertyList;

public import CoreFoundation.CFBase;
public import CoreFoundation.CFData;
public import CoreFoundation.CFError;
public import CoreFoundation.CFStream;

extern (C):

alias __CF_OPTIONS_CFPropertyListMutabilityOptions = int;

enum CFPropertyListMutabilityOptions
{
    kCFPropertyListImmutable = 0,
    kCFPropertyListMutableContainers = 1 << 0,
    kCFPropertyListMutableContainersAndLeaves = 1 << 1
}

CFPropertyListRef CFPropertyListCreateFromXMLData(
    CFAllocatorRef allocator,
    CFDataRef xmlData,
    CFOptionFlags mutabilityOption,
    CFStringRef* errorString);

CFDataRef CFPropertyListCreateXMLData(
    CFAllocatorRef allocator,
    CFPropertyListRef propertyList);

CFPropertyListRef CFPropertyListCreateDeepCopy(
    CFAllocatorRef allocator,
    CFPropertyListRef propertyList,
    CFOptionFlags mutabilityOption);

alias __CF_ENUM_CFPropertyListFormat = int;

enum CFPropertyListFormat
{
    kCFPropertyListOpenStepFormat = 1,
    kCFPropertyListXMLFormat_v1_0 = 100,
    kCFPropertyListBinaryFormat_v1_0 = 200
}

Boolean CFPropertyListIsValid(
    CFPropertyListRef plist,
    CFPropertyListFormat format);

CFIndex CFPropertyListWriteToStream(
    CFPropertyListRef propertyList,
    CFWriteStreamRef stream,
    CFPropertyListFormat format,
    CFStringRef* errorString);

CFPropertyListRef CFPropertyListCreateFromStream(
    CFAllocatorRef allocator,
    CFReadStreamRef stream,
    CFIndex streamLength,
    CFOptionFlags mutabilityOption,
    CFPropertyListFormat* format,
    CFStringRef* errorString);

enum
{
    kCFPropertyListReadCorruptError = 3840,
    kCFPropertyListReadUnknownVersionError = 3841,
    kCFPropertyListReadStreamError = 3842,
    kCFPropertyListWriteStreamError = 3851
}

CFPropertyListRef CFPropertyListCreateWithData(
    CFAllocatorRef allocator,
    CFDataRef data,
    CFOptionFlags options,
    CFPropertyListFormat* format,
    CFErrorRef* error);

CFPropertyListRef CFPropertyListCreateWithStream(
    CFAllocatorRef allocator,
    CFReadStreamRef stream,
    CFIndex streamLength,
    CFOptionFlags options,
    CFPropertyListFormat* format,
    CFErrorRef* error);

CFIndex CFPropertyListWrite(
    CFPropertyListRef propertyList,
    CFWriteStreamRef stream,
    CFPropertyListFormat format,
    CFOptionFlags options,
    CFErrorRef* error);

CFDataRef CFPropertyListCreateData(
    CFAllocatorRef allocator,
    CFPropertyListRef propertyList,
    CFPropertyListFormat format,
    CFOptionFlags options,
    CFErrorRef* error);

