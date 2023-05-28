module CoreFoundation.CFURLPriv;

public import CoreFoundation.CFArray;
public import CoreFoundation.CFBase;
public import CoreFoundation.CFData;
public import CoreFoundation.CFDictionary;
public import CoreFoundation.CFError;
public import CoreFoundation.CFNotificationCenter;
public import CoreFoundation.CFString;
public import CoreFoundation.CFURL;

extern (C):

CFIndex CFURLGetBytesUsingEncoding(
    CFURLRef url,
    UInt8* buffer,
    CFIndex bufferLength,
    CFStringEncoding encoding);

enum
{
    kCFURLNoSuchResourceError = 4,
    kCFURLResourceLockingError = 255,
    kCFURLReadUnknownError = 256,
    kCFURLReadNoPermissionError = 257,
    kCFURLReadInvalidResourceNameError = 258,
    kCFURLReadCorruptResourceError = 259,
    kCFURLReadNoSuchResourceError = 260,
    kCFURLReadInapplicableStringEncodingError = 261,
    kCFURLReadUnsupportedSchemeError = 262,
    kCFURLReadTooLargeError = 263,
    kCFURLReadUnknownStringEncodingError = 264,
    kCFURLWriteUnknownError = 512,
    kCFURLWriteNoPermissionError = 513,
    kCFURLWriteInvalidResourceNameError = 514,
    kCFURLWriteInapplicableStringEncodingError = 517,
    kCFURLWriteUnsupportedSchemeError = 518,
    kCFURLWriteOutOfSpaceError = 640,
    kCFURLWriteVolumeReadOnlyError = 642
}

extern __gshared const CFStringRef _kCFURLPathKey;

extern __gshared const CFStringRef _kCFURLVolumeIDKey;

extern __gshared const CFStringRef _kCFURLInodeNumberKey;

extern __gshared const CFStringRef _kCFURLFileIDKey;

extern __gshared const CFStringRef _kCFURLParentDirectoryIDKey;

extern __gshared const CFStringRef _kCFURLDistinctLocalizedNameKey;

extern __gshared const CFStringRef _kCFURLNameExtensionKey;

extern __gshared const CFStringRef _kCFURLFinderInfoKey;

extern __gshared const CFStringRef _kCFURLHFSTypeCodeKey;

extern __gshared const CFStringRef _kCFURLIsUserNoDumpKey;

extern __gshared const CFStringRef _kCFURLIsUserAppendKey;

extern __gshared const CFStringRef _kCFURLIsUserOpaqueKey;

extern __gshared const CFStringRef _kCFURLIsCompressedKey;

extern __gshared const CFStringRef _kCFURLIsUserTrackedKey;

extern __gshared const CFStringRef _kCFURLIsUserDataVaultKey;

extern __gshared const CFStringRef _kCFURLIsSystemArchivedKey;

extern __gshared const CFStringRef _kCFURLIsSystemAppendKey;

extern __gshared const CFStringRef _kCFURLIsRestrictedKey;

extern __gshared const CFStringRef _kCFURLIsSystemNoUnlinkKey;

extern __gshared const CFStringRef _kCFURLIsSystemFirmlinkKey;

extern __gshared const CFStringRef _kCFURLIsSystemDatalessFaultKey;

extern __gshared const CFStringRef _kCFURLFileFlagsKey;

extern __gshared const CFStringRef _kCFURLGenerationCountKey;

extern __gshared const CFStringRef _kCFURLIsApplicationKey;

extern __gshared const CFStringRef _kCFURLApplicationIsAppletKey;

extern __gshared const CFStringRef _kCFURLApplicationIsPlaceholderKey;

extern __gshared const CFStringRef _kCFURLApplicationIsBetaKey;

extern __gshared const CFStringRef _kCFURLApplicationHasSupportedFormatKey;

extern __gshared const CFStringRef _kCFURLCanSetHiddenExtensionKey;

