//
// Created by os on 2/4/23.
//

#ifndef PROJECT_BASE_PCB_LIST_HPP
#define PROJECT_BASE_PCB_LIST_HPP

#include "MemoryAllocator.hpp"
#include "slab.hpp"

class PCB;

class PCB_List
{
public:
    struct Elem
    {
        static void setCache(kmem_cache_t *c){ Elem::elemCache = c; }

        PCB *data;
        Elem *next;

        static kmem_cache_t *elemCache;

        static Elem* createElem(PCB* data, Elem *next){
            Elem* ret = (Elem *)kmem_cache_alloc(Elem::elemCache);
            if(ret == nullptr) return nullptr;
            ret->data = data;
            ret->next = next;
            return ret;
        }

        static void freeObject(Elem *obj) {
            kmem_cache_free(elemCache, (void *) obj);
        }
    };

    static void setCache(kmem_cache_t *c) { PCB_List::cache = c; }

    static PCB_List *createPCB_List();
    static void freeObject(PCB_List *l);
    static void dtor(PCB_List *l);

    void addFirst(PCB *data);

    int addLast(PCB *data);

    PCB *removeFirst();

    PCB *peekFirst();
private:
    Elem *head, *tail;

    static kmem_cache_t *cache;
};

#endif //PROJEC_BASE_V1_1_LIST_HPP
