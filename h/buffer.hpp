//
// Created by os on 8/24/22.
//

#ifndef PROJEC_BASE_V1_1_BUFFER_HPP
#define PROJEC_BASE_V1_1_BUFFER_HPP

#include "../h/syscall_c.hpp"
#include "printing.hpp"

class Buffer {
private:
    int cap;
    int *buffer;
    int head, tail;

    sem_t spaceAvailable;
    sem_t itemAvailable;
    sem_t mutexHead;
    sem_t mutexTail;

public:
    Buffer(int _cap);
    ~Buffer();

    void put(int val);
    int get();

    int getCnt();

};

#endif //PROJEC_BASE_V1_1_BUFFER_HPP