extern __gshared const CFStringRef _kCFURLIsReadableKey;

extern __gshared const CFStringRef _kCFURLUserCanReadKey;

extern __gshared const CFStringRef _kCFURLIsWriteableKey;

extern __gshared const CFStringRef _kCFURLUserCanWriteKey;

extern __gshared const CFStringRef _kCFURLIsExecutableKey;

extern __gshared const CFStringRef _kCFURLUserCanExecuteKey;

extern __gshared const CFStringRef _kCFURLParentDirectoryIsVolumeRootKey;

extern __gshared const CFStringRef _kCFURLFileSecurityKey;

extern __gshared const CFStringRef _kCFURLFileSizeOfResourceForkKey;

extern __gshared const CFStringRef _kCFURLFileAllocatedSizeOfResourceForkKey;

extern __gshared const CFStringRef _kCFURLEffectiveIconImageDataKey;

extern __gshared const CFStringRef _kCFURLTypeBindingKey;

extern __gshared const CFStringRef _kCFURLCustomIconImageDataKey;

extern __gshared const CFStringRef _kCFURLEffectiveIconFlattenedReferenceDataKey;

extern __gshared const CFStringRef _kCFURLBundleIdentifierKey;

extern __gshared const CFStringRef _kCFURLVersionKey;

extern __gshared const CFStringRef _kCFURLShortVersionStringKey;

extern __gshared const CFStringRef _kCFURLOwnerIDKey;

extern __gshared const CFStringRef _kCFURLGroupIDKey;

extern __gshared const CFStringRef _kCFURLStatModeKey;

extern __gshared const CFStringRef _kCFURLLocalizedNameDictionaryKey;

extern __gshared const CFStringRef _kCFURLLocalizedNameWithExtensionsHiddenDictionaryKey;

extern __gshared const CFStringRef _kCFURLLocalizedTypeDescriptionDictionaryKey;

extern __gshared const CFStringRef _kCFURLApplicationCategoriesKey;

extern __gshared const CFStringRef _kCFURLApplicationHighResolutionModeIsMagnifiedKey;

extern __gshared const CFStringRef _kCFURLCanSetApplicationHighResolutionModeIsMagnifiedKey;

extern __gshared const CFStringRef _kCFURLWriterBundleIdentifierKey;

extern __gshared const CFStringRef _kCFURLApplicationNapIsDisabledKey;

extern __gshared const CFStringRef _kCFURLCanSetApplicationNapIsDisabledKey;

extern __gshared const CFStringRef _kCFURLCanSetStrongBindingKey;

extern __gshared const CFStringRef _kCFURLStrongBindingKey;

extern __gshared const CFStringRef _kCFURLArchitecturesValidOnCurrentSystemKey;

extern __gshared const CFStringRef _kCFURLApplicationArchitecturesKey;

extern __gshared const CFStringRef _kCFURLApplicationSupportedRegionsKey;

extern __gshared const CFStringRef _kCFURLFaultLogicalFileIsHiddenKey;

extern __gshared const CFStringRef _kCFURLLocalizedNameComponentsKey;

extern __gshared const CFStringRef _kCFURLApplicationPrefersExternalGPUKey;

extern __gshared const CFStringRef _kCFURLCanSetApplicationPrefersExternalGPUKey;

extern __gshared const CFStringRef _kCFURLApplicationPrefersSafeApertureSystemFullScreenCompatibilityKey;
extern __gshared const CFStringRef _kCFURLApplicationPrefersSafeApertureAppFullScreenCompatibilityKey;
extern __gshared const CFStringRef _kCFURLApplicationPrefersSafeApertureWindowedCompatibilityKey;
extern __gshared const CFStringRef _kCFURLCanSetApplicationPrefersSafeApertureWindowedCompatibilityKey;

extern __gshared const CFStringRef _kCFURLApplicationDeviceManagementPolicyKey;

