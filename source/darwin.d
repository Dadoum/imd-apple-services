module darwin;

alias blkcnt_t = long;
alias blksize_t = int;
alias dev_t = int;
alias gid_t = uint;
alias ino_t = ulong;
alias mode_t = ushort;
alias nlink_t = ushort;
alias off_t = long;
alias pid_t = int;
//size_t (defined in core.stdc.stddef)
alias ssize_t = long;
alias time_t = long;
alias uid_t = uint;

struct darwin_stat
{
    dev_t       st_dev;
    mode_t      st_mode;
    nlink_t     st_nlink;
    ino_t       st_ino;
    uid_t       st_uid;
    gid_t       st_gid;
    dev_t       st_rdev;
    time_t      st_atime;
    long        st_atimensec;
    time_t      st_mtime;
    long        st_mtimensec;
    time_t      st_ctime;
    long        st_ctimensec;
    time_t      st_birthtime;
    long        st_birthtimensec;
    off_t       st_size;
    blkcnt_t    st_blocks;
    blksize_t   st_blksize;
    uint        st_flags;
    uint        st_gen;
    int         st_lspare;
    long[2]     st_qspare;
}

extern(C) void __memset_chk();
extern(C) int statfs(const char *path, void* buf);

extern(C) int darwin_statfs(const char *path, darwin_stat* buf) {
    import core.sys.posix.sys.stat;
    stat_t statStruct;
    auto ret = statfs(path, &statStruct);
    *buf = darwin_stat(
        cast(uint) statStruct.st_dev,
        cast(ushort) statStruct.st_mode,
        cast(ushort) statStruct.st_nlink,
        cast(int) statStruct.st_ino,
        cast(int) statStruct.st_uid,
        cast(int) statStruct.st_gid,
        cast(int) statStruct.st_rdev,
        cast(int) statStruct.st_atime,
        cast(int) statStruct.st_atimensec,
        cast(int) statStruct.st_mtime,
        cast(int) statStruct.st_mtimensec,
        cast(int) statStruct.st_ctime,
        cast(int) statStruct.st_ctimensec,
        0, // statStruct.st_birthtime,
        0, // statStruct.st_birthtimensec,
        statStruct.st_size,
        statStruct.st_blocks,
        cast(int) statStruct.st_blksize,
        0, // statStruct.st_flags,
        0, // statStruct.st_gen,
        0, // statStruct.st_lspare,
        0, // statStruct.st_qspare
    );
    return ret;
}