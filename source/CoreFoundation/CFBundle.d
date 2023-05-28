module CoreFoundation.CFBundle;

public import CoreFoundation.CFArray;
public import CoreFoundation.CFBase;
public import CoreFoundation.CFDictionary;
public import CoreFoundation.CFError;
public import CoreFoundation.CFURL;

extern (C):

struct __CFBundle;
alias CFBundleRef = __CFBundle*;
alias CFPlugInRef = __CFBundle*;

extern __gshared const CFStringRef kCFBundleInfoDictionaryVersionKey;

extern __gshared const CFStringRef kCFBundleExecutableKey;

extern __gshared const CFStringRef kCFBundleIdentifierKey;

extern __gshared const CFStringRef kCFBundleVersionKey;

extern __gshared const CFStringRef kCFBundleDevelopmentRegionKey;

extern __gshared const CFStringRef kCFBundleNameKey;

extern __gshared const CFStringRef kCFBundleLocalizationsKey;

CFBundleRef CFBundleGetMainBundle();

CFBundleRef CFBundleGetBundleWithIdentifier(CFStringRef bundleID);

CFArrayRef CFBundleGetAllBundles();

CFTypeID CFBundleGetTypeID();

CFBundleRef CFBundleCreate(CFAllocatorRef allocator, CFURLRef bundleURL);

CFArrayRef CFBundleCreateBundlesFromDirectory(
    CFAllocatorRef allocator,
    CFURLRef directoryURL,
    CFStringRef bundleType);

CFURLRef CFBundleCopyBundleURL(CFBundleRef bundle);

CFTypeRef CFBundleGetValueForInfoDictionaryKey(
    CFBundleRef bundle,
    CFStringRef key);

CFDictionaryRef CFBundleGetInfoDictionary(CFBundleRef bundle);

CFDictionaryRef CFBundleGetLocalInfoDictionary(CFBundleRef bundle);

void CFBundleGetPackageInfo(
    CFBundleRef bundle,
    UInt32* packageType,
    UInt32* packageCreator);

CFStringRef CFBundleGetIdentifier(CFBundleRef bundle);

UInt32 CFBundleGetVersionNumber(CFBundleRef bundle);

CFStringRef CFBundleGetDevelopmentRegion(CFBundleRef bundle);

CFURLRef CFBundleCopySupportFilesDirectoryURL(CFBundleRef bundle);

CFURLRef CFBundleCopyResourcesDirectoryURL(CFBundleRef bundle);

CFURLRef CFBundleCopyPrivateFrameworksURL(CFBundleRef bundle);

CFURLRef CFBundleCopySharedFrameworksURL(CFBundleRef bundle);

CFURLRef CFBundleCopySharedSupportURL(CFBundleRef bundle);

CFURLRef CFBundleCopyBuiltInPlugInsURL(CFBundleRef bundle);

CFDictionaryRef CFBundleCopyInfoDictionaryInDirectory(CFURLRef bundleURL);

Boolean CFBundleGetPackageInfoInDirectory(
    CFURLRef url,
    UInt32* packageType,
    UInt32* packageCreator);

CFURLRef CFBundleCopyResourceURL(
    CFBundleRef bundle,
    CFStringRef resourceName,
    CFStringRef resourceType,
    CFStringRef subDirName);

CFArrayRef CFBundleCopyResourceURLsOfType(
    CFBundleRef bundle,
    CFStringRef resourceType,
    CFStringRef subDirName);

CFStringRef CFBundleCopyLocalizedString(
    CFBundleRef bundle,
    CFStringRef key,
    CFStringRef value,
    CFStringRef tableName);

CFURLRef CFBundleCopyResourceURLInDirectory(
    CFURLRef bundleURL,
    CFStringRef resourceName,
    CFStringRef resourceType,
    CFStringRef subDirName);

CFArrayRef CFBundleCopyResourceURLsOfTypeInDirectory(
    CFURLRef bundleURL,
    CFStringRef resourceType,
    CFStringRef subDirName);

CFArrayRef CFBundleCopyBundleLocalizations(CFBundleRef bundle);

CFArrayRef CFBundleCopyPreferredLocalizationsFromArray(CFArrayRef locArray);

CFArrayRef CFBundleCopyLocalizationsForPreferences(
    CFArrayRef locArray,
    CFArrayRef prefArray);

CFURLRef CFBundleCopyResourceURLForLocalization(
    CFBundleRef bundle,
    CFStringRef resourceName,
    CFStringRef resourceType,
    CFStringRef subDirName,
    CFStringRef localizationName);

CFArrayRef CFBundleCopyResourceURLsOfTypeForLocalization(
    CFBundleRef bundle,
    CFStringRef resourceType,
    CFStringRef subDirName,
    CFStringRef localizationName);

CFDictionaryRef CFBundleCopyInfoDictionaryForURL(CFURLRef url);

CFArrayRef CFBundleCopyLocalizationsForURL(CFURLRef url);

CFArrayRef CFBundleCopyExecutableArchitecturesForURL(CFURLRef url);

CFURLRef CFBundleCopyExecutableURL(CFBundleRef bundle);

enum
{
    kCFBundleExecutableArchitectureI386 = 0x00000007,
    kCFBundleExecutableArchitecturePPC = 0x00000012,
    kCFBundleExecutableArchitectureX86_64 = 0x01000007,
    kCFBundleExecutableArchitecturePPC64 = 0x01000012,
    kCFBundleExecutableArchitectureARM64 = 16777228
}

CFArrayRef CFBundleCopyExecutableArchitectures(CFBundleRef bundle);

Boolean CFBundlePreflightExecutable(CFBundleRef bundle, CFErrorRef* error);

Boolean CFBundleLoadExecutableAndReturnError(
    CFBundleRef bundle,
    CFErrorRef* error);

Boolean CFBundleLoadExecutable(CFBundleRef bundle);

Boolean CFBundleIsExecutableLoaded(CFBundleRef bundle);

void CFBundleUnloadExecutable(CFBundleRef bundle);

void* CFBundleGetFunctionPointerForName(
    CFBundleRef bundle,
    CFStringRef functionName);

void CFBundleGetFunctionPointersForNames(
    CFBundleRef bundle,
    CFArrayRef functionNames,
    void** ftbl);

void* CFBundleGetDataPointerForName(CFBundleRef bundle, CFStringRef symbolName);

void CFBundleGetDataPointersForNames(
    CFBundleRef bundle,
    CFArrayRef symbolNames,
    void** stbl);

CFURLRef CFBundleCopyAuxiliaryExecutableURL(
    CFBundleRef bundle,
    CFStringRef executableName);

CFPlugInRef CFBundleGetPlugIn(CFBundleRef bundle);

alias CFBundleRefNum = int;

CFBundleRefNum CFBundleOpenBundleResourceMap(CFBundleRef bundle);

SInt32 CFBundleOpenBundleResourceFiles(
    CFBundleRef bundle,
    CFBundleRefNum* refNum,
    CFBundleRefNum* localizedRefNum);

void CFBundleCloseBundleResourceMap(CFBundleRef bundle, CFBundleRefNum refNum);

