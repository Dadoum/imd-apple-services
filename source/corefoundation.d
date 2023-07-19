module corefoundation;

import core.stdc.stdint;

extern(C):

class String {
    string str;

    this(string str) {
        this.str = str;
    }

    alias str this;
}

alias CFStringRef = String;

bool CFSTR_CMP(CFStringRef str1, CFStringRef str2) {
    return str1.str == str2.str;
}

/// Dictionary with linear lookup, we don't care about performance
class NaiveDictionary {
    CFStringRef[] keys;
    Object[] values;

    Object opIndexAssign(Object value, CFStringRef str) {
        keys ~= str;
        values ~= value;
        return value;
    }

    Object opIndex(CFStringRef index) {
        import std.algorithm;
        auto matchingIndex = keys.countUntil!((key) => CFSTR_CMP(key, index));
        return values[matchingIndex];
    }

}

alias CFIndex = long;
alias CFAllocatorRef = void*;

alias CFDictionaryRef = NaiveDictionary;
alias CFMutableDictionaryRef = CFDictionaryRef;

pragma(mangle, "repl.CFDictionaryCreateMutable") CFMutableDictionaryRef CFDictionaryCreateMutable(
    void* allocator,
    CFIndex capacity,
    void* keyCallBacks,
    void* valueCallBacks) {
    return new NaiveDictionary();
}

pragma(mangle, "repl.CFDictionaryGetValue") Object CFDictionaryGetValue(CFDictionaryRef theDict, CFStringRef key) {
    return theDict[key];
}

pragma(mangle, "repl.CFDictionarySetValue") void CFDictionarySetValue(CFDictionaryRef theDict, CFStringRef key, Object value) {
    theDict[key] = value;
}

pragma(mangle, "repl.CFDictionaryAddValue") void CFDictionaryAddValue(CFDictionaryRef theDict, CFStringRef key, Object value) {
    theDict[key] = value;
}

class Data {
    ubyte[] data;

    this(ubyte[] data) {
        this.data = data;
    }

    alias data this;
}
alias CFDataRef = Data;
alias CFTypeRef = Object;

pragma(mangle, "repl.CFDataGetLength") int CFDataGetLength(CFDataRef theData) {
    return cast(int) theData.length;
}

struct CFRange
{
    CFIndex location;
    CFIndex length;
}

pragma(mangle, "repl.CFDataGetBytes") void CFDataGetBytes(CFDataRef theData, CFRange range, ubyte *buffer) {
    buffer[0..range.length] = theData.data[range.location..range.location + range.length];
}

pragma(mangle, "repl.CFDataGetTypeID") auto CFDataGetTypeID() {
    return typeid(CFDataRef);
}

// alias CFStringRef;

pragma(mangle, "repl.CFStringGetTypeID") auto CFStringGetTypeID() {
    return typeid(CFStringRef);
}

pragma(mangle, "repl.CFStringGetLength") int CFStringGetLength(CFStringRef str) {
    return cast(int) str.length;
}

alias CFStringEncoding = uint32_t;

pragma(mangle, "repl.CFStringGetMaximumSizeForEncoding") CFIndex CFStringGetMaximumSizeForEncoding(CFIndex length, CFStringEncoding encoding) {
    return length;
}

pragma(mangle, "repl.CFStringGetCString") bool CFStringGetCString(CFStringRef str, char* output, CFIndex outputSize, CFStringEncoding encoding) {
    import std.string;
    output[0..str.str.length] = str.str;
    output[str.str.length] = '\0';
    return true;
}

pragma(mangle, "repl.CFStringCreateWithCString") CFStringRef CFStringCreateWithCString(void* alloc,
    const(char)* cStr,
    CFStringEncoding encoding) {
    import std.string;
    return new String(cast(string) cStr.fromStringz());
}

alias CFTypeID = TypeInfo;

pragma(mangle, "repl.CFGetTypeID") CFTypeID CFGetTypeID(Object obj) {
    return typeid(obj);
}

class UUID {
    static import std.uuid;
    std.uuid.UUID uuid;

    this(std.uuid.UUID uuid_) {
        this.uuid = uuid_;
    }
}

alias CFUUIDRef = UUID;

pragma(mangle, "repl.CFUUIDCreateString") CFStringRef CFUUIDCreateString(void* alloc, CFUUIDRef uuid) {
    import std.uni;
    return new String(uuid.uuid.toString().toUpper());
}

pragma(mangle, "repl.CFRelease") void CFRelease(CFTypeRef cf) {

}
