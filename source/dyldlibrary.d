/++
 + Thanks? to https://github.com/shinh/maloader/
 +/

module dyldlibrary;

import slf4d;

import core.memory;
import core.stdc.string;
import core.sys.darwin.mach.loader;
import core.sys.darwin.mach.nlist;
import core.sys.posix.sys.mman;

import std.algorithm;
import std.experimental.allocator.mmap_allocator;
import std.mmfile;
import path = std.path;
import std.range;
import std.string;

import fake.windows_stubs;
import symbols;

alias cpu_type_t = int;
alias cpu_subtype_t = int;

enum CPU_ARCH_ABI64 = 0x1000000;
enum CPU_TYPE_X86 = 7; // 0x00000111
enum CPU_TYPE_I386 = CPU_TYPE_X86; // For compatibility
enum CPU_TYPE_X86_64 = CPU_TYPE_X86 | CPU_ARCH_ABI64;
enum CPU_TYPE_ARM = 12;
enum CPU_TYPE_ARM64 = CPU_TYPE_ARM | CPU_ARCH_ABI64;
enum CPU_TYPE_POWERPC = 18;
enum CPU_TYPE_POWERPC64 = CPU_TYPE_POWERPC | CPU_ARCH_ABI64;

struct fat_header {
    uint magic;
    uint nfat_arch;
}

struct fat_arch {
    cpu_type_t cputype;
    cpu_subtype_t cpusubtype;
    uint offset;
    uint size;
    uint align_;
}

import std.stdio;

class DyldLibrary {
    package MmFile dylibFile;
    void[] allocation;

    void[][] stubMaps;
    size_t currentMapOffset = 0;
    void[][] segments;

    package string name;

    this(string libraryName) {
        dylibFile = new MmFile(libraryName);

        if (cast(ubyte[]) dylibFile[0..4] == [0xCA, 0xFE, 0xBA, 0xBE]) { // It's a fat executable!
            auto fatHeader = dylibFile.identify!(fat_header)(0);
            size_t currentFatArchLocation = fat_header.sizeof;
            fat_arch currentFatArch = void;
            foreach (fatArchIndex; 0..fatHeader.nfat_arch.bigEndian) {
                currentFatArch = dylibFile.identify!(fat_arch)(currentFatArchLocation);
                currentFatArchLocation += fat_arch.sizeof;

                if (currentFatArch.cputype.bigEndian == CPU_TYPE_X86_64) {
                    parseMachO(dylibFile[currentFatArch.offset.bigEndian..currentFatArch.offset.bigEndian + currentFatArch.size.bigEndian]);
                    return;
                }
            }
        } else {
            parseMachO(dylibFile[0..$]);
            return;
        }
        throw new LoaderException("The file can't be loaded on x86_64.");
    }

