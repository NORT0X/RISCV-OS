#include "../h/slab.hpp"
#include "../h/KernelSlab.hpp"

void kmem_init(void *space, int block_num){
    uint64 realSize = (uint64)block_num * BLOCK_SIZE;
    void* end = (void *)((uint64)space + realSize);
    Buddy::buddy_init(space, end);
    KernelSlab::kernel_slab_init();
}

kmem_cache_t *kmem_cache_create(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)){
   kmem_cache_t *res = (kmem_cache_t *)Buddy::buddy_allocate(sizeof(kmem_cache_t));
   res->cache_create((char *)name, size, ctor, dtor);
   KernelSlab::addCache(res);
   return res;
}

int kmem_cache_shrink(kmem_cache_t *cachep){
    return cachep->shrink();
}

void *kmalloc(size_t size){
    return Buddy::buddy_allocate(size);
}

void kfree(const void *objp){
    Buddy::buddy_free((void *)objp);
}

void *kmem_cache_alloc(kmem_cache_t *cachep){
    return cachep->alloc_object();
}

void kmem_cache_free(kmem_cache_t *cachep, void *objp){
    cachep->free_object(objp);
}

void kmem_cache_destroy(kmem_cache_t *cachep){
    cachep->destructor();
    KernelSlab::deleteCache(cachep);
}

void kmem_cache_info(kmem_cache_t *cachep){
    cachep->printInfo();
}

int kmem_cache_error(kmem_cache_t *cachep){
    return cachep->printError();
}