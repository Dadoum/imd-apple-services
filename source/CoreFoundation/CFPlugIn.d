module CoreFoundation.CFPlugIn;

public import CoreFoundation.CFArray;
public import CoreFoundation.CFBase;
public import CoreFoundation.CFBundle;
public import CoreFoundation.CFURL;
public import CoreFoundation.CFUUID;

extern (C):

extern __gshared const CFStringRef kCFPlugInDynamicRegistrationKey;
extern __gshared const CFStringRef kCFPlugInDynamicRegisterFunctionKey;
extern __gshared const CFStringRef kCFPlugInUnloadFunctionKey;
extern __gshared const CFStringRef kCFPlugInFactoriesKey;
extern __gshared const CFStringRef kCFPlugInTypesKey;

alias CFPlugInDynamicRegisterFunction = void function(CFPlugInRef plugIn);
alias CFPlugInUnloadFunction = void function(CFPlugInRef plugIn);
alias CFPlugInFactoryFunction = void* function(CFAllocatorRef allocator, CFUUIDRef typeUUID);

CFTypeID CFPlugInGetTypeID();

CFPlugInRef CFPlugInCreate(CFAllocatorRef allocator, CFURLRef plugInURL);

CFBundleRef CFPlugInGetBundle(CFPlugInRef plugIn);

void CFPlugInSetLoadOnDemand(CFPlugInRef plugIn, Boolean flag);

Boolean CFPlugInIsLoadOnDemand(CFPlugInRef plugIn);

CFArrayRef CFPlugInFindFactoriesForPlugInType(CFUUIDRef typeUUID);

CFArrayRef CFPlugInFindFactoriesForPlugInTypeInPlugIn(CFUUIDRef typeUUID, CFPlugInRef plugIn);

void* CFPlugInInstanceCreate(CFAllocatorRef allocator, CFUUIDRef factoryUUID, CFUUIDRef typeUUID);

Boolean CFPlugInRegisterFactoryFunction(CFUUIDRef factoryUUID, CFPlugInFactoryFunction func);

Boolean CFPlugInRegisterFactoryFunctionByName(CFUUIDRef factoryUUID, CFPlugInRef plugIn, CFStringRef functionName);

Boolean CFPlugInUnregisterFactory(CFUUIDRef factoryUUID);

Boolean CFPlugInRegisterPlugInType(CFUUIDRef factoryUUID, CFUUIDRef typeUUID);

Boolean CFPlugInUnregisterPlugInType(CFUUIDRef factoryUUID, CFUUIDRef typeUUID);

void CFPlugInAddInstanceForFactory(CFUUIDRef factoryID);

void CFPlugInRemoveInstanceForFactory(CFUUIDRef factoryID);

struct __CFPlugInInstance;
alias CFPlugInInstanceRef = __CFPlugInInstance*;

alias CFPlugInInstanceGetInterfaceFunction = ubyte function(CFPlugInInstanceRef instance, CFStringRef interfaceName, void** ftbl);
alias CFPlugInInstanceDeallocateInstanceDataFunction = void function(void* instanceData);

Boolean CFPlugInInstanceGetInterfaceFunctionTable(CFPlugInInstanceRef instance, CFStringRef interfaceName, void** ftbl);

CFStringRef CFPlugInInstanceGetFactoryName(CFPlugInInstanceRef instance);

void* CFPlugInInstanceGetInstanceData(CFPlugInInstanceRef instance);

CFTypeID CFPlugInInstanceGetTypeID();

CFPlugInInstanceRef CFPlugInInstanceCreateWithInstanceDataSize(CFAllocatorRef allocator, CFIndex instanceDataSize, CFPlugInInstanceDeallocateInstanceDataFunction deallocateInstanceFunction, CFStringRef factoryName, CFPlugInInstanceGetInterfaceFunction getInterfaceFunction);

