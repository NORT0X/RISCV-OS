#include "../h/ConsoleHandler.hpp"
#include "../h/PCB.hpp"

ConsoleHandler *ConsoleHandler::instance = nullptr;

ConsoleHandler *ConsoleHandler::createConsoleHandler() {
    ConsoleHandler *ret = (ConsoleHandler *)kmalloc(sizeof(ConsoleHandler));
    ret->input = ConsoleBuffer::createConsoleBuffer(65536); //65536
    ret->output = ConsoleBuffer::createConsoleBuffer(65536);
    return ret;
}


char ConsoleHandler::sys_getc() {
    return (char)input->get();
}

void ConsoleHandler::writeDataInput(char c) {
    input->put(c);
}

void ConsoleHandler::sys_putc(char c) {
    if(output != nullptr) {
        output->put(c);
    }
}

[[noreturn]] void ConsoleHandler::sendDataToConsole() {
    while(1) {
        char *status = (char *)CONSOLE_STATUS;
        if (*status & CONSOLE_TX_STATUS_BIT) {
            char data = (char) ConsoleHandler::getInstance()->output->get();
            *((char *)CONSOLE_TX_DATA) = data;
        }
    }
}