#include "../h/SEM.hpp"

kmem_cache_t *SEM::cache = nullptr;

SEM *SEM::createSEM(int val) {
    SEM* ret = (SEM *)kmem_cache_alloc(SEM::cache);
    if(ret == nullptr) return nullptr;
    ret->val = val;
    ret->q = Queue::createQueue();
    if(ret->q == nullptr){
        kmem_cache_free(SEM::cache, ret);
        return nullptr;
    }
    return ret;
}

int SEM::wait(){
    if(--val < 0){
        if(q->put(PCB::running) == -1) {
            val++;
            return -1;
        }

        PCB::running->status = ThreadStatus::BLOCKED;
        PCB::dispatch();
    }
    return 0;
}

int SEM::signal() {
    if(val < 0){
        PCB* tmp = q->get();
        if(tmp){
            tmp->status = READY;
            Scheduler::put(tmp);
        }
    }
    val++;
    return 0;
}

int SEM::close() {
    PCB* tmp = q->get();
    while(tmp != nullptr){
        tmp->status = ThreadStatus::READY;
        tmp = q->get();
    }
    return 0;
}

void SEM::freeObject(SEM *s){
    kmem_cache_free(SEM::cache, (void *)s);
}

void SEM::dtor(SEM *s){
    Queue::freeObject(s->q);
}