    private void parseMachO(void[] macho) {
        auto machHeader = macho.identify!(mach_header_64)(0); // 64-bit only
        assert(machHeader.magic == MH_MAGIC_64);

        size_t currentCommandLocation = mach_header_64.sizeof / ubyte.sizeof;
        load_command currentCommand = void;

        size_t minimum = size_t.max; // minimum should be kept somewhere but anyway it is null in most cases
        size_t maximum = size_t.min;

        foreach (commandIndex; 0..machHeader.ncmds) {
            currentCommand = macho.identify!(load_command)(currentCommandLocation);
            scope(exit) currentCommandLocation += currentCommand.cmdsize / ubyte.sizeof;
            if (currentCommand.cmd == LC_SEGMENT_64) {
                auto lcSegment = macho.identify!(segment_command_64)(currentCommandLocation);

                if (lcSegment.vmaddr < minimum) {
                    minimum = lcSegment.vmaddr;
                }

                auto headerEnd = lcSegment.vmaddr + lcSegment.vmsize;
                if (headerEnd > maximum) {
                    maximum = headerEnd;
                }
            }
        }

        currentCommandLocation = mach_header_64.sizeof / ubyte.sizeof;

        auto alignedMinimum = pageFloor(minimum);
        auto alignedMaximum = pageCeil(maximum);
        auto allocSize = alignedMaximum - alignedMinimum;
        allocation = MmapAllocator.instance.allocate(allocSize);
        getLogger().debugF!"Allocated %x - %x (%x) for %s"(cast(size_t) allocation.ptr, cast(size_t) allocation.ptr + allocSize, allocSize, name);

        size_t headerStart;
        size_t headerEnd;

        size_t fileStart;
        size_t fileEnd;

        section_64[] bindSections;
        char* strtab;
        uint* dynsym;
        uint* symtab;

        foreach (commandIndex; 0..machHeader.ncmds) {
            currentCommand = macho.identify!(load_command)(currentCommandLocation);
            scope(exit) currentCommandLocation += currentCommand.cmdsize / ubyte.sizeof;

            switch (currentCommand.cmd) {
                case LC_SEGMENT_64:
                    auto lcSegment = macho.identify!(segment_command_64)(currentCommandLocation);
                    getLogger().trace("LC_SEGMENT_64");
                    getLogger().debugF!"Segment name: %s"(lcSegment.segname);
                    getLogger().debugF!"Segment span: %x - %x [aligned: %x - %x]"(
                        lcSegment.vmaddr,
                        lcSegment.vmaddr + lcSegment.vmsize,
                        pageFloor(lcSegment.vmaddr),
                        pageCeil(lcSegment.vmaddr + lcSegment.vmsize),
                    );

                    auto segment = macho.identify!(segment_command_64)(currentCommandLocation);
                    headerStart = segment.vmaddr - minimum;
                    headerEnd = segment.vmaddr + segment.filesize - minimum;

                    fileStart = segment.fileoff;
                    fileEnd = segment.fileoff + segment.filesize;

                    allocation[headerStart..headerEnd] = macho[fileStart..fileEnd];
                    segments ~= allocation[headerStart..headerEnd];

                    // Parse sections
                    auto sectionLocation = currentCommandLocation + segment_command_64.sizeof / ubyte.sizeof;
                    foreach (sectionIndex; 0..segment.nsects) {
                        auto section = macho.identify!(section_64)(sectionLocation);
                        scope(exit) sectionLocation += section_64.sizeof / ubyte.sizeof;

                        allocation[section.addr - minimum..section.addr - minimum + section.size] = macho[section.offset..section.offset + section.size];
                        switch (section.flags & SECTION_TYPE) {
                            case S_NON_LAZY_SYMBOL_POINTERS:
                            case S_LAZY_SYMBOL_POINTERS:
                                bindSections ~= section;
                                break;
                            default:
                                break;
                        }
                        // getLogger().trace(section.segname, " | section name: ", section.sectname);
                    }

                    // Protect segment
                    auto protectionResult = mprotect(allocation.ptr + headerStart, headerEnd - headerStart, segment.initprot);
                    if (protectionResult != 0) {
                        throw new LoaderException("Cannot protect the memory correctly.");
                    }
                    getLogger().trace("====");
                    break;
                case LC_ID_DYLIB:
                    auto lcDylib = macho.identify!(dylib_command)(currentCommandLocation);
                    // getLogger().trace("LC_ID_DYLIB");
                    name = path.baseName((cast(immutable char*) &macho[currentCommandLocation + lcDylib.dylib_.name.offset]).fromStringz);
                    // getLogger().trace("====");
                    break;
                case LC_DYLD_INFO:
                case LC_DYLD_INFO_ONLY:
                    auto lcDyldInfo = macho.identify!(dyld_info_command)(currentCommandLocation);
                    getLogger().trace("LC_DYLD_INFO(_ONLY)?");
                    decodeExports(cast(ubyte[]) macho[lcDyldInfo.export_off..lcDyldInfo.export_off + lcDyldInfo.export_size]);
                    rebase(cast(ubyte[]) macho[lcDyldInfo.rebase_off..lcDyldInfo.rebase_off + lcDyldInfo.rebase_size]);
                    bind(cast(ubyte[]) macho[lcDyldInfo.bind_off..lcDyldInfo.bind_off + lcDyldInfo.bind_size]);
                    bind(cast(ubyte[]) macho[lcDyldInfo.weak_bind_off..lcDyldInfo.weak_bind_off + lcDyldInfo.weak_bind_size], false);
                    bind(cast(ubyte[]) macho[lcDyldInfo.lazy_bind_off..lcDyldInfo.lazy_bind_off + lcDyldInfo.lazy_bind_size]);
                    getLogger().trace("====");
                    break;
                case LC_SYMTAB:
                    auto lcSymtab = macho.identify!(symtab_command)(currentCommandLocation);
                    getLogger().trace("LC_SYMTAB");
                    strtab = cast(char*) &macho[lcSymtab.stroff];
                    symtab = cast(uint*) &macho[lcSymtab.symoff];
                    getLogger().trace("====");
                    break;
                case LC_DYSYMTAB:
                    auto lcDysymtab = macho.identify!(dysymtab_command)(currentCommandLocation);
                    getLogger().trace("LC_DYSYMTAB");
                    dynsym = cast(uint*) &macho[lcDysymtab.indirectsymoff];
                    getLogger().trace("====");
                    break;
                case LC_VERSION_MIN_MACOSX:
                    auto lcMinVersion = macho.identify!(version_min_command)(currentCommandLocation);
                    // getLogger().trace("LC_VERSION_MIN_MACOSX");
                    // getLogger().trace("version: ",  lcMinVersion.version_ >> 16 & 0xF, ".", lcMinVersion.version_ >> 8 & 0x8, ".", lcMinVersion.version_ & 0x8);
                    // getLogger().trace("the more you know");
                    // getLogger().trace("====");
                    break;
                case LC_LOAD_DYLIB:
                case LC_LOAD_WEAK_DYLIB:
                    auto lcDylib = macho.identify!(dylib_command)(currentCommandLocation);
                    // getLogger().trace("LC_LOAD_(WEAK_)?DYLIB");
                    auto name = (cast(immutable char*) &macho[currentCommandLocation + lcDylib.dylib_.name.offset]).fromStringz;
                    // getLogger().trace("Want ", name);
                    // getLogger().trace("Cool i don't care");
                    // getLogger().trace("====");
                    break;
                default:
                    // stderr.writefln!("command: %x")(currentCommand.cmd);
                    // getLogger().trace("size: ", currentCommand.cmdsize);
                    // getLogger().trace("====");
                    break;
            }
        }

        foreach (bindSection; bindSections) {
            uint indirectOff = bindSection.reserved1;
            foreach (bindIndex; 0..bindSection.size / size_t.sizeof) {
                uint dysym = dynsym[indirectOff + bindIndex];
                uint index = dysym & 0x3fffffff;
                auto symbol = cast(nlist_64*) (symtab + index * 4);

                auto symbolName = strtab + symbol.n_strx + 1; // Remove the underscore at the beginning.

                bind(
                    cast(ubyte) BIND_TYPE_POINTER,
                    cast(void**) (allocation.ptr + bindSection.addr - minimum + bindIndex * size_t.sizeof),
                    symbolName,
                    0UL,
                    true
                );
                // +/
            }
        }
    }

