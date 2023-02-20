#include "../h/syscall_c.hpp"
#include "../h/riscv.hpp"
#include "../h/ksyscall.hpp"
#include "../h/PCB.hpp"
void* mem_alloc(size_t size){
    uint8 number = ksyscall::MEM_ALLOC;
    __asm__ volatile("mv a1, %[size]" : : [size] "r" (size));
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    __asm__ volatile("ecall");
    uint64 res;
    __asm__ volatile("mv %[res], a0" : [res] "=r" (res));
    return (void*)res;
}

int mem_free(void* addr){
    if(addr == nullptr) return -1;
    uint8 number = ksyscall::MEM_FREE;
    __asm__ volatile("mv a1, %[addr]" : : [addr] "r" (addr));
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    __asm__ volatile("ecall");
    int res;
    __asm__ volatile("mv %[res], a0" : [res] "=r" (res));
    return res;
}

int thread_create(thread_t *handle, void(*start_routine)(void *), void* arg){
    uint8 number = ksyscall::THREAD_CREATE;
    __asm__ volatile("mv t1, %[handle]" : : [handle] "r" (handle)); // There will be calling of mem_alloc and it will corrupt a0 reg
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    __asm__ volatile("ecall");
    __asm__ volatile("mv a0, t1"); // Because of reason mentioned above we are restoring handle;
    PCB* tmp;
    __asm__ volatile("mv %[tmp], a3" : [tmp] "=r" (tmp));
    *handle = tmp;
    if(*handle == nullptr) return -1;
    return 0;
}

int thread_exit(){
    uint8 number = ksyscall::THREAD_EXIT;
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    __asm__ volatile("ecall");
    return 0;
}

void thread_dispatch() {
    uint8 number = ksyscall::THREAD_DISPATCH;
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    __asm__ volatile("ecall");
}

int sem_open(sem_t* handle, unsigned init){
    uint8 number = ksyscall::SEM_OPEN;
    __asm__ volatile("mv t1, %[handle]" : : [handle] "r" (handle));
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    __asm__ volatile("ecall");
    __asm__ volatile("mv a0, t1");
    SEM* tmp;
    __asm__ volatile("mv %[tmp], a3" : [tmp] "=r" (tmp));
    *handle = tmp;
    if(handle == nullptr) return -1;
    return 0;
}

int sem_close(sem_t handle){
    if(handle == nullptr) return -1;

    uint8 number = ksyscall::SEM_CLOSE;
    __asm__ volatile("mv a1, a0");
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    __asm__ volatile("ecall");
    int res;
    __asm__ volatile("mv %[res], a0" : [res] "=r" (res));
    return res;
}

int sem_wait(sem_t id){
    if(id == nullptr) return -1;
    uint8 number = ksyscall::SEM_WAIT;
    __asm__ volatile("mv a1, a0");
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    __asm__ volatile("ecall");
    int res;
    __asm__ volatile("mv %[res], a0" : [res] "=r" (res));
    return res;
}

int sem_signal(sem_t id){
    if(id == nullptr) return -1;
    uint8 number = ksyscall::SEM_SIGNAL;
    __asm__ volatile("mv a1, a0");
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    __asm__ volatile("ecall");
    int res;
    __asm__ volatile("mv %[res], a0" : [res] "=r" (res));
    return res;
}

int time_sleep(time_t){
    uint8 number = ksyscall::TIME_SLEEP;
    __asm__ volatile("mv a1, a0");
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    __asm__ volatile("ecall");
    int res;
    __asm__ volatile("mv %[res], a0" : [res] "=r" (res));
    return 0;
}

char getc(){
    uint8 number = ksyscall::GETC;
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    __asm__ volatile("ecall");
    char res;
    __asm__ volatile("mv %[res], a0" : [res] "=r" (res));
    return res;
}

void putc(char c){
    uint8 number = ksyscall::PUTC;
    __asm__ volatile("mv a1, a0");
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    __asm__ volatile("ecall");
}
