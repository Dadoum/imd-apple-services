module CoreFoundation.CFRegularExpression;

public import CoreFoundation.CFBase;
public import CoreFoundation.CFError;

extern (C):

alias __CF_OPTIONS__CFRegularExpressionOptions = int;

enum _CFRegularExpressionOptions
{
    _kCFRegularExpressionCaseInsensitive = 1 << 0,
    _kCFRegularExpressionAllowCommentsAndWhitespace = 1 << 1,
    _kCFRegularExpressionIgnoreMetacharacters = 1 << 2,
    _kCFRegularExpressionDotMatchesLineSeparators = 1 << 3,
    _kCFRegularExpressionAnchorsMatchLines = 1 << 4,
    _kCFRegularExpressionUseUnixLineSeparators = 1 << 5,
    _kCFRegularExpressionUseUnicodeWordBoundaries = 1 << 6
}

alias __CF_OPTIONS__CFRegularExpressionMatchingOptions = int;

enum _CFRegularExpressionMatchingOptions
{
    _kCFRegularExpressionMatchingReportProgress = 1 << 0,
    _kCFRegularExpressionMatchingReportCompletion = 1 << 1,
    _kCFRegularExpressionMatchingAnchored = 1 << 2,
    _kCFRegularExpressionMatchingWithTransparentBounds = 1 << 3,
    _kCFRegularExpressionMatchingWithoutAnchoringBounds = 1 << 4,
    _kCFRegularExpressionMatchingOmitResult = 1 << 13
}

alias __CF_OPTIONS__CFRegularExpressionMatchingFlags = int;

enum _CFRegularExpressionMatchingFlags
{
    _kCFRegularExpressionMatchingProgress = 1 << 0,
    _kCFRegularExpressionMatchingCompleted = 1 << 1,
    _kCFRegularExpressionMatchingHitEnd = 1 << 2,
    _kCFRegularExpressionMatchingRequiredEnd = 1 << 3,
    _kCFRegularExpressionMatchingInternalError = 1 << 4
}

struct ___CFRegularExpression;
alias _CFRegularExpressionRef = const(___CFRegularExpression)*;

alias _CFRegularExpressionMatch = void function(void* context, CFRange* ranges, CFIndex count, _CFRegularExpressionMatchingFlags flags, Boolean* stop);

CFStringRef _CFRegularExpressionCreateEscapedPattern(CFStringRef pattern);
_CFRegularExpressionRef _CFRegularExpressionCreate(CFAllocatorRef allocator, CFStringRef pattern, _CFRegularExpressionOptions options, CFErrorRef* errorPtr);
void _CFRegularExpressionDestroy(_CFRegularExpressionRef regex);

CFIndex _CFRegularExpressionGetNumberOfCaptureGroups(_CFRegularExpressionRef regex);
CFIndex _CFRegularExpressionGetCaptureGroupNumberWithName(_CFRegularExpressionRef regex, CFStringRef groupName);
void _CFRegularExpressionEnumerateMatchesInString(_CFRegularExpressionRef regexObj, CFStringRef string, _CFRegularExpressionMatchingOptions options, CFRange range, void* context, _CFRegularExpressionMatch match);

CFStringRef _CFRegularExpressionGetPattern(_CFRegularExpressionRef regex);
_CFRegularExpressionOptions _CFRegularExpressionGetOptions(_CFRegularExpressionRef regex);

