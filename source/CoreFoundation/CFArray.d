module CoreFoundation.CFArray;

public import CoreFoundation.CFBase;

extern (C):

alias CFArrayRetainCallBack = const(void)* function(CFAllocatorRef allocator, const(void)* value);
alias CFArrayReleaseCallBack = void function(CFAllocatorRef allocator, const(void)* value);
alias CFArrayCopyDescriptionCallBack = const(__CFString)* function(const(void)* value);
alias CFArrayEqualCallBack = ubyte function(const(void)* value1, const(void)* value2);

struct CFArrayCallBacks
{
    CFIndex version_;
    CFArrayRetainCallBack retain;
    CFArrayReleaseCallBack release;
    CFArrayCopyDescriptionCallBack copyDescription;
    CFArrayEqualCallBack equal;
}

extern __gshared const CFArrayCallBacks kCFTypeArrayCallBacks;

alias CFArrayApplierFunction = void function(const(void)* value, void* context);

struct __CFArray;
alias CFArrayRef = const(__CFArray)*;

alias CFMutableArrayRef = __CFArray*;

CFTypeID CFArrayGetTypeID();

CFArrayRef CFArrayCreate(
    CFAllocatorRef allocator,
    const(void*)* values,
    CFIndex numValues,
    const(CFArrayCallBacks)* callBacks);

CFArrayRef CFArrayCreateCopy(CFAllocatorRef allocator, CFArrayRef theArray);

CFMutableArrayRef CFArrayCreateMutable(
    CFAllocatorRef allocator,
    CFIndex capacity,
    const(CFArrayCallBacks)* callBacks);

CFMutableArrayRef CFArrayCreateMutableCopy(
    CFAllocatorRef allocator,
    CFIndex capacity,
    CFArrayRef theArray);

CFIndex CFArrayGetCount(CFArrayRef theArray);

CFIndex CFArrayGetCountOfValue(
    CFArrayRef theArray,
    CFRange range,
    const(void)* value);

Boolean CFArrayContainsValue(
    CFArrayRef theArray,
    CFRange range,
    const(void)* value);

const(void)* CFArrayGetValueAtIndex(CFArrayRef theArray, CFIndex idx);

void CFArrayGetValues(CFArrayRef theArray, CFRange range, const(void*)* values);

void CFArrayApplyFunction(
    CFArrayRef theArray,
    CFRange range,
    CFArrayApplierFunction applier,
    void* context);

CFIndex CFArrayGetFirstIndexOfValue(
    CFArrayRef theArray,
    CFRange range,
    const(void)* value);

CFIndex CFArrayGetLastIndexOfValue(
    CFArrayRef theArray,
    CFRange range,
    const(void)* value);

CFIndex CFArrayBSearchValues(
    CFArrayRef theArray,
    CFRange range,
    const(void)* value,
    CFComparatorFunction comparator,
    void* context);

void CFArrayAppendValue(CFMutableArrayRef theArray, const(void)* value);

void CFArrayInsertValueAtIndex(
    CFMutableArrayRef theArray,
    CFIndex idx,
    const(void)* value);

void CFArraySetValueAtIndex(
    CFMutableArrayRef theArray,
    CFIndex idx,
    const(void)* value);

void CFArrayRemoveValueAtIndex(CFMutableArrayRef theArray, CFIndex idx);

void CFArrayRemoveAllValues(CFMutableArrayRef theArray);

void CFArrayReplaceValues(
    CFMutableArrayRef theArray,
    CFRange range,
    const(void*)* newValues,
    CFIndex newCount);

void CFArrayExchangeValuesAtIndices(
    CFMutableArrayRef theArray,
    CFIndex idx1,
    CFIndex idx2);

void CFArraySortValues(
    CFMutableArrayRef theArray,
    CFRange range,
    CFComparatorFunction comparator,
    void* context);

void CFArrayAppendArray(
    CFMutableArrayRef theArray,
    CFArrayRef otherArray,
    CFRange otherRange);

