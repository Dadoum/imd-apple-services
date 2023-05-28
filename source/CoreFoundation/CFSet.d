module CoreFoundation.CFSet;

import core.stdc.config;

public import CoreFoundation.CFBase;

extern (C):

alias CFSetRetainCallBack = const(void)* function(CFAllocatorRef allocator, const(void)* value);

alias CFSetReleaseCallBack = void function(CFAllocatorRef allocator, const(void)* value);

alias CFSetCopyDescriptionCallBack = const(__CFString)* function(const(void)* value);

alias CFSetEqualCallBack = ubyte function(const(void)* value1, const(void)* value2);

alias CFSetHashCallBack = c_ulong function(const(void)* value);

struct CFSetCallBacks
{
    CFIndex version_;
    CFSetRetainCallBack retain;
    CFSetReleaseCallBack release;
    CFSetCopyDescriptionCallBack copyDescription;
    CFSetEqualCallBack equal;
    CFSetHashCallBack hash;
}

extern __gshared const CFSetCallBacks kCFTypeSetCallBacks;

extern __gshared const CFSetCallBacks kCFCopyStringSetCallBacks;

alias CFSetApplierFunction = void function(const(void)* value, void* context);

struct __CFSet;
alias CFSetRef = const(__CFSet)*;

alias CFMutableSetRef = __CFSet*;

CFTypeID CFSetGetTypeID();

CFSetRef CFSetCreate(
    CFAllocatorRef allocator,
    const(void*)* values,
    CFIndex numValues,
    const(CFSetCallBacks)* callBacks);

CFSetRef CFSetCreateCopy(CFAllocatorRef allocator, CFSetRef theSet);

CFMutableSetRef CFSetCreateMutable(
    CFAllocatorRef allocator,
    CFIndex capacity,
    const(CFSetCallBacks)* callBacks);

CFMutableSetRef CFSetCreateMutableCopy(
    CFAllocatorRef allocator,
    CFIndex capacity,
    CFSetRef theSet);

CFIndex CFSetGetCount(CFSetRef theSet);

CFIndex CFSetGetCountOfValue(CFSetRef theSet, const(void)* value);

Boolean CFSetContainsValue(CFSetRef theSet, const(void)* value);

const(void)* CFSetGetValue(CFSetRef theSet, const(void)* value);

Boolean CFSetGetValueIfPresent(
    CFSetRef theSet,
    const(void)* candidate,
    const(void*)* value);

void CFSetGetValues(CFSetRef theSet, const(void*)* values);

void CFSetApplyFunction(
    CFSetRef theSet,
    CFSetApplierFunction applier,
    void* context);

void CFSetAddValue(CFMutableSetRef theSet, const(void)* value);

void CFSetReplaceValue(CFMutableSetRef theSet, const(void)* value);

void CFSetSetValue(CFMutableSetRef theSet, const(void)* value);

void CFSetRemoveValue(CFMutableSetRef theSet, const(void)* value);

void CFSetRemoveAllValues(CFMutableSetRef theSet);

