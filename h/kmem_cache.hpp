//
// Created by os on 1/29/23.
//

#ifndef PROJECT_BASE_KMEM_CACHE_HPP
#define PROJECT_BASE_KMEM_CACHE_HPP

#include "../lib/hw.h"
#include "Buddy.h"
#include "slab.hpp"
#include "KernelPrint.hpp"

class kmem_cache{
private:
    char *name;
    size_t sizeOfObject;
    void (*ctor)(void *);
    void (*dtor)(void *);

    struct slab{
        void *address;
        uint64 counter;
        uint64 limit;
        size_t sizeInBlocks;
        uint8 *allocateArray; //value = 1 if allocated - value = 0 if not allocated

        struct slab *next;
    };

    int error_indicator;

    slab *empty_slabs;
    slab *not_empty_slabs;
    slab *full_slabs;

    uint64 number_of_slabs;
    int num_of_alloc_objects;

    void add_slab(slab **head, slab* slab);
    int delete_slab(slab **head, slab* slab);
    int cache_alloc_buffer(size_t size);
    void deallocInSlab(slab *p_slab, void *objp);

    int sizeOfCache();
public:
    void cache_create(char *n, size_t s, void (*ct)(void *), void (*dt)(void *));
    void destructor();

    int shrink();

    void *alloc_object();
    void free_object(void *objp);

    void printInfo();
    int printError();
};
#endif //PROJECT_BASE_KMEM_CACHE_HPP