module CoreFoundation.CFKnownLocations;

public import CoreFoundation.CFBase;
public import CoreFoundation.CFURL;

extern (C):

alias __CF_ENUM_CFKnownLocationUser = int;

enum CFKnownLocationUser
{
    _kCFKnownLocationUserAny = 0,
    _kCFKnownLocationUserCurrent = 1,
    _kCFKnownLocationUserByName = 2
}

CFURLRef _CFKnownLocationCreatePreferencesURLForUser(CFKnownLocationUser user, CFStringRef username);

