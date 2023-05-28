module CoreFoundation.CFString;

import core.stdc.config;
import core.stdc.stdarg;

public import CoreFoundation.CFArray;
public import CoreFoundation.CFBase;
public import CoreFoundation.CFCharacterSet;
public import CoreFoundation.CFData;
public import CoreFoundation.CFDictionary;
public import CoreFoundation.CFLocale;

extern (C):

alias CFStringEncoding = uint;

alias __CF_ENUM_CFStringBuiltInEncodings = int;

enum CFStringBuiltInEncodings
{
    kCFStringEncodingMacRoman = 0,
    kCFStringEncodingWindowsLatin1 = 0x0500,
    kCFStringEncodingISOLatin1 = 0x0201,
    kCFStringEncodingNextStepLatin = 0x0B01,
    kCFStringEncodingASCII = 0x0600,
    kCFStringEncodingUnicode = 0x0100,
    kCFStringEncodingUTF8 = 0x08000100,
    kCFStringEncodingNonLossyASCII = 0x0BFF,

    kCFStringEncodingUTF16 = 0x0100,
    kCFStringEncodingUTF16BE = 0x10000100,
    kCFStringEncodingUTF16LE = 0x14000100,

    kCFStringEncodingUTF32 = 0x0c000100,
    kCFStringEncodingUTF32BE = 0x18000100,
    kCFStringEncodingUTF32LE = 0x1c000100
}

CFTypeID CFStringGetTypeID();

CFStringRef CFStringCreateWithPascalString(
    CFAllocatorRef alloc,
    ConstStr255Param pStr,
    CFStringEncoding encoding);

CFStringRef CFStringCreateWithCString(
    CFAllocatorRef alloc,
    const(char)* cStr,
    CFStringEncoding encoding);

CFStringRef CFStringCreateWithBytes(
    CFAllocatorRef alloc,
    const(UInt8)* bytes,
    CFIndex numBytes,
    CFStringEncoding encoding,
    Boolean isExternalRepresentation);

CFStringRef CFStringCreateWithCharacters(
    CFAllocatorRef alloc,
    const(UniChar)* chars,
    CFIndex numChars);

CFStringRef CFStringCreateWithPascalStringNoCopy(
    CFAllocatorRef alloc,
    ConstStr255Param pStr,
    CFStringEncoding encoding,
    CFAllocatorRef contentsDeallocator);

CFStringRef CFStringCreateWithCStringNoCopy(
    CFAllocatorRef alloc,
    const(char)* cStr,
    CFStringEncoding encoding,
    CFAllocatorRef contentsDeallocator);

CFStringRef CFStringCreateWithBytesNoCopy(
    CFAllocatorRef alloc,
    const(UInt8)* bytes,
    CFIndex numBytes,
    CFStringEncoding encoding,
    Boolean isExternalRepresentation,
    CFAllocatorRef contentsDeallocator);

CFStringRef CFStringCreateWithCharactersNoCopy(
    CFAllocatorRef alloc,
    const(UniChar)* chars,
    CFIndex numChars,
    CFAllocatorRef contentsDeallocator);

CFStringRef CFStringCreateWithSubstring(
    CFAllocatorRef alloc,
    CFStringRef str,
    CFRange range);

CFStringRef CFStringCreateCopy(CFAllocatorRef alloc, CFStringRef theString);

CFStringRef CFStringCreateWithFormat(
    CFAllocatorRef alloc,
    CFDictionaryRef formatOptions,
    CFStringRef format,
    ...);

CFStringRef CFStringCreateWithFormatAndArguments(
    CFAllocatorRef alloc,
    CFDictionaryRef formatOptions,
    CFStringRef format,
    va_list arguments);

CFMutableStringRef CFStringCreateMutable(
    CFAllocatorRef alloc,
    CFIndex maxLength);

CFMutableStringRef CFStringCreateMutableCopy(
    CFAllocatorRef alloc,
    CFIndex maxLength,
    CFStringRef theString);