    void rebase(ubyte[] rebaseTable) {
        getLogger().trace(">>>>>>>>>>>>>>>>>>>>>>>>>>");
        getLogger().trace("Processing rebases...");
        const(ubyte)* p = cast(const(ubyte)*) rebaseTable.ptr;

        ubyte type = 0;
        int segIndex = 0;
        ulong segOffset = 0;

        rebaseLoop: while (p < rebaseTable.ptr + rebaseTable.length) {
            ubyte op = *p & REBASE_OPCODE_MASK;
            ubyte imm = *p & REBASE_IMMEDIATE_MASK;
            p += 1;

            switch (op) {
                case REBASE_OPCODE_DONE:
                    break rebaseLoop;
                case REBASE_OPCODE_SET_TYPE_IMM:
                    type = imm;
                    break;
                case REBASE_OPCODE_SET_SEGMENT_AND_OFFSET_ULEB:
                    segIndex = imm;
                    segOffset = uLEB128(&p);
                    break;
                case REBASE_OPCODE_ADD_ADDR_ULEB:
                    segOffset += uLEB128(&p);
                    break;
                case REBASE_OPCODE_ADD_ADDR_IMM_SCALED:
                    segOffset += imm * size_t.sizeof;
                    break;
                case REBASE_OPCODE_DO_REBASE_IMM_TIMES:
                    for (int i = 0; i < imm; i++) {
                        rebase(type, segIndex, segOffset);
                        segOffset += size_t.sizeof;
                    }
                    break;
                case REBASE_OPCODE_DO_REBASE_ULEB_TIMES:
                    size_t count = uLEB128(&p);
                    for (int i = 0; i < count; i++) {
                        rebase(type, segIndex, segOffset);
                        segOffset += size_t.sizeof;
                    }
                    break;
                case REBASE_OPCODE_DO_REBASE_ADD_ADDR_ULEB:
                    rebase(type, segIndex, segOffset);
                    segOffset += uLEB128(&p) + size_t.sizeof;
                    break;
                case REBASE_OPCODE_DO_REBASE_ULEB_TIMES_SKIPPING_ULEB:
                    size_t count = uLEB128(&p);
                    uint64_t skip = uLEB128(&p);
                    for (int i = 0; i < count; i++) {
                        rebase(type, segIndex, segOffset);
                        segOffset += skip + size_t.sizeof;
                    }
                    break;
                default:
                    throw new LoaderException(format!"Unknown rebase op: %x"(op));
            }
        }
        getLogger().trace("Done!");
        getLogger().trace("<<<<<<<<<<<<<<<<<<<<<<<<<<");
    }