extern __gshared const CFStringRef _kCFURLIsExcludedFromCloudBackupKey;

extern __gshared const CFStringRef _kCFURLIsExcludedFromUnencryptedBackupKey;

extern __gshared const CFStringRef _kCFURLDeviceRefNumKey;

extern __gshared const CFStringRef _kCFURLContentTypeKey;

extern __gshared const CFStringRef _kCFURLVolumeRefNumKey;

extern __gshared const CFStringRef _kCFURLVolumeUUIDStringKey;

extern __gshared const CFStringRef _kCFURLVolumeCreationDateKey;

extern __gshared const CFStringRef _kCFURLVolumeIsLocalKey;

extern __gshared const CFStringRef _kCFURLVolumeIsAutomountKey;

extern __gshared const CFStringRef _kCFURLVolumeDontBrowseKey;

extern __gshared const CFStringRef _kCFURLVolumeIsReadOnlyKey;

extern __gshared const CFStringRef _kCFURLVolumeIsQuarantinedKey;

extern __gshared const CFStringRef _kCFURLVolumeIsEjectableKey;

extern __gshared const CFStringRef _kCFURLVolumeIsRemovableKey;

extern __gshared const CFStringRef _kCFURLVolumeIsInternalKey;

extern __gshared const CFStringRef _kCFURLVolumeIsExternalKey;

extern __gshared const CFStringRef _kCFURLVolumeIsDiskImageKey;

extern __gshared const CFStringRef _kCFURLDiskImageBackingURLKey;

extern __gshared const CFStringRef _kCFURLVolumeIsFileVaultKey;

extern __gshared const CFStringRef _kCFURLVolumeSupportsFileProtectionKey;

extern __gshared const CFStringRef _kCFURLVolumeIsiDiskKey;

extern __gshared const CFStringRef _kCFURLVolumeiDiskUserNameKey;

extern __gshared const CFStringRef _kCFURLVolumeIsLocaliDiskMirrorKey;

extern __gshared const CFStringRef _kCFURLVolumeIsiPodKey;

extern __gshared const CFStringRef _kCFURLVolumeIsCDKey;

extern __gshared const CFStringRef _kCFURLVolumeIsDVDKey;

extern __gshared const CFStringRef _kCFURLVolumeIsDeviceFileSystemKey;

extern __gshared const CFStringRef _kCFURLVolumeIsHFSStandardKey;

extern __gshared const CFStringRef _kCFURLVolumeIOMediaIconFamilyNameKey;

extern __gshared const CFStringRef _kCFURLVolumeIOMediaIconBundleIdentifierKey;

extern __gshared const CFStringRef _kCFURLVolumeQuarantinePropertiesKey;

extern __gshared const CFStringRef _kCFURLVolumeOpenFolderURLKey;

extern __gshared const CFStringRef _kCFURLResolvedFromBookmarkDataKey;

extern __gshared const CFStringRef _kCFURLVolumeMountPointStringKey;

extern __gshared const CFStringRef _kCFURLVolumeDeviceIDKey;

extern __gshared const CFStringRef _kCFURLVolumeIsTimeMachineKey;

extern __gshared const CFStringRef _kCFURLVolumeIsAirportKey;

extern __gshared const CFStringRef _kCFURLVolumeIsVideoDiskKey;

extern __gshared const CFStringRef _kCFURLVolumeIsDVDVideoKey;

extern __gshared const CFStringRef _kCFURLVolumeIsBDVideoKey;

extern __gshared const CFStringRef _kCFURLVolumeIsMobileTimeMachineKey;

extern __gshared const CFStringRef _kCFURLVolumeIsNetworkOpticalKey;

extern __gshared const CFStringRef _kCFURLCompleteMountURLKey;

extern __gshared const CFStringRef _kCFURLUbiquitousItemDownloadRequestedKey;

extern __gshared const CFStringRef _kCFURLCloudDocsPlaceholderDictionaryKey;