CFMutableStringRef CFStringCreateMutableWithExternalCharactersNoCopy(
    CFAllocatorRef alloc,
    UniChar* chars,
    CFIndex numChars,
    CFIndex capacity,
    CFAllocatorRef externalCharactersAllocator);

CFIndex CFStringGetLength(CFStringRef theString);

UniChar CFStringGetCharacterAtIndex(CFStringRef theString, CFIndex idx);

void CFStringGetCharacters(
    CFStringRef theString,
    CFRange range,
    UniChar* buffer);

Boolean CFStringGetPascalString(
    CFStringRef theString,
    StringPtr buffer,
    CFIndex bufferSize,
    CFStringEncoding encoding);

Boolean CFStringGetCString(
    CFStringRef theString,
    char* buffer,
    CFIndex bufferSize,
    CFStringEncoding encoding);

ConstStringPtr CFStringGetPascalStringPtr(
    CFStringRef theString,
    CFStringEncoding encoding);

const(char)* CFStringGetCStringPtr(
    CFStringRef theString,
    CFStringEncoding encoding);

const(UniChar)* CFStringGetCharactersPtr(CFStringRef theString);

CFIndex CFStringGetBytes(
    CFStringRef theString,
    CFRange range,
    CFStringEncoding encoding,
    UInt8 lossByte,
    Boolean isExternalRepresentation,
    UInt8* buffer,
    CFIndex maxBufLen,
    CFIndex* usedBufLen);

CFStringRef CFStringCreateFromExternalRepresentation(
    CFAllocatorRef alloc,
    CFDataRef data,
    CFStringEncoding encoding);

CFDataRef CFStringCreateExternalRepresentation(
    CFAllocatorRef alloc,
    CFStringRef theString,
    CFStringEncoding encoding,
    UInt8 lossByte);

CFStringEncoding CFStringGetSmallestEncoding(CFStringRef theString);

CFStringEncoding CFStringGetFastestEncoding(CFStringRef theString);

CFStringEncoding CFStringGetSystemEncoding();

CFIndex CFStringGetMaximumSizeForEncoding(
    CFIndex length,
    CFStringEncoding encoding);

Boolean CFStringGetFileSystemRepresentation(
    CFStringRef string,
    char* buffer,
    CFIndex maxBufLen);

CFIndex CFStringGetMaximumSizeOfFileSystemRepresentation(CFStringRef string);

CFStringRef CFStringCreateWithFileSystemRepresentation(
    CFAllocatorRef alloc,
    const(char)* buffer);

alias __CF_OPTIONS_CFStringCompareFlags = int;

enum CFStringCompareFlags
{
    kCFCompareCaseInsensitive = 1,
    kCFCompareBackwards = 4,
    kCFCompareAnchored = 8,
    kCFCompareNonliteral = 16,
    kCFCompareLocalized = 32,
    kCFCompareNumerically = 64,
    kCFCompareDiacriticInsensitive = 128,
    kCFCompareWidthInsensitive = 256,
    kCFCompareForcedOrdering = 512
}

CFComparisonResult CFStringCompareWithOptionsAndLocale(
    CFStringRef theString1,
    CFStringRef theString2,
    CFRange rangeToCompare,
    CFStringCompareFlags compareOptions,
    CFLocaleRef locale);

CFComparisonResult CFStringCompareWithOptions(
    CFStringRef theString1,
    CFStringRef theString2,
    CFRange rangeToCompare,
    CFStringCompareFlags compareOptions);

CFComparisonResult CFStringCompare(
    CFStringRef theString1,
    CFStringRef theString2,
    CFStringCompareFlags compareOptions);

Boolean CFStringFindWithOptionsAndLocale(
    CFStringRef theString,
    CFStringRef stringToFind,
    CFRange rangeToSearch,
    CFStringCompareFlags searchOptions,
    CFLocaleRef locale,
    CFRange* result);

Boolean CFStringFindWithOptions(
    CFStringRef theString,
    CFStringRef stringToFind,
    CFRange rangeToSearch,
    CFStringCompareFlags searchOptions,
    CFRange* result);

