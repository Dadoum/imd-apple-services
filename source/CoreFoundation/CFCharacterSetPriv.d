module CoreFoundation.CFCharacterSetPriv;

public import CoreFoundation.CFBase;
public import CoreFoundation.CFCharacterSet;

extern (C):

Boolean CFCharacterSetIsSurrogateHighCharacter(UniChar character);

Boolean CFCharacterSetIsSurrogateLowCharacter(UniChar character);

UTF32Char CFCharacterSetGetLongCharacterForSurrogatePair(
    UniChar surrogateHigh,
    UniChar surrogateLow);

Boolean CFCharacterSetIsSurrogatePairMember(CFCharacterSetRef theSet, UniChar surrogateHigh, UniChar surrogateLow);

alias __CF_ENUM_CFCharacterSetKeyedCodingType = int;

enum CFCharacterSetKeyedCodingType
{
    kCFCharacterSetKeyedCodingTypeBitmap = 1,
    kCFCharacterSetKeyedCodingTypeBuiltin = 2,
    kCFCharacterSetKeyedCodingTypeRange = 3,
    kCFCharacterSetKeyedCodingTypeString = 4,
    kCFCharacterSetKeyedCodingTypeBuiltinAndBitmap = 5
}

CFCharacterSetKeyedCodingType _CFCharacterSetGetKeyedCodingType(CFCharacterSetRef cset);
CFCharacterSetPredefinedSet _CFCharacterSetGetKeyedCodingBuiltinType(CFCharacterSetRef cset);
CFRange _CFCharacterSetGetKeyedCodingRange(CFCharacterSetRef cset);
CFStringRef _CFCharacterSetCreateKeyedCodingString(CFCharacterSetRef cset);
bool _CFCharacterSetIsInverted(CFCharacterSetRef cset);
void _CFCharacterSetSetIsInverted(CFCharacterSetRef cset, bool flag);

void _CFCharacterSetCompact(CFMutableCharacterSetRef cset);
void _CFCharacterSetFast(CFMutableCharacterSetRef cset);

