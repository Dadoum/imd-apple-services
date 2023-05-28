module CoreFoundation.CFBag;

import core.stdc.config;

public import CoreFoundation.CFBase;

extern (C):

alias CFBagRetainCallBack = const(void)* function(CFAllocatorRef allocator, const(void)* value);
alias CFBagReleaseCallBack = void function(CFAllocatorRef allocator, const(void)* value);
alias CFBagCopyDescriptionCallBack = const(__CFString)* function(const(void)* value);
alias CFBagEqualCallBack = ubyte function(const(void)* value1, const(void)* value2);
alias CFBagHashCallBack = c_ulong function(const(void)* value);

struct CFBagCallBacks
{
    CFIndex version_;
    CFBagRetainCallBack retain;
    CFBagReleaseCallBack release;
    CFBagCopyDescriptionCallBack copyDescription;
    CFBagEqualCallBack equal;
    CFBagHashCallBack hash;
}

extern __gshared const CFBagCallBacks kCFTypeBagCallBacks;
extern __gshared const CFBagCallBacks kCFCopyStringBagCallBacks;

alias CFBagApplierFunction = void function(const(void)* value, void* context);

struct __CFBag;
alias CFBagRef = const(__CFBag)*;
alias CFMutableBagRef = __CFBag*;

CFTypeID CFBagGetTypeID();

CFBagRef CFBagCreate(
    CFAllocatorRef allocator,
    const(void*)* values,
    CFIndex numValues,
    const(CFBagCallBacks)* callBacks);

CFBagRef CFBagCreateCopy(CFAllocatorRef allocator, CFBagRef theBag);

CFMutableBagRef CFBagCreateMutable(
    CFAllocatorRef allocator,
    CFIndex capacity,
    const(CFBagCallBacks)* callBacks);

CFMutableBagRef CFBagCreateMutableCopy(
    CFAllocatorRef allocator,
    CFIndex capacity,
    CFBagRef theBag);

CFIndex CFBagGetCount(CFBagRef theBag);

CFIndex CFBagGetCountOfValue(CFBagRef theBag, const(void)* value);

Boolean CFBagContainsValue(CFBagRef theBag, const(void)* value);

const(void)* CFBagGetValue(CFBagRef theBag, const(void)* value);

Boolean CFBagGetValueIfPresent(
    CFBagRef theBag,
    const(void)* candidate,
    const(void*)* value);

void CFBagGetValues(CFBagRef theBag, const(void*)* values);

void CFBagApplyFunction(
    CFBagRef theBag,
    CFBagApplierFunction applier,
    void* context);

void CFBagAddValue(CFMutableBagRef theBag, const(void)* value);

void CFBagReplaceValue(CFMutableBagRef theBag, const(void)* value);

void CFBagSetValue(CFMutableBagRef theBag, const(void)* value);

void CFBagRemoveValue(CFMutableBagRef theBag, const(void)* value);

void CFBagRemoveAllValues(CFMutableBagRef theBag);

