//
// Created by os on 8/23/22.
//

#ifndef PROJEC_BASE_V1_1_PRINTING_HPP
#define PROJEC_BASE_V1_1_PRINTING_HPP

#include "./syscall_c.hpp"

typedef unsigned long uint64;

extern "C" uint64 copy_and_swap(uint64 &lock, uint64 expected, uint64 desired);

void printString(char const *string);

char* getString(char *buf, int max);

int stringToInt(const char *s);

void printInt(int xx, int base=10, int sgn=0);

#endif //PROJEC_BASE_V1_1_PRINTING_HPP
