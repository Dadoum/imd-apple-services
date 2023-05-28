module CoreFoundation.CFCharacterSet;

public import CoreFoundation.CFBase;
public import CoreFoundation.CFData;

extern (C):

struct __CFCharacterSet;
alias CFCharacterSetRef = const(__CFCharacterSet)*;

alias CFMutableCharacterSetRef = __CFCharacterSet*;

alias __CF_ENUM_CFCharacterSetPredefinedSet = int;

enum CFCharacterSetPredefinedSet
{
    kCFCharacterSetControl = 1,
    kCFCharacterSetWhitespace = 2,
    kCFCharacterSetWhitespaceAndNewline = 3,
    kCFCharacterSetDecimalDigit = 4,
    kCFCharacterSetLetter = 5,
    kCFCharacterSetLowercaseLetter = 6,
    kCFCharacterSetUppercaseLetter = 7,
    kCFCharacterSetNonBase = 8,
    kCFCharacterSetDecomposable = 9,
    kCFCharacterSetAlphaNumeric = 10,
    kCFCharacterSetPunctuation = 11,
    kCFCharacterSetCapitalizedLetter = 13,
    kCFCharacterSetSymbol = 14,
    kCFCharacterSetNewline = 15,
    kCFCharacterSetIllegal = 12
}

CFTypeID CFCharacterSetGetTypeID();

CFCharacterSetRef CFCharacterSetGetPredefined(
    CFCharacterSetPredefinedSet theSetIdentifier);

CFCharacterSetRef CFCharacterSetCreateWithCharactersInRange(
    CFAllocatorRef alloc,
    CFRange theRange);

CFCharacterSetRef CFCharacterSetCreateWithCharactersInString(
    CFAllocatorRef alloc,
    CFStringRef theString);

CFCharacterSetRef CFCharacterSetCreateWithBitmapRepresentation(
    CFAllocatorRef alloc,
    CFDataRef theData);

CFCharacterSetRef CFCharacterSetCreateInvertedSet(CFAllocatorRef alloc, CFCharacterSetRef theSet);

Boolean CFCharacterSetIsSupersetOfSet(CFCharacterSetRef theSet, CFCharacterSetRef theOtherset);

Boolean CFCharacterSetHasMemberInPlane(CFCharacterSetRef theSet, CFIndex thePlane);

CFMutableCharacterSetRef CFCharacterSetCreateMutable(CFAllocatorRef alloc);

CFCharacterSetRef CFCharacterSetCreateCopy(
    CFAllocatorRef alloc,
    CFCharacterSetRef theSet);

CFMutableCharacterSetRef CFCharacterSetCreateMutableCopy(
    CFAllocatorRef alloc,
    CFCharacterSetRef theSet);

Boolean CFCharacterSetIsCharacterMember(
    CFCharacterSetRef theSet,
    UniChar theChar);

Boolean CFCharacterSetIsLongCharacterMember(CFCharacterSetRef theSet, UTF32Char theChar);

CFDataRef CFCharacterSetCreateBitmapRepresentation(
    CFAllocatorRef alloc,
    CFCharacterSetRef theSet);

void CFCharacterSetAddCharactersInRange(
    CFMutableCharacterSetRef theSet,
    CFRange theRange);

void CFCharacterSetRemoveCharactersInRange(
    CFMutableCharacterSetRef theSet,
    CFRange theRange);

void CFCharacterSetAddCharactersInString(
    CFMutableCharacterSetRef theSet,
    CFStringRef theString);

void CFCharacterSetRemoveCharactersInString(
    CFMutableCharacterSetRef theSet,
    CFStringRef theString);

void CFCharacterSetUnion(
    CFMutableCharacterSetRef theSet,
    CFCharacterSetRef theOtherSet);

void CFCharacterSetIntersect(
    CFMutableCharacterSetRef theSet,
    CFCharacterSetRef theOtherSet);

void CFCharacterSetInvert(CFMutableCharacterSetRef theSet);

