#ifndef PROJECT_BASE_KSYSCALL_HPP
#define PROJECT_BASE_KSYSCALL_HPP

#include "../lib/hw.h"

class PCB;
class SEM;

class ksyscall{
public:
    enum ECALL{
        MEM_ALLOC = 1,
        MEM_FREE = 2,
        THREAD_CREATE = 11,
        THREAD_EXIT = 12,
        THREAD_DISPATCH = 13,
        SEM_OPEN = 21,
        SEM_CLOSE = 22,
        SEM_WAIT = 23,
        SEM_SIGNAL = 24,
        TIME_SLEEP = 31,
        GETC = 41,
        PUTC = 42,
    };

    static void hanldeSyscall(unsigned short number);
private:
    friend class Riscv;

    static uint64 fp;

    static void mem_alloc();
    static void mem_free();

    static void thread_create();
    static void thread_exit();
    static void thread_dispatch();

    static void sem_open();
    static void sem_close();
    static void sem_wait();
    static void sem_signal();

    static void thread_sleep();

    static void getc();
    static void putc();
};

#endif //PROJECT_BASE_KSYSCALL_HPP
