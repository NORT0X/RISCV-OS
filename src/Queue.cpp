#include "../h/Queue.hpp"
#include "../h/PCB_List.hpp"

kmem_cache_t *Queue::cache = nullptr;

Queue *Queue::createQueue() {
    Queue *ret = (Queue *) kmem_cache_alloc(Queue::cache);
    if(ret == nullptr) return nullptr;
    ret->size = 0;
    ret->queue = PCB_List::createPCB_List();
    if(ret->queue == nullptr){
        kmem_cache_free(Queue::cache, ret);
        return nullptr;
    }
    return ret;
}

int Queue::put(PCB* pcb){
    int ret = queue->addLast(pcb);
    if(ret == -1)  return -1;
    size++;
    return ret;
}

PCB *Queue::get(){
    size--;
    return queue->removeFirst();
}

void Queue::freeObject(Queue *q) {
    kmem_cache_free(Queue::cache, (void *)q);
}

void Queue::dtor(Queue *q) {
    PCB_List::freeObject(q->queue);
}
