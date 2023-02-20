//
// Created by os on 8/18/22.
//

#ifndef PROJEC_BASE_V1_1_SLEEPQ_HPP
#define PROJEC_BASE_V1_1_SLEEPQ_HPP

#include "./syscall_c.hpp"
#include "./MemoryAllocator.hpp"
#include "./slab.hpp"

class SleepQ{
public:
    struct ElemQ{
        void *operator new(size_t size){
            return MemoryAllocator::sys_mem_alloc(size);
        }
        void operator delete(void *p){
            MemoryAllocator::sys_mem_free(p);
        }
        static void setCache(kmem_cache_t *c){ ElemQ::cache = c; }

        PCB* pcb;
        time_t rang;
        ElemQ *next;

        static kmem_cache_t *cache;
        ElemQ(PCB* p, time_t r, ElemQ* n = nullptr): pcb(p), rang(r), next(n) {}

        static ElemQ *createElemQ(PCB *p, time_t r, ElemQ* n = nullptr){
            ElemQ *ret = (ElemQ *) kmem_cache_alloc(ElemQ::cache);
            ret->pcb = p;
            ret->rang = r;
            ret->next = n;
            return ret;
        }

        static void freeObject(ElemQ *obj){
            kmem_cache_free(ElemQ::cache, (void *)obj);
        }
    };


    static void put(PCB *pcb, time_t time);
    static PCB *get();
private:
    friend class PCB;
    static ElemQ *head;
    static ElemQ *last;

    SleepQ() = default;

    static void update();

};

#endif //PROJEC_BASE_V1_1_SLEEPQ_HPP
