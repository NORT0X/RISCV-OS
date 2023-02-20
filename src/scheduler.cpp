#include "../h/scheduler.hpp"
#include "../h/PCB_List.hpp"

PCB_List *Scheduler::readyThreadQueue;

PCB *Scheduler::get(){
    return readyThreadQueue->removeFirst();
}

int Scheduler::put(PCB *pcb) {
    return readyThreadQueue->addLast(pcb);
}

void Scheduler::createScheduler(kmem_cache_t *cache) {
    readyThreadQueue = (PCB_List *)kmem_cache_alloc(cache);
}
