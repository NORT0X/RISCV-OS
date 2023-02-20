//
// Created by os on 8/10/22.
//

#ifndef PROJEC_BASE_V1_1_PCB_HPP
#define PROJEC_BASE_V1_1_PCB_HPP

#include "../lib/hw.h"
#include "../h/scheduler.hpp"
#include "./SleepQ.hpp"
#include "./MemoryAllocator.hpp"
#include "./riscv.hpp"
#include "./slab.hpp"

enum ThreadStatus {READY, BLOCKED};

class PCB{
public:
    static void setCache(kmem_cache_t *c) { PCB::cache = c; }

    ~PCB() { delete[] stack; }
    static void dtor(PCB *pcb);

    static uint64 get_thread_counter() {return PCB::thread_counter;}

    bool isFinished() const { return finished; }

    void setFinished(bool value) {if(value){ thread_counter--; } finished = value;}

    uint64 getTimeSlice() const { return timeSlice; }

    using Body = void (*)(void*);

    uint64 getBody() const { return (uint64)body; }

    static PCB *createThread(Body body, void *args);

    static int addToSleepQ(time_t time);

    static void wakingUp();

    static void exitThread();

    static PCB *running;
    static PCB *main_t;
    static PCB *console_t;
    static PCB *user_main_t;
    //static PCB *console_writer_t;

private:
    struct Context{
        uint64 ra;
        uint64 sp;
    };

    static kmem_cache_t *cache;

    enum ThreadStatus status;

    Body body;
    void *args;
    uint64 *stack;
    Context context;
    uint64 timeSlice;
    bool finished;

    friend class Riscv;
    friend class SEM;
    friend class ksyscall;

    static void threadWrapper();

    static void contextSwitch(Context *oldContext, Context *runningConetxt);

    static void dispatch();

    static uint64 thread_counter;

    static uint64 timeSliceCounter;

    static uint64 constexpr STACK_SIZE = DEFAULT_STACK_SIZE;
    static uint64 constexpr TIME_SLICE = DEFAULT_TIME_SLICE;
};

#endif //PROJEC_BASE_V1_1_PCB_HPP
