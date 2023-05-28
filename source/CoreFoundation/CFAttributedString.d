module CoreFoundation.CFAttributedString;

public import CoreFoundation.CFBase;
public import CoreFoundation.CFDictionary;

extern (C):

struct __CFAttributedString;
alias CFAttributedStringRef = const(__CFAttributedString)*;
alias CFMutableAttributedStringRef = __CFAttributedString*;

CFTypeID CFAttributedStringGetTypeID();

CFAttributedStringRef CFAttributedStringCreate(CFAllocatorRef alloc, CFStringRef str, CFDictionaryRef attributes);

CFAttributedStringRef CFAttributedStringCreateWithSubstring(CFAllocatorRef alloc, CFAttributedStringRef aStr, CFRange range);

CFAttributedStringRef CFAttributedStringCreateCopy(CFAllocatorRef alloc, CFAttributedStringRef aStr);

CFStringRef CFAttributedStringGetString(CFAttributedStringRef aStr);

CFIndex CFAttributedStringGetLength(CFAttributedStringRef aStr);

CFDictionaryRef CFAttributedStringGetAttributes(CFAttributedStringRef aStr, CFIndex loc, CFRange* effectiveRange);

CFTypeRef CFAttributedStringGetAttribute(CFAttributedStringRef aStr, CFIndex loc, CFStringRef attrName, CFRange* effectiveRange);

CFDictionaryRef CFAttributedStringGetAttributesAndLongestEffectiveRange(CFAttributedStringRef aStr, CFIndex loc, CFRange inRange, CFRange* longestEffectiveRange);

CFTypeRef CFAttributedStringGetAttributeAndLongestEffectiveRange(CFAttributedStringRef aStr, CFIndex loc, CFStringRef attrName, CFRange inRange, CFRange* longestEffectiveRange);

CFMutableAttributedStringRef CFAttributedStringCreateMutableCopy(CFAllocatorRef alloc, CFIndex maxLength, CFAttributedStringRef aStr);

CFMutableAttributedStringRef CFAttributedStringCreateMutable(CFAllocatorRef alloc, CFIndex maxLength);

void CFAttributedStringReplaceString(CFMutableAttributedStringRef aStr, CFRange range, CFStringRef replacement);

CFMutableStringRef CFAttributedStringGetMutableString(CFMutableAttributedStringRef aStr);

void CFAttributedStringSetAttributes(CFMutableAttributedStringRef aStr, CFRange range, CFDictionaryRef replacement, Boolean clearOtherAttributes);

void CFAttributedStringSetAttribute(CFMutableAttributedStringRef aStr, CFRange range, CFStringRef attrName, CFTypeRef value);

void CFAttributedStringRemoveAttribute(CFMutableAttributedStringRef aStr, CFRange range, CFStringRef attrName);

void CFAttributedStringReplaceAttributedString(CFMutableAttributedStringRef aStr, CFRange range, CFAttributedStringRef replacement);

void CFAttributedStringBeginEditing(CFMutableAttributedStringRef aStr);

void CFAttributedStringEndEditing(CFMutableAttributedStringRef aStr);

