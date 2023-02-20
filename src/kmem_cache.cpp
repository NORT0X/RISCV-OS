#include "../h/kmem_cache.hpp"

void kmem_cache::cache_create(char *n, size_t s, void (*ct)(void *), void (*dt)(void *)) {
    name = n;
    sizeOfObject = s;
    ctor = ct;
    dtor = dt;
    number_of_slabs = 0;
    num_of_alloc_objects = 0;
    error_indicator = 0;

    empty_slabs = nullptr;
    not_empty_slabs = nullptr;
    full_slabs = nullptr;
}

void kmem_cache::add_slab(kmem_cache::slab **head, kmem_cache::slab *slab) {
    slab->next = nullptr;
    if(*head == nullptr){
        *head = slab;
    }else{
        kmem_cache::slab *tmp = *head;
        while(tmp->next != nullptr){
            tmp = tmp->next;
        }
        tmp->next = slab;
    }
}

int kmem_cache::delete_slab(kmem_cache::slab **head, kmem_cache::slab *slab) {
    kmem_cache::slab* prev = nullptr;
    kmem_cache::slab* tmp = *head;

    if(tmp != nullptr && tmp == slab){
        *head = tmp->next;
    }else{
        while(tmp != nullptr && tmp != slab){
            prev = tmp;
            tmp = tmp->next;
        }

        //if slab was not found
        if(tmp == nullptr)
            return -1;

        if(prev != nullptr)
            prev->next = tmp->next;
    }
    slab->next = nullptr;
    slab->limit = 0;
    Buddy::buddy_free(slab->address);
    Buddy::buddy_free(slab->allocateArray);
    slab->address = nullptr;
    slab->allocateArray = nullptr;
    Buddy::buddy_free(slab);
    return 0;
}

int kmem_cache::cache_alloc_buffer(size_t size) {
    void *res = Buddy::buddy_allocate(size);
    if(res == nullptr){
        error_indicator = -1;
        return -1;
    }
    //add this empty slab to empty_slabs - buffer = slab
    slab *new_slab = (slab *)Buddy::buddy_allocate(sizeof(slab));
    if(new_slab == nullptr){
        Buddy::buddy_free(res);
        error_indicator = -1;
        return -1;
    }
    number_of_slabs++;
    new_slab->address = res;
    new_slab->counter = 0;
    new_slab->sizeInBlocks = (size/BLOCK_SIZE) + (size%BLOCK_SIZE == 0 ? 0 : 1);
    new_slab->limit = (new_slab->sizeInBlocks * BLOCK_SIZE) / this->sizeOfObject;

    new_slab->allocateArray = (uint8 *)Buddy::buddy_allocate(sizeof(uint8)*new_slab->limit);
    if(new_slab->allocateArray == nullptr){
        Buddy::buddy_free(res);
        Buddy::buddy_free(new_slab);
        error_indicator = -1;
        return -1;
    }
    //Buffer is totally empty
    for(uint64 i = 0; i < new_slab->limit; i++){
        new_slab->allocateArray[i] = 0;
    }

    add_slab(&empty_slabs, new_slab);
    return 0;
}

int kmem_cache::shrink() {
    int res = 0;
    if(empty_slabs == nullptr) return res; //can't shrink
    slab* tmp;

    if(not_empty_slabs != nullptr)
        tmp = empty_slabs->next;
    else
        tmp = empty_slabs;

    slab *forDelet = tmp;
    while(tmp != nullptr){
        tmp = tmp->next;
        res += forDelet->sizeInBlocks;
        delete_slab(&empty_slabs, forDelet);
    }
    number_of_slabs -= (uint64)res;
    return res;
}

void *kmem_cache::alloc_object() {
    void *addr;

    if(not_empty_slabs != nullptr){
        slab *p_slab = not_empty_slabs;

        //find free space in slab
        uint64 offset = 0;
        for(;offset < p_slab->limit; offset++){
            if(p_slab->allocateArray[offset] == 0){
                p_slab->allocateArray[offset] = 1;
                break;
            }
        }
        addr = (void *)((uint64)p_slab->address + offset * this->sizeOfObject);
        if(ctor != nullptr) {
            ctor(addr);
        }

        p_slab->counter++;
        if(p_slab->counter == p_slab->limit){
            //add slab to full_slabs list and remove from not_empty-slabs
            not_empty_slabs = not_empty_slabs->next;
            add_slab(&full_slabs, p_slab);
        }
        num_of_alloc_objects++;
        return addr;
    }else if(empty_slabs != nullptr){
        slab *p_slab = empty_slabs;

        //take first element of slab for allocation because it's empty
        uint64 offset = 0;
        p_slab->allocateArray[offset] = 1;
        addr = (void *)((uint64)p_slab->address + offset * this->sizeOfObject);
        if(ctor != nullptr) {
            ctor(addr);
        }

        p_slab->counter++;
        if(p_slab->counter == p_slab->limit){
            //add slab to full_slabs list and remove from empty-slabs
            //this only happens if slab is size of one object
            empty_slabs = empty_slabs->next;
            add_slab(&full_slabs, p_slab);
        }else{
            //else add slab to not_empty_slabs and remove from empty_slabs
            empty_slabs = empty_slabs->next;
            add_slab(&not_empty_slabs, p_slab);
        }
        num_of_alloc_objects++;
        return addr;
    }else{
        // there is no empty slab so we must create one
        if(cache_alloc_buffer(BLOCK_SIZE) == -1){
            return nullptr;
        }
        //now we should check if there is slab in empty_slabs
        if(empty_slabs != nullptr){
            slab *p_slab = empty_slabs;

            //take first element of slab for allocation because it's empty
            uint64 offset = 0;
            p_slab->allocateArray[offset] = 1;
            addr = (void *)((uint64)p_slab->address + offset * this->sizeOfObject);
            if(ctor != nullptr) {
                ctor(addr);
            }

            p_slab->counter++;
            if(p_slab->counter == p_slab->limit){
                //add slab to full_slabs list and remove from empty-slabs
                //this only happens if slab is size of one object
                empty_slabs = empty_slabs->next;
                add_slab(&full_slabs, p_slab);
            }else{
                //else add slab to not_empty_slabs and remove from empty_slabs
                empty_slabs = empty_slabs->next;
                add_slab(&not_empty_slabs, p_slab);
            }
            num_of_alloc_objects++;
            return addr;
        }
    }
    return nullptr;
}

