module CoreFoundation.CFBinaryHeap;

public import CoreFoundation.CFBase;

extern (C):

struct CFBinaryHeapCompareContext
{
    CFIndex version_;
    void* info;
    const(void)* function(const(void)* info) retain;
    void function(const(void)* info) release;
    CFStringRef function(const(void)* info) copyDescription;
}

struct CFBinaryHeapCallBacks
{
    CFIndex version_;
    const(void)* function(CFAllocatorRef allocator, const(void)* ptr) retain;
    void function(CFAllocatorRef allocator, const(void)* ptr) release;
    CFStringRef function(const(void)* ptr) copyDescription;
    CFComparisonResult function(const(void)* ptr1, const(void)* ptr2, void* context) compare;
}

extern __gshared const CFBinaryHeapCallBacks kCFStringBinaryHeapCallBacks;

alias CFBinaryHeapApplierFunction = void function(const(void)* val, void* context);

struct __CFBinaryHeap;
alias CFBinaryHeapRef = __CFBinaryHeap*;

CFTypeID CFBinaryHeapGetTypeID();

CFBinaryHeapRef CFBinaryHeapCreate(CFAllocatorRef allocator, CFIndex capacity, const(CFBinaryHeapCallBacks)* callBacks, const(CFBinaryHeapCompareContext)* compareContext);

CFBinaryHeapRef CFBinaryHeapCreateCopy(CFAllocatorRef allocator, CFIndex capacity, CFBinaryHeapRef heap);

CFIndex CFBinaryHeapGetCount(CFBinaryHeapRef heap);

CFIndex CFBinaryHeapGetCountOfValue(CFBinaryHeapRef heap, const(void)* value);

Boolean CFBinaryHeapContainsValue(CFBinaryHeapRef heap, const(void)* value);

const(void)* CFBinaryHeapGetMinimum(CFBinaryHeapRef heap);

Boolean CFBinaryHeapGetMinimumIfPresent(CFBinaryHeapRef heap, const(void*)* value);

void CFBinaryHeapGetValues(CFBinaryHeapRef heap, const(void*)* values);

void CFBinaryHeapApplyFunction(CFBinaryHeapRef heap, CFBinaryHeapApplierFunction applier, void* context);

void CFBinaryHeapAddValue(CFBinaryHeapRef heap, const(void)* value);

void CFBinaryHeapRemoveMinimumValue(CFBinaryHeapRef heap);

void CFBinaryHeapRemoveAllValues(CFBinaryHeapRef heap);

