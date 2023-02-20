//
// Created by os on 8/21/22.
//

#ifndef PROJEC_BASE_V1_1_BUFFER_CPP_API_HPP
#define PROJEC_BASE_V1_1_BUFFER_CPP_API_HPP

#include "./syscall_cpp.hpp"
#include "./printing.hpp"

class BufferCPP {
private:
    int cap;
    int *buffer;
    int head, tail;

    Semaphore* spaceAvailable;
    Semaphore* itemAvailable;
    Semaphore* mutexHead;
    Semaphore* mutexTail;

public:
    BufferCPP(int _cap);
    ~BufferCPP();

    void put(int val);
    int get();

    int getCnt();
};

#endif //PROJEC_BASE_V1_1_BUFFER_CPP_API_HPP
