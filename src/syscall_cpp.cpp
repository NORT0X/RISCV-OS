#include "../h/syscall_cpp.hpp"

void Thread::threadWrapper(void *arg) {
    ((Thread*)arg)->run();
}

int Thread::start() {
    return thread_create(&myHandle,  threadWrapper, this);
}

void Thread::dispatch() {
    thread_dispatch();
}

int Thread::sleep(time_t time) {
    time_sleep(time);
    return 0;
}


Semaphore::Semaphore(unsigned int init) {
    sem_open(&myHandle, init);
}
Semaphore::~Semaphore() {
    sem_close(myHandle);
}

int Semaphore::wait() {
    return sem_wait(myHandle);
}

int Semaphore::signal() {
    return sem_signal(myHandle);
}

char Console::getc() {
    uint8 number = 41;
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    __asm__ volatile("ecall");
    char res;
    __asm__ volatile("mv %[res], a0" : [res] "=r" (res));
    return res;
}

void Console::putc(char c) {
    uint8 number = 42;
    __asm__ volatile("mv a1, a0");
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    __asm__ volatile("ecall");
}