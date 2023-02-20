#include "../h/ConsoleBuffer.hpp"
#include "../h/SEM.hpp"

ConsoleBuffer::ConsoleBuffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    buffer = (char *)MemoryAllocator::sys_mem_alloc(sizeof(char) * cap);
    itemAvailable = SEM::createSEM(0);
    spaceAvailable = SEM::createSEM(_cap);
    mutexHead = SEM::createSEM(1);
    mutexTail = SEM::createSEM(1);
}

ConsoleBuffer *ConsoleBuffer::createConsoleBuffer(int _cap) {
    ConsoleBuffer *ret = (ConsoleBuffer *)kmalloc(sizeof(ConsoleBuffer));
    if(ret == nullptr) return nullptr;

    ret->head = 0;
    ret->tail = 0;
    ret->buffer = (char *)kmalloc(sizeof(char)*_cap);
    ret->itemAvailable = SEM::createSEM(0);
    ret->spaceAvailable = SEM::createSEM(_cap);
    ret->mutexHead = SEM::createSEM(1);
    ret->mutexTail = SEM::createSEM(1);
    return ret;
}

ConsoleBuffer::~ConsoleBuffer() {
    while (getCnt() > 0) {
        head = (head + 1) % cap;
    }

    MemoryAllocator::sys_mem_free(buffer);
    itemAvailable->close();
    spaceAvailable->close();
    mutexTail->close();
    mutexHead->close();
    MemoryAllocator::sys_mem_free(itemAvailable);
    MemoryAllocator::sys_mem_free(spaceAvailable);
    MemoryAllocator::sys_mem_free(mutexTail);
    MemoryAllocator::sys_mem_free(mutexHead);
}

void ConsoleBuffer::put(int val) {
    spaceAvailable->wait();

    mutexTail->wait();
    buffer[tail] = val;
    tail = (tail + 1) % cap;

    mutexTail->signal();

    itemAvailable->signal();

}

int ConsoleBuffer::get() {
    itemAvailable->wait();

    mutexHead->wait();

    int ret = buffer[head];
    head = (head + 1) % cap;

    mutexHead->signal();

    spaceAvailable->signal();

    return ret;
}

int ConsoleBuffer::getCnt() {
    int ret;

    mutexHead->wait();
    mutexTail->wait();

    if (tail >= head) {
        ret = tail - head;
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    mutexHead->signal();

    return ret;
}
