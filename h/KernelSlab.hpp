//
// Created by os on 1/29/23.
//

#ifndef PROJECT_BASE_KERNELSLAB_HPP
#define PROJECT_BASE_KERNELSLAB_HPP

#include "kmem_cache.hpp"
#include "Buddy.h"

class KernelSlab{
private:
    struct caches{
        kmem_cache *elem;
        struct caches *next, *prev;
    };
    static caches *head;
public:
    static void kernel_slab_init();

    static void addCache(kmem_cache *elem);
    static int deleteCache(kmem_cache *elem);
};

#endif //PROJECT_BASE_KERNELSLAB_HPP
