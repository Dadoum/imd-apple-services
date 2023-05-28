module CoreFoundation.CFStringEncodingConverterExt;

import core.stdc.config;

public import CoreFoundation.CFBase;
public import CoreFoundation.CFStringEncodingConverter;

extern (C):

enum
{
    kCFStringEncodingConverterStandard = 0,
    kCFStringEncodingConverterCheapEightBit = 1,
    kCFStringEncodingConverterStandardEightBit = 2,
    kCFStringEncodingConverterCheapMultiByte = 3,
    kCFStringEncodingConverterPlatformSpecific = 4,
    kCFStringEncodingConverterICU = 5
}

alias CFStringEncodingToBytesProc = c_long function(uint flags, const(UniChar)* characters, CFIndex numChars, ubyte* bytes, CFIndex maxByteLen, CFIndex* usedByteLen);
alias CFStringEncodingToUnicodeProc = c_long function(uint flags, const(ubyte)* bytes, CFIndex numBytes, UniChar* characters, CFIndex maxCharLen, CFIndex* usedCharLen);

alias CFStringEncodingCheapEightBitToBytesProc = bool function(uint flags, UniChar character, ubyte* byte_);
alias CFStringEncodingCheapEightBitToUnicodeProc = bool function(uint flags, ubyte byte_, UniChar* character);

alias CFStringEncodingStandardEightBitToBytesProc = ushort function(uint flags, const(UniChar)* characters, CFIndex numChars, ubyte* byte_);
alias CFStringEncodingStandardEightBitToUnicodeProc = ushort function(uint flags, ubyte byte_, UniChar* characters);

alias CFStringEncodingCheapMultiByteToBytesProc = ushort function(uint flags, UniChar character, ubyte* bytes);
alias CFStringEncodingCheapMultiByteToUnicodeProc = ushort function(uint flags, const(ubyte)* bytes, CFIndex numBytes, UniChar* character);

alias CFStringEncodingToBytesLenProc = c_long function(uint flags, const(UniChar)* characters, CFIndex numChars);
alias CFStringEncodingToUnicodeLenProc = c_long function(uint flags, const(ubyte)* bytes, CFIndex numBytes);

alias CFStringEncodingToBytesPrecomposeProc = c_long function(uint flags, const(UniChar)* character, CFIndex numChars, ubyte* bytes, CFIndex maxByteLen, CFIndex* usedByteLen);
alias CFStringEncodingIsValidCombiningCharacterProc = bool function(UniChar character);

private union _CFStringEncodingConverter_Union
{
    CFStringEncodingToBytesProc standard;
    CFStringEncodingCheapEightBitToBytesProc cheapEightBit;
    CFStringEncodingStandardEightBitToBytesProc standardEightBit;
    CFStringEncodingCheapMultiByteToBytesProc cheapMultibyte;
}

struct CFStringEncodingConverter
{
    import std.bitmanip : bitfields;

    _CFStringEncodingConverter_Union toBytes;
    _CFStringEncodingConverter_Union toUnicode;

    ushort maxBytesPerChar;
    ushort maxDecomposedCharLen;
    ubyte encodingClass;

    mixin(bitfields!(
        uint, "", 24,
        uint, "", 8));

    CFStringEncodingToBytesLenProc toBytesLen;
    CFStringEncodingToUnicodeLenProc toUnicodeLen;
    CFStringEncodingToBytesFallbackProc toBytesFallback;
    CFStringEncodingToUnicodeFallbackProc toUnicodeFallback;
    CFStringEncodingToBytesPrecomposeProc toBytesPrecompose;
    CFStringEncodingIsValidCombiningCharacterProc isValidCombiningChar;
}

enum
{
    kCFStringEncodingGetConverterSelector = 0,
    kCFStringEncodingIsDecomposableCharacterSelector = 1,
    kCFStringEncodingDecomposeCharacterSelector = 2,
    kCFStringEncodingIsValidLatin1CombiningCharacterSelector = 3,
    kCFStringEncodingPrecomposeLatin1CharacterSelector = 4
}

alias CFStringEncodingBootstrapProc = const(CFStringEncodingConverter)* function(uint encoding, const(void)* getSelector);

bool CFStringEncodingIsValidCombiningCharacterForLatin1(UniChar character);
UniChar CFStringEncodingPrecomposeLatinCharacter(const(UniChar)* character, CFIndex numChars, CFIndex* usedChars);

struct _CFStringEncodingUnicodeTo8BitCharMap
{
    import std.bitmanip : bitfields;

    UniChar _u;
    ubyte _c;
    mixin(bitfields!(ubyte, "", 8));
}

alias CFStringEncodingUnicodeTo8BitCharMap = _CFStringEncodingUnicodeTo8BitCharMap;

bool CFStringEncodingUnicodeTo8BitEncoding(
    const(CFStringEncodingUnicodeTo8BitCharMap)* theTable,
    CFIndex numElem,
    UniChar character,
    ubyte* ch);

