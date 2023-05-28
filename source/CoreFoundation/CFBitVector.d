module CoreFoundation.CFBitVector;

public import CoreFoundation.CFBase;

extern (C):

alias CFBit = uint;

struct __CFBitVector;
alias CFBitVectorRef = const(__CFBitVector)*;
alias CFMutableBitVectorRef = __CFBitVector*;

CFTypeID CFBitVectorGetTypeID();

CFBitVectorRef CFBitVectorCreate(CFAllocatorRef allocator, const(UInt8)* bytes, CFIndex numBits);
CFBitVectorRef CFBitVectorCreateCopy(CFAllocatorRef allocator, CFBitVectorRef bv);
CFMutableBitVectorRef CFBitVectorCreateMutable(CFAllocatorRef allocator, CFIndex capacity);
CFMutableBitVectorRef CFBitVectorCreateMutableCopy(CFAllocatorRef allocator, CFIndex capacity, CFBitVectorRef bv);

CFIndex CFBitVectorGetCount(CFBitVectorRef bv);
CFIndex CFBitVectorGetCountOfBit(CFBitVectorRef bv, CFRange range, CFBit value);
Boolean CFBitVectorContainsBit(CFBitVectorRef bv, CFRange range, CFBit value);
CFBit CFBitVectorGetBitAtIndex(CFBitVectorRef bv, CFIndex idx);
void CFBitVectorGetBits(CFBitVectorRef bv, CFRange range, UInt8* bytes);
CFIndex CFBitVectorGetFirstIndexOfBit(CFBitVectorRef bv, CFRange range, CFBit value);
CFIndex CFBitVectorGetLastIndexOfBit(CFBitVectorRef bv, CFRange range, CFBit value);

void CFBitVectorSetCount(CFMutableBitVectorRef bv, CFIndex count);
void CFBitVectorFlipBitAtIndex(CFMutableBitVectorRef bv, CFIndex idx);
void CFBitVectorFlipBits(CFMutableBitVectorRef bv, CFRange range);
void CFBitVectorSetBitAtIndex(CFMutableBitVectorRef bv, CFIndex idx, CFBit value);
void CFBitVectorSetBits(CFMutableBitVectorRef bv, CFRange range, CFBit value);
void CFBitVectorSetAllBits(CFMutableBitVectorRef bv, CFBit value);

