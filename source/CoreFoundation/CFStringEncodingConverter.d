module CoreFoundation.CFStringEncodingConverter;

import core.stdc.config;

public import CoreFoundation.CFBase;

extern (C):

enum
{
    kCFStringEncodingAllowLossyConversion = 1UL << 0,
    kCFStringEncodingBasicDirectionLeftToRight = 1UL << 1,
    kCFStringEncodingBasicDirectionRightToLeft = 1UL << 2,
    kCFStringEncodingSubstituteCombinings = 1UL << 3,
    kCFStringEncodingComposeCombinings = 1UL << 4,
    kCFStringEncodingIgnoreCombinings = 1UL << 5,
    kCFStringEncodingUseCanonical = 1UL << 6,
    kCFStringEncodingUseHFSPlusCanonical = 1UL << 7,
    kCFStringEncodingPrependBOM = 1UL << 8,
    kCFStringEncodingDisableCorporateArea = 1UL << 9,
    kCFStringEncodingASCIICompatibleConversion = 1UL << 10,
    kCFStringEncodingLenientUTF8Conversion = 1UL << 11,
    kCFStringEncodingPartialInput = 1UL << 12,
    kCFStringEncodingPartialOutput = 1UL << 13
}

enum
{
    kCFStringEncodingConversionSuccess = 0,
    kCFStringEncodingInvalidInputStream = 1,
    kCFStringEncodingInsufficientOutputBufferLength = 2,
    kCFStringEncodingConverterUnavailable = 3
}

uint CFStringEncodingUnicodeToBytes(uint encoding, uint flags, const(UniChar)* characters, CFIndex numChars, CFIndex* usedCharLen, ubyte* bytes, CFIndex maxByteLen, CFIndex* usedByteLen);

uint CFStringEncodingBytesToUnicode(uint encoding, uint flags, const(ubyte)* bytes, CFIndex numBytes, CFIndex* usedByteLen, UniChar* characters, CFIndex maxCharLen, CFIndex* usedCharLen);

alias CFStringEncodingToBytesFallbackProc = c_long function(const(UniChar)* characters, CFIndex numChars, ubyte* bytes, CFIndex maxByteLen, CFIndex* usedByteLen);
alias CFStringEncodingToUnicodeFallbackProc = c_long function(const(ubyte)* bytes, CFIndex numBytes, UniChar* characters, CFIndex maxCharLen, CFIndex* usedCharLen);

void CFStringEncodingRegisterFallbackProcedures(uint encoding, CFStringEncodingToBytesFallbackProc toBytes, CFStringEncodingToUnicodeFallbackProc toUnicode);

