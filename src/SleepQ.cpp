#include "../h/SleepQ.hpp"

SleepQ::ElemQ *SleepQ::head = nullptr;
SleepQ::ElemQ *SleepQ::last = nullptr;

kmem_cache_t *SleepQ::ElemQ::cache = nullptr;

void SleepQ::put(PCB *pcb, time_t time){
    if(head == nullptr){
        ElemQ *new_e = ElemQ::createElemQ(pcb, time);//new ElemQ(pcb, time);
        new_e->next = nullptr;
        head = new_e;
        last = new_e;
    }else{
        ElemQ *new_e = ElemQ::createElemQ(pcb, time);//new ElemQ(pcb, time);
        if(time <= head->rang){
            new_e->next = head;
            head->rang = head->rang - new_e->rang;
            head = new_e;
        }else{
            ElemQ *prev = head;
            ElemQ *tmp = head->next;
            new_e->rang = new_e->rang - head->rang;
            while(tmp != nullptr){
                if(new_e->rang <= tmp->rang){
                    tmp->rang = tmp->rang - new_e->rang;
                    prev->next = new_e;
                    new_e->next = tmp;
                    break;
                }
                new_e->rang = new_e->rang - tmp->rang;
                prev = tmp;
                tmp = tmp->next;
            }
            if(tmp == nullptr){
                last->next = new_e;
                last = new_e;
            }
        }
    }
}

PCB *SleepQ::get(){
    if(!head) return nullptr;

    ElemQ *tmp = head;
    head = head->next;
    if(!head) last = nullptr;

    PCB *res = tmp->pcb;
    //MemoryAllocator::sys_mem_free(tmp);
    ElemQ::freeObject(tmp);
    return res;
}

void SleepQ::update() {
    if(head != nullptr) {
        if(head->rang != 0) head->rang--;
    }
}