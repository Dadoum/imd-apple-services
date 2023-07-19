module fake.diskarbitration;

import std.string;

import slf4d;

import corefoundation;
import fake.windows_stubs;

extern(C):

__gshared auto kDADiskDescriptionVolumeUUIDKey = new String("DADiskDescriptionVolumeUUIDKey");

long DASessionCreate(void *alloc) {
    getLogger().trace("DASessionCreate");
    // Create a CFNumberRef
    // Create a CFNumberRef from 201
    return 201;
    // return ;
}


long DADiskCreateFromBSDName(CFAllocatorRef, CFAllocatorRef, char* name) {
    getLogger().traceF!"DADiskCreateFromBSDName: %s"(name.fromStringz());
    return 202;
}

CFDictionaryRef DADiskCopyDescription() {
    getLogger().trace("DADiskCopyDescription");
    // CFDictionaryRef description = CFDictionaryCreate();
    CFMutableDictionaryRef description = CFDictionaryCreateMutable(
        null,
        0,
        null,
        null
    );

    static import std.uuid;
    import fake.iokit;
    CFDictionaryAddValue(
        description,
        kDADiskDescriptionVolumeUUIDKey,
        new UUID(std.uuid.UUID(data["root_disk_uuid"].str().native()))
    );
    // CFDictionaryAddValue(
    //     description,
    //     kDADiskDescriptionVolumeUUIDKey,
    //     CFUUIDCreate(null)
    // );

    return cast(CFDictionaryRef) description;
}
