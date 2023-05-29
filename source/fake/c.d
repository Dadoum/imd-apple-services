module fake.c;

import std.string;

import slf4d;

import darwin;
import fake.windows_stubs;

extern(C):

int sysctlbyname(char* name) {
    getLogger().traceF!"sysctlbyname: %s"(name.fromStringz());
    return 0;
}

uint arc4randomHook() {
    import std.random;
    return unpredictableSeed();
}

public import core.stdc.stdlib: malloc, free;
public import core.stdc.string: memcpy, memset;

void __bzero_impl(return scope void* b, size_t len) {
    memset(b, '\0', len);
}

alias __darwin_statfs64 = darwin_statfs;
