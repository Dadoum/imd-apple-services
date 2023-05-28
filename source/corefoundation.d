module corefoundation;

public import CoreFoundation.CoreFoundation;

template CFSTR(string str) {
    __gshared static CFStringRef CFSTR;

    shared static this() {
        CFSTR = __CFStringMakeConstantString(str.ptr);
    }
}

bool CFSTR_CMP(CFStringRef str1, CFStringRef str2) {
    return CFStringCompare(str1, str2, cast(CFStringCompareFlags) 0) == 0;
}

string toString(CFStringRef str) {
    auto len = CFStringGetLength(str) + 1;
    string dstr = new immutable(char)[len];
    auto success = CFStringGetCString(str, cast(char*) dstr.ptr, len, CFStringBuiltInEncodings.kCFStringEncodingASCII);
    return dstr[0..$-1];
}
