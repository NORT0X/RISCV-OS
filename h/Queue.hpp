//
// Created by os on 8/15/22.
//

#ifndef PROJEC_BASE_V1_1_QUEUE_HPP
#define PROJEC_BASE_V1_1_QUEUE_HPP

#include "./list.hpp"
#include "./PCB.hpp"

class PCB_List;

class Queue{
public:
    static void setCache(kmem_cache_t *c) { Queue::cache = c; }

    static Queue *createQueue();
    static void freeObject(Queue *q);
    static void dtor(Queue *q);

    int put(PCB* pcb);
    PCB* get();
private:
    friend class PCB;

    static kmem_cache_t *cache;

    int size;
    PCB_List *queue;
};

#endif //PROJEC_BASE_V1_1_QUEUE_HPP