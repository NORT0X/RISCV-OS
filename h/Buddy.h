//
// Created by os on 1/3/23.
//

#ifndef PROJECT_BASE_BUDDY_H
#define PROJECT_BASE_BUDDY_H
#include "../lib/hw.h"

class Buddy {
private:
    static void *START, *END;
    static uint64 highestN;
    static uint64 minN;

    struct buddy_free_block{
        buddy_free_block *next;
        uint64 position;
    };

    struct buddy_free_levels{
        //buddy_free_block *block;
        buddy_free_block *first;
        uint64 level;
        buddy_free_levels *next, *prev;
    };

    struct buddy_allocated_blocks{
        int size;
        void* address;
    };

    static void clearMemory(void *, size_t);

    static buddy_free_levels *head;
    static buddy_allocated_blocks* allocatedHead;
    //structure help functions
    static void free_block_init(buddy_free_block *, buddy_free_levels *, uint64);

    static void free_levels_init();

    static buddy_free_block* findBlockAt(buddy_free_levels *, uint64);
    static void deleteBlock(buddy_free_levels *, uint64);

    static uint64 init_highestN();
    static int check_size_validation(uint64);
    static uint64 calculate_real_size(size_t);
    static uint64 calculate_exponent(uint64);
public:
    static int buddy_init(void*, void*);

    static void* buddy_allocate(size_t);

    static void buddy_free(void *);

};

#endif //PROJECT_BASE_BUDDY_H
