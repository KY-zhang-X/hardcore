#ifndef __USER_LIBS_PROC_H__
#define __USER_LIBS_PROC_H__

#include <defs.h>

#define PROC_NAME_LEN 50

// process's state in his life cycle
enum proc_state
{
    PROC_UNINIT = 0, // uninitialized
    PROC_SLEEPING,   // sleeping
    PROC_RUNNABLE,   // runnable(maybe running)
    PROC_ZOMBIE,     // almost dead, and wait parent proc to reclaim his resource
};

typedef int bool;
typedef unsigned int uint32_t;

// used by system call
struct proc_struct_user
{
    enum proc_state state;        // Process state
    int pid;                      // Process ID
    int runs;                     // the running times of Proces
    volatile bool need_resched;   // bool value: need to be rescheduled to release CPU?
    int parent;                   // the parent process
    uint32_t flags;               // Process flag
    char name[PROC_NAME_LEN + 1]; // Process name
    uint32_t wait_state;          // waiting state
    int cpr, ypr, optr;           // relations between processes
    int time_slice;               // time slice for occupying the CPU
    uint32_t vruntime;            // cfs scheduler : virtual run time
    uint32_t cfs_prior;           // cfs scheduler : the prior of this process (less have more prior), the mininum vruntime procee will be schedule
    int is_thread;                // 标志该进程是否是一个子线程
    int total_page;               // 总页数
    int free_page;                // 未被使用的页面数量
};

int get_pdb(void *base);
int nice(int pid, int prior);

#endif /* !__USER_LIBS_PROC_H__ */