module CoreFoundation.CFURL;

public import CoreFoundation.CFBase;
public import CoreFoundation.CFData;
public import CoreFoundation.CFString;

extern (C):

alias __CF_ENUM_CFURLPathStyle = int;

enum CFURLPathStyle
{
    kCFURLPOSIXPathStyle = 0,
    kCFURLHFSPathStyle = 1,
    kCFURLWindowsPathStyle = 2
}

struct __CFURL;
alias CFURLRef = const(__CFURL)*;

CFTypeID CFURLGetTypeID();

CFURLRef CFURLCreateWithBytes(
    CFAllocatorRef allocator,
    const(UInt8)* URLBytes,
    CFIndex length,
    CFStringEncoding encoding,
    CFURLRef baseURL);

CFDataRef CFURLCreateData(
    CFAllocatorRef allocator,
    CFURLRef url,
    CFStringEncoding encoding,
    Boolean escapeWhitespace);

CFURLRef CFURLCreateWithString(
    CFAllocatorRef allocator,
    CFStringRef URLString,
    CFURLRef baseURL);

CFURLRef CFURLCreateAbsoluteURLWithBytes(
    CFAllocatorRef alloc,
    const(UInt8)* relativeURLBytes,
    CFIndex length,
    CFStringEncoding encoding,
    CFURLRef baseURL,
    Boolean useCompatibilityMode);

CFURLRef CFURLCreateWithFileSystemPath(
    CFAllocatorRef allocator,
    CFStringRef filePath,
    CFURLPathStyle pathStyle,
    Boolean isDirectory);

CFURLRef CFURLCreateFromFileSystemRepresentation(
    CFAllocatorRef allocator,
    const(UInt8)* buffer,
    CFIndex bufLen,
    Boolean isDirectory);

CFURLRef CFURLCreateWithFileSystemPathRelativeToBase(
    CFAllocatorRef allocator,
    CFStringRef filePath,
    CFURLPathStyle pathStyle,
    Boolean isDirectory,
    CFURLRef baseURL);

CFURLRef CFURLCreateFromFileSystemRepresentationRelativeToBase(
    CFAllocatorRef allocator,
    const(UInt8)* buffer,
    CFIndex bufLen,
    Boolean isDirectory,
    CFURLRef baseURL);

Boolean CFURLGetFileSystemRepresentation(
    CFURLRef url,
    Boolean resolveAgainstBase,
    UInt8* buffer,
    CFIndex maxBufLen);

CFURLRef CFURLCopyAbsoluteURL(CFURLRef relativeURL);

CFStringRef CFURLGetString(CFURLRef anURL);

CFURLRef CFURLGetBaseURL(CFURLRef anURL);

Boolean CFURLCanBeDecomposed(CFURLRef anURL);

CFStringRef CFURLCopyScheme(CFURLRef anURL);

CFStringRef CFURLCopyNetLocation(CFURLRef anURL);

CFStringRef CFURLCopyPath(CFURLRef anURL);

CFStringRef CFURLCopyStrictPath(CFURLRef anURL, Boolean* isAbsolute);

CFStringRef CFURLCopyFileSystemPath(CFURLRef anURL, CFURLPathStyle pathStyle);

Boolean CFURLHasDirectoryPath(CFURLRef anURL);

CFStringRef CFURLCopyResourceSpecifier(CFURLRef anURL);

CFStringRef CFURLCopyHostName(CFURLRef anURL);

SInt32 CFURLGetPortNumber(CFURLRef anURL);

CFStringRef CFURLCopyUserName(CFURLRef anURL);

CFStringRef CFURLCopyPassword(CFURLRef anURL);

CFStringRef CFURLCopyParameterString(
    CFURLRef anURL,
    CFStringRef charactersToLeaveEscaped);
CFStringRef CFURLCopyQueryString(
    CFURLRef anURL,
    CFStringRef charactersToLeaveEscaped);

CFStringRef CFURLCopyFragment(
    CFURLRef anURL,
    CFStringRef charactersToLeaveEscaped);

CFStringRef CFURLCopyLastPathComponent(CFURLRef url);

CFStringRef CFURLCopyPathExtension(CFURLRef url);

CFURLRef CFURLCreateCopyAppendingPathComponent(
    CFAllocatorRef allocator,
    CFURLRef url,
    CFStringRef pathComponent,
    Boolean isDirectory);

CFURLRef CFURLCreateCopyDeletingLastPathComponent(
    CFAllocatorRef allocator,
    CFURLRef url);

CFURLRef CFURLCreateCopyAppendingPathExtension(
    CFAllocatorRef allocator,
    CFURLRef url,
    CFStringRef extension);

CFURLRef CFURLCreateCopyDeletingPathExtension(
    CFAllocatorRef allocator,
    CFURLRef url);

CFIndex CFURLGetBytes(CFURLRef url, UInt8* buffer, CFIndex bufferLength);

alias __CF_ENUM_CFURLComponentType = int;

enum CFURLComponentType
{
    kCFURLComponentScheme = 1,
    kCFURLComponentNetLocation = 2,
    kCFURLComponentPath = 3,
    kCFURLComponentResourceSpecifier = 4,

    kCFURLComponentUser = 5,
    kCFURLComponentPassword = 6,
    kCFURLComponentUserInfo = 7,
    kCFURLComponentHost = 8,
    kCFURLComponentPort = 9,
    kCFURLComponentParameterString = 10,
    kCFURLComponentQuery = 11,
    kCFURLComponentFragment = 12
}

CFRange CFURLGetByteRangeForComponent(
    CFURLRef url,
    CFURLComponentType component,
    CFRange* rangeIncludingSeparators);

CFStringRef CFURLCreateStringByReplacingPercentEscapes(
    CFAllocatorRef allocator,
    CFStringRef originalString,
    CFStringRef charactersToLeaveEscaped);

CFStringRef CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
    CFAllocatorRef allocator,
    CFStringRef origString,
    CFStringRef charsToLeaveEscaped,
    CFStringEncoding encoding);

CFStringRef CFURLCreateStringByAddingPercentEscapes(
    CFAllocatorRef allocator,
    CFStringRef originalString,
    CFStringRef charactersToLeaveUnescaped,
    CFStringRef legalURLCharactersToBeEscaped,
    CFStringEncoding encoding);

