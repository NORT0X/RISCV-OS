//
// Created by os on 8/10/22.
//

#ifndef PROJEC_BASE_V1_1_SCHEDULER_HPP
#define PROJEC_BASE_V1_1_SCHEDULER_HPP

#include "list.hpp"
#include "slab.hpp"

class PCB;
class PCB_List;

class Scheduler {
private:
    static PCB_List *readyThreadQueue;
public:
    static void createScheduler(kmem_cache_t *cache);

    static PCB *get();
    static int put(PCB *pcb);
};

#endif //PROJEC_BASE_V1_1_SCHEDULER_HPP
