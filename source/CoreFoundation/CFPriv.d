module CoreFoundation.CFPriv;

import core.sys.posix.sys.select;
import core.sys.posix.sys.types;

public import CoreFoundation.CFArray;
public import CoreFoundation.CFBase;
public import CoreFoundation.CFBundle;
public import CoreFoundation.CFCharacterSet;
public import CoreFoundation.CFData;
public import CoreFoundation.CFDate;
public import CoreFoundation.CFDictionary;
public import CoreFoundation.CFError;
public import CoreFoundation.CFLocale;
public import CoreFoundation.CFSet;
public import CoreFoundation.CFString;
public import CoreFoundation.CFURL;

extern (C):

void _CFRuntimeSetCFMPresent(void* a);

const(char)* _CFProcessPath();
const(char*)* _CFGetProcessPath();
const(char*)* _CFGetProgname();

void _CFGetUGIDs(uid_t* euid, gid_t* egid);
uid_t _CFGetEUID();
uid_t _CFGetEGID();

CFPropertyListRef _CFURLCopyPropertyListRepresentation(CFURLRef url);
CFURLRef _CFURLCreateFromPropertyListRepresentation(CFAllocatorRef alloc, CFPropertyListRef pListRepresentation);

void CFPreferencesFlushCaches();

alias __CF_ENUM_CFURLComponentDecomposition = int;

enum CFURLComponentDecomposition
{
    kCFURLComponentDecompositionNonHierarchical = 0,
    kCFURLComponentDecompositionRFC1808 = 1,
    kCFURLComponentDecompositionRFC2396 = 2
}

struct CFURLComponentsNonHierarchical
{
    CFStringRef scheme;
    CFStringRef schemeSpecific;
}

struct CFURLComponentsRFC1808
{
    CFStringRef scheme;
    CFStringRef user;
    CFStringRef password;
    CFStringRef host;
    CFIndex port;
    CFArrayRef pathComponents;
    CFStringRef parameterString;
    CFStringRef query;
    CFStringRef fragment;
    CFURLRef baseURL;
}

struct CFURLComponentsRFC2396
{
    CFStringRef scheme;

    CFStringRef userinfo;
    CFStringRef host;
    CFIndex port;

    CFArrayRef pathComponents;
    CFStringRef query;
    CFStringRef fragment;
    CFURLRef baseURL;
}

Boolean _CFURLCopyComponents(
    CFURLRef url,
    CFURLComponentDecomposition decompositionType,
    void* components);

CFURLRef _CFURLCreateFromComponents(
    CFAllocatorRef alloc,
    CFURLComponentDecomposition decompositionType,
    const(void)* components);

Boolean _CFStringGetFileSystemRepresentation(CFStringRef string, UInt8* buffer, CFIndex maxBufLen);

CFStringRef _CFStringCreateWithBytesNoCopy(CFAllocatorRef alloc, const(UInt8)* bytes, CFIndex numBytes, CFStringEncoding encoding, Boolean externalFormat, CFAllocatorRef contentsDeallocator);

CFStringRef CFGetUserName();

CFStringRef CFCopyUserName();

CFURLRef CFCopyHomeDirectoryURLForUser(CFStringRef uName);

alias __CF_ENUM_CFSearchPathDirectory = int;

enum CFSearchPathDirectory
{
    kCFApplicationDirectory = 1,
    kCFDemoApplicationDirectory = 2,
    kCFDeveloperApplicationDirectory = 3,
    kCFAdminApplicationDirectory = 4,
    kCFLibraryDirectory = 5,
    kCFDeveloperDirectory = 6,
    kCFUserDirectory = 7,
    kCFDocumentationDirectory = 8,
    kCFDocumentDirectory = 9,

    kCFCoreServiceDirectory = 10,
    kCFAutosavedInformationDirectory = 11,
    kCFDesktopDirectory = 12,
    kCFCachesDirectory = 13,
    kCFApplicationSupportDirectory = 14,
    kCFDownloadsDirectory = 15,
    kCFInputMethodsDirectory = 16,
    kCFMoviesDirectory = 17,
    kCFMusicDirectory = 18,
    kCFPicturesDirectory = 19,
    kCFPrinterDescriptionDirectory = 20,
    kCFSharedPublicDirectory = 21,
    kCFPreferencePanesDirectory = 22,

    kCFAllApplicationsDirectory = 100,
    kCFAllLibrariesDirectory = 101
}

alias __CF_OPTIONS_CFSearchPathDomainMask = int;

