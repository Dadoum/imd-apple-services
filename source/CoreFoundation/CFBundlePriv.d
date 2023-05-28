module CoreFoundation.CFBundlePriv;

public import CoreFoundation.CFArray;
public import CoreFoundation.CFBase;
public import CoreFoundation.CFBundle;
public import CoreFoundation.CFData;
public import CoreFoundation.CFDictionary;
public import CoreFoundation.CFString;
public import CoreFoundation.CFURL;

extern (C):

extern __gshared const CFStringRef _kCFBundlePackageTypeKey;
extern __gshared const CFStringRef _kCFBundleSignatureKey;
extern __gshared const CFStringRef _kCFBundleIconFileKey;
extern __gshared const CFStringRef _kCFBundleDocumentTypesKey;
extern __gshared const CFStringRef _kCFBundleURLTypesKey;

extern __gshared const CFStringRef _kCFBundleDisplayNameKey;
extern __gshared const CFStringRef _kCFBundleShortVersionStringKey;
extern __gshared const CFStringRef _kCFBundleGetInfoStringKey;
extern __gshared const CFStringRef _kCFBundleGetInfoHTMLKey;

extern __gshared const CFStringRef _kCFBundleTypeNameKey;
extern __gshared const CFStringRef _kCFBundleTypeRoleKey;
extern __gshared const CFStringRef _kCFBundleTypeIconFileKey;
extern __gshared const CFStringRef _kCFBundleTypeOSTypesKey;
extern __gshared const CFStringRef _kCFBundleTypeExtensionsKey;
extern __gshared const CFStringRef _kCFBundleTypeMIMETypesKey;

extern __gshared const CFStringRef _kCFBundleURLNameKey;
extern __gshared const CFStringRef _kCFBundleURLIconFileKey;
extern __gshared const CFStringRef _kCFBundleURLSchemesKey;

extern __gshared const CFStringRef _kCFBundleOldExecutableKey;
extern __gshared const CFStringRef _kCFBundleOldInfoDictionaryVersionKey;
extern __gshared const CFStringRef _kCFBundleOldNameKey;
extern __gshared const CFStringRef _kCFBundleOldIconFileKey;
extern __gshared const CFStringRef _kCFBundleOldDocumentTypesKey;
extern __gshared const CFStringRef _kCFBundleOldShortVersionStringKey;

extern __gshared const CFStringRef _kCFBundleOldTypeNameKey;
extern __gshared const CFStringRef _kCFBundleOldTypeRoleKey;
extern __gshared const CFStringRef _kCFBundleOldTypeIconFileKey;
extern __gshared const CFStringRef _kCFBundleOldTypeExtensions1Key;
extern __gshared const CFStringRef _kCFBundleOldTypeExtensions2Key;
extern __gshared const CFStringRef _kCFBundleOldTypeOSTypesKey;

extern __gshared const CFStringRef _kCFBundleSupportedPlatformsKey;

extern __gshared const CFStringRef _kCFBundleResourceSpecificationKey;

CFURLRef _CFBundleCopyBundleURLForExecutableURL(CFURLRef url);

Boolean _CFBundleURLLooksLikeBundle(CFURLRef url);

CFBundleRef _CFBundleCreateIfLooksLikeBundle(
    CFAllocatorRef allocator,
    CFURLRef url);

CFBundleRef _CFBundleGetMainBundleIfLooksLikeBundle();

Boolean _CFBundleMainBundleInfoDictionaryComesFromResourceFork();

CFBundleRef _CFBundleCreateWithExecutableURLIfLooksLikeBundle(
    CFAllocatorRef allocator,
    CFURLRef url);

CFURLRef _CFBundleCopyMainBundleExecutableURL(Boolean* looksLikeBundle);

CFBundleRef _CFBundleGetExistingBundleWithBundleURL(CFURLRef bundleURL);

CFArrayRef _CFBundleGetSupportedPlatforms(CFBundleRef bundle);

CFStringRef _CFBundleGetCurrentPlatform();

CFBundleRef _CFBundleCreateUnique(CFAllocatorRef allocator, CFURLRef bundleURL);

CFBundleRef _CFBundleCreateIfMightBeBundle(
    CFAllocatorRef allocator,
    CFURLRef url);

CFBundleRef _CFBundleCreateWithExecutableURLIfMightBeBundle(
    CFAllocatorRef allocator,
    CFURLRef url);

CFURLRef _CFBundleCopyResourceForkURL(CFBundleRef bundle);

CFURLRef _CFBundleCopyInfoPlistURL(CFBundleRef bundle);

CFURLRef _CFBundleCopyExecutableURLInDirectory(CFURLRef url);