    void rebase(ubyte type, int segIndex, ulong segOffset) {
        if (type == REBASE_TYPE_POINTER) {
            *(cast(size_t*) &segments[segIndex][segOffset]) += cast(size_t) allocation.ptr;
        } else {
            throw new LoaderException(format!"Unknown rebase type: %x"(type));
        }
    }

    void bind(ubyte[] bindTable, bool generateFallback = true) {
        getLogger().trace(">>>>>>>>>>>>>>>>>>>>>>>>>>");
        getLogger().trace("Processing binds...");
        const(ubyte)* p = cast(const(ubyte)*) bindTable.ptr;

        ubyte ordinal = 0;
        char* symbolName;
        ubyte type = BIND_TYPE_POINTER;
        long addend = 0;
        int segIndex = 0;
        ulong segOffset = 0;

        rebaseLoop: while (p < bindTable.ptr + bindTable.length) {
            ubyte op = *p & BIND_OPCODE_MASK;
            ubyte imm = *p & BIND_IMMEDIATE_MASK;
            p += 1;

            switch (op) {
                case BIND_OPCODE_DONE:
                    break rebaseLoop;
                case BIND_OPCODE_SET_DYLIB_ORDINAL_IMM:
                    ordinal = imm;
                    break;
                case BIND_OPCODE_SET_DYLIB_ORDINAL_ULEB:
                    ordinal = cast(ubyte) uLEB128(&p);
                    break;
                case BIND_OPCODE_SET_DYLIB_SPECIAL_IMM:
                    if (imm == 0) {
                        ordinal = 0;
                    } else {
                        ordinal = BIND_OPCODE_MASK | imm;
                    }
                    break;
                case BIND_OPCODE_SET_SYMBOL_TRAILING_FLAGS_IMM:
                    symbolName = cast(char*) p;
                    p += strlen(symbolName) + 1;
                    break;
                case BIND_OPCODE_SET_TYPE_IMM:
                    type = imm;
                    break;
                case BIND_OPCODE_SET_ADDEND_SLEB:
                    addend = sLEB128(&p);
                    break;
                case BIND_OPCODE_SET_SEGMENT_AND_OFFSET_ULEB:
                    segIndex = imm;
                    segOffset = uLEB128(&p);
                    break;
                case BIND_OPCODE_ADD_ADDR_ULEB:
                    segOffset += uLEB128(&p);
                    break;
                case BIND_OPCODE_DO_BIND:
                    bind(type, (cast(void**) &segments[segIndex][segOffset]), symbolName, addend, generateFallback);
                    segOffset += size_t.sizeof;
                    break;
                case BIND_OPCODE_DO_BIND_ADD_ADDR_ULEB:
                    bind(type, (cast(void**) &segments[segIndex][segOffset]), symbolName, addend, generateFallback);
                    segOffset += uLEB128(&p) + size_t.sizeof;
                    break;
                case BIND_OPCODE_DO_BIND_ADD_ADDR_IMM_SCALED:
                    bind(type, (cast(void**) &segments[segIndex][segOffset]), symbolName, addend, generateFallback);
                    segOffset += imm * size_t.sizeof + size_t.sizeof;
                    break;
                case BIND_OPCODE_DO_BIND_ULEB_TIMES_SKIPPING_ULEB:
                    uint64_t count = uLEB128(&p);
                    uint64_t skip = uLEB128(&p);
                    for (uint64_t i = 0; i < count; i++) {
                        bind(type, (cast(void**) &segments[segIndex][segOffset]), symbolName, addend, generateFallback);
                        segOffset += skip + size_t.sizeof;
                    }
                    break;
                default:
                    throw new LoaderException(format!"Unknown bind op: %x"(op));
            }
        }
        getLogger().trace("Done!");
        getLogger().trace("<<<<<<<<<<<<<<<<<<<<<<<<<<");
    }

    void bind(ubyte type, void** location, char* symbolName, long addend, bool generateFallback) {
        if (type == BIND_TYPE_POINTER) {
            auto replacement = symbolReplacement(cast(string) symbolName.fromStringz());
            if (replacement.isNull() && generateFallback) {
                *location = buildStub(symbolName);
            } else {
                *location = replacement.get(null);
            }
        } else {
            throw new LoaderException(format!"Unknown bind type: %x"(type));
        }
    }

