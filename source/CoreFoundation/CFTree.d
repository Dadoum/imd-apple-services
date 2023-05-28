module CoreFoundation.CFTree;

public import CoreFoundation.CFBase;

extern (C):

alias CFTreeRetainCallBack = const(void)* function(const(void)* info);

alias CFTreeReleaseCallBack = void function(const(void)* info);

alias CFTreeCopyDescriptionCallBack = const(__CFString)* function(const(void)* info);

struct CFTreeContext
{
    CFIndex version_;
    void* info;
    CFTreeRetainCallBack retain;
    CFTreeReleaseCallBack release;
    CFTreeCopyDescriptionCallBack copyDescription;
}

alias CFTreeApplierFunction = void function(const(void)* value, void* context);

struct __CFTree;
alias CFTreeRef = __CFTree*;

CFTypeID CFTreeGetTypeID();

CFTreeRef CFTreeCreate(CFAllocatorRef allocator, const(CFTreeContext)* context);

CFTreeRef CFTreeGetParent(CFTreeRef tree);

CFTreeRef CFTreeGetNextSibling(CFTreeRef tree);

CFTreeRef CFTreeGetFirstChild(CFTreeRef tree);

void CFTreeGetContext(CFTreeRef tree, CFTreeContext* context);

CFIndex CFTreeGetChildCount(CFTreeRef tree);

CFTreeRef CFTreeGetChildAtIndex(CFTreeRef tree, CFIndex idx);

void CFTreeGetChildren(CFTreeRef tree, CFTreeRef* children);

void CFTreeApplyFunctionToChildren(
    CFTreeRef tree,
    CFTreeApplierFunction applier,
    void* context);

CFTreeRef CFTreeFindRoot(CFTreeRef tree);

void CFTreeSetContext(CFTreeRef tree, const(CFTreeContext)* context);

void CFTreePrependChild(CFTreeRef tree, CFTreeRef newChild);

void CFTreeAppendChild(CFTreeRef tree, CFTreeRef newChild);

void CFTreeInsertSibling(CFTreeRef tree, CFTreeRef newSibling);

void CFTreeRemove(CFTreeRef tree);

void CFTreeRemoveAllChildren(CFTreeRef tree);

void CFTreeSortChildren(
    CFTreeRef tree,
    CFComparatorFunction comparator,
    void* context);

