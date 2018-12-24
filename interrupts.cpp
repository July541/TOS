#include "interrupts.h"

void printf(char *str);

uint32_t InterruptManager::handleInterrupt(uint8_t interruptNumber, uint32_t esp) {
    printf((char*)"INTRRUPT");
    return esp;
}
