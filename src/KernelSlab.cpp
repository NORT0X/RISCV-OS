#include "../h/KernelSlab.hpp"

KernelSlab::caches *KernelSlab::head = 0;

void KernelSlab::kernel_slab_init() {
    head = 0;
}

void KernelSlab::addCache(kmem_cache *elem) {
    caches *new_cache = (caches *)Buddy::buddy_allocate(sizeof(caches));
    new_cache->elem = elem;
    new_cache->next = 0;
    new_cache->prev = 0;
    if(head == 0){
        head = new_cache;
    }else{
        caches *tmp = head;
        while(tmp->next != 0){
            tmp = tmp->next;
        }
        tmp->next = new_cache;
        new_cache->prev = tmp;
    }
}

int KernelSlab::deleteCache(kmem_cache *elem) {
    caches *tmp = head;
    while(tmp->next != 0){
        if(tmp->elem == elem){
            //delete node
            return 0;
        }
        tmp = tmp->next;
    }
    return -1;
}