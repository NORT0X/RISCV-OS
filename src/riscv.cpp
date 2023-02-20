#include "../h/riscv.hpp"
#include "../h/syscall_c.hpp"
#include "../h/PCB.hpp"
#include "../h/SEM.hpp"
#include "../h/ksyscall.hpp"

void Riscv::popSppSpie()
{
    if(PCB::running == PCB::main_t || PCB::running == PCB::console_t){ //|| PCB::running == PCB::user_main_t){
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(BitMaskSstatus::SSTATUS_SPP));
    }else{
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(BitMaskSstatus::SSTATUS_SPP));
    }
    __asm__ volatile("csrw sepc, ra");
    __asm__ volatile("sret");
}

void Riscv::handleSupervisorTrap(unsigned short number) {
    uint64 scauseVar = Riscv::r_scause();
    if (scauseVar == USER_ECALL || scauseVar == SYSTEM_ECALL) {
        // interrupt: no; cause code: environment call from U-mode(8) or S-mode(9)
        mc_sip(SIP_SSIP);
        mc_sip(SIP_STIP);
        uint64 volatile sepc = Riscv::r_sepc();
        uint64 volatile sstatus = r_sstatus();
        sepc += 4;

        saveFp(ksyscall::fp);
        ksyscall::hanldeSyscall(number);

        Riscv::w_sstatus(sstatus);
        Riscv::w_sepc(sepc);
    }else if(scauseVar == TIMER_INT){
        // interrupt: yes; cause code: supervisor software interrupt (CLINT; machine timer interrupt)
        //Sleeping processing
        mc_sip(SIP_SSIP);
        PCB::wakingUp();

        //Async processing
        PCB::timeSliceCounter++;
        if(PCB::timeSliceCounter >= PCB::running->getTimeSlice()){
            uint64 volatile sepc = r_sepc();
            uint64 volatile sstatus = r_sstatus();
            PCB::timeSliceCounter = 0;
            PCB::dispatch();
            w_sstatus(sstatus);
            w_sepc(sepc);
        }
    }else if(scauseVar == EXTERNAL_INT){
        uint64 volatile sepc = Riscv::r_sepc();
        uint64 volatile sstatus = r_sstatus();
        int volatile irq = plic_claim();
        mc_sip(SIP_SEIP);
        mc_sip(SIP_STIP);

        if(irq == 0x0a){
            char volatile *status = (char *)CONSOLE_STATUS;
            if(*status & CONSOLE_RX_STATUS_BIT){
                char volatile r = *(char *)CONSOLE_RX_DATA;
                ConsoleHandler::getInstance()->writeDataInput(r);
                //ConsoleHandler::getInstance()->handle();
            }
        }
        plic_complete(irq);
        Riscv::w_sstatus(sstatus);
        Riscv::w_sepc(sepc);
    }else{
        // unexpected trap
    }
}