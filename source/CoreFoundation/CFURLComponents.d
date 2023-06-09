module CoreFoundation.CFURLComponents;

public import CoreFoundation.CFArray;
public import CoreFoundation.CFBase;
public import CoreFoundation.CFCharacterSet;
public import CoreFoundation.CFNumber;
public import CoreFoundation.CFURL;

extern (C):

struct __CFURLComponents;
alias CFURLComponentsRef = __CFURLComponents*;

CFTypeID _CFURLComponentsGetTypeID();

CFURLComponentsRef _CFURLComponentsCreate(CFAllocatorRef alloc);

CFURLComponentsRef _CFURLComponentsCreateWithURL(CFAllocatorRef alloc, CFURLRef url, Boolean resolveAgainstBaseURL);

CFURLComponentsRef _CFURLComponentsCreateWithString(CFAllocatorRef alloc, CFStringRef string);

CFURLComponentsRef _CFURLComponentsCreateCopy(CFAllocatorRef alloc, CFURLComponentsRef components);

CFURLRef _CFURLComponentsCopyURL(CFURLComponentsRef components);

CFURLRef _CFURLComponentsCopyURLRelativeToURL(CFURLComponentsRef components, CFURLRef relativeToURL);

CFStringRef _CFURLComponentsCopyString(CFURLComponentsRef components);

CFStringRef _CFURLComponentsCopyScheme(CFURLComponentsRef components);
CFStringRef _CFURLComponentsCopyUser(CFURLComponentsRef components);
CFStringRef _CFURLComponentsCopyPassword(CFURLComponentsRef components);
CFStringRef _CFURLComponentsCopyHost(CFURLComponentsRef components);
CFNumberRef _CFURLComponentsCopyPort(CFURLComponentsRef components);
CFStringRef _CFURLComponentsCopyPath(CFURLComponentsRef components);
CFStringRef _CFURLComponentsCopyQuery(CFURLComponentsRef components);
CFStringRef _CFURLComponentsCopyFragment(CFURLComponentsRef components);

Boolean _CFURLComponentsSchemeIsValid(CFStringRef scheme);

Boolean _CFURLComponentsSetScheme(CFURLComponentsRef components, CFStringRef scheme);
Boolean _CFURLComponentsSetUser(CFURLComponentsRef components, CFStringRef user);
Boolean _CFURLComponentsSetPassword(CFURLComponentsRef components, CFStringRef password);
Boolean _CFURLComponentsSetHost(CFURLComponentsRef components, CFStringRef host);
Boolean _CFURLComponentsSetPort(CFURLComponentsRef components, CFNumberRef port);
Boolean _CFURLComponentsSetPath(CFURLComponentsRef components, CFStringRef path);
Boolean _CFURLComponentsSetQuery(CFURLComponentsRef components, CFStringRef query);
Boolean _CFURLComponentsSetFragment(CFURLComponentsRef components, CFStringRef fragment);

CFStringRef _CFURLComponentsCopyPercentEncodedUser(CFURLComponentsRef components);
CFStringRef _CFURLComponentsCopyPercentEncodedPassword(CFURLComponentsRef components);
CFStringRef _CFURLComponentsCopyPercentEncodedHost(CFURLComponentsRef components);
CFStringRef _CFURLComponentsCopyPercentEncodedPath(CFURLComponentsRef components);
CFStringRef _CFURLComponentsCopyPercentEncodedQuery(CFURLComponentsRef components);
CFStringRef _CFURLComponentsCopyPercentEncodedFragment(CFURLComponentsRef components);

Boolean _CFURLComponentsSetPercentEncodedUser(CFURLComponentsRef components, CFStringRef user);
Boolean _CFURLComponentsSetPercentEncodedPassword(CFURLComponentsRef components, CFStringRef password);
Boolean _CFURLComponentsSetPercentEncodedHost(CFURLComponentsRef components, CFStringRef host);
Boolean _CFURLComponentsSetPercentEncodedPath(CFURLComponentsRef components, CFStringRef path);
Boolean _CFURLComponentsSetPercentEncodedQuery(CFURLComponentsRef components, CFStringRef query);
Boolean _CFURLComponentsSetPercentEncodedFragment(CFURLComponentsRef components, CFStringRef fragment);

CFRange _CFURLComponentsGetRangeOfScheme(CFURLComponentsRef components);
CFRange _CFURLComponentsGetRangeOfUser(CFURLComponentsRef components);
CFRange _CFURLComponentsGetRangeOfPassword(CFURLComponentsRef components);
CFRange _CFURLComponentsGetRangeOfHost(CFURLComponentsRef components);
CFRange _CFURLComponentsGetRangeOfPort(CFURLComponentsRef components);
CFRange _CFURLComponentsGetRangeOfPath(CFURLComponentsRef components);
CFRange _CFURLComponentsGetRangeOfQuery(CFURLComponentsRef components);
CFRange _CFURLComponentsGetRangeOfFragment(CFURLComponentsRef components);

CFStringRef _CFStringCreateByAddingPercentEncodingWithAllowedCharacters(CFAllocatorRef alloc, CFStringRef string, CFCharacterSetRef allowedCharacters);
CFStringRef _CFStringCreateByRemovingPercentEncoding(CFAllocatorRef alloc, CFStringRef string);

CFCharacterSetRef _CFURLComponentsGetURLUserAllowedCharacterSet();
CFCharacterSetRef _CFURLComponentsGetURLPasswordAllowedCharacterSet();
CFCharacterSetRef _CFURLComponentsGetURLHostAllowedCharacterSet();
CFCharacterSetRef _CFURLComponentsGetURLPathAllowedCharacterSet();
CFCharacterSetRef _CFURLComponentsGetURLQueryAllowedCharacterSet();
CFCharacterSetRef _CFURLComponentsGetURLFragmentAllowedCharacterSet();

extern __gshared const CFStringRef _kCFURLComponentsNameKey;
extern __gshared const CFStringRef _kCFURLComponentsValueKey;

CFArrayRef _CFURLComponentsCopyQueryItems(CFURLComponentsRef components);
void _CFURLComponentsSetQueryItems(CFURLComponentsRef components, CFArrayRef names, CFArrayRef values);

CFArrayRef _CFURLComponentsCopyPercentEncodedQueryItems(CFURLComponentsRef components);
Boolean _CFURLComponentsSetPercentEncodedQueryItems(CFURLComponentsRef components, CFArrayRef names, CFArrayRef values);