extern __gshared const CFStringRef _kCFURLCloudDocsPlaceholderLogicalNameKey;

extern __gshared const CFStringRef kCFURLUbiquitousItemDownloadRequestedKey;

extern __gshared const CFStringRef kCFURLUbiquitousItemContainerDisplayNameKey;

extern __gshared const CFStringRef kCFURLUbiquitousItemIsSharedKey;

extern __gshared const CFStringRef kCFURLUbiquitousSharedItemCurrentUserRoleKey;
extern __gshared const CFStringRef kCFURLUbiquitousSharedItemRoleOwner;
extern __gshared const CFStringRef kCFURLUbiquitousSharedItemRoleParticipant;

extern __gshared const CFStringRef kCFURLUbiquitousSharedItemOwnerNameComponentsKey;
extern __gshared const CFStringRef kCFURLUbiquitousSharedItemMostRecentEditorNameComponentsKey;

extern __gshared const CFStringRef kCFURLUbiquitousSharedItemCurrentUserPermissionsKey;
extern __gshared const CFStringRef kCFURLUbiquitousSharedItemPermissionsReadOnly;
extern __gshared const CFStringRef kCFURLUbiquitousSharedItemPermissionsReadWrite;

extern __gshared const CFStringRef kCFURLUbiquitousSharedItemRoleKey;
extern __gshared const CFStringRef kCFURLUbiquitousSharedItemOwnerNameKey;
extern __gshared const CFStringRef kCFURLUbiquitousSharedItemPermissionsKey;
extern __gshared const CFStringRef kCFURLUbiquitousSharedItemReadOnlyPermissions;
extern __gshared const CFStringRef kCFURLUbiquitousSharedItemReadWritePermissions;

extern __gshared const CFStringRef kCFURLThumbnailDictionaryKey;
extern __gshared const CFStringRef kCFURLThumbnailKey;

extern __gshared const CFStringRef kCFThumbnail1024x1024SizeKey;

extern __gshared const CFStringRef _kCFURLPromisePhysicalURLKey;

enum
{
    kCFURLResourceIsRegularFile = 0x00000001,
    kCFURLResourceIsDirectory = 0x00000002,
    kCFURLResourceIsSymbolicLink = 0x00000004,
    kCFURLResourceIsVolume = 0x00000008,
    kCFURLResourceIsPackage = 0x00000010,
    kCFURLResourceIsSystemImmutable = 0x00000020,
    kCFURLResourceIsUserImmutable = 0x00000040,
    kCFURLResourceIsHidden = 0x00000080,
    kCFURLResourceHasHiddenExtension = 0x00000100,
    kCFURLResourceIsApplication = 0x00000200,
    kCFURLResourceIsCompressed = 0x00000400,
    kCFURLResourceIsSystemCompressed = 1024,
    kCFURLCanSetHiddenExtension = 0x00000800,
    kCFURLResourceIsReadable = 0x00001000,
    kCFURLResourceIsWriteable = 0x00002000,
    kCFURLResourceIsExecutable = 0x00004000,
    kCFURLIsAliasFile = 0x00008000,
    kCFURLIsMountTrigger = 0x00010000
}

alias CFURLResourcePropertyFlags = ulong;

Boolean _CFURLGetResourcePropertyFlags(
    CFURLRef url,
    CFURLResourcePropertyFlags mask,
    CFURLResourcePropertyFlags* flags,
    CFErrorRef* error);

alias __CF_OPTIONS_CFURLVolumePropertyFlags = int;

