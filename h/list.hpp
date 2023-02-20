//
// Created by os on 8/9/22.
//

#ifndef PROJEC_BASE_V1_1_LIST_HPP
#define PROJEC_BASE_V1_1_LIST_HPP

#include "MemoryAllocator.hpp"

template<typename T>
class List
{
private:
    struct Elem
    {
        void *operator new(size_t size){
            return MemoryAllocator::sys_mem_alloc(size);
        }
        void operator delete(void *p){
            MemoryAllocator::sys_mem_free(p);
        }
        T *data;
        Elem *next;

        Elem(T *data, Elem *next) : data(data), next(next) {}
    };

    Elem *head, *tail;

public:
    List() : head(0), tail(0) {}

    List(const List<T> &) = delete;

    List<T> &operator=(const List<T> &) = delete;

    void addFirst(T *data)
    {
        Elem *elem = new Elem(data, head);
        head = elem;
        if (!tail) { tail = head; }
    }

    void addLast(T *data)
    {
        Elem *elem = new Elem(data, 0);
        if (tail)
        {
            tail->next = elem;
            tail = elem;
        } else
        {
            head = tail = elem;
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }

        Elem *elem = head;
        head = head->next;
        if (!head) { tail = 0; }

        T *ret = elem->data;
        delete elem;
        return ret;
    }

    T *peekFirst()
    {
        if (!head) { return 0; }
        return head->data;
    }
};

#endif //PROJEC_BASE_V1_1_LIST_HPP