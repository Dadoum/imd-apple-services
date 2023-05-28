module CoreFoundation.CFByteOrder;

import core.stdc.config;

public import CoreFoundation.CFBase;

extern (C):

enum __CFByteOrder
{
    CFByteOrderUnknown = 0,
    CFByteOrderLittleEndian = 1,
    CFByteOrderBigEndian = 2
}

alias CFByteOrder = c_long;

CFByteOrder CFByteOrderGetCurrent();

ushort CFSwapInt16(ushort arg);

uint CFSwapInt32(uint arg);

ulong CFSwapInt64(ulong arg);

ushort CFSwapInt16BigToHost(ushort arg);

uint CFSwapInt32BigToHost(uint arg);

ulong CFSwapInt64BigToHost(ulong arg);

ushort CFSwapInt16HostToBig(ushort arg);

uint CFSwapInt32HostToBig(uint arg);

ulong CFSwapInt64HostToBig(ulong arg);

ushort CFSwapInt16LittleToHost(ushort arg);

uint CFSwapInt32LittleToHost(uint arg);

ulong CFSwapInt64LittleToHost(ulong arg);

ushort CFSwapInt16HostToLittle(ushort arg);

uint CFSwapInt32HostToLittle(uint arg);

ulong CFSwapInt64HostToLittle(ulong arg);

struct CFSwappedFloat32
{
    uint v;
}

struct CFSwappedFloat64
{
    ulong v;
}

CFSwappedFloat32 CFConvertFloat32HostToSwapped(Float32 arg);

Float32 CFConvertFloat32SwappedToHost(CFSwappedFloat32 arg);

CFSwappedFloat64 CFConvertFloat64HostToSwapped(Float64 arg);

Float64 CFConvertFloat64SwappedToHost(CFSwappedFloat64 arg);

CFSwappedFloat32 CFConvertFloatHostToSwapped(float arg);

float CFConvertFloatSwappedToHost(CFSwappedFloat32 arg);

CFSwappedFloat64 CFConvertDoubleHostToSwapped(double arg);

double CFConvertDoubleSwappedToHost(CFSwappedFloat64 arg);

