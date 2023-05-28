module CoreFoundation.CFDictionary;

import core.stdc.config;

public import CoreFoundation.CFBase;

extern (C):

alias CFDictionaryRetainCallBack = const(void)* function(CFAllocatorRef allocator, const(void)* value);
alias CFDictionaryReleaseCallBack = void function(CFAllocatorRef allocator, const(void)* value);
alias CFDictionaryCopyDescriptionCallBack = const(__CFString)* function(const(void)* value);
alias CFDictionaryEqualCallBack = ubyte function(const(void)* value1, const(void)* value2);
alias CFDictionaryHashCallBack = c_ulong function(const(void)* value);

struct CFDictionaryKeyCallBacks
{
    CFIndex version_;
    CFDictionaryRetainCallBack retain;
    CFDictionaryReleaseCallBack release;
    CFDictionaryCopyDescriptionCallBack copyDescription;
    CFDictionaryEqualCallBack equal;
    CFDictionaryHashCallBack hash;
}

extern __gshared const CFDictionaryKeyCallBacks kCFTypeDictionaryKeyCallBacks;

extern __gshared const CFDictionaryKeyCallBacks kCFCopyStringDictionaryKeyCallBacks;

struct CFDictionaryValueCallBacks
{
    CFIndex version_;
    CFDictionaryRetainCallBack retain;
    CFDictionaryReleaseCallBack release;
    CFDictionaryCopyDescriptionCallBack copyDescription;
    CFDictionaryEqualCallBack equal;
}

extern __gshared const CFDictionaryValueCallBacks kCFTypeDictionaryValueCallBacks;

alias CFDictionaryApplierFunction = void function(const(void)* key, const(void)* value, void* context);

struct __CFDictionary;
alias CFDictionaryRef = const(__CFDictionary)*;

alias CFMutableDictionaryRef = __CFDictionary*;

CFTypeID CFDictionaryGetTypeID();

CFDictionaryRef CFDictionaryCreate(
    CFAllocatorRef allocator,
    const(void*)* keys,
    const(void*)* values,
    CFIndex numValues,
    const(CFDictionaryKeyCallBacks)* keyCallBacks,
    const(CFDictionaryValueCallBacks)* valueCallBacks);

CFDictionaryRef CFDictionaryCreateCopy(
    CFAllocatorRef allocator,
    CFDictionaryRef theDict);

CFMutableDictionaryRef CFDictionaryCreateMutable(
    CFAllocatorRef allocator,
    CFIndex capacity,
    const(CFDictionaryKeyCallBacks)* keyCallBacks,
    const(CFDictionaryValueCallBacks)* valueCallBacks);

CFMutableDictionaryRef CFDictionaryCreateMutableCopy(
    CFAllocatorRef allocator,
    CFIndex capacity,
    CFDictionaryRef theDict);

CFIndex CFDictionaryGetCount(CFDictionaryRef theDict);

CFIndex CFDictionaryGetCountOfKey(CFDictionaryRef theDict, const(void)* key);

CFIndex CFDictionaryGetCountOfValue(
    CFDictionaryRef theDict,
    const(void)* value);

Boolean CFDictionaryContainsKey(CFDictionaryRef theDict, const(void)* key);

Boolean CFDictionaryContainsValue(CFDictionaryRef theDict, const(void)* value);

const(void)* CFDictionaryGetValue(CFDictionaryRef theDict, const(void)* key);

Boolean CFDictionaryGetValueIfPresent(
    CFDictionaryRef theDict,
    const(void)* key,
    const(void*)* value);

void CFDictionaryGetKeysAndValues(
    CFDictionaryRef theDict,
    const(void*)* keys,
    const(void*)* values);

void CFDictionaryApplyFunction(
    CFDictionaryRef theDict,
    CFDictionaryApplierFunction applier,
    void* context);

void CFDictionaryAddValue(
    CFMutableDictionaryRef theDict,
    const(void)* key,
    const(void)* value);

void CFDictionarySetValue(
    CFMutableDictionaryRef theDict,
    const(void)* key,
    const(void)* value);

void CFDictionaryReplaceValue(
    CFMutableDictionaryRef theDict,
    const(void)* key,
    const(void)* value);

void CFDictionaryRemoveValue(CFMutableDictionaryRef theDict, const(void)* key);

void CFDictionaryRemoveAllValues(CFMutableDictionaryRef theDict);

