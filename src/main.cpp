#include "../lib/hw.h"
#include "../h/syscall_c.hpp"
#include "../h/PCB.hpp"
#include "../h/userMain.hpp"
#include "../h/SEM.hpp"
#include "../h/PCB_List.hpp"

int main(){

    int blockNum = (int)(((uint64)HEAP_END_ADDR - (uint64)HEAP_START_ADDR) / (BLOCK_SIZE * 8));
    kmem_init((void *)HEAP_START_ADDR, blockNum);
    MemoryAllocator::mem_init((void *)((uint64)HEAP_START_ADDR + (uint64)blockNum * BLOCK_SIZE), (void *)HEAP_END_ADDR);

    //Creating kmem_caches for different objects
    kmem_cache_t *PCB_k = kmem_cache_create("PCB", sizeof(PCB), nullptr, (void (*)(void *))(PCB::dtor));
    PCB::setCache(PCB_k);

    kmem_cache_t *SEM_k = kmem_cache_create("SEM", sizeof(SEM), nullptr, (void (*)(void *))(SEM::dtor));
    SEM::setCache(SEM_k);


    kmem_cache_t *QUEUE_k = kmem_cache_create("QUEUE", sizeof(Queue), nullptr, (void (*)(void *))(Queue::dtor));
    Queue::setCache(QUEUE_k);


    kmem_cache_t *PCB_List_k = kmem_cache_create("PCB_List", sizeof(PCB_List), nullptr, (void (*)(void *))(PCB_List::dtor));
    PCB_List::setCache(PCB_List_k);

    kmem_cache_t *PCB_List_Elem_k = kmem_cache_create("PCB_List_Elem", sizeof(PCB_List::Elem), nullptr, nullptr);
    PCB_List::Elem::setCache(PCB_List_Elem_k);

    kmem_cache_t *SLEEP_Q_k = kmem_cache_create("SleepQ", sizeof(SleepQ::ElemQ), nullptr, nullptr);
    SleepQ::ElemQ::setCache(SLEEP_Q_k);

    //init scheduler
    kmem_cache_t *SCHEDULER_k = kmem_cache_create("SCHEDULER", sizeof(PCB_List), nullptr, (void (*)(void *))(PCB_List::dtor));
    Scheduler::createScheduler(SCHEDULER_k);

    //init threads
    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);

    thread_t main;
    //thread_t getDataFromConsole_t;
    thread_t sendDataToConsole_t;
    thread_t userMain_t;
    main = PCB::createThread(nullptr, nullptr);
    PCB::running = main;
    PCB::main_t = main;
    userMain_t = PCB::createThread((void(*)(void*))(userMain), nullptr);
    PCB::user_main_t = userMain_t;
    sendDataToConsole_t = PCB::createThread((void (*)(void *))ConsoleHandler::sendDataToConsole, nullptr);
    PCB::console_t = sendDataToConsole_t;
    //getDataFromConsole_t = PCB::createThread((void (*)(void *))ConsoleHandler::getDataFromConsole, nullptr);
    //PCB::console_writer_t = getDataFromConsole_t;

    Riscv::ms_sstatus(Riscv::SSTATUS_SIE);

    uint64 cont = PCB::get_thread_counter();
    while(!(userMain_t->isFinished()) || cont > 2){
        cont = PCB::get_thread_counter();
        thread_dispatch();
    }
    return 0;
}