module fake.c;

import std.string;

import slf4d;

import darwin;

extern(C):

int sysctlbyname(char* name) {
    getLogger().traceF!"sysctlbyname: %s"(name.fromStringz());
    return 0;
}


uint arc4randomHook() {
    return 0;
}

public import core.stdc.stdlib: malloc, free;
public import core.stdc.string: memcpy;
void __memset_chk();
void bzero();

alias __darwin_statfs64 = darwin_statfs;
