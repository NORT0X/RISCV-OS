#include "../h/PCB_List.hpp"

kmem_cache_t *PCB_List::cache = nullptr;
kmem_cache_t *PCB_List::Elem::elemCache = nullptr;

PCB_List *PCB_List::createPCB_List(){
    PCB_List *ret = (PCB_List *)kmem_cache_alloc(PCB_List::cache);
    if(ret == nullptr) return nullptr;
    ret->head = nullptr;
    ret->tail = nullptr;
    return ret;
}

void PCB_List::addFirst(PCB *data)
{
    //Elem *elem = new Elem(data, head);
    Elem *elem = Elem::createElem(data, head);
    head = elem;
    if (!tail) { tail = head; }
}

int PCB_List::addLast(PCB *data)
{
    //Elem *elem = new Elem(data, 0);
    Elem *elem = Elem::createElem(data, nullptr);
    if(!elem) return -1;
    if (tail)
    {
        tail->next = elem;
        tail = elem;
    } else
    {
        head = tail = elem;
    }
    return 0;
}

PCB *PCB_List::removeFirst()
{
    if (!head) { return 0; }

    Elem *elem = head;
    head = head->next;
    if (!head) { tail = 0; }

    PCB *ret = elem->data;

    elem->next = nullptr;
    Elem::freeObject(elem);

    return ret;
}

PCB *PCB_List::peekFirst()
{
    if (!head) { return 0; }
    return head->data;
}

void PCB_List::freeObject(PCB_List *l) {
    kmem_cache_free(PCB_List::cache, (void *)l);
}

void PCB_List::dtor(PCB_List *l) {
    while(!l->head){
        l->removeFirst();
    }
}
