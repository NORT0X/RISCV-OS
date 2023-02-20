//
// Created by os on 8/9/22.
//

#ifndef PROJEC_BASE_V1_1_SYSCALL_CPP_HPP
#define PROJEC_BASE_V1_1_SYSCALL_CPP_HPP

#include "../h/syscall_c.hpp"
#include "../lib/hw.h"

class Thread {
private:
    thread_t myHandle;
protected:
    Thread() {}
    virtual void run() {}
private:
    static void threadWrapper(void *arg);
public:
    Thread(void (*body)(void*), void* arg);
    virtual ~Thread() {}

    int start();
    static void dispatch();
    static int sleep(time_t);
};

class Semaphore {
public:
    Semaphore(unsigned init = 1);
    virtual ~Semaphore();

    int wait();
    int signal();
private:
    sem_t myHandle;
};

class Console {
public:
    static char getc();
    static void putc(char);
};

#endif //PROJEC_BASE_V1_1_SYSCALL_CPP_HPP
