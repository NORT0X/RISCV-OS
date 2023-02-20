//
// Created by os on 8/18/22.
//

#ifndef PROJEC_BASE_V1_1_CONSOLEBUFFER_HPP
#define PROJEC_BASE_V1_1_CONSOLEBUFFER_HPP

//#include "./syscall_c.hpp"
#include "./MemoryAllocator.hpp"

class SEM;

class ConsoleBuffer {
private:
    int cap;
    char *buffer;
    int head, tail;

    SEM *spaceAvailable;
    SEM *itemAvailable;
    SEM *mutexHead;
    SEM *mutexTail;

public:
    void *operator new(size_t size){
        return MemoryAllocator::sys_mem_alloc(size);
    }
    void operator delete(void *p){
        MemoryAllocator::sys_mem_free(p);
    }
    static ConsoleBuffer *createConsoleBuffer(int _cap);

    ConsoleBuffer(int _cap);
    ~ConsoleBuffer();

    void put(int val);
    int get();

    int getCnt();

};


#endif //PROJEC_BASE_V1_1_CONSOLEBUFFER_HPP