CFURLRef _CFBundleCopyOtherExecutableURLInDirectory(CFURLRef url);

void _CFBundleGetLanguageAndRegionCodes(
    SInt32* languageCode,
    SInt32* regionCode);

Boolean CFBundleGetLocalizationInfoForLocalization(
    CFStringRef localizationName,
    SInt32* languageCode,
    SInt32* regionCode,
    SInt32* scriptCode,
    CFStringEncoding* stringEncoding);

CFStringRef CFBundleCopyLocalizationForLocalizationInfo(
    SInt32 languageCode,
    SInt32 regionCode,
    SInt32 scriptCode,
    CFStringEncoding stringEncoding);

CFStringRef CFBundleCopyLocalizedStringForLocalization(CFBundleRef bundle, CFStringRef key, CFStringRef value, CFStringRef tableName, CFStringRef localizationName);

void _CFBundleSetDefaultLocalization(CFStringRef localizationName);

void* _CFBundleGetCFMFunctionPointerForName(
    CFBundleRef bundle,
    CFStringRef funcName);

void _CFBundleGetCFMFunctionPointersForNames(
    CFBundleRef bundle,
    CFArrayRef functionNames,
    void** ftbl);

void _CFBundleSetCFMConnectionID(CFBundleRef bundle, void* connectionID);

CFStringRef _CFBundleCopyFileTypeForFileURL(CFURLRef url);

CFStringRef _CFBundleCopyFileTypeForFileData(CFDataRef data);

Boolean _CFBundleGetHasChanged(CFBundleRef bundle);

void _CFBundleFlushCaches();

void _CFBundleFlushCachesForURL(CFURLRef url);

void _CFBundleFlushBundleCaches(CFBundleRef bundle);

void _CFBundleFlushLanguageCachesAfterEUIDChange();

CFArrayRef _CFBundleCopyAllBundles();

void _CFBundleSetStringsFilesShared(CFBundleRef bundle, Boolean flag);

Boolean _CFBundleGetStringsFilesShared(CFBundleRef bundle);

CFURLRef _CFBundleCopyFrameworkURLForExecutablePath(CFStringRef executablePath);

CFBundleRef _CFBundleGetBundleWithIdentifierAndLibraryName(
    CFStringRef bundleID,
    CFStringRef libraryName);

CFBundleRef _CFBundleGetBundleWithIdentifierWithHint(
    CFStringRef bundleID,
    void* pointer);

CFURLRef _CFBundleCopyWrappedBundleURL(CFBundleRef bundle);

CFURLRef _CFBundleCopyWrapperContainerURL(CFBundleRef bundle);

Boolean _CFBundleAddResourceURL(CFBundleRef bundle, CFURLRef url);

Boolean _CFBundleRemoveResourceURL(CFBundleRef bundle, CFURLRef url);

CFStringRef _CFDoubledStringCreate(CFStringRef theString);

CFStringRef _CFAccentuatedStringCreate(CFStringRef theString);

CFStringRef _CFAffixedStringCreate(
    CFStringRef theString,
    CFStringRef prefix,
    CFStringRef suffix);

CFStringRef _CFRLORightToLeftStringCreate(CFStringRef theString);

CFDictionaryRef _CFBundleGetLocalInfoDictionary(CFBundleRef bundle);

CFPropertyListRef _CFBundleGetValueForInfoKey(
    CFBundleRef bundle,
    CFStringRef key);

Boolean _CFBundleGetPackageInfoInDirectory(
    CFAllocatorRef alloc,
    CFURLRef url,
    UInt32* packageType,
    UInt32* packageCreator);

CFDictionaryRef _CFBundleCopyInfoDictionaryInResourceFork(CFURLRef url);

CFURLRef _CFBundleCopyPrivateFrameworksURL(CFBundleRef bundle);

CFURLRef _CFBundleCopySharedFrameworksURL(CFBundleRef bundle);

CFURLRef _CFBundleCopySharedSupportURL(CFBundleRef bundle);

CFURLRef _CFBundleCopyResourceURLForLanguage(
    CFBundleRef bundle,
    CFStringRef resourceName,
    CFStringRef resourceType,
    CFStringRef subDirName,
    CFStringRef language);

CFArrayRef _CFBundleCopyResourceURLsOfTypeForLanguage(
    CFBundleRef bundle,
    CFStringRef resourceType,
    CFStringRef subDirName,
    CFStringRef language);

CFBundleRefNum _CFBundleOpenBundleResourceFork(CFBundleRef bundle);

void _CFBundleCloseBundleResourceFork(CFBundleRef bundle);

