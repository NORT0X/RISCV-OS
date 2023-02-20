#include "../h/ksyscall.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../h/PCB.hpp"
#include "../h/SEM.hpp"

uint64 ksyscall::fp = 0;

void ksyscall::hanldeSyscall(unsigned short number){
    switch(number) {
        case MEM_ALLOC: // mem_alloc
            ksyscall::mem_alloc();
            break;
        case MEM_FREE: // mem_free
            ksyscall::mem_free();
            break;
        case THREAD_CREATE: // thread_create
            ksyscall::thread_create();
            break;
        case THREAD_EXIT:
            ksyscall::thread_exit();
            break;
        case THREAD_DISPATCH:
            ksyscall::thread_dispatch();
            break;
        case SEM_OPEN:
            ksyscall::sem_open();
            break;
        case SEM_CLOSE:
            ksyscall::sem_close();
            break;
        case SEM_WAIT:
            ksyscall::sem_wait();
            break;
        case SEM_SIGNAL:
            ksyscall::sem_signal();
            break;
        case TIME_SLEEP:
            ksyscall::thread_sleep();
            break;
        case GETC:
            ksyscall::getc();
            break;
        case PUTC:
            ksyscall::putc();
            break;
    }
}

void ksyscall::mem_alloc() {
    size_t size_a;
    __asm__ volatile("mv %[size], a1" : [size] "=r"(size_a));
    uint64 res = (uint64) MemoryAllocator::sys_mem_alloc(size_a);
    __asm__ volatile("mv a0, %[res]" : : [res] "r" (res));
    __asm__ volatile("sd a0, 10*8(%[fp])" : : [fp] "r" (ksyscall::fp));
}

void ksyscall::mem_free() {
    void *addr;
    __asm__ volatile("mv %[addr], a1" : [addr] "=r"(addr));
    uint64 res = (uint64) MemoryAllocator::sys_mem_free(addr);
    __asm__ volatile("mv a0, %[res]" : : [res] "r" (res));
    __asm__ volatile("sd a0, 10*8(%[fp])" : : [fp] "r" (ksyscall::fp));
}

void ksyscall::thread_create() {
    PCB* new_handle;
    void (*start_r)(void *);
    void *arg;
    __asm__ volatile("mv %[start_r], a1" : [start_r] "=r"(start_r));
    __asm__ volatile("mv %[arg], a2" : [arg] "=r"(arg));
    new_handle = PCB::createThread(start_r, arg);
    __asm__ volatile("mv a0, %[res]" : : [res] "r" (new_handle));
    __asm__ volatile("sd a0, 13*8(%[fp])" : : [fp] "r" (ksyscall::fp));
}

void ksyscall::thread_exit() {
    PCB::exitThread();
}

void ksyscall::thread_dispatch() {
    PCB::timeSliceCounter = 0;
    PCB::dispatch();
}

void ksyscall::sem_open() {
    SEM* new_handle;
    int init;
    __asm__ volatile("mv %[init], a1" : [init] "=r" (init));
    new_handle = SEM::createSEM(init);
    __asm__ volatile("mv a0, %[res]" : : [res] "r" (new_handle));
    __asm__ volatile("sd a0, 13*8(%[fp])" : : [fp] "r" (ksyscall::fp));
}

void ksyscall::sem_close() {
    SEM* id;
    __asm__ volatile("mv %[id], a1" : [id] "=r" (id));
    int res = id->close();
    SEM::freeObject(id);
    __asm__ volatile("mv a0, %[res]" : : [res] "r" (res));
    __asm__ volatile("sd a0, 10*8(%[fp])" : : [fp] "r" (ksyscall::fp));
}

void ksyscall::sem_wait() {
    SEM* id;
    __asm__ volatile("mv %[id], a1" : [id] "=r" (id));
    int res = id->wait();
    __asm__ volatile("mv a0, %[res]" : : [res] "r" (res));
    __asm__ volatile("sd a0, 10*8(%[fp])" : : [fp] "r" (ksyscall::fp));
}

void ksyscall::sem_signal() {
    SEM* id;
    __asm__ volatile("mv %[id], a1" : [id] "=r" (id));
    int res = id->signal();
    __asm__ volatile("mv a0, %[res]" : : [res] "r" (res));
    __asm__ volatile("sd a0, 10*8(%[fp])" : : [fp] "r" (ksyscall::fp));
}

void ksyscall::thread_sleep() {
    time_t time;
    __asm__ volatile("mv %[time], a1" : [time] "=r" (time));
    PCB::addToSleepQ(time);
}

void ksyscall::getc() {
    char res = ConsoleHandler::getInstance()->sys_getc();
    __asm__ volatile("mv a0, %[res]" : : [res] "r" (res));
    __asm__ volatile("sd a0, 10*8(%[fp])" : : [fp] "r" (ksyscall::fp));
}

void ksyscall::putc() {
    char data;
    __asm__ volatile("mv %[data], a1" : [data] "=r"(data));
    ConsoleHandler::getInstance()->sys_putc(data);
}