CFArrayRef CFStringCreateArrayWithFindResults(
    CFAllocatorRef alloc,
    CFStringRef theString,
    CFStringRef stringToFind,
    CFRange rangeToSearch,
    CFStringCompareFlags compareOptions);

CFRange CFStringFind(
    CFStringRef theString,
    CFStringRef stringToFind,
    CFStringCompareFlags compareOptions);

Boolean CFStringHasPrefix(CFStringRef theString, CFStringRef prefix);

Boolean CFStringHasSuffix(CFStringRef theString, CFStringRef suffix);

CFRange CFStringGetRangeOfComposedCharactersAtIndex(CFStringRef theString, CFIndex theIndex);

Boolean CFStringFindCharacterFromSet(CFStringRef theString, CFCharacterSetRef theSet, CFRange rangeToSearch, CFStringCompareFlags searchOptions, CFRange* result);

void CFStringGetLineBounds(
    CFStringRef theString,
    CFRange range,
    CFIndex* lineBeginIndex,
    CFIndex* lineEndIndex,
    CFIndex* contentsEndIndex);

void CFStringGetParagraphBounds(
    CFStringRef string,
    CFRange range,
    CFIndex* parBeginIndex,
    CFIndex* parEndIndex,
    CFIndex* contentsEndIndex);

CFIndex CFStringGetHyphenationLocationBeforeIndex(
    CFStringRef string,
    CFIndex location,
    CFRange limitRange,
    CFOptionFlags options,
    CFLocaleRef locale,
    UTF32Char* character);

Boolean CFStringIsHyphenationAvailableForLocale(CFLocaleRef locale);

CFStringRef CFStringCreateByCombiningStrings(
    CFAllocatorRef alloc,
    CFArrayRef theArray,
    CFStringRef separatorString);

CFArrayRef CFStringCreateArrayBySeparatingStrings(
    CFAllocatorRef alloc,
    CFStringRef theString,
    CFStringRef separatorString);

SInt32 CFStringGetIntValue(CFStringRef str);

double CFStringGetDoubleValue(CFStringRef str);

void CFStringAppend(CFMutableStringRef theString, CFStringRef appendedString);

void CFStringAppendCharacters(
    CFMutableStringRef theString,
    const(UniChar)* chars,
    CFIndex numChars);

void CFStringAppendPascalString(
    CFMutableStringRef theString,
    ConstStr255Param pStr,
    CFStringEncoding encoding);

void CFStringAppendCString(
    CFMutableStringRef theString,
    const(char)* cStr,
    CFStringEncoding encoding);

void CFStringAppendFormat(
    CFMutableStringRef theString,
    CFDictionaryRef formatOptions,
    CFStringRef format,
    ...);

void CFStringAppendFormatAndArguments(
    CFMutableStringRef theString,
    CFDictionaryRef formatOptions,
    CFStringRef format,
    va_list arguments);

void CFStringInsert(
    CFMutableStringRef str,
    CFIndex idx,
    CFStringRef insertedStr);

void CFStringDelete(CFMutableStringRef theString, CFRange range);

void CFStringReplace(
    CFMutableStringRef theString,
    CFRange range,
    CFStringRef replacement);

void CFStringReplaceAll(CFMutableStringRef theString, CFStringRef replacement);

CFIndex CFStringFindAndReplace(
    CFMutableStringRef theString,
    CFStringRef stringToFind,
    CFStringRef replacementString,
    CFRange rangeToSearch,
    CFStringCompareFlags compareOptions);

void CFStringSetExternalCharactersNoCopy(
    CFMutableStringRef theString,
    UniChar* chars,
    CFIndex length,
    CFIndex capacity);

void CFStringPad(
    CFMutableStringRef theString,
    CFStringRef padString,
    CFIndex length,
    CFIndex indexIntoPad);

void CFStringTrim(CFMutableStringRef theString, CFStringRef trimString);

void CFStringTrimWhitespace(CFMutableStringRef theString);

void CFStringLowercase(CFMutableStringRef theString, CFLocaleRef locale);

void CFStringUppercase(CFMutableStringRef theString, CFLocaleRef locale);

void CFStringCapitalize(CFMutableStringRef theString, CFLocaleRef locale);

