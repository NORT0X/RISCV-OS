//
// Created by os on 8/9/22.
//

#ifndef PROJEC_BASE_V1_1_MEMORYALLOCATOR_HPP
#define PROJEC_BASE_V1_1_MEMORYALLOCATOR_HPP

#include "../lib/hw.h"

enum AllocatorStatus {FREE, ALLOCATED};

class MemoryAllocator{
private:
    MemoryAllocator() {}
    struct Allocator{
        uint64 start_addr;
        size_t size;
        struct Allocator *next;
    };
    static struct Allocator *alloc_head;
    static const void *MEM_START;
    static const void *MEM_END;

    static void emptySpace(uint64 startAddr, uint64 size);
public:
    static void* sys_mem_alloc(size_t);
    static void* sys_mem_free(void *);
    static void mem_init(void* START, void* END);
};

#endif //PROJEC_BASE_V1_1_MEMORYALLOCATOR_HPP
