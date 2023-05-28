module CoreFoundation.CFRunArray;

public import CoreFoundation.CFBase;

extern (C):

struct __CFRunArray;
alias CFRunArrayRef = __CFRunArray*;

CFTypeID CFRunArrayGetTypeID();

CFRunArrayRef CFRunArrayCreate(CFAllocatorRef allocator);

CFIndex CFRunArrayGetCount(CFRunArrayRef array);
CFTypeRef CFRunArrayGetValueAtIndex(CFRunArrayRef array, CFIndex loc, CFRange* effectiveRange, CFIndex* runArrayIndexPtr);
CFTypeRef CFRunArrayGetValueAtRunArrayIndex(CFRunArrayRef array, CFIndex runArrayIndex, CFIndex* countPtr);

void CFRunArrayInsert(CFRunArrayRef array, CFRange range, CFTypeRef obj);

void CFRunArrayDelete(CFRunArrayRef array, CFRange range);

void CFRunArrayReplace(CFRunArrayRef array, CFRange range, CFTypeRef obj, CFIndex count);