enum CFSearchPathDomainMask
{
    kCFUserDomainMask = 1,
    kCFLocalDomainMask = 2,
    kCFNetworkDomainMask = 4,
    kCFSystemDomainMask = 8,
    kCFAllDomainsMask = 0x0ffff
}

extern __gshared const CFStringRef kCFFileURLExists;
extern __gshared const CFStringRef kCFFileURLPOSIXMode;
extern __gshared const CFStringRef kCFFileURLSize;
extern __gshared const CFStringRef kCFFileURLDirectoryContents;
extern __gshared const CFStringRef kCFFileURLLastModificationTime;
extern __gshared const CFStringRef kCFHTTPURLStatusCode;
extern __gshared const CFStringRef kCFHTTPURLStatusLine;

CFStringRef CFCopySystemVersionString();
CFDictionaryRef _CFCopySystemVersionDictionary();
CFDictionaryRef _CFCopyServerVersionDictionary();

CFDictionaryRef _CFCopySystemVersionPlatformDictionary();

CFStringRef _CFCopySystemVersionDictionaryValue(CFStringRef key);
extern __gshared const CFStringRef _kCFSystemVersionProductNameKey;
extern __gshared const CFStringRef _kCFSystemVersionProductCopyrightKey;
extern __gshared const CFStringRef _kCFSystemVersionProductVersionKey;
extern __gshared const CFStringRef _kCFSystemVersionProductVersionExtraKey;
extern __gshared const CFStringRef _kCFSystemVersionProductUserVisibleVersionKey;
extern __gshared const CFStringRef _kCFSystemVersionBuildVersionKey;
extern __gshared const CFStringRef _kCFSystemVersionProductVersionStringKey;
extern __gshared const CFStringRef _kCFSystemVersionBuildStringKey;

void CFMergeSortArray(void* list, CFIndex count, CFIndex elementSize, CFComparatorFunction comparator, void* context);
void CFQSortArray(void* list, CFIndex count, CFIndex elementSize, CFComparatorFunction comparator, void* context);

CFHashCode CFHashBytes(UInt8* bytes, CFIndex length);

alias __CF_ENUM_CFSystemVersion = int;

enum CFSystemVersion
{
    CFSystemVersionCheetah = 0,
    CFSystemVersionPuma = 1,
    CFSystemVersionJaguar = 2,
    CFSystemVersionPanther = 3,
    CFSystemVersionTiger = 4,
    CFSystemVersionLeopard = 5,
    CFSystemVersionSnowLeopard = 6,
    CFSystemVersionLion = 7,
    CFSystemVersionMountainLion = 8,
    CFSystemVersionMax = 9
}

Boolean _CFExecutableLinkedOnOrAfter(CFSystemVersion version_);

alias __CF_ENUM_CFStringCharacterClusterType = int;

enum CFStringCharacterClusterType
{
    kCFStringGraphemeCluster = 1,
    kCFStringComposedCharacterCluster = 2,
    kCFStringCursorMovementCluster = 3,
    kCFStringBackwardDeletionCluster = 4
}

CFRange CFStringGetRangeOfCharacterClusterAtIndex(CFStringRef string, CFIndex charIndex, CFStringCharacterClusterType type);

enum
{
    kCFCompareDiacriticsInsensitive = 128
}

enum
{
    kCFCompareIgnoreNonAlphanumeric = 1UL << 16
}

void _CFStringEncodingSetForceASCIICompatibility(Boolean flag);

const(UniChar)* CFStringGetCharactersPtrFromInlineBuffer(
    CFStringInlineBuffer* buf,
    CFRange desiredRange);

void CFStringGetCharactersFromInlineBuffer(
    CFStringInlineBuffer* buf,
    CFRange desiredRange,
    UniChar* outBuf);

enum __kCFStringAppendBufferLength = 1024;
struct CFStringAppendBuffer
{
    UniChar[__kCFStringAppendBufferLength] buffer;
    CFIndex bufferIndex;
    CFMutableStringRef theString;
}

void CFStringInitAppendBuffer(CFAllocatorRef alloc, CFStringAppendBuffer* buf);

void CFStringReleaseAppendBuffer(CFStringAppendBuffer* buf);

void CFStringAppendStringToAppendBuffer(
    CFStringAppendBuffer* buf,
    CFStringRef appendedString);

void CFStringAppendCharactersToAppendBuffer(
    CFStringAppendBuffer* buf,
    const(UniChar)* chars,
    CFIndex numChars);

CFMutableStringRef CFStringCreateMutableWithAppendBuffer(
    CFStringAppendBuffer* buf);