alias __CF_ENUM_CFStringNormalizationForm = int;

enum CFStringNormalizationForm
{
    kCFStringNormalizationFormD = 0,
    kCFStringNormalizationFormKD = 1,
    kCFStringNormalizationFormC = 2,
    kCFStringNormalizationFormKC = 3
}

void CFStringNormalize(CFMutableStringRef theString, CFStringNormalizationForm theForm);

void CFStringFold(
    CFMutableStringRef theString,
    CFStringCompareFlags theFlags,
    CFLocaleRef theLocale);

Boolean CFStringTransform(
    CFMutableStringRef string,
    CFRange* range,
    CFStringRef transform,
    Boolean reverse);

extern __gshared const CFStringRef kCFStringTransformStripCombiningMarks;
extern __gshared const CFStringRef kCFStringTransformToLatin;
extern __gshared const CFStringRef kCFStringTransformFullwidthHalfwidth;
extern __gshared const CFStringRef kCFStringTransformLatinKatakana;
extern __gshared const CFStringRef kCFStringTransformLatinHiragana;
extern __gshared const CFStringRef kCFStringTransformHiraganaKatakana;
extern __gshared const CFStringRef kCFStringTransformMandarinLatin;
extern __gshared const CFStringRef kCFStringTransformLatinHangul;
extern __gshared const CFStringRef kCFStringTransformLatinArabic;
extern __gshared const CFStringRef kCFStringTransformLatinHebrew;
extern __gshared const CFStringRef kCFStringTransformLatinThai;
extern __gshared const CFStringRef kCFStringTransformLatinCyrillic;
extern __gshared const CFStringRef kCFStringTransformLatinGreek;
extern __gshared const CFStringRef kCFStringTransformToXMLHex;
extern __gshared const CFStringRef kCFStringTransformToUnicodeName;
extern __gshared const CFStringRef kCFStringTransformStripDiacritics;

Boolean CFStringIsEncodingAvailable(CFStringEncoding encoding);

const(CFStringEncoding)* CFStringGetListOfAvailableEncodings();

CFStringRef CFStringGetNameOfEncoding(CFStringEncoding encoding);

c_ulong CFStringConvertEncodingToNSStringEncoding(CFStringEncoding encoding);

CFStringEncoding CFStringConvertNSStringEncodingToEncoding(c_ulong encoding);

UInt32 CFStringConvertEncodingToWindowsCodepage(CFStringEncoding encoding);

CFStringEncoding CFStringConvertWindowsCodepageToEncoding(UInt32 codepage);

CFStringEncoding CFStringConvertIANACharSetNameToEncoding(
    CFStringRef theString);

CFStringRef CFStringConvertEncodingToIANACharSetName(CFStringEncoding encoding);

CFStringEncoding CFStringGetMostCompatibleMacStringEncoding(
    CFStringEncoding encoding);

enum __kCFStringInlineBufferLength = 42;

struct CFStringInlineBuffer
{
    UniChar[__kCFStringInlineBufferLength] buffer;
    CFStringRef theString;
    const(UniChar)* directUniCharBuffer;
    const(char)* directCStringBuffer;
    CFRange rangeToBuffer;
    CFIndex bufferedRangeStart;
    CFIndex bufferedRangeEnd;
}

void CFStringInitInlineBuffer(
    CFStringRef str,
    CFStringInlineBuffer* buf,
    CFRange range);

UniChar CFStringGetCharacterFromInlineBuffer(
    CFStringInlineBuffer* buf,
    CFIndex idx);

Boolean CFStringIsSurrogateHighCharacter(UniChar character);

Boolean CFStringIsSurrogateLowCharacter(UniChar character);

UTF32Char CFStringGetLongCharacterForSurrogatePair(
    UniChar surrogateHigh,
    UniChar surrogateLow);

Boolean CFStringGetSurrogatePairForLongCharacter(
    UTF32Char character,
    UniChar* surrogates);

void CFShow(CFTypeRef obj);

void CFShowStr(CFStringRef str);

CFStringRef __CFStringMakeConstantString(const(char)* cStr);

