module CoreFoundation.CFLogUtilities;

public import CoreFoundation.CFBase;

extern (C):

alias CFLogLevel = int;

enum
{
    kCFLogLevelEmergency = 0,
    kCFLogLevelAlert = 1,
    kCFLogLevelCritical = 2,
    kCFLogLevelError = 3,
    kCFLogLevelWarning = 4,
    kCFLogLevelNotice = 5,
    kCFLogLevelInfo = 6,
    kCFLogLevelDebug = 7
}

void CFLog(CFLogLevel level, CFStringRef format, ...);

