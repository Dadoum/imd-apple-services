module fake.diskarbitration;

import std.string;

import slf4d;

import corefoundation;

extern(C):

alias kDADiskDescriptionVolumeUUIDKey = CFSTR!"DADiskDescriptionVolumeUUIDKey";

CFNumberRef DASessionCreate(void *alloc) {
    getLogger().trace("DASessionCreate");
    // Create a CFNumberRef
    // Create a CFNumberRef from 201
    int value = 201;
    CFNumberRef value_cf = CFNumberCreate(null, CFNumberType.kCFNumberIntType, &value);
    return value_cf;
    // return 201;
}


CFNumberRef DADiskCreateFromBSDName(CFAllocatorRef, CFAllocatorRef, char* name) {
    getLogger().traceF!"DADiskCreateFromBSDName: %s"(name.fromStringz());
    int value = 202;
    CFNumberRef value_cf = CFNumberCreate(null, CFNumberType.kCFNumberIntType, &value);
    return value_cf;
}

CFDictionaryRef DADiskCopyDescription() {
    getLogger().trace("DADiskCopyDescription");
    // CFDictionaryRef description = CFDictionaryCreate();
    CFMutableDictionaryRef description = CFDictionaryCreateMutable(
        kCFAllocatorDefault,
        0,
        &kCFCopyStringDictionaryKeyCallBacks,
        &kCFTypeDictionaryValueCallBacks
    );

    CFDictionaryAddValue(
        description,
        kDADiskDescriptionVolumeUUIDKey,
        CFUUIDCreate(kCFAllocatorDefault)
    );

    return cast(CFDictionaryRef) description;
}
