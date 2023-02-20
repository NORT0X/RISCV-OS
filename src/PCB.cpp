#include "../h/PCB.hpp"

PCB *PCB::running = nullptr;
PCB *PCB::main_t = nullptr;
PCB *PCB::console_t = nullptr;
PCB *PCB::user_main_t = nullptr;
uint64 PCB::thread_counter = 0;

kmem_cache_t *PCB::cache = nullptr;

uint64 PCB::timeSliceCounter = 0;

PCB *PCB::createThread(Body body, void* args) {
    PCB* ret = (PCB *)kmem_cache_alloc(cache);
    if(ret == nullptr) return nullptr;
    ret->body = body;
    ret->args = (ret->body != nullptr ? args : nullptr);
    ret->stack = (ret->body != nullptr ? (uint64 *)kmalloc(sizeof(uint64)*STACK_SIZE) : 0);
    if(!ret->stack && ret->body != nullptr) {
        kmem_cache_free(cache, (void *)ret);
        return nullptr;
    }
    ret->context = {(uint64) &threadWrapper,
             ret->stack != 0 ? (uint64) &ret->stack[STACK_SIZE-1] : 0
            };
    ret->timeSlice = TIME_SLICE;
    ret->finished = false;
    if(ret->body != 0) {
        if(Scheduler::put(ret) == -1){
            kfree((void *)ret->stack);
            kmem_cache_free(cache, (void *)ret);
            return nullptr;
        }
        ret->status = READY;
    }
    thread_counter++;
    return ret;
}

void PCB::exitThread() {
    running->setFinished(true);
    dispatch();
}

void PCB::dispatch() {
    PCB *old = running;
    if(!old->isFinished() && old->status != ThreadStatus::BLOCKED) { Scheduler::put(old);}
    running = Scheduler::get();

    PCB::contextSwitch(&old->context, &running->context);
}

void PCB::threadWrapper() {
    Riscv::popSppSpie();
    running->body(running->args);
    running->setFinished(true);
    thread_dispatch();
}

int PCB::addToSleepQ(time_t time){
    SleepQ::put(running, time);
    running->status = ThreadStatus::BLOCKED;
    dispatch();
    return 0;
}

void PCB::wakingUp() {
    SleepQ::update();
    if(SleepQ::head != nullptr){
        if(SleepQ::head->rang <= 0) {
            PCB *tmp = SleepQ::get();
            tmp->status = ThreadStatus::READY;
            Scheduler::put(tmp);
        }
    }
}

void PCB::dtor(PCB *pcb) {
    if(pcb->stack) kfree((void *)pcb->stack);
}
