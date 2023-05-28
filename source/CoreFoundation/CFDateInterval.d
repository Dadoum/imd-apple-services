module CoreFoundation.CFDateInterval;

public import CoreFoundation.CFBase;
public import CoreFoundation.CFDate;

extern (C):

struct __CFDateInterval;
alias CFDateIntervalRef = __CFDateInterval*;

CFDateIntervalRef CFDateIntervalCreate(CFAllocatorRef allocator, CFDateRef startDate, CFTimeInterval duration);

CFDateIntervalRef CFDateIntervalCreateWithEndDate(CFAllocatorRef allocator, CFDateRef startDate, CFDateRef endDate);

CFTimeInterval CFDateIntervalGetDuration(CFDateIntervalRef interval);

CFDateRef CFDateIntervalCopyStartDate(CFDateIntervalRef interval);

CFDateRef CFDateIntervalCopyEndDate(CFDateIntervalRef interval);

CFComparisonResult CFDateIntervalCompare(CFDateIntervalRef interval1, CFDateIntervalRef interval2);

Boolean CFDateIntervalIntersectsDateInterval(CFDateIntervalRef interval, CFDateIntervalRef intervalToIntersect);

CFDateIntervalRef CFDateIntervalCreateIntersectionWithDateInterval(CFAllocatorRef allocator, CFDateIntervalRef interval, CFDateIntervalRef intervalToIntersect);

Boolean CFDateIntervalContainsDate(CFDateIntervalRef interval, CFDateRef date);