void kmem_cache::deallocInSlab(slab *p_slab, void *objp) {
    uint64 offset = 0;
    for(; offset < p_slab->limit; offset++){
        if((uint64)objp == (uint64)p_slab->address + offset * this->sizeOfObject){
            p_slab->allocateArray[offset] = 0;
            num_of_alloc_objects--;
            p_slab->counter--;
            if(dtor != nullptr) {
                dtor(objp);
            }
            //MAYBE SHOULD BE CLEARD WHOLE SPACE - CHANGE IN FUTURE
            return;
        }
    }
}

void kmem_cache::free_object(void *objp) {
    //check if object is part of full_slabs
    slab *prev = nullptr;
    slab *tmp = full_slabs;
    while(tmp != nullptr){
        if((uint64)objp >= (uint64)tmp->address && (uint64)objp < (uint64)tmp->address + this->sizeOfObject * tmp->limit){
            deallocInSlab(tmp, objp);
            //remove slab from full_slabs and put in not_empty_slabs
            if(prev == nullptr){
                full_slabs = full_slabs->next;
            }else{
                prev->next = tmp->next;
            }
            add_slab(&not_empty_slabs, tmp);
            return;
        }
        prev = tmp;
        tmp = tmp->next;
    }
    //check if object is part of not_empty_slabs
    prev = nullptr;
    tmp = not_empty_slabs;
    while(tmp != nullptr){
        if((uint64)objp >= (uint64)tmp->address && (uint64)objp < (uint64)tmp->address + this->sizeOfObject * tmp->limit){
            deallocInSlab(tmp, objp);
            if(tmp->counter == 0){
                //remove slab from not_empty_slabs and put in empty_slabs
                if(prev == nullptr){
                    not_empty_slabs = not_empty_slabs->next;
                }else{
                    prev->next = tmp->next;
                }
                add_slab(&empty_slabs, tmp);
            }
            return;
        }
        prev = tmp;
        tmp = tmp->next;
    }

    error_indicator = -2;
}

void kmem_cache::destructor() {
    //destroy all slabs
    while(empty_slabs != nullptr){
        slab *p_slab = empty_slabs;
        delete_slab(&empty_slabs, p_slab);
    }
    while(not_empty_slabs != nullptr){
        slab *p_slab = not_empty_slabs;
        delete_slab(&not_empty_slabs, p_slab);
    }
    while(full_slabs != nullptr){
        slab *p_slab = full_slabs;
        delete_slab(&full_slabs, p_slab);
    }
}

int kmem_cache::sizeOfCache() {
    int res = 0;
    slab *p_slab = empty_slabs;
    while(p_slab != nullptr){
        res += p_slab->sizeInBlocks;
        p_slab = p_slab->next;
    }
    p_slab = not_empty_slabs;
    while(p_slab != nullptr){
        res += p_slab->sizeInBlocks;
        p_slab = p_slab->next;
    }
    p_slab = full_slabs;
    while(p_slab != nullptr){
        res += p_slab->sizeInBlocks;
        p_slab = p_slab->next;
    }
    return res;
}

void kmem_cache::printInfo() {
    kernel_printString("===============\n");
    kernel_printString("Cache: ");
    kernel_printString(this->name);
    kernel_printString("\n");

    kernel_printString("Size of one object: ");
    kernel_printInt((int)this->sizeOfObject);
    kernel_printString(" bytes\n");

    int cacheSize = sizeOfCache();
    kernel_printString("Size of cache: ");
    kernel_printInt(cacheSize);
    kernel_printString(" blocks\n");

    kernel_printString("Number of slabs: ");
    kernel_printInt((int)number_of_slabs);
    kernel_printString("\n");

    kernel_printString("Number of objects in one slab: ");
    kernel_printInt(BLOCK_SIZE/sizeOfObject);
    kernel_printString("\n");

    kernel_printString("Percentage of cache occupancy: ");
    int onePer = cacheSize*BLOCK_SIZE / 100;

    kernel_printInt(num_of_alloc_objects*(int)sizeOfObject/onePer);
    kernel_printString("%\n");
    kernel_printString("===============\n");

}

int kmem_cache::printError() {
    switch(error_indicator){
        case 0:
            kernel_printString("No errors.\n");
            break;
        case -1:
            kernel_printString("Error: not enough space for another slab.\n");
            break;
        case -2:
            kernel_printString("Error: object was not able to be deallocated.\n");
            break;
    }
    return error_indicator;
}