enum CFURLVolumePropertyFlags
{
    kCFURLVolumeIsLocal = 0x1L,
    kCFURLVolumeIsAutomount = 0x2L,
    kCFURLVolumeDontBrowse = 0x4L,
    kCFURLVolumeIsReadOnly = 0x8L,
    kCFURLVolumeIsQuarantined = 0x10L,
    kCFURLVolumeIsEjectable = 0x20L,
    kCFURLVolumeIsRemovable = 0x40L,
    kCFURLVolumeIsInternal = 0x80L,
    kCFURLVolumeIsExternal = 0x100L,
    kCFURLVolumeIsDiskImage = 0x200L,
    kCFURLVolumeIsFileVault = 0x400L,
    kCFURLVolumeIsLocaliDiskMirror = 2048,
    kCFURLVolumeIsiPod = 0x1000L,
    kCFURLVolumeIsiDisk = 8192,
    kCFURLVolumeIsCD = 0x4000L,
    kCFURLVolumeIsDVD = 0x8000L,
    kCFURLVolumeIsDeviceFileSystem = 0x10000L,
    kCFURLVolumeIsTimeMachine = 131072,
    kCFURLVolumeIsAirport = 262144,
    kCFURLVolumeIsVideoDisk = 524288,
    kCFURLVolumeIsDVDVideo = 1048576,
    kCFURLVolumeIsBDVideo = 2097152,
    kCFURLVolumeIsMobileTimeMachine = 4194304,
    kCFURLVolumeIsNetworkOptical = 8388608,
    kCFURLVolumeIsBeingRepaired = 16777216,
    kCFURLVolumeIsBeingUnmounted = 33554432,
    kCFURLVolumeIsRootFileSystem = 67108864,
    kCFURLVolumeIsEncrypted = 134217728,
    kCFURLVolumeSupportsFileProtection = 268435456,

    kCFURLVolumeSupportsPersistentIDs = 0x100000000L,
    kCFURLVolumeSupportsSearchFS = 0x200000000L,
    kCFURLVolumeSupportsExchange = 0x400000000L,

    kCFURLVolumeSupportsSymbolicLinks = 0x1000000000L,
    kCFURLVolumeSupportsDenyModes = 0x2000000000L,
    kCFURLVolumeSupportsCopyFile = 0x4000000000L,
    kCFURLVolumeSupportsReadDirAttr = 0x8000000000L,
    kCFURLVolumeSupportsJournaling = 0x10000000000L,
    kCFURLVolumeSupportsRename = 0x20000000000L,
    kCFURLVolumeSupportsFastStatFS = 0x40000000000L,
    kCFURLVolumeSupportsCaseSensitiveNames = 0x80000000000L,
    kCFURLVolumeSupportsCasePreservedNames = 0x100000000000L,
    kCFURLVolumeSupportsFLock = 0x200000000000L,
    kCFURLVolumeHasNoRootDirectoryTimes = 0x400000000000L,
    kCFURLVolumeSupportsExtendedSecurity = 0x800000000000L,
    kCFURLVolumeSupports2TBFileSize = 0x1000000000000L,
    kCFURLVolumeSupportsHardLinks = 0x2000000000000L,
    kCFURLVolumeSupportsMandatoryByteRangeLocks = 0x4000000000000L,
    kCFURLVolumeSupportsPathFromID = 0x8000000000000L,

    kCFURLVolumeIsJournaling = 0x20000000000000L,
    kCFURLVolumeSupportsSparseFiles = 0x40000000000000L,
    kCFURLVolumeSupportsZeroRuns = 0x80000000000000L,
    kCFURLVolumeSupportsVolumeSizes = 0x100000000000000L,
    kCFURLVolumeSupportsRemoteEvents = 0x200000000000000L,
    kCFURLVolumeSupportsHiddenFiles = 0x400000000000000L,
    kCFURLVolumeSupportsDecmpFSCompression = 0x800000000000000L,
    kCFURLVolumeHas64BitObjectIDs = 0x1000000000000000L,
    kCFURLVolumeSupportsFileCloning = 2305843009213693952,
    kCFURLVolumeSupportsSwapRenaming = 4611686018427387904,
    kCFURLVolumeSupportsExclusiveRenaming = -9223372036854775808,
    kCFURLVolumePropertyFlagsAll = 0xffffffffffffffffL
}

