//
// Created by os on 8/21/22.
//

#ifndef PROJEC_BASE_V1_1_CONSOLEHANDLER_HPP
#define PROJEC_BASE_V1_1_CONSOLEHANDLER_HPP

#include "./syscall_c.hpp"
#include "./ConsoleBuffer.hpp"

class ConsoleHandler{
public:
    ConsoleHandler(ConsoleHandler const &) = delete;
    void operator=(ConsoleHandler const &) = delete;

    static ConsoleHandler *createConsoleHandler();

    static ConsoleHandler *getInstance(){
        if(instance == nullptr){
            instance = ConsoleHandler::createConsoleHandler();
        }
        return instance;
    }

    char sys_getc();
    void writeDataInput(char );

    void sys_putc(char c);

    [[noreturn]] static void sendDataToConsole();
private:
    static ConsoleHandler *instance;

    ConsoleHandler () {}

    ConsoleBuffer *input;
    ConsoleBuffer *output;
};

#endif //PROJEC_BASE_V1_1_CONSOLEHANDLER_HPP