struct CFCharacterSetInlineBuffer
{
    CFCharacterSetRef cset;
    uint flags;
    uint rangeStart;
    uint rangeLimit;
    const(ubyte)* bitmap;
}

enum
{
    kCFCharacterSetIsCompactBitmap = 1UL << 0,
    kCFCharacterSetNoBitmapAvailable = 1UL << 1,
    kCFCharacterSetIsInverted = 1UL << 2
}

void CFCharacterSetInitInlineBuffer(
    CFCharacterSetRef cset,
    CFCharacterSetInlineBuffer* buffer);

bool CFCharacterSetInlineBufferIsLongCharacterMember(
    const(CFCharacterSetInlineBuffer)* buffer,
    UTF32Char character);

CFTypeRef _CFTryRetain(CFTypeRef cf);
Boolean _CFIsDeallocating(CFTypeRef cf);

Boolean _CFNonObjCEqual(CFTypeRef cf1, CFTypeRef cf2);
CFTypeRef _CFNonObjCRetain(CFTypeRef cf);
void _CFNonObjCRelease(CFTypeRef cf);
CFHashCode _CFNonObjCHash(CFTypeRef cf);

Boolean CFLocaleGetLanguageRegionEncodingForLocaleIdentifier(
    CFStringRef localeIdentifier,
    LangCode* langCode,
    RegionCode* regCode,
    ScriptCode* scriptCode,
    CFStringEncoding* stringEncoding);

void _CFCalendarResetCurrent();

CFAbsoluteTime _CFAbsoluteTimeFromFileTimeSpec(timespec ts);

timespec _CFFileTimeSpecFromAbsoluteTime(CFAbsoluteTime at);

bool _CFPropertyListCreateSingleValue(CFAllocatorRef allocator, CFDataRef data, CFOptionFlags option, CFStringRef keyPath, CFPropertyListRef* value, CFErrorRef* error);

bool _CFPropertyListCreateFiltered(CFAllocatorRef allocator, CFDataRef data, CFOptionFlags option, CFSetRef keyPaths, CFPropertyListRef* value, CFErrorRef* error);

CFSetRef _CFPropertyListCopyTopLevelKeys(CFAllocatorRef allocator, CFDataRef data, CFOptionFlags option, CFErrorRef* outError);

bool _CFPropertyListValidateData(CFDataRef data, CFTypeID* outTopLevelTypeID);

alias __CF_OPTIONS__CFBundleFilteredPlistOptions = int;

enum _CFBundleFilteredPlistOptions
{
    _CFBundleFilteredPlistMemoryMapped = 1
}

CFPropertyListRef _CFBundleCreateFilteredInfoPlist(CFBundleRef bundle, CFSetRef keyPaths, _CFBundleFilteredPlistOptions options);
CFPropertyListRef _CFBundleCreateFilteredLocalizedInfoPlist(CFBundleRef bundle, CFSetRef keyPaths, CFStringRef localizationName, _CFBundleFilteredPlistOptions options);

CFArrayRef CFDateFormatterCreateDateFormatsFromTemplates(CFAllocatorRef allocator, CFArrayRef tmplates, CFOptionFlags options, CFLocaleRef locale);

extern __gshared const CFStringRef kCFNumberFormatterUsesCharacterDirection;
extern __gshared const CFStringRef kCFDateFormatterUsesCharacterDirection;

void _CFGetPathExtensionRangesFromPathComponentUniChars(const(UniChar)* uchars, CFIndex ucharsLength, CFRange* outPrimaryExtRange, CFRange* outSecondaryExtRange);
void _CFGetPathExtensionRangesFromPathComponent(CFStringRef inName, CFRange* outPrimaryExtRange, CFRange* outSecondaryExtRange);
Boolean _CFExtensionUniCharsIsValidToAppend(const(UniChar)* uchars, CFIndex ucharsLength);
Boolean _CFExtensionIsValidToAppend(CFStringRef extension);

CFStringRef _CFXDGCreateDataHomePath();

CFStringRef _CFXDGCreateConfigHomePath();

CFArrayRef _CFXDGCreateDataDirectoriesPaths();

CFArrayRef _CFXDGCreateConfigDirectoriesPaths();

CFStringRef _CFXDGCreateCacheDirectoryPath();

CFStringRef _CFXDGCreateRuntimeDirectoryPath();

void* _CFGetHandleForInsertedOrInterposingLibrary(const(char)* namePrefix);

Boolean _CFRunLoopPerCalloutAutoreleasepoolEnabled();
Boolean _CFRunLoopSetPerCalloutAutoreleasepoolEnabled(Boolean enabled);