Boolean _CFURLGetVolumePropertyFlags(
    CFURLRef url,
    CFURLVolumePropertyFlags mask,
    CFURLVolumePropertyFlags* flags,
    CFErrorRef* error);

Boolean _CFURLCopyResourcePropertyForKeyFromCache(
    CFURLRef url,
    CFStringRef key,
    void* cfTypeRefValue);

CFDictionaryRef _CFURLCopyResourcePropertiesForKeysFromCache(
    CFURLRef url,
    CFArrayRef keys);

Boolean _CFURLCacheResourcePropertyForKey(
    CFURLRef url,
    CFStringRef key,
    CFErrorRef* error);

Boolean _CFURLCacheResourcePropertiesForKeys(
    CFURLRef url,
    CFArrayRef keys,
    CFErrorRef* error);

CFArrayRef _CFURLCreateDisplayPathComponentsArray(
    CFURLRef url,
    CFErrorRef* error);

Boolean _CFURLIsFileURL(CFURLRef url);

Boolean _CFURLIsFileReferenceURL(CFURLRef url);

void* __CFURLResourceInfoPtr(CFURLRef url);

void __CFURLSetResourceInfoPtr(CFURLRef url, void* ptr);

CFURLRef _CFURLCreateWithFileSystemPathCachingResourcePropertiesForKeys(
    CFAllocatorRef allocator,
    CFStringRef posixFilePath,
    CFArrayRef keys,
    CFErrorRef* error);

struct FSCatalogInfo;
struct HFSUniStr255;

SInt32 _CFURLGetCatalogInfo(
    CFURLRef url,
    UInt32 whichInfo,
    FSCatalogInfo* catalogInfo,
    HFSUniStr255* name);

enum
{
    _CFURLItemReplacementUsingNewMetadataOnly = 2,

    _CFURLItemReplacementWithoutDeletingBackupItem = 1 << 4
}

Boolean _CFURLReplaceObject(
    CFAllocatorRef allocator,
    CFURLRef originalItemURL,
    CFURLRef newItemURL,
    CFStringRef newName,
    CFStringRef backupItemName,
    CFOptionFlags options,
    CFURLRef* resultingURL,
    CFErrorRef* error);

Boolean _CFURLIsProtectedDirectory(CFURLRef directoryURL);

void _CFURLAttachSecurityScopeToFileURL(
    CFURLRef url,
    CFDataRef sandboxExtension);

CFDataRef _CFURLCopySecurityScopeFromFileURL(CFURLRef url);

Boolean _CFURLNoteSecurityScopedResourceMoved(
    CFURLRef sourceURL,
    CFURLRef destinationURL);

void _CFURLSetPermanentResourcePropertyForKey(
    CFURLRef url,
    CFStringRef key,
    CFTypeRef propertyValue);

CFStringRef _CFURLBookmarkCopyDescription(CFDataRef bookmarkRef);

extern __gshared const CFStringRef _kCFURLRevocableBookmarkBundleIdentifierKey;
extern __gshared const CFStringRef _kCFURLRevocableBookmarkAppIdentifierKey;
extern __gshared const CFStringRef _kCFURLRevocableBookmarkActiveStatusKey;
extern __gshared const CFStringRef _kCFURLRevocableBookmarkSaltKey;

CFArrayRef _CFURLRevocableBookmarksCopyClients();

CFArrayRef _CFURLRevocableBookmarksCopyClientBundleIdentifiers(Boolean includeInactive);

Boolean _CFURLRevocableBookmarksSetActiveStatusForBundleIdentifier(CFStringRef identifier, Boolean active);

Boolean _CFURLRevocableBookmarksRevokeForBundleIdentifier(CFStringRef identifier);

extern __gshared const CFNotificationName _kCFURLRevocableBookmarksClientsDidChangeNotification;

