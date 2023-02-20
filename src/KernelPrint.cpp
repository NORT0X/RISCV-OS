#include "../h/KernelPrint.hpp"

void kernel_printString(char const *string)
{
    while (*string != '\0')
    {
        ConsoleHandler::getInstance()->sys_putc(*string);
        string++;
    }
}

char k_digits[] = "0123456789ABCDEF";
void kernel_printInt(int xx, int base, int sgn)
{
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    }

    i = 0;
    do{
        buf[i++] = k_digits[x % base];
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';

    while(--i >= 0)
        ConsoleHandler::getInstance()->sys_putc(buf[i]);

}