//
// Created by os on 8/10/22.
//

#ifndef PROJEC_BASE_V1_1_SYSCALL_C_HPP
#define PROJEC_BASE_V1_1_SYSCALL_C_HPP

#include "../lib/hw.h"

void *mem_alloc(size_t size);

int mem_free(void *);

class PCB;
typedef PCB* thread_t;

int thread_create(thread_t *handle, void(*start_routine)(void *), void* arg);
int thread_exit();
void thread_dispatch();

class SEM;
typedef SEM* sem_t;
int sem_open(sem_t* handle, unsigned init);
int sem_close(sem_t handle);
int sem_wait(sem_t id);
int sem_signal(sem_t id);

typedef unsigned long time_t;
int time_sleep(time_t);

const int EOF = -1;
char getc();
void putc(char);


#endif //PROJEC_BASE_V1_1_SYSCALL_C_HPP