    void decodeExports(ubyte[] exportTable) {
        getLogger().trace(">>>>>>>>>>>>>>>>>>>>>>>>>>");
        getLogger().trace("Processing exports...");

        void parse(const(ubyte)* offset, string prefix) {
            if (ubyte term_size = *offset++) {
                uLEB128(&offset);
                uLEB128(&offset);
            }

            ubyte childrenCount = *offset++;
            foreach (index; 0..childrenCount) {
                size_t prefixSize = prefix.length;
                while (*offset) {
                    prefix ~= cast(immutable char) *offset++;
                }
                offset++;

                uint64_t off = uLEB128(&offset);
                parse(&exportTable[off], prefix);

                prefix.length = prefixSize;
            }
        }

        parse(exportTable.ptr, "");
        getLogger().trace("Done!");
        getLogger().trace("<<<<<<<<<<<<<<<<<<<<<<<<<<");
    }

    private void* buildStub(char* name) {
        ubyte[] code = buildStubCode(name);
        if (stubMaps.length == 0 || currentMapOffset + code.length > stubMaps[$ - 1].length) {
            stubMaps ~= MmapAllocator.instance.allocate(pageSize);
            currentMapOffset = 0;
        }

        void[] currentStubMap = stubMaps[$ - 1];

        mprotect(currentStubMap.ptr, currentStubMap.length, PROT_READ | PROT_WRITE);
        currentStubMap[currentMapOffset..currentMapOffset + code.length] = code;
        mprotect(currentStubMap.ptr, currentStubMap.length, PROT_READ | PROT_EXEC);

        void* address = &currentStubMap[currentMapOffset];
        currentMapOffset += code.length;
        return address;
    }

    private ubyte[] buildStubCode(char* name) {
        // generates x86_64 assembler code for `undefinedSymbol(name)`
        // it's never going to return back so we don't care about not saving registers.
        return [
            ub!0x48, ub!0xBF, ] ~ name.ubytes() ~ [ // mov name %rdi
            ub!0x48, ub!0xB8, ] ~ (&undefinedSymbol).ubytes() ~ [ // mov &undefinedSymbol %rax
            ub!0xFF, ub!0xE0 // jmp *%rax
        ];
    }

    ~this() {
        foreach (stubMap; stubMaps) {
            MmapAllocator.instance.deallocate(stubMap);
        }

        if (allocation) {
            MmapAllocator.instance.deallocate(allocation);
        }
    }
}

pragma(inline, true) size_t pageMask() pure {
    return ~(pageSize - 1);
}

T bigEndian(T)(T val) pure {
    version (LittleEndian) {
        ubyte[4] valBytes = (cast(ubyte*) &val)[0..T.sizeof];
        ubyte[4] valInverted;
        foreach (idx, ref b; valInverted) {
            b = valBytes[$ - idx - 1];
        }
        return *cast(T*) &valInverted;
    } else {
        return val;
    }
}

size_t pageFloor(size_t number) pure {
    return number & pageMask;
}

size_t pageCeil(size_t number) pure {
    return (number + pageSize - 1) & pageMask;
}

RetType[] identifyArray(RetType, FromType)(FromType obj, size_t offset, size_t length) {
    return (cast(RetType[]) obj[offset..offset + (RetType.sizeof * length)]).ptr[0..length];
}

RetType identify(RetType, FromType)(FromType obj, size_t offset) {
    return obj[offset..offset + RetType.sizeof].reinterpret!(RetType);
}

RetType reinterpret(RetType, FromType)(FromType[] obj) {
    return (cast(RetType[]) obj)[0];
}

ubyte[T.sizeof] ubytes(T)(T val) {
    return *cast(ubyte[T.sizeof]*) &val;
}

class LoaderException: Exception {
    this(string message, string file = __FILE__, size_t line = __LINE__) {
        super("Cannot load library: " ~ message, file, line);
    }
}

template ub(ubyte a) {
    enum ub = a;
}


// From druntime
import core.stdc.stdint;

alias uintptr_t _uleb128_t;
alias intptr_t _sleb128_t;

_uleb128_t uLEB128(const(ubyte)** p)
{
    auto q = *p;
    _uleb128_t result = 0;
    uint shift = 0;
    while (1)
    {
        ubyte b = *q++;
        result |= cast(_uleb128_t)(b & 0x7F) << shift;
        if ((b & 0x80) == 0)
            break;
        shift += 7;
    }
    *p = q;
    return result;
}

_sleb128_t sLEB128(const(ubyte)** p)
{
    auto q = *p;
    ubyte b;

    _sleb128_t result = 0;
    uint shift = 0;
    while (1)
    {
        b = *q++;
        result |= cast(_sleb128_t)(b & 0x7F) << shift;
        shift += 7;
        if ((b & 0x80) == 0)
            break;
    }
    if (shift < result.sizeof * 8 && (b & 0x40))
        result |= -(cast(_sleb128_t)1 << shift);
    *p = q;
    return result;
}
