#include "../h/MemoryAllocator.hpp"

struct MemoryAllocator::Allocator *MemoryAllocator::alloc_head = nullptr;

const void* MemoryAllocator::MEM_START = (void *)HEAP_START_ADDR;
const void* MemoryAllocator::MEM_END = (void *)HEAP_END_ADDR;


void MemoryAllocator::mem_init(void* START, void* END){
    MEM_START = START;
    MEM_END = END;
}

void MemoryAllocator::emptySpace(uint64 startAddr, uint64 size) {
    uint64 addr = startAddr;
    while(addr < startAddr + size){
        uint8 *memory = (uint8 *)addr;
        *memory = 0;
        addr++;
    }
}

void* MemoryAllocator::sys_mem_alloc(size_t size){
    size_t realSize = ((size + sizeof(struct Allocator)) / MEM_BLOCK_SIZE) * MEM_BLOCK_SIZE + MEM_BLOCK_SIZE;
    uint64 addr = (uint64)MEM_START;
    uint64 res = 0;
    struct Allocator *new_m;
    struct Allocator *head= alloc_head;
    //IF THERE IS NO ALLOCATED MEMORY ON HEAP
    if(head == nullptr){
        if(realSize < (uint64)MEM_END - (uint64)MEM_START){
            new_m = (struct Allocator *) addr;
            new_m->size = realSize;
            new_m->next = nullptr;
            new_m->start_addr = addr;
            alloc_head = new_m;

            res = new_m->start_addr + sizeof(struct Allocator) + 1;
        }else{
            res = -1;
        }
        return (void *)res;
    }

    //CHECK IF THERE IS FREE SPACE ON START OF HEAP
    if(realSize < alloc_head->start_addr - (uint64)MEM_START){
        new_m = (struct Allocator *) addr;
        new_m->size = realSize;
        new_m->start_addr = addr;
        new_m->next = alloc_head;
        alloc_head = new_m;

        res = new_m->start_addr + sizeof(struct Allocator);
        return (void *)res;
    }

    //FIND FIRST FREE SPACE
    struct Allocator *prev = alloc_head;
    struct Allocator *tmp = alloc_head->next;
    while(tmp != nullptr){
        if(realSize < tmp->start_addr - 1 - (prev->start_addr + prev->size)){
            addr = prev->start_addr + prev->size + 1;
            new_m = (struct Allocator *)addr;
            new_m->start_addr = addr;
            new_m->size = realSize;

            new_m->next = tmp;
            prev->next = new_m;

            res = new_m->start_addr + sizeof(struct Allocator) + 1;
            return (void *)res;
        }
        prev = tmp;
        tmp = tmp->next;
    }

    //CHECK IF THERE IS FREE SPACE AT THE END
    tmp = prev;
    if(realSize < (uint64)MEM_END - (tmp->start_addr + tmp->size + 1)){
        addr = tmp->start_addr + tmp->size + 1;
        new_m = (struct Allocator *) addr;
        new_m->start_addr = addr;
        new_m->size = realSize;

        new_m->next = nullptr;
        tmp->next = new_m;

        res = addr + sizeof(struct Allocator) + 1;
        return (void *)res;
    }

    return nullptr;
}

void* MemoryAllocator::sys_mem_free(void *addr){
    struct Allocator *prev = 0;
    struct Allocator *tmp = alloc_head;
    while(tmp != 0){
        if(tmp->start_addr + sizeof(struct Allocator) == (uint64)addr){
            if(prev == 0){ //if head is that must be deleted then...
                alloc_head = tmp->next;
                emptySpace(tmp->start_addr, tmp->size);
            }
            else{
                prev->next = tmp->next;
                emptySpace(tmp->start_addr, tmp->size);
            }
            return 0;
        }
        prev = tmp;
        tmp = tmp->next;
    }
    return (void*)-1;
}