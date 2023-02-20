//
// Created by os on 8/15/22.
//

#ifndef PROJEC_BASE_V1_1_SEM_HPP
#define PROJEC_BASE_V1_1_SEM_HPP

#include "../lib/hw.h"
#include "./PCB.hpp"
#include "./Queue.hpp"

class SEM{
public:
    static void setCache(kmem_cache_t *c) { SEM::cache = c; }

    static SEM* createSEM(int val);
    static void freeObject(SEM *s);
    static void dtor(SEM *s);

    int wait();

    int signal();

    int close();
    //void signalAll();

    int value() const { return val; }
private:
    SEM() {}

    int val;

    static kmem_cache_t *cache;
    Queue *q;


    friend class PCB;
};


#endif //PROJEC_BASE_V1_1_SEM_HPP