
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000a117          	auipc	sp,0xa
    80000004:	fa813103          	ld	sp,-88(sp) # 80009fa8 <_GLOBAL_OFFSET_TABLE_+0x78>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	414050ef          	jal	ra,80005430 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80001000:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80001004:	00b29a63          	bne	t0,a1,80001018 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001008:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000100c:	fe029ae3          	bnez	t0,80001000 <copy_and_swap>
    li a0, 0               # Set return to success.
    80001010:	00000513          	li	a0,0
    jr ra                  # Return.
    80001014:	00008067          	ret

0000000080001018 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001018:	00100513          	li	a0,1
    8000101c:	00008067          	ret

0000000080001020 <_ZN5Riscv14supervisorTrapEt>:
.align 4
.global _ZN5Riscv14supervisorTrapEt
.type _ZN5Riscv14supervisorTrapEt, @function

_ZN5Riscv14supervisorTrapEt:
    addi sp, sp, -256
    80001020:	f0010113          	addi	sp,sp,-256
    .irp index, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    sd x\index, \index * 8(sp)
    .endr
    80001024:	00013023          	sd	zero,0(sp)
    80001028:	00113423          	sd	ra,8(sp)
    8000102c:	00213823          	sd	sp,16(sp)
    80001030:	00313c23          	sd	gp,24(sp)
    80001034:	02413023          	sd	tp,32(sp)
    80001038:	02513423          	sd	t0,40(sp)
    8000103c:	02613823          	sd	t1,48(sp)
    80001040:	02713c23          	sd	t2,56(sp)
    80001044:	04813023          	sd	s0,64(sp)
    80001048:	04913423          	sd	s1,72(sp)
    8000104c:	04a13823          	sd	a0,80(sp)
    80001050:	04b13c23          	sd	a1,88(sp)
    80001054:	06c13023          	sd	a2,96(sp)
    80001058:	06d13423          	sd	a3,104(sp)
    8000105c:	06e13823          	sd	a4,112(sp)
    80001060:	06f13c23          	sd	a5,120(sp)
    80001064:	09013023          	sd	a6,128(sp)
    80001068:	09113423          	sd	a7,136(sp)
    8000106c:	09213823          	sd	s2,144(sp)
    80001070:	09313c23          	sd	s3,152(sp)
    80001074:	0b413023          	sd	s4,160(sp)
    80001078:	0b513423          	sd	s5,168(sp)
    8000107c:	0b613823          	sd	s6,176(sp)
    80001080:	0b713c23          	sd	s7,184(sp)
    80001084:	0d813023          	sd	s8,192(sp)
    80001088:	0d913423          	sd	s9,200(sp)
    8000108c:	0da13823          	sd	s10,208(sp)
    80001090:	0db13c23          	sd	s11,216(sp)
    80001094:	0fc13023          	sd	t3,224(sp)
    80001098:	0fd13423          	sd	t4,232(sp)
    8000109c:	0fe13823          	sd	t5,240(sp)
    800010a0:	0ff13c23          	sd	t6,248(sp)

    call _ZN5Riscv20handleSupervisorTrapEt
    800010a4:	5f8020ef          	jal	ra,8000369c <_ZN5Riscv20handleSupervisorTrapEt>

    .irp index, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    ld x\index, \index * 8(sp)
    .endr
    800010a8:	00013003          	ld	zero,0(sp)
    800010ac:	00813083          	ld	ra,8(sp)
    800010b0:	01013103          	ld	sp,16(sp)
    800010b4:	01813183          	ld	gp,24(sp)
    800010b8:	02013203          	ld	tp,32(sp)
    800010bc:	02813283          	ld	t0,40(sp)
    800010c0:	03013303          	ld	t1,48(sp)
    800010c4:	03813383          	ld	t2,56(sp)
    800010c8:	04013403          	ld	s0,64(sp)
    800010cc:	04813483          	ld	s1,72(sp)
    800010d0:	05013503          	ld	a0,80(sp)
    800010d4:	05813583          	ld	a1,88(sp)
    800010d8:	06013603          	ld	a2,96(sp)
    800010dc:	06813683          	ld	a3,104(sp)
    800010e0:	07013703          	ld	a4,112(sp)
    800010e4:	07813783          	ld	a5,120(sp)
    800010e8:	08013803          	ld	a6,128(sp)
    800010ec:	08813883          	ld	a7,136(sp)
    800010f0:	09013903          	ld	s2,144(sp)
    800010f4:	09813983          	ld	s3,152(sp)
    800010f8:	0a013a03          	ld	s4,160(sp)
    800010fc:	0a813a83          	ld	s5,168(sp)
    80001100:	0b013b03          	ld	s6,176(sp)
    80001104:	0b813b83          	ld	s7,184(sp)
    80001108:	0c013c03          	ld	s8,192(sp)
    8000110c:	0c813c83          	ld	s9,200(sp)
    80001110:	0d013d03          	ld	s10,208(sp)
    80001114:	0d813d83          	ld	s11,216(sp)
    80001118:	0e013e03          	ld	t3,224(sp)
    8000111c:	0e813e83          	ld	t4,232(sp)
    80001120:	0f013f03          	ld	t5,240(sp)
    80001124:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001128:	10010113          	addi	sp,sp,256
    8000112c:	10200073          	sret

0000000080001130 <_ZN3PCB13contextSwitchEPNS_7ContextES1_>:
.global _ZN3PCB13contextSwitchEPNS_7ContextES1_
.type _ZN3PCB13contextSwitchEPNS_7ContextES1_, @function
_ZN3PCB13contextSwitchEPNS_7ContextES1_:
    sd ra, 0 * 8(a0)
    80001130:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    80001134:	00253423          	sd	sp,8(a0)

    ld ra, 0 * 8(a1)
    80001138:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    8000113c:	0085b103          	ld	sp,8(a1)

    80001140:	00008067          	ret

0000000080001144 <_Z9mem_allocm>:
#include "../h/syscall_c.hpp"
#include "../h/riscv.hpp"
#include "../h/ksyscall.hpp"
#include "../h/PCB.hpp"
void* mem_alloc(size_t size){
    80001144:	ff010113          	addi	sp,sp,-16
    80001148:	00813423          	sd	s0,8(sp)
    8000114c:	01010413          	addi	s0,sp,16
    uint8 number = ksyscall::MEM_ALLOC;
    __asm__ volatile("mv a1, %[size]" : : [size] "r" (size));
    80001150:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    80001154:	00100793          	li	a5,1
    80001158:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    8000115c:	00000073          	ecall
    uint64 res;
    __asm__ volatile("mv %[res], a0" : [res] "=r" (res));
    80001160:	00050513          	mv	a0,a0
    return (void*)res;
}
    80001164:	00813403          	ld	s0,8(sp)
    80001168:	01010113          	addi	sp,sp,16
    8000116c:	00008067          	ret

0000000080001170 <_Z8mem_freePv>:

int mem_free(void* addr){
    80001170:	ff010113          	addi	sp,sp,-16
    80001174:	00813423          	sd	s0,8(sp)
    80001178:	01010413          	addi	s0,sp,16
    if(addr == nullptr) return -1;
    8000117c:	02050463          	beqz	a0,800011a4 <_Z8mem_freePv+0x34>
    uint8 number = ksyscall::MEM_FREE;
    __asm__ volatile("mv a1, %[addr]" : : [addr] "r" (addr));
    80001180:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    80001184:	00200793          	li	a5,2
    80001188:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    8000118c:	00000073          	ecall
    int res;
    __asm__ volatile("mv %[res], a0" : [res] "=r" (res));
    80001190:	00050513          	mv	a0,a0
    80001194:	0005051b          	sext.w	a0,a0
    return res;
}
    80001198:	00813403          	ld	s0,8(sp)
    8000119c:	01010113          	addi	sp,sp,16
    800011a0:	00008067          	ret
    if(addr == nullptr) return -1;
    800011a4:	fff00513          	li	a0,-1
    800011a8:	ff1ff06f          	j	80001198 <_Z8mem_freePv+0x28>

00000000800011ac <_Z13thread_createPP3PCBPFvPvES2_>:

int thread_create(thread_t *handle, void(*start_routine)(void *), void* arg){
    800011ac:	ff010113          	addi	sp,sp,-16
    800011b0:	00813423          	sd	s0,8(sp)
    800011b4:	01010413          	addi	s0,sp,16
    uint8 number = ksyscall::THREAD_CREATE;
    __asm__ volatile("mv t1, %[handle]" : : [handle] "r" (handle)); // There will be calling of mem_alloc and it will corrupt a0 reg
    800011b8:	00050313          	mv	t1,a0
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    800011bc:	00b00793          	li	a5,11
    800011c0:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    800011c4:	00000073          	ecall
    __asm__ volatile("mv a0, t1"); // Because of reason mentioned above we are restoring handle;
    800011c8:	00030513          	mv	a0,t1
    PCB* tmp;
    __asm__ volatile("mv %[tmp], a3" : [tmp] "=r" (tmp));
    800011cc:	00068793          	mv	a5,a3
    *handle = tmp;
    800011d0:	00f53023          	sd	a5,0(a0)
    if(*handle == nullptr) return -1;
    800011d4:	00078a63          	beqz	a5,800011e8 <_Z13thread_createPP3PCBPFvPvES2_+0x3c>
    return 0;
    800011d8:	00000513          	li	a0,0
}
    800011dc:	00813403          	ld	s0,8(sp)
    800011e0:	01010113          	addi	sp,sp,16
    800011e4:	00008067          	ret
    if(*handle == nullptr) return -1;
    800011e8:	fff00513          	li	a0,-1
    800011ec:	ff1ff06f          	j	800011dc <_Z13thread_createPP3PCBPFvPvES2_+0x30>

00000000800011f0 <_Z11thread_exitv>:

int thread_exit(){
    800011f0:	ff010113          	addi	sp,sp,-16
    800011f4:	00813423          	sd	s0,8(sp)
    800011f8:	01010413          	addi	s0,sp,16
    uint8 number = ksyscall::THREAD_EXIT;
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    800011fc:	00c00793          	li	a5,12
    80001200:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001204:	00000073          	ecall
    return 0;
}
    80001208:	00000513          	li	a0,0
    8000120c:	00813403          	ld	s0,8(sp)
    80001210:	01010113          	addi	sp,sp,16
    80001214:	00008067          	ret

0000000080001218 <_Z15thread_dispatchv>:

void thread_dispatch() {
    80001218:	ff010113          	addi	sp,sp,-16
    8000121c:	00813423          	sd	s0,8(sp)
    80001220:	01010413          	addi	s0,sp,16
    uint8 number = ksyscall::THREAD_DISPATCH;
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    80001224:	00d00793          	li	a5,13
    80001228:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    8000122c:	00000073          	ecall
}
    80001230:	00813403          	ld	s0,8(sp)
    80001234:	01010113          	addi	sp,sp,16
    80001238:	00008067          	ret

000000008000123c <_Z8sem_openPP3SEMj>:

int sem_open(sem_t* handle, unsigned init){
    8000123c:	ff010113          	addi	sp,sp,-16
    80001240:	00813423          	sd	s0,8(sp)
    80001244:	01010413          	addi	s0,sp,16
    uint8 number = ksyscall::SEM_OPEN;
    __asm__ volatile("mv t1, %[handle]" : : [handle] "r" (handle));
    80001248:	00050313          	mv	t1,a0
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    8000124c:	01500793          	li	a5,21
    80001250:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001254:	00000073          	ecall
    __asm__ volatile("mv a0, t1");
    80001258:	00030513          	mv	a0,t1
    SEM* tmp;
    __asm__ volatile("mv %[tmp], a3" : [tmp] "=r" (tmp));
    8000125c:	00068793          	mv	a5,a3
    *handle = tmp;
    80001260:	00f53023          	sd	a5,0(a0)
    if(handle == nullptr) return -1;
    80001264:	00050a63          	beqz	a0,80001278 <_Z8sem_openPP3SEMj+0x3c>
    return 0;
    80001268:	00000513          	li	a0,0
}
    8000126c:	00813403          	ld	s0,8(sp)
    80001270:	01010113          	addi	sp,sp,16
    80001274:	00008067          	ret
    if(handle == nullptr) return -1;
    80001278:	fff00513          	li	a0,-1
    8000127c:	ff1ff06f          	j	8000126c <_Z8sem_openPP3SEMj+0x30>

0000000080001280 <_Z9sem_closeP3SEM>:

int sem_close(sem_t handle){
    80001280:	ff010113          	addi	sp,sp,-16
    80001284:	00813423          	sd	s0,8(sp)
    80001288:	01010413          	addi	s0,sp,16
    if(handle == nullptr) return -1;
    8000128c:	02050463          	beqz	a0,800012b4 <_Z9sem_closeP3SEM+0x34>

    uint8 number = ksyscall::SEM_CLOSE;
    __asm__ volatile("mv a1, a0");
    80001290:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    80001294:	01600793          	li	a5,22
    80001298:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    8000129c:	00000073          	ecall
    int res;
    __asm__ volatile("mv %[res], a0" : [res] "=r" (res));
    800012a0:	00050513          	mv	a0,a0
    800012a4:	0005051b          	sext.w	a0,a0
    return res;
}
    800012a8:	00813403          	ld	s0,8(sp)
    800012ac:	01010113          	addi	sp,sp,16
    800012b0:	00008067          	ret
    if(handle == nullptr) return -1;
    800012b4:	fff00513          	li	a0,-1
    800012b8:	ff1ff06f          	j	800012a8 <_Z9sem_closeP3SEM+0x28>

00000000800012bc <_Z8sem_waitP3SEM>:

int sem_wait(sem_t id){
    800012bc:	ff010113          	addi	sp,sp,-16
    800012c0:	00813423          	sd	s0,8(sp)
    800012c4:	01010413          	addi	s0,sp,16
    if(id == nullptr) return -1;
    800012c8:	02050463          	beqz	a0,800012f0 <_Z8sem_waitP3SEM+0x34>
    uint8 number = ksyscall::SEM_WAIT;
    __asm__ volatile("mv a1, a0");
    800012cc:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    800012d0:	01700793          	li	a5,23
    800012d4:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    800012d8:	00000073          	ecall
    int res;
    __asm__ volatile("mv %[res], a0" : [res] "=r" (res));
    800012dc:	00050513          	mv	a0,a0
    800012e0:	0005051b          	sext.w	a0,a0
    return res;
}
    800012e4:	00813403          	ld	s0,8(sp)
    800012e8:	01010113          	addi	sp,sp,16
    800012ec:	00008067          	ret
    if(id == nullptr) return -1;
    800012f0:	fff00513          	li	a0,-1
    800012f4:	ff1ff06f          	j	800012e4 <_Z8sem_waitP3SEM+0x28>

00000000800012f8 <_Z10sem_signalP3SEM>:

int sem_signal(sem_t id){
    800012f8:	ff010113          	addi	sp,sp,-16
    800012fc:	00813423          	sd	s0,8(sp)
    80001300:	01010413          	addi	s0,sp,16
    if(id == nullptr) return -1;
    80001304:	02050463          	beqz	a0,8000132c <_Z10sem_signalP3SEM+0x34>
    uint8 number = ksyscall::SEM_SIGNAL;
    __asm__ volatile("mv a1, a0");
    80001308:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    8000130c:	01800793          	li	a5,24
    80001310:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001314:	00000073          	ecall
    int res;
    __asm__ volatile("mv %[res], a0" : [res] "=r" (res));
    80001318:	00050513          	mv	a0,a0
    8000131c:	0005051b          	sext.w	a0,a0
    return res;
}
    80001320:	00813403          	ld	s0,8(sp)
    80001324:	01010113          	addi	sp,sp,16
    80001328:	00008067          	ret
    if(id == nullptr) return -1;
    8000132c:	fff00513          	li	a0,-1
    80001330:	ff1ff06f          	j	80001320 <_Z10sem_signalP3SEM+0x28>

0000000080001334 <_Z10time_sleepm>:

int time_sleep(time_t){
    80001334:	ff010113          	addi	sp,sp,-16
    80001338:	00813423          	sd	s0,8(sp)
    8000133c:	01010413          	addi	s0,sp,16
    uint8 number = ksyscall::TIME_SLEEP;
    __asm__ volatile("mv a1, a0");
    80001340:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    80001344:	01f00793          	li	a5,31
    80001348:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    8000134c:	00000073          	ecall
    int res;
    __asm__ volatile("mv %[res], a0" : [res] "=r" (res));
    80001350:	00050793          	mv	a5,a0
    return 0;
}
    80001354:	00000513          	li	a0,0
    80001358:	00813403          	ld	s0,8(sp)
    8000135c:	01010113          	addi	sp,sp,16
    80001360:	00008067          	ret

0000000080001364 <_Z4getcv>:

char getc(){
    80001364:	ff010113          	addi	sp,sp,-16
    80001368:	00813423          	sd	s0,8(sp)
    8000136c:	01010413          	addi	s0,sp,16
    uint8 number = ksyscall::GETC;
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    80001370:	02900793          	li	a5,41
    80001374:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001378:	00000073          	ecall
    char res;
    __asm__ volatile("mv %[res], a0" : [res] "=r" (res));
    8000137c:	00050513          	mv	a0,a0
    return res;
}
    80001380:	0ff57513          	andi	a0,a0,255
    80001384:	00813403          	ld	s0,8(sp)
    80001388:	01010113          	addi	sp,sp,16
    8000138c:	00008067          	ret

0000000080001390 <_Z4putcc>:

void putc(char c){
    80001390:	ff010113          	addi	sp,sp,-16
    80001394:	00813423          	sd	s0,8(sp)
    80001398:	01010413          	addi	s0,sp,16
    uint8 number = ksyscall::PUTC;
    __asm__ volatile("mv a1, a0");
    8000139c:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    800013a0:	02a00793          	li	a5,42
    800013a4:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    800013a8:	00000073          	ecall
}
    800013ac:	00813403          	ld	s0,8(sp)
    800013b0:	01010113          	addi	sp,sp,16
    800013b4:	00008067          	ret

00000000800013b8 <_ZN10KernelSlab16kernel_slab_initEv>:
#include "../h/KernelSlab.hpp"

KernelSlab::caches *KernelSlab::head = 0;

void KernelSlab::kernel_slab_init() {
    800013b8:	ff010113          	addi	sp,sp,-16
    800013bc:	00813423          	sd	s0,8(sp)
    800013c0:	01010413          	addi	s0,sp,16
    head = 0;
    800013c4:	00009797          	auipc	a5,0x9
    800013c8:	c807be23          	sd	zero,-868(a5) # 8000a060 <_ZN10KernelSlab4headE>
}
    800013cc:	00813403          	ld	s0,8(sp)
    800013d0:	01010113          	addi	sp,sp,16
    800013d4:	00008067          	ret

00000000800013d8 <_ZN10KernelSlab8addCacheEP10kmem_cache>:

void KernelSlab::addCache(kmem_cache *elem) {
    800013d8:	fe010113          	addi	sp,sp,-32
    800013dc:	00113c23          	sd	ra,24(sp)
    800013e0:	00813823          	sd	s0,16(sp)
    800013e4:	00913423          	sd	s1,8(sp)
    800013e8:	02010413          	addi	s0,sp,32
    800013ec:	00050493          	mv	s1,a0
    caches *new_cache = (caches *)Buddy::buddy_allocate(sizeof(caches));
    800013f0:	01800513          	li	a0,24
    800013f4:	00000097          	auipc	ra,0x0
    800013f8:	774080e7          	jalr	1908(ra) # 80001b68 <_ZN5Buddy14buddy_allocateEm>
    new_cache->elem = elem;
    800013fc:	00953023          	sd	s1,0(a0)
    new_cache->next = 0;
    80001400:	00053423          	sd	zero,8(a0)
    new_cache->prev = 0;
    80001404:	00053823          	sd	zero,16(a0)
    if(head == 0){
    80001408:	00009797          	auipc	a5,0x9
    8000140c:	c587b783          	ld	a5,-936(a5) # 8000a060 <_ZN10KernelSlab4headE>
    80001410:	02078663          	beqz	a5,8000143c <_ZN10KernelSlab8addCacheEP10kmem_cache+0x64>
        head = new_cache;
    }else{
        caches *tmp = head;
        while(tmp->next != 0){
    80001414:	00078713          	mv	a4,a5
    80001418:	0087b783          	ld	a5,8(a5)
    8000141c:	fe079ce3          	bnez	a5,80001414 <_ZN10KernelSlab8addCacheEP10kmem_cache+0x3c>
            tmp = tmp->next;
        }
        tmp->next = new_cache;
    80001420:	00a73423          	sd	a0,8(a4)
        new_cache->prev = tmp;
    80001424:	00e53823          	sd	a4,16(a0)
    }
}
    80001428:	01813083          	ld	ra,24(sp)
    8000142c:	01013403          	ld	s0,16(sp)
    80001430:	00813483          	ld	s1,8(sp)
    80001434:	02010113          	addi	sp,sp,32
    80001438:	00008067          	ret
        head = new_cache;
    8000143c:	00009797          	auipc	a5,0x9
    80001440:	c2a7b223          	sd	a0,-988(a5) # 8000a060 <_ZN10KernelSlab4headE>
    80001444:	fe5ff06f          	j	80001428 <_ZN10KernelSlab8addCacheEP10kmem_cache+0x50>

0000000080001448 <_ZN10KernelSlab11deleteCacheEP10kmem_cache>:

int KernelSlab::deleteCache(kmem_cache *elem) {
    80001448:	ff010113          	addi	sp,sp,-16
    8000144c:	00813423          	sd	s0,8(sp)
    80001450:	01010413          	addi	s0,sp,16
    caches *tmp = head;
    80001454:	00009797          	auipc	a5,0x9
    80001458:	c0c7b783          	ld	a5,-1012(a5) # 8000a060 <_ZN10KernelSlab4headE>
    while(tmp->next != 0){
    8000145c:	00078713          	mv	a4,a5
    80001460:	0087b783          	ld	a5,8(a5)
    80001464:	00078a63          	beqz	a5,80001478 <_ZN10KernelSlab11deleteCacheEP10kmem_cache+0x30>
        if(tmp->elem == elem){
    80001468:	00073703          	ld	a4,0(a4)
    8000146c:	fea718e3          	bne	a4,a0,8000145c <_ZN10KernelSlab11deleteCacheEP10kmem_cache+0x14>
            //delete node
            return 0;
    80001470:	00000513          	li	a0,0
    80001474:	0080006f          	j	8000147c <_ZN10KernelSlab11deleteCacheEP10kmem_cache+0x34>
        }
        tmp = tmp->next;
    }
    return -1;
    80001478:	fff00513          	li	a0,-1
    8000147c:	00813403          	ld	s0,8(sp)
    80001480:	01010113          	addi	sp,sp,16
    80001484:	00008067          	ret

0000000080001488 <_ZN3PCB13threadWrapperEv>:
    running = Scheduler::get();

    PCB::contextSwitch(&old->context, &running->context);
}

void PCB::threadWrapper() {
    80001488:	fe010113          	addi	sp,sp,-32
    8000148c:	00113c23          	sd	ra,24(sp)
    80001490:	00813823          	sd	s0,16(sp)
    80001494:	00913423          	sd	s1,8(sp)
    80001498:	02010413          	addi	s0,sp,32
    Riscv::popSppSpie();
    8000149c:	00002097          	auipc	ra,0x2
    800014a0:	1a0080e7          	jalr	416(ra) # 8000363c <_ZN5Riscv10popSppSpieEv>
    running->body(running->args);
    800014a4:	00009497          	auipc	s1,0x9
    800014a8:	bc448493          	addi	s1,s1,-1084 # 8000a068 <_ZN3PCB7runningE>
    800014ac:	0004b783          	ld	a5,0(s1)
    800014b0:	0087b703          	ld	a4,8(a5)
    800014b4:	0107b503          	ld	a0,16(a5)
    800014b8:	000700e7          	jalr	a4
    running->setFinished(true);
    800014bc:	0004b703          	ld	a4,0(s1)

    static uint64 get_thread_counter() {return PCB::thread_counter;}

    bool isFinished() const { return finished; }

    void setFinished(bool value) {if(value){ thread_counter--; } finished = value;}
    800014c0:	0084b783          	ld	a5,8(s1)
    800014c4:	fff78793          	addi	a5,a5,-1
    800014c8:	00f4b423          	sd	a5,8(s1)
    800014cc:	00100793          	li	a5,1
    800014d0:	02f70c23          	sb	a5,56(a4)
    thread_dispatch();
    800014d4:	00000097          	auipc	ra,0x0
    800014d8:	d44080e7          	jalr	-700(ra) # 80001218 <_Z15thread_dispatchv>
}
    800014dc:	01813083          	ld	ra,24(sp)
    800014e0:	01013403          	ld	s0,16(sp)
    800014e4:	00813483          	ld	s1,8(sp)
    800014e8:	02010113          	addi	sp,sp,32
    800014ec:	00008067          	ret

00000000800014f0 <_ZN3PCB12createThreadEPFvPvES0_>:
PCB *PCB::createThread(Body body, void* args) {
    800014f0:	fd010113          	addi	sp,sp,-48
    800014f4:	02113423          	sd	ra,40(sp)
    800014f8:	02813023          	sd	s0,32(sp)
    800014fc:	00913c23          	sd	s1,24(sp)
    80001500:	01213823          	sd	s2,16(sp)
    80001504:	01313423          	sd	s3,8(sp)
    80001508:	03010413          	addi	s0,sp,48
    8000150c:	00050913          	mv	s2,a0
    80001510:	00058993          	mv	s3,a1
    PCB* ret = (PCB *)kmem_cache_alloc(cache);
    80001514:	00009517          	auipc	a0,0x9
    80001518:	b6453503          	ld	a0,-1180(a0) # 8000a078 <_ZN3PCB5cacheE>
    8000151c:	00004097          	auipc	ra,0x4
    80001520:	c00080e7          	jalr	-1024(ra) # 8000511c <_Z16kmem_cache_allocP10kmem_cache>
    80001524:	00050493          	mv	s1,a0
    if(ret == nullptr) return nullptr;
    80001528:	08050663          	beqz	a0,800015b4 <_ZN3PCB12createThreadEPFvPvES0_+0xc4>
    ret->body = body;
    8000152c:	01253423          	sd	s2,8(a0)
    ret->args = (ret->body != nullptr ? args : nullptr);
    80001530:	0a090263          	beqz	s2,800015d4 <_ZN3PCB12createThreadEPFvPvES0_+0xe4>
    80001534:	0134b823          	sd	s3,16(s1)
    ret->stack = (ret->body != nullptr ? (uint64 *)kmalloc(sizeof(uint64)*STACK_SIZE) : 0);
    80001538:	0a090263          	beqz	s2,800015dc <_ZN3PCB12createThreadEPFvPvES0_+0xec>
    8000153c:	00008537          	lui	a0,0x8
    80001540:	00004097          	auipc	ra,0x4
    80001544:	b8c080e7          	jalr	-1140(ra) # 800050cc <_Z7kmallocm>
    80001548:	00050913          	mv	s2,a0
    8000154c:	0124bc23          	sd	s2,24(s1)
    if(!ret->stack && ret->body != nullptr) {
    80001550:	08090a63          	beqz	s2,800015e4 <_ZN3PCB12createThreadEPFvPvES0_+0xf4>
             ret->stack != 0 ? (uint64) &ret->stack[STACK_SIZE-1] : 0
    80001554:	0a090a63          	beqz	s2,80001608 <_ZN3PCB12createThreadEPFvPvES0_+0x118>
    80001558:	00008537          	lui	a0,0x8
    8000155c:	ff850513          	addi	a0,a0,-8 # 7ff8 <_entry-0x7fff8008>
    80001560:	00a90933          	add	s2,s2,a0
    ret->context = {(uint64) &threadWrapper,
    80001564:	00000797          	auipc	a5,0x0
    80001568:	f2478793          	addi	a5,a5,-220 # 80001488 <_ZN3PCB13threadWrapperEv>
    8000156c:	02f4b023          	sd	a5,32(s1)
    80001570:	0324b423          	sd	s2,40(s1)
    ret->timeSlice = TIME_SLICE;
    80001574:	00200793          	li	a5,2
    80001578:	02f4b823          	sd	a5,48(s1)
    ret->finished = false;
    8000157c:	02048c23          	sb	zero,56(s1)
    if(ret->body != 0) {
    80001580:	0084b783          	ld	a5,8(s1)
    80001584:	00078e63          	beqz	a5,800015a0 <_ZN3PCB12createThreadEPFvPvES0_+0xb0>
        if(Scheduler::put(ret) == -1){
    80001588:	00048513          	mv	a0,s1
    8000158c:	00003097          	auipc	ra,0x3
    80001590:	8b8080e7          	jalr	-1864(ra) # 80003e44 <_ZN9Scheduler3putEP3PCB>
    80001594:	fff00793          	li	a5,-1
    80001598:	06f50c63          	beq	a0,a5,80001610 <_ZN3PCB12createThreadEPFvPvES0_+0x120>
        ret->status = READY;
    8000159c:	0004a023          	sw	zero,0(s1)
    thread_counter++;
    800015a0:	00009717          	auipc	a4,0x9
    800015a4:	ac870713          	addi	a4,a4,-1336 # 8000a068 <_ZN3PCB7runningE>
    800015a8:	00873783          	ld	a5,8(a4)
    800015ac:	00178793          	addi	a5,a5,1
    800015b0:	00f73423          	sd	a5,8(a4)
}
    800015b4:	00048513          	mv	a0,s1
    800015b8:	02813083          	ld	ra,40(sp)
    800015bc:	02013403          	ld	s0,32(sp)
    800015c0:	01813483          	ld	s1,24(sp)
    800015c4:	01013903          	ld	s2,16(sp)
    800015c8:	00813983          	ld	s3,8(sp)
    800015cc:	03010113          	addi	sp,sp,48
    800015d0:	00008067          	ret
    ret->args = (ret->body != nullptr ? args : nullptr);
    800015d4:	00000993          	li	s3,0
    800015d8:	f5dff06f          	j	80001534 <_ZN3PCB12createThreadEPFvPvES0_+0x44>
    ret->stack = (ret->body != nullptr ? (uint64 *)kmalloc(sizeof(uint64)*STACK_SIZE) : 0);
    800015dc:	00000913          	li	s2,0
    800015e0:	f6dff06f          	j	8000154c <_ZN3PCB12createThreadEPFvPvES0_+0x5c>
    if(!ret->stack && ret->body != nullptr) {
    800015e4:	0084b783          	ld	a5,8(s1)
    800015e8:	f60786e3          	beqz	a5,80001554 <_ZN3PCB12createThreadEPFvPvES0_+0x64>
        kmem_cache_free(cache, (void *)ret);
    800015ec:	00048593          	mv	a1,s1
    800015f0:	00009517          	auipc	a0,0x9
    800015f4:	a8853503          	ld	a0,-1400(a0) # 8000a078 <_ZN3PCB5cacheE>
    800015f8:	00004097          	auipc	ra,0x4
    800015fc:	b4c080e7          	jalr	-1204(ra) # 80005144 <_Z15kmem_cache_freeP10kmem_cachePv>
        return nullptr;
    80001600:	00090493          	mv	s1,s2
    80001604:	fb1ff06f          	j	800015b4 <_ZN3PCB12createThreadEPFvPvES0_+0xc4>
             ret->stack != 0 ? (uint64) &ret->stack[STACK_SIZE-1] : 0
    80001608:	00000913          	li	s2,0
    8000160c:	f59ff06f          	j	80001564 <_ZN3PCB12createThreadEPFvPvES0_+0x74>
            kfree((void *)ret->stack);
    80001610:	0184b503          	ld	a0,24(s1)
    80001614:	00004097          	auipc	ra,0x4
    80001618:	ae0080e7          	jalr	-1312(ra) # 800050f4 <_Z5kfreePKv>
            kmem_cache_free(cache, (void *)ret);
    8000161c:	00048593          	mv	a1,s1
    80001620:	00009517          	auipc	a0,0x9
    80001624:	a5853503          	ld	a0,-1448(a0) # 8000a078 <_ZN3PCB5cacheE>
    80001628:	00004097          	auipc	ra,0x4
    8000162c:	b1c080e7          	jalr	-1252(ra) # 80005144 <_Z15kmem_cache_freeP10kmem_cachePv>
            return nullptr;
    80001630:	00000493          	li	s1,0
    80001634:	f81ff06f          	j	800015b4 <_ZN3PCB12createThreadEPFvPvES0_+0xc4>

0000000080001638 <_ZN3PCB8dispatchEv>:
void PCB::dispatch() {
    80001638:	fe010113          	addi	sp,sp,-32
    8000163c:	00113c23          	sd	ra,24(sp)
    80001640:	00813823          	sd	s0,16(sp)
    80001644:	00913423          	sd	s1,8(sp)
    80001648:	02010413          	addi	s0,sp,32
    PCB *old = running;
    8000164c:	00009497          	auipc	s1,0x9
    80001650:	a1c4b483          	ld	s1,-1508(s1) # 8000a068 <_ZN3PCB7runningE>
    bool isFinished() const { return finished; }
    80001654:	0384c783          	lbu	a5,56(s1)
    if(!old->isFinished() && old->status != ThreadStatus::BLOCKED) { Scheduler::put(old);}
    80001658:	00079863          	bnez	a5,80001668 <_ZN3PCB8dispatchEv+0x30>
    8000165c:	0004a703          	lw	a4,0(s1)
    80001660:	00100793          	li	a5,1
    80001664:	02f71c63          	bne	a4,a5,8000169c <_ZN3PCB8dispatchEv+0x64>
    running = Scheduler::get();
    80001668:	00002097          	auipc	ra,0x2
    8000166c:	7ac080e7          	jalr	1964(ra) # 80003e14 <_ZN9Scheduler3getEv>
    80001670:	00009797          	auipc	a5,0x9
    80001674:	9ea7bc23          	sd	a0,-1544(a5) # 8000a068 <_ZN3PCB7runningE>
    PCB::contextSwitch(&old->context, &running->context);
    80001678:	02050593          	addi	a1,a0,32
    8000167c:	02048513          	addi	a0,s1,32
    80001680:	00000097          	auipc	ra,0x0
    80001684:	ab0080e7          	jalr	-1360(ra) # 80001130 <_ZN3PCB13contextSwitchEPNS_7ContextES1_>
}
    80001688:	01813083          	ld	ra,24(sp)
    8000168c:	01013403          	ld	s0,16(sp)
    80001690:	00813483          	ld	s1,8(sp)
    80001694:	02010113          	addi	sp,sp,32
    80001698:	00008067          	ret
    if(!old->isFinished() && old->status != ThreadStatus::BLOCKED) { Scheduler::put(old);}
    8000169c:	00048513          	mv	a0,s1
    800016a0:	00002097          	auipc	ra,0x2
    800016a4:	7a4080e7          	jalr	1956(ra) # 80003e44 <_ZN9Scheduler3putEP3PCB>
    800016a8:	fc1ff06f          	j	80001668 <_ZN3PCB8dispatchEv+0x30>

00000000800016ac <_ZN3PCB10exitThreadEv>:
void PCB::exitThread() {
    800016ac:	ff010113          	addi	sp,sp,-16
    800016b0:	00113423          	sd	ra,8(sp)
    800016b4:	00813023          	sd	s0,0(sp)
    800016b8:	01010413          	addi	s0,sp,16
    running->setFinished(true);
    800016bc:	00009797          	auipc	a5,0x9
    800016c0:	9ac78793          	addi	a5,a5,-1620 # 8000a068 <_ZN3PCB7runningE>
    800016c4:	0007b683          	ld	a3,0(a5)
    void setFinished(bool value) {if(value){ thread_counter--; } finished = value;}
    800016c8:	0087b703          	ld	a4,8(a5)
    800016cc:	fff70713          	addi	a4,a4,-1
    800016d0:	00e7b423          	sd	a4,8(a5)
    800016d4:	00100793          	li	a5,1
    800016d8:	02f68c23          	sb	a5,56(a3)
    dispatch();
    800016dc:	00000097          	auipc	ra,0x0
    800016e0:	f5c080e7          	jalr	-164(ra) # 80001638 <_ZN3PCB8dispatchEv>
}
    800016e4:	00813083          	ld	ra,8(sp)
    800016e8:	00013403          	ld	s0,0(sp)
    800016ec:	01010113          	addi	sp,sp,16
    800016f0:	00008067          	ret

00000000800016f4 <_ZN3PCB11addToSleepQEm>:

int PCB::addToSleepQ(time_t time){
    800016f4:	fe010113          	addi	sp,sp,-32
    800016f8:	00113c23          	sd	ra,24(sp)
    800016fc:	00813823          	sd	s0,16(sp)
    80001700:	00913423          	sd	s1,8(sp)
    80001704:	02010413          	addi	s0,sp,32
    80001708:	00050593          	mv	a1,a0
    SleepQ::put(running, time);
    8000170c:	00009497          	auipc	s1,0x9
    80001710:	95c48493          	addi	s1,s1,-1700 # 8000a068 <_ZN3PCB7runningE>
    80001714:	0004b503          	ld	a0,0(s1)
    80001718:	00002097          	auipc	ra,0x2
    8000171c:	540080e7          	jalr	1344(ra) # 80003c58 <_ZN6SleepQ3putEP3PCBm>
    running->status = ThreadStatus::BLOCKED;
    80001720:	0004b783          	ld	a5,0(s1)
    80001724:	00100713          	li	a4,1
    80001728:	00e7a023          	sw	a4,0(a5)
    dispatch();
    8000172c:	00000097          	auipc	ra,0x0
    80001730:	f0c080e7          	jalr	-244(ra) # 80001638 <_ZN3PCB8dispatchEv>
    return 0;
}
    80001734:	00000513          	li	a0,0
    80001738:	01813083          	ld	ra,24(sp)
    8000173c:	01013403          	ld	s0,16(sp)
    80001740:	00813483          	ld	s1,8(sp)
    80001744:	02010113          	addi	sp,sp,32
    80001748:	00008067          	ret

000000008000174c <_ZN3PCB8wakingUpEv>:

void PCB::wakingUp() {
    8000174c:	ff010113          	addi	sp,sp,-16
    80001750:	00113423          	sd	ra,8(sp)
    80001754:	00813023          	sd	s0,0(sp)
    80001758:	01010413          	addi	s0,sp,16
    SleepQ::update();
    8000175c:	00002097          	auipc	ra,0x2
    80001760:	684080e7          	jalr	1668(ra) # 80003de0 <_ZN6SleepQ6updateEv>
    if(SleepQ::head != nullptr){
    80001764:	00009797          	auipc	a5,0x9
    80001768:	8747b783          	ld	a5,-1932(a5) # 80009fd8 <_GLOBAL_OFFSET_TABLE_+0xa8>
    8000176c:	0007b783          	ld	a5,0(a5)
    80001770:	00078663          	beqz	a5,8000177c <_ZN3PCB8wakingUpEv+0x30>
        if(SleepQ::head->rang <= 0) {
    80001774:	0087b783          	ld	a5,8(a5)
    80001778:	00078a63          	beqz	a5,8000178c <_ZN3PCB8wakingUpEv+0x40>
            PCB *tmp = SleepQ::get();
            tmp->status = ThreadStatus::READY;
            Scheduler::put(tmp);
        }
    }
}
    8000177c:	00813083          	ld	ra,8(sp)
    80001780:	00013403          	ld	s0,0(sp)
    80001784:	01010113          	addi	sp,sp,16
    80001788:	00008067          	ret
            PCB *tmp = SleepQ::get();
    8000178c:	00002097          	auipc	ra,0x2
    80001790:	5e4080e7          	jalr	1508(ra) # 80003d70 <_ZN6SleepQ3getEv>
            tmp->status = ThreadStatus::READY;
    80001794:	00052023          	sw	zero,0(a0)
            Scheduler::put(tmp);
    80001798:	00002097          	auipc	ra,0x2
    8000179c:	6ac080e7          	jalr	1708(ra) # 80003e44 <_ZN9Scheduler3putEP3PCB>
}
    800017a0:	fddff06f          	j	8000177c <_ZN3PCB8wakingUpEv+0x30>

00000000800017a4 <_ZN3PCB4dtorEPS_>:

void PCB::dtor(PCB *pcb) {
    if(pcb->stack) kfree((void *)pcb->stack);
    800017a4:	01853503          	ld	a0,24(a0)
    800017a8:	02050663          	beqz	a0,800017d4 <_ZN3PCB4dtorEPS_+0x30>
void PCB::dtor(PCB *pcb) {
    800017ac:	ff010113          	addi	sp,sp,-16
    800017b0:	00113423          	sd	ra,8(sp)
    800017b4:	00813023          	sd	s0,0(sp)
    800017b8:	01010413          	addi	s0,sp,16
    if(pcb->stack) kfree((void *)pcb->stack);
    800017bc:	00004097          	auipc	ra,0x4
    800017c0:	938080e7          	jalr	-1736(ra) # 800050f4 <_Z5kfreePKv>
}
    800017c4:	00813083          	ld	ra,8(sp)
    800017c8:	00013403          	ld	s0,0(sp)
    800017cc:	01010113          	addi	sp,sp,16
    800017d0:	00008067          	ret
    800017d4:	00008067          	ret

00000000800017d8 <_ZN5Buddy11clearMemoryEPvm>:
void *Buddy::START = 0;
void *Buddy::END = 0;
uint64 Buddy::highestN = 0;
uint64 Buddy::minN = 0;

void Buddy::clearMemory(void *address, size_t size){
    800017d8:	ff010113          	addi	sp,sp,-16
    800017dc:	00813423          	sd	s0,8(sp)
    800017e0:	01010413          	addi	s0,sp,16
    for(size_t ind = 0; ind < size; ind++){
    800017e4:	00000793          	li	a5,0
    800017e8:	00b7fa63          	bgeu	a5,a1,800017fc <_ZN5Buddy11clearMemoryEPvm+0x24>
        uint8 *memory = (uint8 *)((size_t)address + ind);
    800017ec:	00f50733          	add	a4,a0,a5
        *memory = 0;
    800017f0:	00070023          	sb	zero,0(a4)
    for(size_t ind = 0; ind < size; ind++){
    800017f4:	00178793          	addi	a5,a5,1
    800017f8:	ff1ff06f          	j	800017e8 <_ZN5Buddy11clearMemoryEPvm+0x10>
    }
}
    800017fc:	00813403          	ld	s0,8(sp)
    80001800:	01010113          	addi	sp,sp,16
    80001804:	00008067          	ret

0000000080001808 <_ZN5Buddy15free_block_initEPNS_16buddy_free_blockEPNS_17buddy_free_levelsEm>:

void Buddy::free_block_init(buddy_free_block *block, buddy_free_levels *level, uint64 position) { // Arguments maybe need two pointers -CHECK
    80001808:	ff010113          	addi	sp,sp,-16
    8000180c:	00813423          	sd	s0,8(sp)
    80001810:	01010413          	addi	s0,sp,16
    block->position = position;
    80001814:	00c53423          	sd	a2,8(a0)
    buddy_free_block *current;
    if(level->first == 0 || level->first->position >= position){
    80001818:	0005b783          	ld	a5,0(a1)
    8000181c:	00078663          	beqz	a5,80001828 <_ZN5Buddy15free_block_initEPNS_16buddy_free_blockEPNS_17buddy_free_levelsEm+0x20>
    80001820:	0087b703          	ld	a4,8(a5)
    80001824:	00c76c63          	bltu	a4,a2,8000183c <_ZN5Buddy15free_block_initEPNS_16buddy_free_blockEPNS_17buddy_free_levelsEm+0x34>
        block->next = level->first;
    80001828:	00f53023          	sd	a5,0(a0)
        level->first = block;
    8000182c:	00a5b023          	sd	a0,0(a1)
            current = current->next;
        }
        block->next = current->next;
        current->next = block;
    }
}
    80001830:	00813403          	ld	s0,8(sp)
    80001834:	01010113          	addi	sp,sp,16
    80001838:	00008067          	ret
        while(current->next != 0 && current->next->position < position){
    8000183c:	00078693          	mv	a3,a5
    80001840:	0007b783          	ld	a5,0(a5)
    80001844:	00078663          	beqz	a5,80001850 <_ZN5Buddy15free_block_initEPNS_16buddy_free_blockEPNS_17buddy_free_levelsEm+0x48>
    80001848:	0087b703          	ld	a4,8(a5)
    8000184c:	fec768e3          	bltu	a4,a2,8000183c <_ZN5Buddy15free_block_initEPNS_16buddy_free_blockEPNS_17buddy_free_levelsEm+0x34>
        block->next = current->next;
    80001850:	00f53023          	sd	a5,0(a0)
        current->next = block;
    80001854:	00a6b023          	sd	a0,0(a3)
}
    80001858:	fd9ff06f          	j	80001830 <_ZN5Buddy15free_block_initEPNS_16buddy_free_blockEPNS_17buddy_free_levelsEm+0x28>

000000008000185c <_ZN5Buddy21check_size_validationEm>:

int Buddy::check_size_validation(uint64 n) {
    8000185c:	ff010113          	addi	sp,sp,-16
    80001860:	00813423          	sd	s0,8(sp)
    80001864:	01010413          	addi	s0,sp,16
    if(n > highestN) return 0;
    80001868:	00009797          	auipc	a5,0x9
    8000186c:	8387b783          	ld	a5,-1992(a5) # 8000a0a0 <_ZN5Buddy8highestNE>
    80001870:	00a7ea63          	bltu	a5,a0,80001884 <_ZN5Buddy21check_size_validationEm+0x28>
    return 1;
    80001874:	00100513          	li	a0,1
}
    80001878:	00813403          	ld	s0,8(sp)
    8000187c:	01010113          	addi	sp,sp,16
    80001880:	00008067          	ret
    if(n > highestN) return 0;
    80001884:	00000513          	li	a0,0
    80001888:	ff1ff06f          	j	80001878 <_ZN5Buddy21check_size_validationEm+0x1c>

000000008000188c <_ZN5Buddy19calculate_real_sizeEm>:

uint64 Buddy::calculate_real_size(size_t size) {
    8000188c:	ff010113          	addi	sp,sp,-16
    80001890:	00813423          	sd	s0,8(sp)
    80001894:	01010413          	addi	s0,sp,16
    return ((size/BLOCK_SIZE)*BLOCK_SIZE + BLOCK_SIZE);
    80001898:	fffff7b7          	lui	a5,0xfffff
    8000189c:	00f57533          	and	a0,a0,a5
}
    800018a0:	000017b7          	lui	a5,0x1
    800018a4:	00f50533          	add	a0,a0,a5
    800018a8:	00813403          	ld	s0,8(sp)
    800018ac:	01010113          	addi	sp,sp,16
    800018b0:	00008067          	ret

00000000800018b4 <_ZN5Buddy18calculate_exponentEm>:

uint64 Buddy::calculate_exponent(uint64 size) {
    800018b4:	ff010113          	addi	sp,sp,-16
    800018b8:	00813423          	sd	s0,8(sp)
    800018bc:	01010413          	addi	s0,sp,16
    800018c0:	00050713          	mv	a4,a0
    uint64 res = 0;
    for(uint64 i = 1; ; i++){
    800018c4:	00100513          	li	a0,1
        res = i;
        if((uint64)1<<i >= size) break;
    800018c8:	00100793          	li	a5,1
    800018cc:	00a797b3          	sll	a5,a5,a0
    800018d0:	00e7f663          	bgeu	a5,a4,800018dc <_ZN5Buddy18calculate_exponentEm+0x28>
    for(uint64 i = 1; ; i++){
    800018d4:	00150513          	addi	a0,a0,1
        res = i;
    800018d8:	ff1ff06f          	j	800018c8 <_ZN5Buddy18calculate_exponentEm+0x14>
    }
    return res;
}
    800018dc:	00813403          	ld	s0,8(sp)
    800018e0:	01010113          	addi	sp,sp,16
    800018e4:	00008067          	ret

00000000800018e8 <_ZN5Buddy13init_highestNEv>:

uint64 Buddy::init_highestN() {
    800018e8:	ff010113          	addi	sp,sp,-16
    800018ec:	00813423          	sd	s0,8(sp)
    800018f0:	01010413          	addi	s0,sp,16
    uint64 prev = 0;
    size_t kernelSize = (size_t)((uint64)END - (uint64)START);
    800018f4:	00008797          	auipc	a5,0x8
    800018f8:	7ac78793          	addi	a5,a5,1964 # 8000a0a0 <_ZN5Buddy8highestNE>
    800018fc:	0087b683          	ld	a3,8(a5)
    80001900:	0107b783          	ld	a5,16(a5)
    80001904:	40f686b3          	sub	a3,a3,a5
    for(uint64 i = 1; ; i++){
    80001908:	00100713          	li	a4,1
    uint64 prev = 0;
    8000190c:	00000513          	li	a0,0
        if((size_t)1<<i >= kernelSize) break;
    80001910:	00100793          	li	a5,1
    80001914:	00e797b3          	sll	a5,a5,a4
    80001918:	00d7f863          	bgeu	a5,a3,80001928 <_ZN5Buddy13init_highestNEv+0x40>
        prev = i;
    8000191c:	00070513          	mv	a0,a4
    for(uint64 i = 1; ; i++){
    80001920:	00170713          	addi	a4,a4,1
        if((size_t)1<<i >= kernelSize) break;
    80001924:	fedff06f          	j	80001910 <_ZN5Buddy13init_highestNEv+0x28>
    }
    return prev;
}
    80001928:	00813403          	ld	s0,8(sp)
    8000192c:	01010113          	addi	sp,sp,16
    80001930:	00008067          	ret

0000000080001934 <_ZN5Buddy10buddy_initEPvS0_>:

int Buddy::buddy_init(void *start_adr, void *end_adr) {
    80001934:	fe010113          	addi	sp,sp,-32
    80001938:	00113c23          	sd	ra,24(sp)
    8000193c:	00813823          	sd	s0,16(sp)
    80001940:	00913423          	sd	s1,8(sp)
    80001944:	01213023          	sd	s2,0(sp)
    80001948:	02010413          	addi	s0,sp,32
    8000194c:	00050913          	mv	s2,a0
    head = nullptr;
    80001950:	00008497          	auipc	s1,0x8
    80001954:	75048493          	addi	s1,s1,1872 # 8000a0a0 <_ZN5Buddy8highestNE>
    80001958:	0004bc23          	sd	zero,24(s1)
    START = start_adr;
    8000195c:	00a4b823          	sd	a0,16(s1)
    END = end_adr;
    80001960:	00b4b423          	sd	a1,8(s1)
    highestN = init_highestN();
    80001964:	00000097          	auipc	ra,0x0
    80001968:	f84080e7          	jalr	-124(ra) # 800018e8 <_ZN5Buddy13init_highestNEv>
    8000196c:	00a4b023          	sd	a0,0(s1)

    minN = 5; // HARD_CODE - SHOULD BE CHANGED IN FUTURE
    80001970:	00500793          	li	a5,5
    80001974:	02f4b023          	sd	a5,32(s1)

    //allocate first buddy_free_level and first buddy_free_block and change START address
    head = (buddy_free_levels *)START;
    80001978:	0124bc23          	sd	s2,24(s1)
    head->first = nullptr;
    8000197c:	00093023          	sd	zero,0(s2)
    head->level = highestN;
    80001980:	0184b683          	ld	a3,24(s1)
    80001984:	0004b783          	ld	a5,0(s1)
    80001988:	00f6b423          	sd	a5,8(a3)
    START = (void *)( (uint64)START + (highestN - minN + 1)*sizeof(buddy_free_levels));
    8000198c:	0204b703          	ld	a4,32(s1)
    80001990:	40e787b3          	sub	a5,a5,a4
    80001994:	00178793          	addi	a5,a5,1
    80001998:	00579793          	slli	a5,a5,0x5
    8000199c:	0104b703          	ld	a4,16(s1)
    800019a0:	00f707b3          	add	a5,a4,a5
    800019a4:	00f4b823          	sd	a5,16(s1)
    head->prev = nullptr;
    800019a8:	0006bc23          	sd	zero,24(a3)
    //allocate rest of the levels
    for(uint64 i = 1; i < highestN - minN + 1; i++){
    800019ac:	00100693          	li	a3,1
    800019b0:	00008797          	auipc	a5,0x8
    800019b4:	6f078793          	addi	a5,a5,1776 # 8000a0a0 <_ZN5Buddy8highestNE>
    800019b8:	0007b703          	ld	a4,0(a5)
    800019bc:	0207b603          	ld	a2,32(a5)
    800019c0:	40c707b3          	sub	a5,a4,a2
    800019c4:	00178593          	addi	a1,a5,1
    800019c8:	04b6f463          	bgeu	a3,a1,80001a10 <_ZN5Buddy10buddy_initEPvS0_+0xdc>
        head[i].first = nullptr;
    800019cc:	00569713          	slli	a4,a3,0x5
    800019d0:	00008597          	auipc	a1,0x8
    800019d4:	6d058593          	addi	a1,a1,1744 # 8000a0a0 <_ZN5Buddy8highestNE>
    800019d8:	0185b783          	ld	a5,24(a1)
    800019dc:	00e787b3          	add	a5,a5,a4
    800019e0:	0007b023          	sd	zero,0(a5)
        head[i].level = highestN - i;
    800019e4:	0185b783          	ld	a5,24(a1)
    800019e8:	00e78633          	add	a2,a5,a4
    800019ec:	0005b583          	ld	a1,0(a1)
    800019f0:	40d585b3          	sub	a1,a1,a3
    800019f4:	00b63423          	sd	a1,8(a2)
        head[i-1].next = &head[i];
    800019f8:	fe070713          	addi	a4,a4,-32
    800019fc:	00e787b3          	add	a5,a5,a4
    80001a00:	00c7b823          	sd	a2,16(a5)
        head[i].prev = &head[i-1];
    80001a04:	00f63c23          	sd	a5,24(a2)
    for(uint64 i = 1; i < highestN - minN + 1; i++){
    80001a08:	00168693          	addi	a3,a3,1
    80001a0c:	fa5ff06f          	j	800019b0 <_ZN5Buddy10buddy_initEPvS0_+0x7c>
    }
    head[highestN-minN].next = nullptr;
    80001a10:	00008697          	auipc	a3,0x8
    80001a14:	69068693          	addi	a3,a3,1680 # 8000a0a0 <_ZN5Buddy8highestNE>
    80001a18:	00579793          	slli	a5,a5,0x5
    80001a1c:	0186b583          	ld	a1,24(a3)
    80001a20:	00f587b3          	add	a5,a1,a5
    80001a24:	0007b823          	sd	zero,16(a5)


    //allocate array of allocated blocks
    uint64 numberOfElements = 1<<(highestN - minN);
    80001a28:	40c7073b          	subw	a4,a4,a2
    80001a2c:	00100593          	li	a1,1
    80001a30:	00e595bb          	sllw	a1,a1,a4
    allocatedHead = (buddy_allocated_blocks *)START;
    80001a34:	0106b703          	ld	a4,16(a3)
    80001a38:	02e6b423          	sd	a4,40(a3)
    START = (void *)((uint64)START + (numberOfElements + 1) * sizeof(buddy_allocated_blocks));
    80001a3c:	00158793          	addi	a5,a1,1
    80001a40:	00479793          	slli	a5,a5,0x4
    80001a44:	00f707b3          	add	a5,a4,a5
    80001a48:	00f6b823          	sd	a5,16(a3)
    allocatedHead->size = 0;
    80001a4c:	00072023          	sw	zero,0(a4)
    allocatedHead->address = 0;
    80001a50:	0286b783          	ld	a5,40(a3)
    80001a54:	0007b423          	sd	zero,8(a5)
    for(uint64 i = 1; i < numberOfElements; i++){
    80001a58:	00100793          	li	a5,1
    80001a5c:	02b7f863          	bgeu	a5,a1,80001a8c <_ZN5Buddy10buddy_initEPvS0_+0x158>
        allocatedHead[i].size = 0;
    80001a60:	00479613          	slli	a2,a5,0x4
    80001a64:	00008717          	auipc	a4,0x8
    80001a68:	63c70713          	addi	a4,a4,1596 # 8000a0a0 <_ZN5Buddy8highestNE>
    80001a6c:	02873683          	ld	a3,40(a4)
    80001a70:	00c686b3          	add	a3,a3,a2
    80001a74:	0006a023          	sw	zero,0(a3)
        allocatedHead[i].address = 0;
    80001a78:	02873703          	ld	a4,40(a4)
    80001a7c:	00c70733          	add	a4,a4,a2
    80001a80:	00073423          	sd	zero,8(a4)
    for(uint64 i = 1; i < numberOfElements; i++){
    80001a84:	00178793          	addi	a5,a5,1
    80001a88:	fd5ff06f          	j	80001a5c <_ZN5Buddy10buddy_initEPvS0_+0x128>
    }

    head->first = (buddy_free_block *)((uint64)START);
    80001a8c:	00008797          	auipc	a5,0x8
    80001a90:	61478793          	addi	a5,a5,1556 # 8000a0a0 <_ZN5Buddy8highestNE>
    80001a94:	0187b703          	ld	a4,24(a5)
    80001a98:	0107b683          	ld	a3,16(a5)
    80001a9c:	00d73023          	sd	a3,0(a4)
    head->first->next = nullptr;
    80001aa0:	0187b703          	ld	a4,24(a5)
    80001aa4:	00073703          	ld	a4,0(a4)
    80001aa8:	00073023          	sd	zero,0(a4)
    head->first->position = 1;
    80001aac:	0187b783          	ld	a5,24(a5)
    80001ab0:	0007b783          	ld	a5,0(a5)
    80001ab4:	00100713          	li	a4,1
    80001ab8:	00e7b423          	sd	a4,8(a5)
    return 0;
}
    80001abc:	00000513          	li	a0,0
    80001ac0:	01813083          	ld	ra,24(sp)
    80001ac4:	01013403          	ld	s0,16(sp)
    80001ac8:	00813483          	ld	s1,8(sp)
    80001acc:	00013903          	ld	s2,0(sp)
    80001ad0:	02010113          	addi	sp,sp,32
    80001ad4:	00008067          	ret

0000000080001ad8 <_ZN5Buddy11findBlockAtEPNS_17buddy_free_levelsEm>:

Buddy::buddy_free_block* Buddy::findBlockAt(Buddy::buddy_free_levels *level,uint64 pos){
    80001ad8:	ff010113          	addi	sp,sp,-16
    80001adc:	00813423          	sd	s0,8(sp)
    80001ae0:	01010413          	addi	s0,sp,16
    buddy_free_block *curr = level->first;
    80001ae4:	00053503          	ld	a0,0(a0)
    while(curr != 0){
    80001ae8:	00050a63          	beqz	a0,80001afc <_ZN5Buddy11findBlockAtEPNS_17buddy_free_levelsEm+0x24>
        if(curr->position == pos) return curr;
    80001aec:	00853783          	ld	a5,8(a0)
    80001af0:	00b78663          	beq	a5,a1,80001afc <_ZN5Buddy11findBlockAtEPNS_17buddy_free_levelsEm+0x24>
        curr = curr->next;
    80001af4:	00053503          	ld	a0,0(a0)
    while(curr != 0){
    80001af8:	ff1ff06f          	j	80001ae8 <_ZN5Buddy11findBlockAtEPNS_17buddy_free_levelsEm+0x10>
    }
    return 0;
}
    80001afc:	00813403          	ld	s0,8(sp)
    80001b00:	01010113          	addi	sp,sp,16
    80001b04:	00008067          	ret

0000000080001b08 <_ZN5Buddy11deleteBlockEPNS_17buddy_free_levelsEm>:

void Buddy::deleteBlock(buddy_free_levels *level, uint64 pos) {
    80001b08:	ff010113          	addi	sp,sp,-16
    80001b0c:	00813423          	sd	s0,8(sp)
    80001b10:	01010413          	addi	s0,sp,16
    buddy_free_block *tmp;
    buddy_free_block *prev;
    tmp = level->first;
    80001b14:	00053603          	ld	a2,0(a0)
    prev = level->first;
    80001b18:	00060693          	mv	a3,a2
    tmp = level->first;
    80001b1c:	00060793          	mv	a5,a2
    while (tmp->position != pos) {
    80001b20:	0087b703          	ld	a4,8(a5)
    80001b24:	00b70863          	beq	a4,a1,80001b34 <_ZN5Buddy11deleteBlockEPNS_17buddy_free_levelsEm+0x2c>
        prev = tmp;
    80001b28:	00078693          	mv	a3,a5
        tmp = tmp->next;
    80001b2c:	0007b783          	ld	a5,0(a5)
    while (tmp->position != pos) {
    80001b30:	ff1ff06f          	j	80001b20 <_ZN5Buddy11deleteBlockEPNS_17buddy_free_levelsEm+0x18>
    }
    //if (tmp == 0) return; always null

    if (tmp == level->first) {
    80001b34:	02c78063          	beq	a5,a2,80001b54 <_ZN5Buddy11deleteBlockEPNS_17buddy_free_levelsEm+0x4c>
        level->first = level->first->next;
        d->position = 0;
        d->next = 0;
    } else {
        buddy_free_block *d = tmp;
        prev->next = tmp->next;
    80001b38:	0007b703          	ld	a4,0(a5)
    80001b3c:	00e6b023          	sd	a4,0(a3)
        d->next = 0;
    80001b40:	0007b023          	sd	zero,0(a5)
        d->position = 0;
    80001b44:	0007b423          	sd	zero,8(a5)
    }
}
    80001b48:	00813403          	ld	s0,8(sp)
    80001b4c:	01010113          	addi	sp,sp,16
    80001b50:	00008067          	ret
        level->first = level->first->next;
    80001b54:	00063783          	ld	a5,0(a2)
    80001b58:	00f53023          	sd	a5,0(a0)
        d->position = 0;
    80001b5c:	00063423          	sd	zero,8(a2)
        d->next = 0;
    80001b60:	00063023          	sd	zero,0(a2)
    80001b64:	fe5ff06f          	j	80001b48 <_ZN5Buddy11deleteBlockEPNS_17buddy_free_levelsEm+0x40>

0000000080001b68 <_ZN5Buddy14buddy_allocateEm>:

void *Buddy::buddy_allocate(size_t size) {
    80001b68:	fd010113          	addi	sp,sp,-48
    80001b6c:	02113423          	sd	ra,40(sp)
    80001b70:	02813023          	sd	s0,32(sp)
    80001b74:	00913c23          	sd	s1,24(sp)
    80001b78:	01213823          	sd	s2,16(sp)
    80001b7c:	01313423          	sd	s3,8(sp)
    80001b80:	01413023          	sd	s4,0(sp)
    80001b84:	03010413          	addi	s0,sp,48
    uint64 realSize = calculate_real_size(size);
    80001b88:	00000097          	auipc	ra,0x0
    80001b8c:	d04080e7          	jalr	-764(ra) # 8000188c <_ZN5Buddy19calculate_real_sizeEm>
    80001b90:	00050993          	mv	s3,a0

    //Calculate exponent
    uint64 n = calculate_exponent(realSize);
    80001b94:	00000097          	auipc	ra,0x0
    80001b98:	d20080e7          	jalr	-736(ra) # 800018b4 <_ZN5Buddy18calculate_exponentEm>
    n = (n < minN ? minN : n);
    80001b9c:	00008a17          	auipc	s4,0x8
    80001ba0:	524a3a03          	ld	s4,1316(s4) # 8000a0c0 <_ZN5Buddy4minNE>
    80001ba4:	01456463          	bltu	a0,s4,80001bac <_ZN5Buddy14buddy_allocateEm+0x44>
    80001ba8:	00050a13          	mv	s4,a0

    int check = check_size_validation(n);
    80001bac:	000a0513          	mv	a0,s4
    80001bb0:	00000097          	auipc	ra,0x0
    80001bb4:	cac080e7          	jalr	-852(ra) # 8000185c <_ZN5Buddy21check_size_validationEm>
    if(check == 0) return nullptr;
    80001bb8:	18050263          	beqz	a0,80001d3c <_ZN5Buddy14buddy_allocateEm+0x1d4>

    //find first level that has enough space
    buddy_free_levels *level = &head[highestN - n];
    80001bbc:	00008797          	auipc	a5,0x8
    80001bc0:	4e478793          	addi	a5,a5,1252 # 8000a0a0 <_ZN5Buddy8highestNE>
    80001bc4:	0187b483          	ld	s1,24(a5)
    80001bc8:	0007b783          	ld	a5,0(a5)
    80001bcc:	414787b3          	sub	a5,a5,s4
    80001bd0:	00579793          	slli	a5,a5,0x5
    80001bd4:	00f484b3          	add	s1,s1,a5
    if(level->first != 0){
    80001bd8:	0004b903          	ld	s2,0(s1)
    80001bdc:	00091c63          	bnez	s2,80001bf4 <_ZN5Buddy14buddy_allocateEm+0x8c>
        }

        return (void *)block;
    }else{
        //find first highest level that have free space
        while(level->first == 0){ //&& level->prev != 0){
    80001be0:	0004b783          	ld	a5,0(s1)
    80001be4:	08079a63          	bnez	a5,80001c78 <_ZN5Buddy14buddy_allocateEm+0x110>
            level = level->prev;
    80001be8:	0184b483          	ld	s1,24(s1)
            if(level == nullptr) return nullptr; //no free space
    80001bec:	fe049ae3          	bnez	s1,80001be0 <_ZN5Buddy14buddy_allocateEm+0x78>
    80001bf0:	0640006f          	j	80001c54 <_ZN5Buddy14buddy_allocateEm+0xec>
        deleteBlock(level, block->position);
    80001bf4:	00893583          	ld	a1,8(s2)
    80001bf8:	00048513          	mv	a0,s1
    80001bfc:	00000097          	auipc	ra,0x0
    80001c00:	f0c080e7          	jalr	-244(ra) # 80001b08 <_ZN5Buddy11deleteBlockEPNS_17buddy_free_levelsEm>
        for(i = 0; i < (uint64)(1 << (highestN - minN)); i++){
    80001c04:	00000693          	li	a3,0
    80001c08:	00008717          	auipc	a4,0x8
    80001c0c:	49870713          	addi	a4,a4,1176 # 8000a0a0 <_ZN5Buddy8highestNE>
    80001c10:	00073783          	ld	a5,0(a4)
    80001c14:	02073703          	ld	a4,32(a4)
    80001c18:	40e7873b          	subw	a4,a5,a4
    80001c1c:	00100793          	li	a5,1
    80001c20:	00e797bb          	sllw	a5,a5,a4
    80001c24:	02f6f663          	bgeu	a3,a5,80001c50 <_ZN5Buddy14buddy_allocateEm+0xe8>
            if(allocatedHead[i].size == 0){
    80001c28:	00469793          	slli	a5,a3,0x4
    80001c2c:	00008717          	auipc	a4,0x8
    80001c30:	49c73703          	ld	a4,1180(a4) # 8000a0c8 <_ZN5Buddy13allocatedHeadE>
    80001c34:	00f707b3          	add	a5,a4,a5
    80001c38:	0007a703          	lw	a4,0(a5)
    80001c3c:	00070663          	beqz	a4,80001c48 <_ZN5Buddy14buddy_allocateEm+0xe0>
        for(i = 0; i < (uint64)(1 << (highestN - minN)); i++){
    80001c40:	00168693          	addi	a3,a3,1
    80001c44:	fc5ff06f          	j	80001c08 <_ZN5Buddy14buddy_allocateEm+0xa0>
                allocatedHead[i].address = (void *)block;
    80001c48:	0127b423          	sd	s2,8(a5)
                allocatedHead[i].size = realSize;
    80001c4c:	0137a023          	sw	s3,0(a5)
        return (void *)block;
    80001c50:	00090493          	mv	s1,s2

        return (void*)res;
    }

    return nullptr;
}
    80001c54:	00048513          	mv	a0,s1
    80001c58:	02813083          	ld	ra,40(sp)
    80001c5c:	02013403          	ld	s0,32(sp)
    80001c60:	01813483          	ld	s1,24(sp)
    80001c64:	01013903          	ld	s2,16(sp)
    80001c68:	00813983          	ld	s3,8(sp)
    80001c6c:	00013a03          	ld	s4,0(sp)
    80001c70:	03010113          	addi	sp,sp,48
    80001c74:	00008067          	ret
        uint64 l = level->level;
    80001c78:	0084b783          	ld	a5,8(s1)
        while(l != n){
    80001c7c:	05478e63          	beq	a5,s4,80001cd8 <_ZN5Buddy14buddy_allocateEm+0x170>
            buddy_free_block *block = level->first;
    80001c80:	0004b903          	ld	s2,0(s1)
            level->first = block->next;
    80001c84:	00093703          	ld	a4,0(s2)
    80001c88:	00e4b023          	sd	a4,0(s1)
            newBlockSecond = (buddy_free_block *)((uint64)((void*)block) + (uint64)(1 << (l-1)));
    80001c8c:	fff7879b          	addiw	a5,a5,-1
    80001c90:	00100513          	li	a0,1
    80001c94:	00f5153b          	sllw	a0,a0,a5
            free_block_init(newBlockSecond, level->next, block->position*2);
    80001c98:	00893603          	ld	a2,8(s2)
    80001c9c:	00161613          	slli	a2,a2,0x1
    80001ca0:	0104b583          	ld	a1,16(s1)
    80001ca4:	00a90533          	add	a0,s2,a0
    80001ca8:	00000097          	auipc	ra,0x0
    80001cac:	b60080e7          	jalr	-1184(ra) # 80001808 <_ZN5Buddy15free_block_initEPNS_16buddy_free_blockEPNS_17buddy_free_levelsEm>
            free_block_init(newBlockFirst, level->next, block->position*2-1);
    80001cb0:	00893603          	ld	a2,8(s2)
    80001cb4:	00161613          	slli	a2,a2,0x1
    80001cb8:	fff60613          	addi	a2,a2,-1
    80001cbc:	0104b583          	ld	a1,16(s1)
    80001cc0:	00090513          	mv	a0,s2
    80001cc4:	00000097          	auipc	ra,0x0
    80001cc8:	b44080e7          	jalr	-1212(ra) # 80001808 <_ZN5Buddy15free_block_initEPNS_16buddy_free_blockEPNS_17buddy_free_levelsEm>
            level = level->next;
    80001ccc:	0104b483          	ld	s1,16(s1)
            l = level->level;
    80001cd0:	0084b783          	ld	a5,8(s1)
        while(l != n){
    80001cd4:	fa9ff06f          	j	80001c7c <_ZN5Buddy14buddy_allocateEm+0x114>
        deleteBlock(level, tmp->position);
    80001cd8:	00893583          	ld	a1,8(s2)
    80001cdc:	00048513          	mv	a0,s1
    80001ce0:	00000097          	auipc	ra,0x0
    80001ce4:	e28080e7          	jalr	-472(ra) # 80001b08 <_ZN5Buddy11deleteBlockEPNS_17buddy_free_levelsEm>
        for(i = 0; i < (uint64)(1 << (highestN - minN)); i++){
    80001ce8:	00000693          	li	a3,0
    80001cec:	00008717          	auipc	a4,0x8
    80001cf0:	3b470713          	addi	a4,a4,948 # 8000a0a0 <_ZN5Buddy8highestNE>
    80001cf4:	00073783          	ld	a5,0(a4)
    80001cf8:	02073703          	ld	a4,32(a4)
    80001cfc:	40e7873b          	subw	a4,a5,a4
    80001d00:	00100793          	li	a5,1
    80001d04:	00e797bb          	sllw	a5,a5,a4
    80001d08:	02f6f663          	bgeu	a3,a5,80001d34 <_ZN5Buddy14buddy_allocateEm+0x1cc>
            if(allocatedHead[i].size == 0){
    80001d0c:	00469793          	slli	a5,a3,0x4
    80001d10:	00008717          	auipc	a4,0x8
    80001d14:	3b873703          	ld	a4,952(a4) # 8000a0c8 <_ZN5Buddy13allocatedHeadE>
    80001d18:	00f707b3          	add	a5,a4,a5
    80001d1c:	0007a703          	lw	a4,0(a5)
    80001d20:	00070663          	beqz	a4,80001d2c <_ZN5Buddy14buddy_allocateEm+0x1c4>
        for(i = 0; i < (uint64)(1 << (highestN - minN)); i++){
    80001d24:	00168693          	addi	a3,a3,1
    80001d28:	fc5ff06f          	j	80001cec <_ZN5Buddy14buddy_allocateEm+0x184>
                allocatedHead[i].address = (void *)res;
    80001d2c:	0127b423          	sd	s2,8(a5)
                allocatedHead[i].size = realSize;
    80001d30:	0137a023          	sw	s3,0(a5)
        return (void*)res;
    80001d34:	00090493          	mv	s1,s2
    80001d38:	f1dff06f          	j	80001c54 <_ZN5Buddy14buddy_allocateEm+0xec>
    if(check == 0) return nullptr;
    80001d3c:	00000493          	li	s1,0
    80001d40:	f15ff06f          	j	80001c54 <_ZN5Buddy14buddy_allocateEm+0xec>

0000000080001d44 <_ZN5Buddy10buddy_freeEPv>:

void Buddy::buddy_free(void *address) {
    80001d44:	fc010113          	addi	sp,sp,-64
    80001d48:	02113c23          	sd	ra,56(sp)
    80001d4c:	02813823          	sd	s0,48(sp)
    80001d50:	02913423          	sd	s1,40(sp)
    80001d54:	03213023          	sd	s2,32(sp)
    80001d58:	01313c23          	sd	s3,24(sp)
    80001d5c:	01413823          	sd	s4,16(sp)
    80001d60:	01513423          	sd	s5,8(sp)
    80001d64:	04010413          	addi	s0,sp,64
    80001d68:	00050a13          	mv	s4,a0
    //find address in allocated_blocks structure
    buddy_allocated_blocks *block_to_free = 0;

    for(uint64 i = 0; i < (uint64)(1<<(highestN-minN)); i++){
    80001d6c:	00000693          	li	a3,0
    80001d70:	00008717          	auipc	a4,0x8
    80001d74:	33070713          	addi	a4,a4,816 # 8000a0a0 <_ZN5Buddy8highestNE>
    80001d78:	00073783          	ld	a5,0(a4)
    80001d7c:	02073703          	ld	a4,32(a4)
    80001d80:	40e7873b          	subw	a4,a5,a4
    80001d84:	00100793          	li	a5,1
    80001d88:	00e797bb          	sllw	a5,a5,a4
    80001d8c:	02f6f263          	bgeu	a3,a5,80001db0 <_ZN5Buddy10buddy_freeEPv+0x6c>
        if(allocatedHead[i].address == address){
    80001d90:	00469793          	slli	a5,a3,0x4
    80001d94:	00008717          	auipc	a4,0x8
    80001d98:	33473703          	ld	a4,820(a4) # 8000a0c8 <_ZN5Buddy13allocatedHeadE>
    80001d9c:	00f707b3          	add	a5,a4,a5
    80001da0:	0087b703          	ld	a4,8(a5)
    80001da4:	01470863          	beq	a4,s4,80001db4 <_ZN5Buddy10buddy_freeEPv+0x70>
    for(uint64 i = 0; i < (uint64)(1<<(highestN-minN)); i++){
    80001da8:	00168693          	addi	a3,a3,1
    80001dac:	fc5ff06f          	j	80001d70 <_ZN5Buddy10buddy_freeEPv+0x2c>
    buddy_allocated_blocks *block_to_free = 0;
    80001db0:	00000793          	li	a5,0
            break;
        }
    }

    //save size and delete data from structure for allocated spaces
    size_t size = block_to_free->size;
    80001db4:	0007a983          	lw	s3,0(a5)
    block_to_free->address = 0;
    80001db8:	0007b423          	sd	zero,8(a5)
    block_to_free->size = 0;
    80001dbc:	0007a023          	sw	zero,0(a5)

    clearMemory(address, size);
    80001dc0:	00098593          	mv	a1,s3
    80001dc4:	000a0513          	mv	a0,s4
    80001dc8:	00000097          	auipc	ra,0x0
    80001dcc:	a10080e7          	jalr	-1520(ra) # 800017d8 <_ZN5Buddy11clearMemoryEPvm>

    //free block and if possible buddy him with his neighbour

    uint64 n = calculate_exponent(size);
    80001dd0:	00098513          	mv	a0,s3
    80001dd4:	00000097          	auipc	ra,0x0
    80001dd8:	ae0080e7          	jalr	-1312(ra) # 800018b4 <_ZN5Buddy18calculate_exponentEm>

    buddy_free_levels *level = &head[highestN - n];
    80001ddc:	00008717          	auipc	a4,0x8
    80001de0:	2c470713          	addi	a4,a4,708 # 8000a0a0 <_ZN5Buddy8highestNE>
    80001de4:	01873903          	ld	s2,24(a4)
    80001de8:	00073783          	ld	a5,0(a4)
    80001dec:	40a787b3          	sub	a5,a5,a0
    80001df0:	00579793          	slli	a5,a5,0x5
    80001df4:	00f90933          	add	s2,s2,a5

    uint64 position = uint64(((uint64)address - (uint64)START) / size);
    80001df8:	01073483          	ld	s1,16(a4)
    80001dfc:	409a04b3          	sub	s1,s4,s1
    80001e00:	0334d4b3          	divu	s1,s1,s3

    //create free block
    buddy_free_block *block = (buddy_free_block *) address;
    80001e04:	0140006f          	j	80001e18 <_ZN5Buddy10buddy_freeEPv+0xd4>

    while(level->prev != 0) {
        free_block_init(block, level, position);

        //find his buddy if there is
        uint64 par = ((uint64) (position & 1) == (uint64) 0 ? position - 1 : position + 1);
    80001e08:	00148a93          	addi	s5,s1,1
    80001e0c:	0340006f          	j	80001e40 <_ZN5Buddy10buddy_freeEPv+0xfc>
        level = level->prev;

        buddy_free_block *largerBlock = (buddy_free_block *) ((uint64) buddy < (uint64) block ? (void *) buddy
                                                                                              : (void *) block);

        position = (position + 1) / 2;
    80001e10:	00148493          	addi	s1,s1,1
    80001e14:	0014d493          	srli	s1,s1,0x1
    while(level->prev != 0) {
    80001e18:	01893783          	ld	a5,24(s2)
    80001e1c:	06078663          	beqz	a5,80001e88 <_ZN5Buddy10buddy_freeEPv+0x144>
        free_block_init(block, level, position);
    80001e20:	00048613          	mv	a2,s1
    80001e24:	00090593          	mv	a1,s2
    80001e28:	000a0513          	mv	a0,s4
    80001e2c:	00000097          	auipc	ra,0x0
    80001e30:	9dc080e7          	jalr	-1572(ra) # 80001808 <_ZN5Buddy15free_block_initEPNS_16buddy_free_blockEPNS_17buddy_free_levelsEm>
        uint64 par = ((uint64) (position & 1) == (uint64) 0 ? position - 1 : position + 1);
    80001e34:	0014f793          	andi	a5,s1,1
    80001e38:	fc0798e3          	bnez	a5,80001e08 <_ZN5Buddy10buddy_freeEPv+0xc4>
    80001e3c:	fff48a93          	addi	s5,s1,-1
        buddy_free_block *buddy = findBlockAt(level, par);
    80001e40:	000a8593          	mv	a1,s5
    80001e44:	00090513          	mv	a0,s2
    80001e48:	00000097          	auipc	ra,0x0
    80001e4c:	c90080e7          	jalr	-880(ra) # 80001ad8 <_ZN5Buddy11findBlockAtEPNS_17buddy_free_levelsEm>
    80001e50:	00050993          	mv	s3,a0
        if (buddy == 0) return;
    80001e54:	02050a63          	beqz	a0,80001e88 <_ZN5Buddy10buddy_freeEPv+0x144>
        deleteBlock(level, par);
    80001e58:	000a8593          	mv	a1,s5
    80001e5c:	00090513          	mv	a0,s2
    80001e60:	00000097          	auipc	ra,0x0
    80001e64:	ca8080e7          	jalr	-856(ra) # 80001b08 <_ZN5Buddy11deleteBlockEPNS_17buddy_free_levelsEm>
        deleteBlock(level, position);
    80001e68:	00048593          	mv	a1,s1
    80001e6c:	00090513          	mv	a0,s2
    80001e70:	00000097          	auipc	ra,0x0
    80001e74:	c98080e7          	jalr	-872(ra) # 80001b08 <_ZN5Buddy11deleteBlockEPNS_17buddy_free_levelsEm>
        level = level->prev;
    80001e78:	01893903          	ld	s2,24(s2)
        buddy_free_block *largerBlock = (buddy_free_block *) ((uint64) buddy < (uint64) block ? (void *) buddy
    80001e7c:	f949fae3          	bgeu	s3,s4,80001e10 <_ZN5Buddy10buddy_freeEPv+0xcc>
    80001e80:	00098a13          	mv	s4,s3
    80001e84:	f8dff06f          	j	80001e10 <_ZN5Buddy10buddy_freeEPv+0xcc>
        block = largerBlock;
    }
    return;
}
    80001e88:	03813083          	ld	ra,56(sp)
    80001e8c:	03013403          	ld	s0,48(sp)
    80001e90:	02813483          	ld	s1,40(sp)
    80001e94:	02013903          	ld	s2,32(sp)
    80001e98:	01813983          	ld	s3,24(sp)
    80001e9c:	01013a03          	ld	s4,16(sp)
    80001ea0:	00813a83          	ld	s5,8(sp)
    80001ea4:	04010113          	addi	sp,sp,64
    80001ea8:	00008067          	ret

0000000080001eac <_ZN8PCB_List14createPCB_ListEv>:
#include "../h/PCB_List.hpp"

kmem_cache_t *PCB_List::cache = nullptr;
kmem_cache_t *PCB_List::Elem::elemCache = nullptr;

PCB_List *PCB_List::createPCB_List(){
    80001eac:	ff010113          	addi	sp,sp,-16
    80001eb0:	00113423          	sd	ra,8(sp)
    80001eb4:	00813023          	sd	s0,0(sp)
    80001eb8:	01010413          	addi	s0,sp,16
    PCB_List *ret = (PCB_List *)kmem_cache_alloc(PCB_List::cache);
    80001ebc:	00008517          	auipc	a0,0x8
    80001ec0:	21453503          	ld	a0,532(a0) # 8000a0d0 <_ZN8PCB_List5cacheE>
    80001ec4:	00003097          	auipc	ra,0x3
    80001ec8:	258080e7          	jalr	600(ra) # 8000511c <_Z16kmem_cache_allocP10kmem_cache>
    if(ret == nullptr) return nullptr;
    80001ecc:	00050663          	beqz	a0,80001ed8 <_ZN8PCB_List14createPCB_ListEv+0x2c>
    ret->head = nullptr;
    80001ed0:	00053023          	sd	zero,0(a0)
    ret->tail = nullptr;
    80001ed4:	00053423          	sd	zero,8(a0)
    return ret;
}
    80001ed8:	00813083          	ld	ra,8(sp)
    80001edc:	00013403          	ld	s0,0(sp)
    80001ee0:	01010113          	addi	sp,sp,16
    80001ee4:	00008067          	ret

0000000080001ee8 <_ZN8PCB_List8addFirstEP3PCB>:

void PCB_List::addFirst(PCB *data)
{
    80001ee8:	fd010113          	addi	sp,sp,-48
    80001eec:	02113423          	sd	ra,40(sp)
    80001ef0:	02813023          	sd	s0,32(sp)
    80001ef4:	00913c23          	sd	s1,24(sp)
    80001ef8:	01213823          	sd	s2,16(sp)
    80001efc:	01313423          	sd	s3,8(sp)
    80001f00:	03010413          	addi	s0,sp,48
    80001f04:	00050493          	mv	s1,a0
    80001f08:	00058913          	mv	s2,a1
    //Elem *elem = new Elem(data, head);
    Elem *elem = Elem::createElem(data, head);
    80001f0c:	00053983          	ld	s3,0(a0)
        Elem *next;

        static kmem_cache_t *elemCache;

        static Elem* createElem(PCB* data, Elem *next){
            Elem* ret = (Elem *)kmem_cache_alloc(Elem::elemCache);
    80001f10:	00008517          	auipc	a0,0x8
    80001f14:	1c853503          	ld	a0,456(a0) # 8000a0d8 <_ZN8PCB_List4Elem9elemCacheE>
    80001f18:	00003097          	auipc	ra,0x3
    80001f1c:	204080e7          	jalr	516(ra) # 8000511c <_Z16kmem_cache_allocP10kmem_cache>
            if(ret == nullptr) return nullptr;
    80001f20:	00050663          	beqz	a0,80001f2c <_ZN8PCB_List8addFirstEP3PCB+0x44>
            ret->data = data;
    80001f24:	01253023          	sd	s2,0(a0)
            ret->next = next;
    80001f28:	01353423          	sd	s3,8(a0)
    head = elem;
    80001f2c:	00a4b023          	sd	a0,0(s1)
    if (!tail) { tail = head; }
    80001f30:	0084b783          	ld	a5,8(s1)
    80001f34:	02078063          	beqz	a5,80001f54 <_ZN8PCB_List8addFirstEP3PCB+0x6c>
}
    80001f38:	02813083          	ld	ra,40(sp)
    80001f3c:	02013403          	ld	s0,32(sp)
    80001f40:	01813483          	ld	s1,24(sp)
    80001f44:	01013903          	ld	s2,16(sp)
    80001f48:	00813983          	ld	s3,8(sp)
    80001f4c:	03010113          	addi	sp,sp,48
    80001f50:	00008067          	ret
    if (!tail) { tail = head; }
    80001f54:	00a4b423          	sd	a0,8(s1)
}
    80001f58:	fe1ff06f          	j	80001f38 <_ZN8PCB_List8addFirstEP3PCB+0x50>

0000000080001f5c <_ZN8PCB_List7addLastEP3PCB>:

int PCB_List::addLast(PCB *data)
{
    80001f5c:	fe010113          	addi	sp,sp,-32
    80001f60:	00113c23          	sd	ra,24(sp)
    80001f64:	00813823          	sd	s0,16(sp)
    80001f68:	00913423          	sd	s1,8(sp)
    80001f6c:	01213023          	sd	s2,0(sp)
    80001f70:	02010413          	addi	s0,sp,32
    80001f74:	00050493          	mv	s1,a0
    80001f78:	00058913          	mv	s2,a1
            Elem* ret = (Elem *)kmem_cache_alloc(Elem::elemCache);
    80001f7c:	00008517          	auipc	a0,0x8
    80001f80:	15c53503          	ld	a0,348(a0) # 8000a0d8 <_ZN8PCB_List4Elem9elemCacheE>
    80001f84:	00003097          	auipc	ra,0x3
    80001f88:	198080e7          	jalr	408(ra) # 8000511c <_Z16kmem_cache_allocP10kmem_cache>
            if(ret == nullptr) return nullptr;
    80001f8c:	04050463          	beqz	a0,80001fd4 <_ZN8PCB_List7addLastEP3PCB+0x78>
            ret->data = data;
    80001f90:	01253023          	sd	s2,0(a0)
            ret->next = next;
    80001f94:	00053423          	sd	zero,8(a0)
    //Elem *elem = new Elem(data, 0);
    Elem *elem = Elem::createElem(data, nullptr);
    if(!elem) return -1;
    if (tail)
    80001f98:	0084b783          	ld	a5,8(s1)
    80001f9c:	02078463          	beqz	a5,80001fc4 <_ZN8PCB_List7addLastEP3PCB+0x68>
    {
        tail->next = elem;
    80001fa0:	00a7b423          	sd	a0,8(a5)
        tail = elem;
    80001fa4:	00a4b423          	sd	a0,8(s1)
    } else
    {
        head = tail = elem;
    }
    return 0;
    80001fa8:	00000513          	li	a0,0
}
    80001fac:	01813083          	ld	ra,24(sp)
    80001fb0:	01013403          	ld	s0,16(sp)
    80001fb4:	00813483          	ld	s1,8(sp)
    80001fb8:	00013903          	ld	s2,0(sp)
    80001fbc:	02010113          	addi	sp,sp,32
    80001fc0:	00008067          	ret
        head = tail = elem;
    80001fc4:	00a4b423          	sd	a0,8(s1)
    80001fc8:	00a4b023          	sd	a0,0(s1)
    return 0;
    80001fcc:	00000513          	li	a0,0
    80001fd0:	fddff06f          	j	80001fac <_ZN8PCB_List7addLastEP3PCB+0x50>
    if(!elem) return -1;
    80001fd4:	fff00513          	li	a0,-1
    80001fd8:	fd5ff06f          	j	80001fac <_ZN8PCB_List7addLastEP3PCB+0x50>

0000000080001fdc <_ZN8PCB_List11removeFirstEv>:

PCB *PCB_List::removeFirst()
{
    80001fdc:	fe010113          	addi	sp,sp,-32
    80001fe0:	00113c23          	sd	ra,24(sp)
    80001fe4:	00813823          	sd	s0,16(sp)
    80001fe8:	00913423          	sd	s1,8(sp)
    80001fec:	02010413          	addi	s0,sp,32
    if (!head) { return 0; }
    80001ff0:	00053583          	ld	a1,0(a0)
    80001ff4:	04058463          	beqz	a1,8000203c <_ZN8PCB_List11removeFirstEv+0x60>

    Elem *elem = head;
    head = head->next;
    80001ff8:	0085b783          	ld	a5,8(a1)
    80001ffc:	00f53023          	sd	a5,0(a0)
    if (!head) { tail = 0; }
    80002000:	02078a63          	beqz	a5,80002034 <_ZN8PCB_List11removeFirstEv+0x58>

    PCB *ret = elem->data;
    80002004:	0005b483          	ld	s1,0(a1)

    elem->next = nullptr;
    80002008:	0005b423          	sd	zero,8(a1)
            return ret;
        }

        static void freeObject(Elem *obj) {
            kmem_cache_free(elemCache, (void *) obj);
    8000200c:	00008517          	auipc	a0,0x8
    80002010:	0cc53503          	ld	a0,204(a0) # 8000a0d8 <_ZN8PCB_List4Elem9elemCacheE>
    80002014:	00003097          	auipc	ra,0x3
    80002018:	130080e7          	jalr	304(ra) # 80005144 <_Z15kmem_cache_freeP10kmem_cachePv>
    Elem::freeObject(elem);

    return ret;
}
    8000201c:	00048513          	mv	a0,s1
    80002020:	01813083          	ld	ra,24(sp)
    80002024:	01013403          	ld	s0,16(sp)
    80002028:	00813483          	ld	s1,8(sp)
    8000202c:	02010113          	addi	sp,sp,32
    80002030:	00008067          	ret
    if (!head) { tail = 0; }
    80002034:	00053423          	sd	zero,8(a0)
    80002038:	fcdff06f          	j	80002004 <_ZN8PCB_List11removeFirstEv+0x28>
    if (!head) { return 0; }
    8000203c:	00058493          	mv	s1,a1
    80002040:	fddff06f          	j	8000201c <_ZN8PCB_List11removeFirstEv+0x40>

0000000080002044 <_ZN8PCB_List9peekFirstEv>:

PCB *PCB_List::peekFirst()
{
    80002044:	ff010113          	addi	sp,sp,-16
    80002048:	00813423          	sd	s0,8(sp)
    8000204c:	01010413          	addi	s0,sp,16
    if (!head) { return 0; }
    80002050:	00053503          	ld	a0,0(a0)
    80002054:	00050463          	beqz	a0,8000205c <_ZN8PCB_List9peekFirstEv+0x18>
    return head->data;
    80002058:	00053503          	ld	a0,0(a0)
}
    8000205c:	00813403          	ld	s0,8(sp)
    80002060:	01010113          	addi	sp,sp,16
    80002064:	00008067          	ret

0000000080002068 <_ZN8PCB_List10freeObjectEPS_>:

void PCB_List::freeObject(PCB_List *l) {
    80002068:	ff010113          	addi	sp,sp,-16
    8000206c:	00113423          	sd	ra,8(sp)
    80002070:	00813023          	sd	s0,0(sp)
    80002074:	01010413          	addi	s0,sp,16
    80002078:	00050593          	mv	a1,a0
    kmem_cache_free(PCB_List::cache, (void *)l);
    8000207c:	00008517          	auipc	a0,0x8
    80002080:	05453503          	ld	a0,84(a0) # 8000a0d0 <_ZN8PCB_List5cacheE>
    80002084:	00003097          	auipc	ra,0x3
    80002088:	0c0080e7          	jalr	192(ra) # 80005144 <_Z15kmem_cache_freeP10kmem_cachePv>
}
    8000208c:	00813083          	ld	ra,8(sp)
    80002090:	00013403          	ld	s0,0(sp)
    80002094:	01010113          	addi	sp,sp,16
    80002098:	00008067          	ret

000000008000209c <_ZN8PCB_List4dtorEPS_>:

void PCB_List::dtor(PCB_List *l) {
    8000209c:	fe010113          	addi	sp,sp,-32
    800020a0:	00113c23          	sd	ra,24(sp)
    800020a4:	00813823          	sd	s0,16(sp)
    800020a8:	00913423          	sd	s1,8(sp)
    800020ac:	02010413          	addi	s0,sp,32
    800020b0:	00050493          	mv	s1,a0
    while(!l->head){
    800020b4:	0004b783          	ld	a5,0(s1)
    800020b8:	00079a63          	bnez	a5,800020cc <_ZN8PCB_List4dtorEPS_+0x30>
        l->removeFirst();
    800020bc:	00048513          	mv	a0,s1
    800020c0:	00000097          	auipc	ra,0x0
    800020c4:	f1c080e7          	jalr	-228(ra) # 80001fdc <_ZN8PCB_List11removeFirstEv>
    while(!l->head){
    800020c8:	fedff06f          	j	800020b4 <_ZN8PCB_List4dtorEPS_+0x18>
    }
}
    800020cc:	01813083          	ld	ra,24(sp)
    800020d0:	01013403          	ld	s0,16(sp)
    800020d4:	00813483          	ld	s1,8(sp)
    800020d8:	02010113          	addi	sp,sp,32
    800020dc:	00008067          	ret

00000000800020e0 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    800020e0:	fe010113          	addi	sp,sp,-32
    800020e4:	00113c23          	sd	ra,24(sp)
    800020e8:	00813823          	sd	s0,16(sp)
    800020ec:	00913423          	sd	s1,8(sp)
    800020f0:	02010413          	addi	s0,sp,32
    800020f4:	00050493          	mv	s1,a0
    LOCK();
    800020f8:	00100613          	li	a2,1
    800020fc:	00000593          	li	a1,0
    80002100:	00008517          	auipc	a0,0x8
    80002104:	fe050513          	addi	a0,a0,-32 # 8000a0e0 <lockPrint>
    80002108:	fffff097          	auipc	ra,0xfffff
    8000210c:	ef8080e7          	jalr	-264(ra) # 80001000 <copy_and_swap>
    80002110:	fe0514e3          	bnez	a0,800020f8 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80002114:	0004c503          	lbu	a0,0(s1)
    80002118:	00050a63          	beqz	a0,8000212c <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    8000211c:	fffff097          	auipc	ra,0xfffff
    80002120:	274080e7          	jalr	628(ra) # 80001390 <_Z4putcc>
        string++;
    80002124:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80002128:	fedff06f          	j	80002114 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    8000212c:	00000613          	li	a2,0
    80002130:	00100593          	li	a1,1
    80002134:	00008517          	auipc	a0,0x8
    80002138:	fac50513          	addi	a0,a0,-84 # 8000a0e0 <lockPrint>
    8000213c:	fffff097          	auipc	ra,0xfffff
    80002140:	ec4080e7          	jalr	-316(ra) # 80001000 <copy_and_swap>
    80002144:	fe0514e3          	bnez	a0,8000212c <_Z11printStringPKc+0x4c>
}
    80002148:	01813083          	ld	ra,24(sp)
    8000214c:	01013403          	ld	s0,16(sp)
    80002150:	00813483          	ld	s1,8(sp)
    80002154:	02010113          	addi	sp,sp,32
    80002158:	00008067          	ret

000000008000215c <_Z9getStringPci>:

char* getString(char *buf, int max) {
    8000215c:	fd010113          	addi	sp,sp,-48
    80002160:	02113423          	sd	ra,40(sp)
    80002164:	02813023          	sd	s0,32(sp)
    80002168:	00913c23          	sd	s1,24(sp)
    8000216c:	01213823          	sd	s2,16(sp)
    80002170:	01313423          	sd	s3,8(sp)
    80002174:	01413023          	sd	s4,0(sp)
    80002178:	03010413          	addi	s0,sp,48
    8000217c:	00050993          	mv	s3,a0
    80002180:	00058a13          	mv	s4,a1
    LOCK();
    80002184:	00100613          	li	a2,1
    80002188:	00000593          	li	a1,0
    8000218c:	00008517          	auipc	a0,0x8
    80002190:	f5450513          	addi	a0,a0,-172 # 8000a0e0 <lockPrint>
    80002194:	fffff097          	auipc	ra,0xfffff
    80002198:	e6c080e7          	jalr	-404(ra) # 80001000 <copy_and_swap>
    8000219c:	fe0514e3          	bnez	a0,80002184 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    800021a0:	00000913          	li	s2,0
    800021a4:	00090493          	mv	s1,s2
    800021a8:	0019091b          	addiw	s2,s2,1
    800021ac:	03495a63          	bge	s2,s4,800021e0 <_Z9getStringPci+0x84>
        cc = getc();
    800021b0:	fffff097          	auipc	ra,0xfffff
    800021b4:	1b4080e7          	jalr	436(ra) # 80001364 <_Z4getcv>
        if(cc < 1)
    800021b8:	02050463          	beqz	a0,800021e0 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    800021bc:	009984b3          	add	s1,s3,s1
    800021c0:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    800021c4:	00a00793          	li	a5,10
    800021c8:	00f50a63          	beq	a0,a5,800021dc <_Z9getStringPci+0x80>
    800021cc:	00d00793          	li	a5,13
    800021d0:	fcf51ae3          	bne	a0,a5,800021a4 <_Z9getStringPci+0x48>
        buf[i++] = c;
    800021d4:	00090493          	mv	s1,s2
    800021d8:	0080006f          	j	800021e0 <_Z9getStringPci+0x84>
    800021dc:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    800021e0:	009984b3          	add	s1,s3,s1
    800021e4:	00048023          	sb	zero,0(s1)

    UNLOCK();
    800021e8:	00000613          	li	a2,0
    800021ec:	00100593          	li	a1,1
    800021f0:	00008517          	auipc	a0,0x8
    800021f4:	ef050513          	addi	a0,a0,-272 # 8000a0e0 <lockPrint>
    800021f8:	fffff097          	auipc	ra,0xfffff
    800021fc:	e08080e7          	jalr	-504(ra) # 80001000 <copy_and_swap>
    80002200:	fe0514e3          	bnez	a0,800021e8 <_Z9getStringPci+0x8c>
    return buf;
}
    80002204:	00098513          	mv	a0,s3
    80002208:	02813083          	ld	ra,40(sp)
    8000220c:	02013403          	ld	s0,32(sp)
    80002210:	01813483          	ld	s1,24(sp)
    80002214:	01013903          	ld	s2,16(sp)
    80002218:	00813983          	ld	s3,8(sp)
    8000221c:	00013a03          	ld	s4,0(sp)
    80002220:	03010113          	addi	sp,sp,48
    80002224:	00008067          	ret

0000000080002228 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80002228:	ff010113          	addi	sp,sp,-16
    8000222c:	00813423          	sd	s0,8(sp)
    80002230:	01010413          	addi	s0,sp,16
    80002234:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80002238:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    8000223c:	0006c603          	lbu	a2,0(a3)
    80002240:	fd06071b          	addiw	a4,a2,-48
    80002244:	0ff77713          	andi	a4,a4,255
    80002248:	00900793          	li	a5,9
    8000224c:	02e7e063          	bltu	a5,a4,8000226c <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80002250:	0025179b          	slliw	a5,a0,0x2
    80002254:	00a787bb          	addw	a5,a5,a0
    80002258:	0017979b          	slliw	a5,a5,0x1
    8000225c:	00168693          	addi	a3,a3,1
    80002260:	00c787bb          	addw	a5,a5,a2
    80002264:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80002268:	fd5ff06f          	j	8000223c <_Z11stringToIntPKc+0x14>
    return n;
}
    8000226c:	00813403          	ld	s0,8(sp)
    80002270:	01010113          	addi	sp,sp,16
    80002274:	00008067          	ret

0000000080002278 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80002278:	fc010113          	addi	sp,sp,-64
    8000227c:	02113c23          	sd	ra,56(sp)
    80002280:	02813823          	sd	s0,48(sp)
    80002284:	02913423          	sd	s1,40(sp)
    80002288:	03213023          	sd	s2,32(sp)
    8000228c:	01313c23          	sd	s3,24(sp)
    80002290:	04010413          	addi	s0,sp,64
    80002294:	00050493          	mv	s1,a0
    80002298:	00058913          	mv	s2,a1
    8000229c:	00060993          	mv	s3,a2
    LOCK();
    800022a0:	00100613          	li	a2,1
    800022a4:	00000593          	li	a1,0
    800022a8:	00008517          	auipc	a0,0x8
    800022ac:	e3850513          	addi	a0,a0,-456 # 8000a0e0 <lockPrint>
    800022b0:	fffff097          	auipc	ra,0xfffff
    800022b4:	d50080e7          	jalr	-688(ra) # 80001000 <copy_and_swap>
    800022b8:	fe0514e3          	bnez	a0,800022a0 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    800022bc:	00098463          	beqz	s3,800022c4 <_Z8printIntiii+0x4c>
    800022c0:	0804c463          	bltz	s1,80002348 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    800022c4:	0004851b          	sext.w	a0,s1
    neg = 0;
    800022c8:	00000593          	li	a1,0
    }

    i = 0;
    800022cc:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    800022d0:	0009079b          	sext.w	a5,s2
    800022d4:	0325773b          	remuw	a4,a0,s2
    800022d8:	00048613          	mv	a2,s1
    800022dc:	0014849b          	addiw	s1,s1,1
    800022e0:	02071693          	slli	a3,a4,0x20
    800022e4:	0206d693          	srli	a3,a3,0x20
    800022e8:	00008717          	auipc	a4,0x8
    800022ec:	bc870713          	addi	a4,a4,-1080 # 80009eb0 <digits>
    800022f0:	00d70733          	add	a4,a4,a3
    800022f4:	00074683          	lbu	a3,0(a4)
    800022f8:	fd040713          	addi	a4,s0,-48
    800022fc:	00c70733          	add	a4,a4,a2
    80002300:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80002304:	0005071b          	sext.w	a4,a0
    80002308:	0325553b          	divuw	a0,a0,s2
    8000230c:	fcf772e3          	bgeu	a4,a5,800022d0 <_Z8printIntiii+0x58>
    if(neg)
    80002310:	00058c63          	beqz	a1,80002328 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    80002314:	fd040793          	addi	a5,s0,-48
    80002318:	009784b3          	add	s1,a5,s1
    8000231c:	02d00793          	li	a5,45
    80002320:	fef48823          	sb	a5,-16(s1)
    80002324:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80002328:	fff4849b          	addiw	s1,s1,-1
    8000232c:	0204c463          	bltz	s1,80002354 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    80002330:	fd040793          	addi	a5,s0,-48
    80002334:	009787b3          	add	a5,a5,s1
    80002338:	ff07c503          	lbu	a0,-16(a5)
    8000233c:	fffff097          	auipc	ra,0xfffff
    80002340:	054080e7          	jalr	84(ra) # 80001390 <_Z4putcc>
    80002344:	fe5ff06f          	j	80002328 <_Z8printIntiii+0xb0>
        x = -xx;
    80002348:	4090053b          	negw	a0,s1
        neg = 1;
    8000234c:	00100593          	li	a1,1
        x = -xx;
    80002350:	f7dff06f          	j	800022cc <_Z8printIntiii+0x54>

    UNLOCK();
    80002354:	00000613          	li	a2,0
    80002358:	00100593          	li	a1,1
    8000235c:	00008517          	auipc	a0,0x8
    80002360:	d8450513          	addi	a0,a0,-636 # 8000a0e0 <lockPrint>
    80002364:	fffff097          	auipc	ra,0xfffff
    80002368:	c9c080e7          	jalr	-868(ra) # 80001000 <copy_and_swap>
    8000236c:	fe0514e3          	bnez	a0,80002354 <_Z8printIntiii+0xdc>
    80002370:	03813083          	ld	ra,56(sp)
    80002374:	03013403          	ld	s0,48(sp)
    80002378:	02813483          	ld	s1,40(sp)
    8000237c:	02013903          	ld	s2,32(sp)
    80002380:	01813983          	ld	s3,24(sp)
    80002384:	04010113          	addi	sp,sp,64
    80002388:	00008067          	ret

000000008000238c <_ZN5Queue11createQueueEv>:
#include "../h/Queue.hpp"
#include "../h/PCB_List.hpp"

kmem_cache_t *Queue::cache = nullptr;

Queue *Queue::createQueue() {
    8000238c:	fe010113          	addi	sp,sp,-32
    80002390:	00113c23          	sd	ra,24(sp)
    80002394:	00813823          	sd	s0,16(sp)
    80002398:	00913423          	sd	s1,8(sp)
    8000239c:	01213023          	sd	s2,0(sp)
    800023a0:	02010413          	addi	s0,sp,32
    Queue *ret = (Queue *) kmem_cache_alloc(Queue::cache);
    800023a4:	00008517          	auipc	a0,0x8
    800023a8:	d4453503          	ld	a0,-700(a0) # 8000a0e8 <_ZN5Queue5cacheE>
    800023ac:	00003097          	auipc	ra,0x3
    800023b0:	d70080e7          	jalr	-656(ra) # 8000511c <_Z16kmem_cache_allocP10kmem_cache>
    800023b4:	00050493          	mv	s1,a0
    if(ret == nullptr) return nullptr;
    800023b8:	00050e63          	beqz	a0,800023d4 <_ZN5Queue11createQueueEv+0x48>
    ret->size = 0;
    800023bc:	00052023          	sw	zero,0(a0)
    ret->queue = PCB_List::createPCB_List();
    800023c0:	00000097          	auipc	ra,0x0
    800023c4:	aec080e7          	jalr	-1300(ra) # 80001eac <_ZN8PCB_List14createPCB_ListEv>
    800023c8:	00050913          	mv	s2,a0
    800023cc:	00a4b423          	sd	a0,8(s1)
    if(ret->queue == nullptr){
    800023d0:	02050063          	beqz	a0,800023f0 <_ZN5Queue11createQueueEv+0x64>
        kmem_cache_free(Queue::cache, ret);
        return nullptr;
    }
    return ret;
}
    800023d4:	00048513          	mv	a0,s1
    800023d8:	01813083          	ld	ra,24(sp)
    800023dc:	01013403          	ld	s0,16(sp)
    800023e0:	00813483          	ld	s1,8(sp)
    800023e4:	00013903          	ld	s2,0(sp)
    800023e8:	02010113          	addi	sp,sp,32
    800023ec:	00008067          	ret
        kmem_cache_free(Queue::cache, ret);
    800023f0:	00048593          	mv	a1,s1
    800023f4:	00008517          	auipc	a0,0x8
    800023f8:	cf453503          	ld	a0,-780(a0) # 8000a0e8 <_ZN5Queue5cacheE>
    800023fc:	00003097          	auipc	ra,0x3
    80002400:	d48080e7          	jalr	-696(ra) # 80005144 <_Z15kmem_cache_freeP10kmem_cachePv>
        return nullptr;
    80002404:	00090493          	mv	s1,s2
    80002408:	fcdff06f          	j	800023d4 <_ZN5Queue11createQueueEv+0x48>

000000008000240c <_ZN5Queue3putEP3PCB>:

int Queue::put(PCB* pcb){
    8000240c:	fe010113          	addi	sp,sp,-32
    80002410:	00113c23          	sd	ra,24(sp)
    80002414:	00813823          	sd	s0,16(sp)
    80002418:	00913423          	sd	s1,8(sp)
    8000241c:	02010413          	addi	s0,sp,32
    80002420:	00050493          	mv	s1,a0
    int ret = queue->addLast(pcb);
    80002424:	00853503          	ld	a0,8(a0)
    80002428:	00000097          	auipc	ra,0x0
    8000242c:	b34080e7          	jalr	-1228(ra) # 80001f5c <_ZN8PCB_List7addLastEP3PCB>
    if(ret == -1)  return -1;
    80002430:	fff00793          	li	a5,-1
    80002434:	00f50863          	beq	a0,a5,80002444 <_ZN5Queue3putEP3PCB+0x38>
    size++;
    80002438:	0004a783          	lw	a5,0(s1)
    8000243c:	0017879b          	addiw	a5,a5,1
    80002440:	00f4a023          	sw	a5,0(s1)
    return ret;
}
    80002444:	01813083          	ld	ra,24(sp)
    80002448:	01013403          	ld	s0,16(sp)
    8000244c:	00813483          	ld	s1,8(sp)
    80002450:	02010113          	addi	sp,sp,32
    80002454:	00008067          	ret

0000000080002458 <_ZN5Queue3getEv>:

PCB *Queue::get(){
    80002458:	ff010113          	addi	sp,sp,-16
    8000245c:	00113423          	sd	ra,8(sp)
    80002460:	00813023          	sd	s0,0(sp)
    80002464:	01010413          	addi	s0,sp,16
    size--;
    80002468:	00052783          	lw	a5,0(a0)
    8000246c:	fff7879b          	addiw	a5,a5,-1
    80002470:	00f52023          	sw	a5,0(a0)
    return queue->removeFirst();
    80002474:	00853503          	ld	a0,8(a0)
    80002478:	00000097          	auipc	ra,0x0
    8000247c:	b64080e7          	jalr	-1180(ra) # 80001fdc <_ZN8PCB_List11removeFirstEv>
}
    80002480:	00813083          	ld	ra,8(sp)
    80002484:	00013403          	ld	s0,0(sp)
    80002488:	01010113          	addi	sp,sp,16
    8000248c:	00008067          	ret

0000000080002490 <_ZN5Queue10freeObjectEPS_>:

void Queue::freeObject(Queue *q) {
    80002490:	ff010113          	addi	sp,sp,-16
    80002494:	00113423          	sd	ra,8(sp)
    80002498:	00813023          	sd	s0,0(sp)
    8000249c:	01010413          	addi	s0,sp,16
    800024a0:	00050593          	mv	a1,a0
    kmem_cache_free(Queue::cache, (void *)q);
    800024a4:	00008517          	auipc	a0,0x8
    800024a8:	c4453503          	ld	a0,-956(a0) # 8000a0e8 <_ZN5Queue5cacheE>
    800024ac:	00003097          	auipc	ra,0x3
    800024b0:	c98080e7          	jalr	-872(ra) # 80005144 <_Z15kmem_cache_freeP10kmem_cachePv>
}
    800024b4:	00813083          	ld	ra,8(sp)
    800024b8:	00013403          	ld	s0,0(sp)
    800024bc:	01010113          	addi	sp,sp,16
    800024c0:	00008067          	ret

00000000800024c4 <_ZN5Queue4dtorEPS_>:

void Queue::dtor(Queue *q) {
    800024c4:	ff010113          	addi	sp,sp,-16
    800024c8:	00113423          	sd	ra,8(sp)
    800024cc:	00813023          	sd	s0,0(sp)
    800024d0:	01010413          	addi	s0,sp,16
    PCB_List::freeObject(q->queue);
    800024d4:	00853503          	ld	a0,8(a0)
    800024d8:	00000097          	auipc	ra,0x0
    800024dc:	b90080e7          	jalr	-1136(ra) # 80002068 <_ZN8PCB_List10freeObjectEPS_>
}
    800024e0:	00813083          	ld	ra,8(sp)
    800024e4:	00013403          	ld	s0,0(sp)
    800024e8:	01010113          	addi	sp,sp,16
    800024ec:	00008067          	ret

00000000800024f0 <_ZN9BufferCPPC1Ei>:
#include "../h/buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800024f0:	fd010113          	addi	sp,sp,-48
    800024f4:	02113423          	sd	ra,40(sp)
    800024f8:	02813023          	sd	s0,32(sp)
    800024fc:	00913c23          	sd	s1,24(sp)
    80002500:	01213823          	sd	s2,16(sp)
    80002504:	01313423          	sd	s3,8(sp)
    80002508:	03010413          	addi	s0,sp,48
    8000250c:	00050493          	mv	s1,a0
    80002510:	00058913          	mv	s2,a1
    80002514:	0015879b          	addiw	a5,a1,1
    80002518:	0007851b          	sext.w	a0,a5
    8000251c:	00f4a023          	sw	a5,0(s1)
    80002520:	0004a823          	sw	zero,16(s1)
    80002524:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80002528:	00251513          	slli	a0,a0,0x2
    8000252c:	fffff097          	auipc	ra,0xfffff
    80002530:	c18080e7          	jalr	-1000(ra) # 80001144 <_Z9mem_allocm>
    80002534:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80002538:	01000513          	li	a0,16
    8000253c:	00001097          	auipc	ra,0x1
    80002540:	8d0080e7          	jalr	-1840(ra) # 80002e0c <_Znwm>
    80002544:	00050993          	mv	s3,a0
    80002548:	00000593          	li	a1,0
    8000254c:	00001097          	auipc	ra,0x1
    80002550:	a90080e7          	jalr	-1392(ra) # 80002fdc <_ZN9SemaphoreC1Ej>
    80002554:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80002558:	01000513          	li	a0,16
    8000255c:	00001097          	auipc	ra,0x1
    80002560:	8b0080e7          	jalr	-1872(ra) # 80002e0c <_Znwm>
    80002564:	00050993          	mv	s3,a0
    80002568:	00090593          	mv	a1,s2
    8000256c:	00001097          	auipc	ra,0x1
    80002570:	a70080e7          	jalr	-1424(ra) # 80002fdc <_ZN9SemaphoreC1Ej>
    80002574:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    80002578:	01000513          	li	a0,16
    8000257c:	00001097          	auipc	ra,0x1
    80002580:	890080e7          	jalr	-1904(ra) # 80002e0c <_Znwm>
    80002584:	00050913          	mv	s2,a0
    80002588:	00100593          	li	a1,1
    8000258c:	00001097          	auipc	ra,0x1
    80002590:	a50080e7          	jalr	-1456(ra) # 80002fdc <_ZN9SemaphoreC1Ej>
    80002594:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80002598:	01000513          	li	a0,16
    8000259c:	00001097          	auipc	ra,0x1
    800025a0:	870080e7          	jalr	-1936(ra) # 80002e0c <_Znwm>
    800025a4:	00050913          	mv	s2,a0
    800025a8:	00100593          	li	a1,1
    800025ac:	00001097          	auipc	ra,0x1
    800025b0:	a30080e7          	jalr	-1488(ra) # 80002fdc <_ZN9SemaphoreC1Ej>
    800025b4:	0324b823          	sd	s2,48(s1)
}
    800025b8:	02813083          	ld	ra,40(sp)
    800025bc:	02013403          	ld	s0,32(sp)
    800025c0:	01813483          	ld	s1,24(sp)
    800025c4:	01013903          	ld	s2,16(sp)
    800025c8:	00813983          	ld	s3,8(sp)
    800025cc:	03010113          	addi	sp,sp,48
    800025d0:	00008067          	ret
    800025d4:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    800025d8:	00098513          	mv	a0,s3
    800025dc:	00001097          	auipc	ra,0x1
    800025e0:	880080e7          	jalr	-1920(ra) # 80002e5c <_ZdlPv>
    800025e4:	00048513          	mv	a0,s1
    800025e8:	00009097          	auipc	ra,0x9
    800025ec:	c20080e7          	jalr	-992(ra) # 8000b208 <_Unwind_Resume>
    800025f0:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    800025f4:	00098513          	mv	a0,s3
    800025f8:	00001097          	auipc	ra,0x1
    800025fc:	864080e7          	jalr	-1948(ra) # 80002e5c <_ZdlPv>
    80002600:	00048513          	mv	a0,s1
    80002604:	00009097          	auipc	ra,0x9
    80002608:	c04080e7          	jalr	-1020(ra) # 8000b208 <_Unwind_Resume>
    8000260c:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80002610:	00090513          	mv	a0,s2
    80002614:	00001097          	auipc	ra,0x1
    80002618:	848080e7          	jalr	-1976(ra) # 80002e5c <_ZdlPv>
    8000261c:	00048513          	mv	a0,s1
    80002620:	00009097          	auipc	ra,0x9
    80002624:	be8080e7          	jalr	-1048(ra) # 8000b208 <_Unwind_Resume>
    80002628:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    8000262c:	00090513          	mv	a0,s2
    80002630:	00001097          	auipc	ra,0x1
    80002634:	82c080e7          	jalr	-2004(ra) # 80002e5c <_ZdlPv>
    80002638:	00048513          	mv	a0,s1
    8000263c:	00009097          	auipc	ra,0x9
    80002640:	bcc080e7          	jalr	-1076(ra) # 8000b208 <_Unwind_Resume>

0000000080002644 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80002644:	fe010113          	addi	sp,sp,-32
    80002648:	00113c23          	sd	ra,24(sp)
    8000264c:	00813823          	sd	s0,16(sp)
    80002650:	00913423          	sd	s1,8(sp)
    80002654:	01213023          	sd	s2,0(sp)
    80002658:	02010413          	addi	s0,sp,32
    8000265c:	00050493          	mv	s1,a0
    80002660:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80002664:	01853503          	ld	a0,24(a0)
    80002668:	00001097          	auipc	ra,0x1
    8000266c:	9ac080e7          	jalr	-1620(ra) # 80003014 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80002670:	0304b503          	ld	a0,48(s1)
    80002674:	00001097          	auipc	ra,0x1
    80002678:	9a0080e7          	jalr	-1632(ra) # 80003014 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    8000267c:	0084b783          	ld	a5,8(s1)
    80002680:	0144a703          	lw	a4,20(s1)
    80002684:	00271713          	slli	a4,a4,0x2
    80002688:	00e787b3          	add	a5,a5,a4
    8000268c:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80002690:	0144a783          	lw	a5,20(s1)
    80002694:	0017879b          	addiw	a5,a5,1
    80002698:	0004a703          	lw	a4,0(s1)
    8000269c:	02e7e7bb          	remw	a5,a5,a4
    800026a0:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    800026a4:	0304b503          	ld	a0,48(s1)
    800026a8:	00001097          	auipc	ra,0x1
    800026ac:	998080e7          	jalr	-1640(ra) # 80003040 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    800026b0:	0204b503          	ld	a0,32(s1)
    800026b4:	00001097          	auipc	ra,0x1
    800026b8:	98c080e7          	jalr	-1652(ra) # 80003040 <_ZN9Semaphore6signalEv>

}
    800026bc:	01813083          	ld	ra,24(sp)
    800026c0:	01013403          	ld	s0,16(sp)
    800026c4:	00813483          	ld	s1,8(sp)
    800026c8:	00013903          	ld	s2,0(sp)
    800026cc:	02010113          	addi	sp,sp,32
    800026d0:	00008067          	ret

00000000800026d4 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    800026d4:	fe010113          	addi	sp,sp,-32
    800026d8:	00113c23          	sd	ra,24(sp)
    800026dc:	00813823          	sd	s0,16(sp)
    800026e0:	00913423          	sd	s1,8(sp)
    800026e4:	01213023          	sd	s2,0(sp)
    800026e8:	02010413          	addi	s0,sp,32
    800026ec:	00050493          	mv	s1,a0
    itemAvailable->wait();
    800026f0:	02053503          	ld	a0,32(a0)
    800026f4:	00001097          	auipc	ra,0x1
    800026f8:	920080e7          	jalr	-1760(ra) # 80003014 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    800026fc:	0284b503          	ld	a0,40(s1)
    80002700:	00001097          	auipc	ra,0x1
    80002704:	914080e7          	jalr	-1772(ra) # 80003014 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80002708:	0084b703          	ld	a4,8(s1)
    8000270c:	0104a783          	lw	a5,16(s1)
    80002710:	00279693          	slli	a3,a5,0x2
    80002714:	00d70733          	add	a4,a4,a3
    80002718:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    8000271c:	0017879b          	addiw	a5,a5,1
    80002720:	0004a703          	lw	a4,0(s1)
    80002724:	02e7e7bb          	remw	a5,a5,a4
    80002728:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    8000272c:	0284b503          	ld	a0,40(s1)
    80002730:	00001097          	auipc	ra,0x1
    80002734:	910080e7          	jalr	-1776(ra) # 80003040 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80002738:	0184b503          	ld	a0,24(s1)
    8000273c:	00001097          	auipc	ra,0x1
    80002740:	904080e7          	jalr	-1788(ra) # 80003040 <_ZN9Semaphore6signalEv>

    return ret;
}
    80002744:	00090513          	mv	a0,s2
    80002748:	01813083          	ld	ra,24(sp)
    8000274c:	01013403          	ld	s0,16(sp)
    80002750:	00813483          	ld	s1,8(sp)
    80002754:	00013903          	ld	s2,0(sp)
    80002758:	02010113          	addi	sp,sp,32
    8000275c:	00008067          	ret

0000000080002760 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80002760:	fe010113          	addi	sp,sp,-32
    80002764:	00113c23          	sd	ra,24(sp)
    80002768:	00813823          	sd	s0,16(sp)
    8000276c:	00913423          	sd	s1,8(sp)
    80002770:	01213023          	sd	s2,0(sp)
    80002774:	02010413          	addi	s0,sp,32
    80002778:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    8000277c:	02853503          	ld	a0,40(a0)
    80002780:	00001097          	auipc	ra,0x1
    80002784:	894080e7          	jalr	-1900(ra) # 80003014 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80002788:	0304b503          	ld	a0,48(s1)
    8000278c:	00001097          	auipc	ra,0x1
    80002790:	888080e7          	jalr	-1912(ra) # 80003014 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80002794:	0144a783          	lw	a5,20(s1)
    80002798:	0104a903          	lw	s2,16(s1)
    8000279c:	0327ce63          	blt	a5,s2,800027d8 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    800027a0:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    800027a4:	0304b503          	ld	a0,48(s1)
    800027a8:	00001097          	auipc	ra,0x1
    800027ac:	898080e7          	jalr	-1896(ra) # 80003040 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    800027b0:	0284b503          	ld	a0,40(s1)
    800027b4:	00001097          	auipc	ra,0x1
    800027b8:	88c080e7          	jalr	-1908(ra) # 80003040 <_ZN9Semaphore6signalEv>

    return ret;
}
    800027bc:	00090513          	mv	a0,s2
    800027c0:	01813083          	ld	ra,24(sp)
    800027c4:	01013403          	ld	s0,16(sp)
    800027c8:	00813483          	ld	s1,8(sp)
    800027cc:	00013903          	ld	s2,0(sp)
    800027d0:	02010113          	addi	sp,sp,32
    800027d4:	00008067          	ret
        ret = cap - head + tail;
    800027d8:	0004a703          	lw	a4,0(s1)
    800027dc:	4127093b          	subw	s2,a4,s2
    800027e0:	00f9093b          	addw	s2,s2,a5
    800027e4:	fc1ff06f          	j	800027a4 <_ZN9BufferCPP6getCntEv+0x44>

00000000800027e8 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    800027e8:	fe010113          	addi	sp,sp,-32
    800027ec:	00113c23          	sd	ra,24(sp)
    800027f0:	00813823          	sd	s0,16(sp)
    800027f4:	00913423          	sd	s1,8(sp)
    800027f8:	02010413          	addi	s0,sp,32
    800027fc:	00050493          	mv	s1,a0
    Console::putc('\n');
    80002800:	00a00513          	li	a0,10
    80002804:	00001097          	auipc	ra,0x1
    80002808:	894080e7          	jalr	-1900(ra) # 80003098 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    8000280c:	00006517          	auipc	a0,0x6
    80002810:	81450513          	addi	a0,a0,-2028 # 80008020 <CONSOLE_STATUS+0x10>
    80002814:	00000097          	auipc	ra,0x0
    80002818:	8cc080e7          	jalr	-1844(ra) # 800020e0 <_Z11printStringPKc>
    while (getCnt()) {
    8000281c:	00048513          	mv	a0,s1
    80002820:	00000097          	auipc	ra,0x0
    80002824:	f40080e7          	jalr	-192(ra) # 80002760 <_ZN9BufferCPP6getCntEv>
    80002828:	02050c63          	beqz	a0,80002860 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    8000282c:	0084b783          	ld	a5,8(s1)
    80002830:	0104a703          	lw	a4,16(s1)
    80002834:	00271713          	slli	a4,a4,0x2
    80002838:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    8000283c:	0007c503          	lbu	a0,0(a5)
    80002840:	00001097          	auipc	ra,0x1
    80002844:	858080e7          	jalr	-1960(ra) # 80003098 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80002848:	0104a783          	lw	a5,16(s1)
    8000284c:	0017879b          	addiw	a5,a5,1
    80002850:	0004a703          	lw	a4,0(s1)
    80002854:	02e7e7bb          	remw	a5,a5,a4
    80002858:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    8000285c:	fc1ff06f          	j	8000281c <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    80002860:	02100513          	li	a0,33
    80002864:	00001097          	auipc	ra,0x1
    80002868:	834080e7          	jalr	-1996(ra) # 80003098 <_ZN7Console4putcEc>
    Console::putc('\n');
    8000286c:	00a00513          	li	a0,10
    80002870:	00001097          	auipc	ra,0x1
    80002874:	828080e7          	jalr	-2008(ra) # 80003098 <_ZN7Console4putcEc>
    mem_free(buffer);
    80002878:	0084b503          	ld	a0,8(s1)
    8000287c:	fffff097          	auipc	ra,0xfffff
    80002880:	8f4080e7          	jalr	-1804(ra) # 80001170 <_Z8mem_freePv>
    delete itemAvailable;
    80002884:	0204b503          	ld	a0,32(s1)
    80002888:	00050863          	beqz	a0,80002898 <_ZN9BufferCPPD1Ev+0xb0>
    8000288c:	00053783          	ld	a5,0(a0)
    80002890:	0087b783          	ld	a5,8(a5)
    80002894:	000780e7          	jalr	a5
    delete spaceAvailable;
    80002898:	0184b503          	ld	a0,24(s1)
    8000289c:	00050863          	beqz	a0,800028ac <_ZN9BufferCPPD1Ev+0xc4>
    800028a0:	00053783          	ld	a5,0(a0)
    800028a4:	0087b783          	ld	a5,8(a5)
    800028a8:	000780e7          	jalr	a5
    delete mutexTail;
    800028ac:	0304b503          	ld	a0,48(s1)
    800028b0:	00050863          	beqz	a0,800028c0 <_ZN9BufferCPPD1Ev+0xd8>
    800028b4:	00053783          	ld	a5,0(a0)
    800028b8:	0087b783          	ld	a5,8(a5)
    800028bc:	000780e7          	jalr	a5
    delete mutexHead;
    800028c0:	0284b503          	ld	a0,40(s1)
    800028c4:	00050863          	beqz	a0,800028d4 <_ZN9BufferCPPD1Ev+0xec>
    800028c8:	00053783          	ld	a5,0(a0)
    800028cc:	0087b783          	ld	a5,8(a5)
    800028d0:	000780e7          	jalr	a5
}
    800028d4:	01813083          	ld	ra,24(sp)
    800028d8:	01013403          	ld	s0,16(sp)
    800028dc:	00813483          	ld	s1,8(sp)
    800028e0:	02010113          	addi	sp,sp,32
    800028e4:	00008067          	ret

00000000800028e8 <_Z5test1v>:
    long id;
    bool finished;
};


void test1() {
    800028e8:	fd010113          	addi	sp,sp,-48
    800028ec:	02113423          	sd	ra,40(sp)
    800028f0:	02813023          	sd	s0,32(sp)
    800028f4:	03010413          	addi	s0,sp,48
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    800028f8:	00007797          	auipc	a5,0x7
    800028fc:	5e878793          	addi	a5,a5,1512 # 80009ee0 <_ZTV10ForkThread+0x10>
    80002900:	fcf43823          	sd	a5,-48(s0)
    80002904:	00100793          	li	a5,1
    80002908:	fef43023          	sd	a5,-32(s0)
    8000290c:	fe040423          	sb	zero,-24(s0)
    ForkThread thread(1);

    thread.start();
    80002910:	fd040513          	addi	a0,s0,-48
    80002914:	00000097          	auipc	ra,0x0
    80002918:	63c080e7          	jalr	1596(ra) # 80002f50 <_ZN6Thread5startEv>
        return finished;
    8000291c:	fe844783          	lbu	a5,-24(s0)

    while (!thread.isFinished()) {
    80002920:	00079863          	bnez	a5,80002930 <_Z5test1v+0x48>
        thread_dispatch();
    80002924:	fffff097          	auipc	ra,0xfffff
    80002928:	8f4080e7          	jalr	-1804(ra) # 80001218 <_Z15thread_dispatchv>
    8000292c:	ff1ff06f          	j	8000291c <_Z5test1v+0x34>
    }

    printString("User main finished\n");
    80002930:	00005517          	auipc	a0,0x5
    80002934:	73850513          	addi	a0,a0,1848 # 80008068 <CONSOLE_STATUS+0x58>
    80002938:	fffff097          	auipc	ra,0xfffff
    8000293c:	7a8080e7          	jalr	1960(ra) # 800020e0 <_Z11printStringPKc>
}
    80002940:	02813083          	ld	ra,40(sp)
    80002944:	02013403          	ld	s0,32(sp)
    80002948:	03010113          	addi	sp,sp,48
    8000294c:	00008067          	ret

0000000080002950 <_Z8userMainv>:
//#include "../test/ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta

#include "../javni_test/prvi/test1.hpp"
//#include "../javni_test/drugi/test2.hpp"

void userMain() {
    80002950:	ff010113          	addi	sp,sp,-16
    80002954:	00113423          	sd	ra,8(sp)
    80002958:	00813023          	sd	s0,0(sp)
    8000295c:	01010413          	addi	s0,sp,16
    //producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

    //testSleeping(); // thread_sleep test C API
    //ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega

    test1();
    80002960:	00000097          	auipc	ra,0x0
    80002964:	f88080e7          	jalr	-120(ra) # 800028e8 <_Z5test1v>
    //test2();

    80002968:	00813083          	ld	ra,8(sp)
    8000296c:	00013403          	ld	s0,0(sp)
    80002970:	01010113          	addi	sp,sp,16
    80002974:	00008067          	ret

0000000080002978 <_ZN10ForkThreadD1Ev>:
class ForkThread : public Thread {
    80002978:	ff010113          	addi	sp,sp,-16
    8000297c:	00813423          	sd	s0,8(sp)
    80002980:	01010413          	addi	s0,sp,16
    80002984:	00813403          	ld	s0,8(sp)
    80002988:	01010113          	addi	sp,sp,16
    8000298c:	00008067          	ret

0000000080002990 <_ZN10ForkThreadD0Ev>:
    80002990:	ff010113          	addi	sp,sp,-16
    80002994:	00113423          	sd	ra,8(sp)
    80002998:	00813023          	sd	s0,0(sp)
    8000299c:	01010413          	addi	s0,sp,16
    800029a0:	00000097          	auipc	ra,0x0
    800029a4:	4bc080e7          	jalr	1212(ra) # 80002e5c <_ZdlPv>
    800029a8:	00813083          	ld	ra,8(sp)
    800029ac:	00013403          	ld	s0,0(sp)
    800029b0:	01010113          	addi	sp,sp,16
    800029b4:	00008067          	ret

00000000800029b8 <_ZN10ForkThread3runEv>:
    virtual void run() {
    800029b8:	fc010113          	addi	sp,sp,-64
    800029bc:	02113c23          	sd	ra,56(sp)
    800029c0:	02813823          	sd	s0,48(sp)
    800029c4:	02913423          	sd	s1,40(sp)
    800029c8:	03213023          	sd	s2,32(sp)
    800029cc:	01313c23          	sd	s3,24(sp)
    800029d0:	01413823          	sd	s4,16(sp)
    800029d4:	01513423          	sd	s5,8(sp)
    800029d8:	04010413          	addi	s0,sp,64
    800029dc:	00050a13          	mv	s4,a0
        printString("Started thread id:");
    800029e0:	00005517          	auipc	a0,0x5
    800029e4:	65850513          	addi	a0,a0,1624 # 80008038 <CONSOLE_STATUS+0x28>
    800029e8:	fffff097          	auipc	ra,0xfffff
    800029ec:	6f8080e7          	jalr	1784(ra) # 800020e0 <_Z11printStringPKc>
        printInt(id);
    800029f0:	00000613          	li	a2,0
    800029f4:	00a00593          	li	a1,10
    800029f8:	010a2503          	lw	a0,16(s4)
    800029fc:	00000097          	auipc	ra,0x0
    80002a00:	87c080e7          	jalr	-1924(ra) # 80002278 <_Z8printIntiii>
        printString("\n");
    80002a04:	00006517          	auipc	a0,0x6
    80002a08:	9b450513          	addi	a0,a0,-1612 # 800083b8 <CONSOLE_STATUS+0x3a8>
    80002a0c:	fffff097          	auipc	ra,0xfffff
    80002a10:	6d4080e7          	jalr	1748(ra) # 800020e0 <_Z11printStringPKc>
        ForkThread* thread = new ForkThread(id + 1);
    80002a14:	02000513          	li	a0,32
    80002a18:	00000097          	auipc	ra,0x0
    80002a1c:	3f4080e7          	jalr	1012(ra) # 80002e0c <_Znwm>
    80002a20:	00050993          	mv	s3,a0
    80002a24:	010a3503          	ld	a0,16(s4)
    80002a28:	00150793          	addi	a5,a0,1
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    80002a2c:	00007717          	auipc	a4,0x7
    80002a30:	4b470713          	addi	a4,a4,1204 # 80009ee0 <_ZTV10ForkThread+0x10>
    80002a34:	00e9b023          	sd	a4,0(s3)
    80002a38:	00f9b823          	sd	a5,16(s3)
    80002a3c:	00098c23          	sb	zero,24(s3)
        ForkThread** threads = (ForkThread** ) mem_alloc(sizeof(ForkThread*) * id);
    80002a40:	00351513          	slli	a0,a0,0x3
    80002a44:	ffffe097          	auipc	ra,0xffffe
    80002a48:	700080e7          	jalr	1792(ra) # 80001144 <_Z9mem_allocm>
        if (threads != nullptr) {
    80002a4c:	10050063          	beqz	a0,80002b4c <_ZN10ForkThread3runEv+0x194>
    80002a50:	00050a93          	mv	s5,a0
            for (long i = 0; i < id; i++) {
    80002a54:	00000493          	li	s1,0
    80002a58:	010a3783          	ld	a5,16(s4)
    80002a5c:	02f4de63          	bge	s1,a5,80002a98 <_ZN10ForkThread3runEv+0xe0>
                threads[i] = new ForkThread(id);
    80002a60:	02000513          	li	a0,32
    80002a64:	00000097          	auipc	ra,0x0
    80002a68:	3a8080e7          	jalr	936(ra) # 80002e0c <_Znwm>
    80002a6c:	010a3703          	ld	a4,16(s4)
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    80002a70:	00007697          	auipc	a3,0x7
    80002a74:	47068693          	addi	a3,a3,1136 # 80009ee0 <_ZTV10ForkThread+0x10>
    80002a78:	00d53023          	sd	a3,0(a0)
    80002a7c:	00e53823          	sd	a4,16(a0)
    80002a80:	00050c23          	sb	zero,24(a0)
                threads[i] = new ForkThread(id);
    80002a84:	00349713          	slli	a4,s1,0x3
    80002a88:	00ea8733          	add	a4,s5,a4
    80002a8c:	00a73023          	sd	a0,0(a4)
            for (long i = 0; i < id; i++) {
    80002a90:	00148493          	addi	s1,s1,1
    80002a94:	fc5ff06f          	j	80002a58 <_ZN10ForkThread3runEv+0xa0>
            if (thread != nullptr) {
    80002a98:	06098a63          	beqz	s3,80002b0c <_ZN10ForkThread3runEv+0x154>
                if (thread->start() == 0) {
    80002a9c:	00098513          	mv	a0,s3
    80002aa0:	00000097          	auipc	ra,0x0
    80002aa4:	4b0080e7          	jalr	1200(ra) # 80002f50 <_ZN6Thread5startEv>
    80002aa8:	00050913          	mv	s2,a0
    80002aac:	04051863          	bnez	a0,80002afc <_ZN10ForkThread3runEv+0x144>
                    for (int i = 0; i < 5000; i++) {
    80002ab0:	00050493          	mv	s1,a0
    80002ab4:	0100006f          	j	80002ac4 <_ZN10ForkThread3runEv+0x10c>
                        thread_dispatch();
    80002ab8:	ffffe097          	auipc	ra,0xffffe
    80002abc:	760080e7          	jalr	1888(ra) # 80001218 <_Z15thread_dispatchv>
                    for (int i = 0; i < 5000; i++) {
    80002ac0:	0014849b          	addiw	s1,s1,1
    80002ac4:	000017b7          	lui	a5,0x1
    80002ac8:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    80002acc:	0097ce63          	blt	a5,s1,80002ae8 <_ZN10ForkThread3runEv+0x130>
                        for (int j = 0; j < 5000; j++) {
    80002ad0:	00090713          	mv	a4,s2
    80002ad4:	000017b7          	lui	a5,0x1
    80002ad8:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    80002adc:	fce7cee3          	blt	a5,a4,80002ab8 <_ZN10ForkThread3runEv+0x100>
    80002ae0:	0017071b          	addiw	a4,a4,1
    80002ae4:	ff1ff06f          	j	80002ad4 <_ZN10ForkThread3runEv+0x11c>
        return finished;
    80002ae8:	0189c783          	lbu	a5,24(s3)
                    while (!thread->isFinished()) {
    80002aec:	00079863          	bnez	a5,80002afc <_ZN10ForkThread3runEv+0x144>
                        thread_dispatch();
    80002af0:	ffffe097          	auipc	ra,0xffffe
    80002af4:	728080e7          	jalr	1832(ra) # 80001218 <_Z15thread_dispatchv>
                    while (!thread->isFinished()) {
    80002af8:	ff1ff06f          	j	80002ae8 <_ZN10ForkThread3runEv+0x130>
                delete thread;
    80002afc:	0009b783          	ld	a5,0(s3)
    80002b00:	0107b783          	ld	a5,16(a5)
    80002b04:	00098513          	mv	a0,s3
    80002b08:	000780e7          	jalr	a5
                        for (int j = 0; j < 5000; j++) {
    80002b0c:	00000493          	li	s1,0
    80002b10:	0080006f          	j	80002b18 <_ZN10ForkThread3runEv+0x160>
            for (long i = 0; i < id; i++) {
    80002b14:	00148493          	addi	s1,s1,1
    80002b18:	010a3783          	ld	a5,16(s4)
    80002b1c:	02f4d263          	bge	s1,a5,80002b40 <_ZN10ForkThread3runEv+0x188>
                delete threads[i];
    80002b20:	00349793          	slli	a5,s1,0x3
    80002b24:	00fa87b3          	add	a5,s5,a5
    80002b28:	0007b503          	ld	a0,0(a5)
    80002b2c:	fe0504e3          	beqz	a0,80002b14 <_ZN10ForkThread3runEv+0x15c>
    80002b30:	00053783          	ld	a5,0(a0)
    80002b34:	0107b783          	ld	a5,16(a5)
    80002b38:	000780e7          	jalr	a5
    80002b3c:	fd9ff06f          	j	80002b14 <_ZN10ForkThread3runEv+0x15c>
            mem_free(threads);
    80002b40:	000a8513          	mv	a0,s5
    80002b44:	ffffe097          	auipc	ra,0xffffe
    80002b48:	62c080e7          	jalr	1580(ra) # 80001170 <_Z8mem_freePv>
        printString("Finished thread id:");
    80002b4c:	00005517          	auipc	a0,0x5
    80002b50:	50450513          	addi	a0,a0,1284 # 80008050 <CONSOLE_STATUS+0x40>
    80002b54:	fffff097          	auipc	ra,0xfffff
    80002b58:	58c080e7          	jalr	1420(ra) # 800020e0 <_Z11printStringPKc>
        printInt(id);
    80002b5c:	00000613          	li	a2,0
    80002b60:	00a00593          	li	a1,10
    80002b64:	010a2503          	lw	a0,16(s4)
    80002b68:	fffff097          	auipc	ra,0xfffff
    80002b6c:	710080e7          	jalr	1808(ra) # 80002278 <_Z8printIntiii>
        printString("\n");
    80002b70:	00006517          	auipc	a0,0x6
    80002b74:	84850513          	addi	a0,a0,-1976 # 800083b8 <CONSOLE_STATUS+0x3a8>
    80002b78:	fffff097          	auipc	ra,0xfffff
    80002b7c:	568080e7          	jalr	1384(ra) # 800020e0 <_Z11printStringPKc>
        finished = true;
    80002b80:	00100793          	li	a5,1
    80002b84:	00fa0c23          	sb	a5,24(s4)
    }
    80002b88:	03813083          	ld	ra,56(sp)
    80002b8c:	03013403          	ld	s0,48(sp)
    80002b90:	02813483          	ld	s1,40(sp)
    80002b94:	02013903          	ld	s2,32(sp)
    80002b98:	01813983          	ld	s3,24(sp)
    80002b9c:	01013a03          	ld	s4,16(sp)
    80002ba0:	00813a83          	ld	s5,8(sp)
    80002ba4:	04010113          	addi	sp,sp,64
    80002ba8:	00008067          	ret

0000000080002bac <main>:
#include "../h/PCB.hpp"
#include "../h/userMain.hpp"
#include "../h/SEM.hpp"
#include "../h/PCB_List.hpp"

int main(){
    80002bac:	fd010113          	addi	sp,sp,-48
    80002bb0:	02113423          	sd	ra,40(sp)
    80002bb4:	02813023          	sd	s0,32(sp)
    80002bb8:	00913c23          	sd	s1,24(sp)
    80002bbc:	01213823          	sd	s2,16(sp)
    80002bc0:	01313423          	sd	s3,8(sp)
    80002bc4:	03010413          	addi	s0,sp,48

    int blockNum = (int)(((uint64)HEAP_END_ADDR - (uint64)HEAP_START_ADDR) / (BLOCK_SIZE * 8));
    80002bc8:	00007997          	auipc	s3,0x7
    80002bcc:	3989b983          	ld	s3,920(s3) # 80009f60 <_GLOBAL_OFFSET_TABLE_+0x30>
    80002bd0:	0009b503          	ld	a0,0(s3)
    80002bd4:	00007917          	auipc	s2,0x7
    80002bd8:	41493903          	ld	s2,1044(s2) # 80009fe8 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80002bdc:	00093483          	ld	s1,0(s2)
    80002be0:	40a484b3          	sub	s1,s1,a0
    80002be4:	00f4d493          	srli	s1,s1,0xf
    80002be8:	0004849b          	sext.w	s1,s1
    kmem_init((void *)HEAP_START_ADDR, blockNum);
    80002bec:	00048593          	mv	a1,s1
    80002bf0:	00002097          	auipc	ra,0x2
    80002bf4:	3ec080e7          	jalr	1004(ra) # 80004fdc <_Z9kmem_initPvi>
    MemoryAllocator::mem_init((void *)((uint64)HEAP_START_ADDR + (uint64)blockNum * BLOCK_SIZE), (void *)HEAP_END_ADDR);
    80002bf8:	00c49493          	slli	s1,s1,0xc
    80002bfc:	0009b503          	ld	a0,0(s3)
    80002c00:	00093583          	ld	a1,0(s2)
    80002c04:	00950533          	add	a0,a0,s1
    80002c08:	00001097          	auipc	ra,0x1
    80002c0c:	2f8080e7          	jalr	760(ra) # 80003f00 <_ZN15MemoryAllocator8mem_initEPvS0_>

    //Creating kmem_caches for different objects
    kmem_cache_t *PCB_k = kmem_cache_create("PCB", sizeof(PCB), nullptr, (void (*)(void *))(PCB::dtor));
    80002c10:	00007697          	auipc	a3,0x7
    80002c14:	3f86b683          	ld	a3,1016(a3) # 8000a008 <_GLOBAL_OFFSET_TABLE_+0xd8>
    80002c18:	00000613          	li	a2,0
    80002c1c:	04000593          	li	a1,64
    80002c20:	00005517          	auipc	a0,0x5
    80002c24:	46050513          	addi	a0,a0,1120 # 80008080 <CONSOLE_STATUS+0x70>
    80002c28:	00002097          	auipc	ra,0x2
    80002c2c:	3ec080e7          	jalr	1004(ra) # 80005014 <_Z17kmem_cache_createPKcmPFvPvES3_>
    static void setCache(kmem_cache_t *c) { PCB::cache = c; }
    80002c30:	00007797          	auipc	a5,0x7
    80002c34:	3487b783          	ld	a5,840(a5) # 80009f78 <_GLOBAL_OFFSET_TABLE_+0x48>
    80002c38:	00a7b023          	sd	a0,0(a5)
    PCB::setCache(PCB_k);

    kmem_cache_t *SEM_k = kmem_cache_create("SEM", sizeof(SEM), nullptr, (void (*)(void *))(SEM::dtor));
    80002c3c:	00007697          	auipc	a3,0x7
    80002c40:	32c6b683          	ld	a3,812(a3) # 80009f68 <_GLOBAL_OFFSET_TABLE_+0x38>
    80002c44:	00000613          	li	a2,0
    80002c48:	01000593          	li	a1,16
    80002c4c:	00005517          	auipc	a0,0x5
    80002c50:	43c50513          	addi	a0,a0,1084 # 80008088 <CONSOLE_STATUS+0x78>
    80002c54:	00002097          	auipc	ra,0x2
    80002c58:	3c0080e7          	jalr	960(ra) # 80005014 <_Z17kmem_cache_createPKcmPFvPvES3_>
#include "./PCB.hpp"
#include "./Queue.hpp"

class SEM{
public:
    static void setCache(kmem_cache_t *c) { SEM::cache = c; }
    80002c5c:	00007797          	auipc	a5,0x7
    80002c60:	3a47b783          	ld	a5,932(a5) # 8000a000 <_GLOBAL_OFFSET_TABLE_+0xd0>
    80002c64:	00a7b023          	sd	a0,0(a5)
    SEM::setCache(SEM_k);


    kmem_cache_t *QUEUE_k = kmem_cache_create("QUEUE", sizeof(Queue), nullptr, (void (*)(void *))(Queue::dtor));
    80002c68:	00007697          	auipc	a3,0x7
    80002c6c:	3886b683          	ld	a3,904(a3) # 80009ff0 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80002c70:	00000613          	li	a2,0
    80002c74:	01000593          	li	a1,16
    80002c78:	00005517          	auipc	a0,0x5
    80002c7c:	41850513          	addi	a0,a0,1048 # 80008090 <CONSOLE_STATUS+0x80>
    80002c80:	00002097          	auipc	ra,0x2
    80002c84:	394080e7          	jalr	916(ra) # 80005014 <_Z17kmem_cache_createPKcmPFvPvES3_>

class PCB_List;

class Queue{
public:
    static void setCache(kmem_cache_t *c) { Queue::cache = c; }
    80002c88:	00007797          	auipc	a5,0x7
    80002c8c:	3887b783          	ld	a5,904(a5) # 8000a010 <_GLOBAL_OFFSET_TABLE_+0xe0>
    80002c90:	00a7b023          	sd	a0,0(a5)
    Queue::setCache(QUEUE_k);


    kmem_cache_t *PCB_List_k = kmem_cache_create("PCB_List", sizeof(PCB_List), nullptr, (void (*)(void *))(PCB_List::dtor));
    80002c94:	00007697          	auipc	a3,0x7
    80002c98:	33c6b683          	ld	a3,828(a3) # 80009fd0 <_GLOBAL_OFFSET_TABLE_+0xa0>
    80002c9c:	00000613          	li	a2,0
    80002ca0:	01000593          	li	a1,16
    80002ca4:	00005517          	auipc	a0,0x5
    80002ca8:	3f450513          	addi	a0,a0,1012 # 80008098 <CONSOLE_STATUS+0x88>
    80002cac:	00002097          	auipc	ra,0x2
    80002cb0:	368080e7          	jalr	872(ra) # 80005014 <_Z17kmem_cache_createPKcmPFvPvES3_>
        }
    };

    static void setCache(kmem_cache_t *c) { PCB_List::cache = c; }
    80002cb4:	00007797          	auipc	a5,0x7
    80002cb8:	3447b783          	ld	a5,836(a5) # 80009ff8 <_GLOBAL_OFFSET_TABLE_+0xc8>
    80002cbc:	00a7b023          	sd	a0,0(a5)
    PCB_List::setCache(PCB_List_k);

    kmem_cache_t *PCB_List_Elem_k = kmem_cache_create("PCB_List_Elem", sizeof(PCB_List::Elem), nullptr, nullptr);
    80002cc0:	00000693          	li	a3,0
    80002cc4:	00000613          	li	a2,0
    80002cc8:	01000593          	li	a1,16
    80002ccc:	00005517          	auipc	a0,0x5
    80002cd0:	3dc50513          	addi	a0,a0,988 # 800080a8 <CONSOLE_STATUS+0x98>
    80002cd4:	00002097          	auipc	ra,0x2
    80002cd8:	340080e7          	jalr	832(ra) # 80005014 <_Z17kmem_cache_createPKcmPFvPvES3_>
        static void setCache(kmem_cache_t *c){ Elem::elemCache = c; }
    80002cdc:	00007797          	auipc	a5,0x7
    80002ce0:	2a47b783          	ld	a5,676(a5) # 80009f80 <_GLOBAL_OFFSET_TABLE_+0x50>
    80002ce4:	00a7b023          	sd	a0,0(a5)
    PCB_List::Elem::setCache(PCB_List_Elem_k);

    kmem_cache_t *SLEEP_Q_k = kmem_cache_create("SleepQ", sizeof(SleepQ::ElemQ), nullptr, nullptr);
    80002ce8:	00000693          	li	a3,0
    80002cec:	00000613          	li	a2,0
    80002cf0:	01800593          	li	a1,24
    80002cf4:	00005517          	auipc	a0,0x5
    80002cf8:	3c450513          	addi	a0,a0,964 # 800080b8 <CONSOLE_STATUS+0xa8>
    80002cfc:	00002097          	auipc	ra,0x2
    80002d00:	318080e7          	jalr	792(ra) # 80005014 <_Z17kmem_cache_createPKcmPFvPvES3_>
            return MemoryAllocator::sys_mem_alloc(size);
        }
        void operator delete(void *p){
            MemoryAllocator::sys_mem_free(p);
        }
        static void setCache(kmem_cache_t *c){ ElemQ::cache = c; }
    80002d04:	00007797          	auipc	a5,0x7
    80002d08:	26c7b783          	ld	a5,620(a5) # 80009f70 <_GLOBAL_OFFSET_TABLE_+0x40>
    80002d0c:	00a7b023          	sd	a0,0(a5)
    SleepQ::ElemQ::setCache(SLEEP_Q_k);

    //init scheduler
    kmem_cache_t *SCHEDULER_k = kmem_cache_create("SCHEDULER", sizeof(PCB_List), nullptr, (void (*)(void *))(PCB_List::dtor));
    80002d10:	00007697          	auipc	a3,0x7
    80002d14:	2c06b683          	ld	a3,704(a3) # 80009fd0 <_GLOBAL_OFFSET_TABLE_+0xa0>
    80002d18:	00000613          	li	a2,0
    80002d1c:	01000593          	li	a1,16
    80002d20:	00005517          	auipc	a0,0x5
    80002d24:	3a050513          	addi	a0,a0,928 # 800080c0 <CONSOLE_STATUS+0xb0>
    80002d28:	00002097          	auipc	ra,0x2
    80002d2c:	2ec080e7          	jalr	748(ra) # 80005014 <_Z17kmem_cache_createPKcmPFvPvES3_>
    Scheduler::createScheduler(SCHEDULER_k);
    80002d30:	00001097          	auipc	ra,0x1
    80002d34:	148080e7          	jalr	328(ra) # 80003e78 <_ZN9Scheduler15createSchedulerEP10kmem_cache>

    //init threads
    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
    80002d38:	00007797          	auipc	a5,0x7
    80002d3c:	2807b783          	ld	a5,640(a5) # 80009fb8 <_GLOBAL_OFFSET_TABLE_+0x88>
    return stvec;
}

inline void Riscv::w_stvec(uint64 stvec)
{
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    80002d40:	10579073          	csrw	stvec,a5

    thread_t main;
    //thread_t getDataFromConsole_t;
    thread_t sendDataToConsole_t;
    thread_t userMain_t;
    main = PCB::createThread(nullptr, nullptr);
    80002d44:	00000593          	li	a1,0
    80002d48:	00000513          	li	a0,0
    80002d4c:	ffffe097          	auipc	ra,0xffffe
    80002d50:	7a4080e7          	jalr	1956(ra) # 800014f0 <_ZN3PCB12createThreadEPFvPvES0_>
    PCB::running = main;
    80002d54:	00007797          	auipc	a5,0x7
    80002d58:	28c7b783          	ld	a5,652(a5) # 80009fe0 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80002d5c:	00a7b023          	sd	a0,0(a5)
    PCB::main_t = main;
    80002d60:	00007797          	auipc	a5,0x7
    80002d64:	2507b783          	ld	a5,592(a5) # 80009fb0 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002d68:	00a7b023          	sd	a0,0(a5)
    userMain_t = PCB::createThread((void(*)(void*))(userMain), nullptr);
    80002d6c:	00000593          	li	a1,0
    80002d70:	00007517          	auipc	a0,0x7
    80002d74:	1c853503          	ld	a0,456(a0) # 80009f38 <_GLOBAL_OFFSET_TABLE_+0x8>
    80002d78:	ffffe097          	auipc	ra,0xffffe
    80002d7c:	778080e7          	jalr	1912(ra) # 800014f0 <_ZN3PCB12createThreadEPFvPvES0_>
    80002d80:	00050913          	mv	s2,a0
    PCB::user_main_t = userMain_t;
    80002d84:	00007797          	auipc	a5,0x7
    80002d88:	20c7b783          	ld	a5,524(a5) # 80009f90 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002d8c:	00a7b023          	sd	a0,0(a5)
    sendDataToConsole_t = PCB::createThread((void (*)(void *))ConsoleHandler::sendDataToConsole, nullptr);
    80002d90:	00000593          	li	a1,0
    80002d94:	00007517          	auipc	a0,0x7
    80002d98:	1ac53503          	ld	a0,428(a0) # 80009f40 <_GLOBAL_OFFSET_TABLE_+0x10>
    80002d9c:	ffffe097          	auipc	ra,0xffffe
    80002da0:	754080e7          	jalr	1876(ra) # 800014f0 <_ZN3PCB12createThreadEPFvPvES0_>
    PCB::console_t = sendDataToConsole_t;
    80002da4:	00007797          	auipc	a5,0x7
    80002da8:	1f47b783          	ld	a5,500(a5) # 80009f98 <_GLOBAL_OFFSET_TABLE_+0x68>
    80002dac:	00a7b023          	sd	a0,0(a5)
    __asm__ volatile ("csrw sip, %[sip]" : : [sip] "r"(sip));
}

inline void Riscv::ms_sstatus(uint64 mask)
{
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80002db0:	00200793          	li	a5,2
    80002db4:	1007a073          	csrs	sstatus,a5
    static uint64 get_thread_counter() {return PCB::thread_counter;}
    80002db8:	00007797          	auipc	a5,0x7
    80002dbc:	2107b783          	ld	a5,528(a5) # 80009fc8 <_GLOBAL_OFFSET_TABLE_+0x98>
    80002dc0:	0007b483          	ld	s1,0(a5)
    80002dc4:	0180006f          	j	80002ddc <main+0x230>
    80002dc8:	00007797          	auipc	a5,0x7
    80002dcc:	2007b783          	ld	a5,512(a5) # 80009fc8 <_GLOBAL_OFFSET_TABLE_+0x98>
    80002dd0:	0007b483          	ld	s1,0(a5)
    Riscv::ms_sstatus(Riscv::SSTATUS_SIE);

    uint64 cont = PCB::get_thread_counter();
    while(!(userMain_t->isFinished()) || cont > 2){
        cont = PCB::get_thread_counter();
        thread_dispatch();
    80002dd4:	ffffe097          	auipc	ra,0xffffe
    80002dd8:	444080e7          	jalr	1092(ra) # 80001218 <_Z15thread_dispatchv>
    bool isFinished() const { return finished; }
    80002ddc:	03894783          	lbu	a5,56(s2)
    while(!(userMain_t->isFinished()) || cont > 2){
    80002de0:	fe0784e3          	beqz	a5,80002dc8 <main+0x21c>
    80002de4:	00200793          	li	a5,2
    80002de8:	fe97e0e3          	bltu	a5,s1,80002dc8 <main+0x21c>
    }
    return 0;
    80002dec:	00000513          	li	a0,0
    80002df0:	02813083          	ld	ra,40(sp)
    80002df4:	02013403          	ld	s0,32(sp)
    80002df8:	01813483          	ld	s1,24(sp)
    80002dfc:	01013903          	ld	s2,16(sp)
    80002e00:	00813983          	ld	s3,8(sp)
    80002e04:	03010113          	addi	sp,sp,48
    80002e08:	00008067          	ret

0000000080002e0c <_Znwm>:
#include "../h/syscall_c.hpp"

//using size_t = decltype(sizeof(0));

void *operator new(size_t n)
{
    80002e0c:	ff010113          	addi	sp,sp,-16
    80002e10:	00113423          	sd	ra,8(sp)
    80002e14:	00813023          	sd	s0,0(sp)
    80002e18:	01010413          	addi	s0,sp,16
    return mem_alloc(n);
    80002e1c:	ffffe097          	auipc	ra,0xffffe
    80002e20:	328080e7          	jalr	808(ra) # 80001144 <_Z9mem_allocm>
}
    80002e24:	00813083          	ld	ra,8(sp)
    80002e28:	00013403          	ld	s0,0(sp)
    80002e2c:	01010113          	addi	sp,sp,16
    80002e30:	00008067          	ret

0000000080002e34 <_Znam>:

void *operator new[](size_t n)
{
    80002e34:	ff010113          	addi	sp,sp,-16
    80002e38:	00113423          	sd	ra,8(sp)
    80002e3c:	00813023          	sd	s0,0(sp)
    80002e40:	01010413          	addi	s0,sp,16
    return mem_alloc(n);
    80002e44:	ffffe097          	auipc	ra,0xffffe
    80002e48:	300080e7          	jalr	768(ra) # 80001144 <_Z9mem_allocm>
}
    80002e4c:	00813083          	ld	ra,8(sp)
    80002e50:	00013403          	ld	s0,0(sp)
    80002e54:	01010113          	addi	sp,sp,16
    80002e58:	00008067          	ret

0000000080002e5c <_ZdlPv>:

void operator delete(void *p) noexcept
{
    80002e5c:	ff010113          	addi	sp,sp,-16
    80002e60:	00113423          	sd	ra,8(sp)
    80002e64:	00813023          	sd	s0,0(sp)
    80002e68:	01010413          	addi	s0,sp,16
    mem_free(p);
    80002e6c:	ffffe097          	auipc	ra,0xffffe
    80002e70:	304080e7          	jalr	772(ra) # 80001170 <_Z8mem_freePv>
}
    80002e74:	00813083          	ld	ra,8(sp)
    80002e78:	00013403          	ld	s0,0(sp)
    80002e7c:	01010113          	addi	sp,sp,16
    80002e80:	00008067          	ret

0000000080002e84 <_ZdaPv>:

void operator delete[](void *p) noexcept
{
    80002e84:	ff010113          	addi	sp,sp,-16
    80002e88:	00113423          	sd	ra,8(sp)
    80002e8c:	00813023          	sd	s0,0(sp)
    80002e90:	01010413          	addi	s0,sp,16
    mem_free(p);
    80002e94:	ffffe097          	auipc	ra,0xffffe
    80002e98:	2dc080e7          	jalr	732(ra) # 80001170 <_Z8mem_freePv>
    80002e9c:	00813083          	ld	ra,8(sp)
    80002ea0:	00013403          	ld	s0,0(sp)
    80002ea4:	01010113          	addi	sp,sp,16
    80002ea8:	00008067          	ret

0000000080002eac <_ZN6Thread13threadWrapperEPv>:
#include "../h/syscall_cpp.hpp"

void Thread::threadWrapper(void *arg) {
    80002eac:	ff010113          	addi	sp,sp,-16
    80002eb0:	00113423          	sd	ra,8(sp)
    80002eb4:	00813023          	sd	s0,0(sp)
    80002eb8:	01010413          	addi	s0,sp,16
    ((Thread*)arg)->run();
    80002ebc:	00053783          	ld	a5,0(a0)
    80002ec0:	0007b783          	ld	a5,0(a5)
    80002ec4:	000780e7          	jalr	a5
}
    80002ec8:	00813083          	ld	ra,8(sp)
    80002ecc:	00013403          	ld	s0,0(sp)
    80002ed0:	01010113          	addi	sp,sp,16
    80002ed4:	00008067          	ret

0000000080002ed8 <_ZN9SemaphoreD1Ev>:


Semaphore::Semaphore(unsigned int init) {
    sem_open(&myHandle, init);
}
Semaphore::~Semaphore() {
    80002ed8:	ff010113          	addi	sp,sp,-16
    80002edc:	00113423          	sd	ra,8(sp)
    80002ee0:	00813023          	sd	s0,0(sp)
    80002ee4:	01010413          	addi	s0,sp,16
    80002ee8:	00007797          	auipc	a5,0x7
    80002eec:	02078793          	addi	a5,a5,32 # 80009f08 <_ZTV9Semaphore+0x10>
    80002ef0:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80002ef4:	00853503          	ld	a0,8(a0)
    80002ef8:	ffffe097          	auipc	ra,0xffffe
    80002efc:	388080e7          	jalr	904(ra) # 80001280 <_Z9sem_closeP3SEM>
}
    80002f00:	00813083          	ld	ra,8(sp)
    80002f04:	00013403          	ld	s0,0(sp)
    80002f08:	01010113          	addi	sp,sp,16
    80002f0c:	00008067          	ret

0000000080002f10 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    80002f10:	fe010113          	addi	sp,sp,-32
    80002f14:	00113c23          	sd	ra,24(sp)
    80002f18:	00813823          	sd	s0,16(sp)
    80002f1c:	00913423          	sd	s1,8(sp)
    80002f20:	02010413          	addi	s0,sp,32
    80002f24:	00050493          	mv	s1,a0
}
    80002f28:	00000097          	auipc	ra,0x0
    80002f2c:	fb0080e7          	jalr	-80(ra) # 80002ed8 <_ZN9SemaphoreD1Ev>
    80002f30:	00048513          	mv	a0,s1
    80002f34:	00000097          	auipc	ra,0x0
    80002f38:	f28080e7          	jalr	-216(ra) # 80002e5c <_ZdlPv>
    80002f3c:	01813083          	ld	ra,24(sp)
    80002f40:	01013403          	ld	s0,16(sp)
    80002f44:	00813483          	ld	s1,8(sp)
    80002f48:	02010113          	addi	sp,sp,32
    80002f4c:	00008067          	ret

0000000080002f50 <_ZN6Thread5startEv>:
int Thread::start() {
    80002f50:	ff010113          	addi	sp,sp,-16
    80002f54:	00113423          	sd	ra,8(sp)
    80002f58:	00813023          	sd	s0,0(sp)
    80002f5c:	01010413          	addi	s0,sp,16
    return thread_create(&myHandle,  threadWrapper, this);
    80002f60:	00050613          	mv	a2,a0
    80002f64:	00000597          	auipc	a1,0x0
    80002f68:	f4858593          	addi	a1,a1,-184 # 80002eac <_ZN6Thread13threadWrapperEPv>
    80002f6c:	00850513          	addi	a0,a0,8
    80002f70:	ffffe097          	auipc	ra,0xffffe
    80002f74:	23c080e7          	jalr	572(ra) # 800011ac <_Z13thread_createPP3PCBPFvPvES2_>
}
    80002f78:	00813083          	ld	ra,8(sp)
    80002f7c:	00013403          	ld	s0,0(sp)
    80002f80:	01010113          	addi	sp,sp,16
    80002f84:	00008067          	ret

0000000080002f88 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80002f88:	ff010113          	addi	sp,sp,-16
    80002f8c:	00113423          	sd	ra,8(sp)
    80002f90:	00813023          	sd	s0,0(sp)
    80002f94:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80002f98:	ffffe097          	auipc	ra,0xffffe
    80002f9c:	280080e7          	jalr	640(ra) # 80001218 <_Z15thread_dispatchv>
}
    80002fa0:	00813083          	ld	ra,8(sp)
    80002fa4:	00013403          	ld	s0,0(sp)
    80002fa8:	01010113          	addi	sp,sp,16
    80002fac:	00008067          	ret

0000000080002fb0 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80002fb0:	ff010113          	addi	sp,sp,-16
    80002fb4:	00113423          	sd	ra,8(sp)
    80002fb8:	00813023          	sd	s0,0(sp)
    80002fbc:	01010413          	addi	s0,sp,16
    time_sleep(time);
    80002fc0:	ffffe097          	auipc	ra,0xffffe
    80002fc4:	374080e7          	jalr	884(ra) # 80001334 <_Z10time_sleepm>
}
    80002fc8:	00000513          	li	a0,0
    80002fcc:	00813083          	ld	ra,8(sp)
    80002fd0:	00013403          	ld	s0,0(sp)
    80002fd4:	01010113          	addi	sp,sp,16
    80002fd8:	00008067          	ret

0000000080002fdc <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80002fdc:	ff010113          	addi	sp,sp,-16
    80002fe0:	00113423          	sd	ra,8(sp)
    80002fe4:	00813023          	sd	s0,0(sp)
    80002fe8:	01010413          	addi	s0,sp,16
    80002fec:	00007797          	auipc	a5,0x7
    80002ff0:	f1c78793          	addi	a5,a5,-228 # 80009f08 <_ZTV9Semaphore+0x10>
    80002ff4:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80002ff8:	00850513          	addi	a0,a0,8
    80002ffc:	ffffe097          	auipc	ra,0xffffe
    80003000:	240080e7          	jalr	576(ra) # 8000123c <_Z8sem_openPP3SEMj>
}
    80003004:	00813083          	ld	ra,8(sp)
    80003008:	00013403          	ld	s0,0(sp)
    8000300c:	01010113          	addi	sp,sp,16
    80003010:	00008067          	ret

0000000080003014 <_ZN9Semaphore4waitEv>:

int Semaphore::wait() {
    80003014:	ff010113          	addi	sp,sp,-16
    80003018:	00113423          	sd	ra,8(sp)
    8000301c:	00813023          	sd	s0,0(sp)
    80003020:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80003024:	00853503          	ld	a0,8(a0)
    80003028:	ffffe097          	auipc	ra,0xffffe
    8000302c:	294080e7          	jalr	660(ra) # 800012bc <_Z8sem_waitP3SEM>
}
    80003030:	00813083          	ld	ra,8(sp)
    80003034:	00013403          	ld	s0,0(sp)
    80003038:	01010113          	addi	sp,sp,16
    8000303c:	00008067          	ret

0000000080003040 <_ZN9Semaphore6signalEv>:

int Semaphore::signal() {
    80003040:	ff010113          	addi	sp,sp,-16
    80003044:	00113423          	sd	ra,8(sp)
    80003048:	00813023          	sd	s0,0(sp)
    8000304c:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80003050:	00853503          	ld	a0,8(a0)
    80003054:	ffffe097          	auipc	ra,0xffffe
    80003058:	2a4080e7          	jalr	676(ra) # 800012f8 <_Z10sem_signalP3SEM>
}
    8000305c:	00813083          	ld	ra,8(sp)
    80003060:	00013403          	ld	s0,0(sp)
    80003064:	01010113          	addi	sp,sp,16
    80003068:	00008067          	ret

000000008000306c <_ZN7Console4getcEv>:

char Console::getc() {
    8000306c:	ff010113          	addi	sp,sp,-16
    80003070:	00813423          	sd	s0,8(sp)
    80003074:	01010413          	addi	s0,sp,16
    uint8 number = 41;
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    80003078:	02900793          	li	a5,41
    8000307c:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80003080:	00000073          	ecall
    char res;
    __asm__ volatile("mv %[res], a0" : [res] "=r" (res));
    80003084:	00050513          	mv	a0,a0
    return res;
}
    80003088:	0ff57513          	andi	a0,a0,255
    8000308c:	00813403          	ld	s0,8(sp)
    80003090:	01010113          	addi	sp,sp,16
    80003094:	00008067          	ret

0000000080003098 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80003098:	ff010113          	addi	sp,sp,-16
    8000309c:	00813423          	sd	s0,8(sp)
    800030a0:	01010413          	addi	s0,sp,16
    uint8 number = 42;
    __asm__ volatile("mv a1, a0");
    800030a4:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %[number]" : : [number] "r" (number));
    800030a8:	02a00793          	li	a5,42
    800030ac:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    800030b0:	00000073          	ecall
    800030b4:	00813403          	ld	s0,8(sp)
    800030b8:	01010113          	addi	sp,sp,16
    800030bc:	00008067          	ret

00000000800030c0 <_ZN8ksyscall9mem_allocEv>:
            ksyscall::putc();
            break;
    }
}

void ksyscall::mem_alloc() {
    800030c0:	ff010113          	addi	sp,sp,-16
    800030c4:	00113423          	sd	ra,8(sp)
    800030c8:	00813023          	sd	s0,0(sp)
    800030cc:	01010413          	addi	s0,sp,16
    size_t size_a;
    __asm__ volatile("mv %[size], a1" : [size] "=r"(size_a));
    800030d0:	00058513          	mv	a0,a1
    uint64 res = (uint64) MemoryAllocator::sys_mem_alloc(size_a);
    800030d4:	00001097          	auipc	ra,0x1
    800030d8:	e84080e7          	jalr	-380(ra) # 80003f58 <_ZN15MemoryAllocator13sys_mem_allocEm>
    __asm__ volatile("mv a0, %[res]" : : [res] "r" (res));
    800030dc:	00050513          	mv	a0,a0
    __asm__ volatile("sd a0, 10*8(%[fp])" : : [fp] "r" (ksyscall::fp));
    800030e0:	00007797          	auipc	a5,0x7
    800030e4:	0107b783          	ld	a5,16(a5) # 8000a0f0 <_ZN8ksyscall2fpE>
    800030e8:	04a7b823          	sd	a0,80(a5)
}
    800030ec:	00813083          	ld	ra,8(sp)
    800030f0:	00013403          	ld	s0,0(sp)
    800030f4:	01010113          	addi	sp,sp,16
    800030f8:	00008067          	ret

00000000800030fc <_ZN8ksyscall8mem_freeEv>:

void ksyscall::mem_free() {
    800030fc:	ff010113          	addi	sp,sp,-16
    80003100:	00113423          	sd	ra,8(sp)
    80003104:	00813023          	sd	s0,0(sp)
    80003108:	01010413          	addi	s0,sp,16
    void *addr;
    __asm__ volatile("mv %[addr], a1" : [addr] "=r"(addr));
    8000310c:	00058513          	mv	a0,a1
    uint64 res = (uint64) MemoryAllocator::sys_mem_free(addr);
    80003110:	00001097          	auipc	ra,0x1
    80003114:	f74080e7          	jalr	-140(ra) # 80004084 <_ZN15MemoryAllocator12sys_mem_freeEPv>
    __asm__ volatile("mv a0, %[res]" : : [res] "r" (res));
    80003118:	00050513          	mv	a0,a0
    __asm__ volatile("sd a0, 10*8(%[fp])" : : [fp] "r" (ksyscall::fp));
    8000311c:	00007797          	auipc	a5,0x7
    80003120:	fd47b783          	ld	a5,-44(a5) # 8000a0f0 <_ZN8ksyscall2fpE>
    80003124:	04a7b823          	sd	a0,80(a5)
}
    80003128:	00813083          	ld	ra,8(sp)
    8000312c:	00013403          	ld	s0,0(sp)
    80003130:	01010113          	addi	sp,sp,16
    80003134:	00008067          	ret

0000000080003138 <_ZN8ksyscall13thread_createEv>:

void ksyscall::thread_create() {
    80003138:	ff010113          	addi	sp,sp,-16
    8000313c:	00113423          	sd	ra,8(sp)
    80003140:	00813023          	sd	s0,0(sp)
    80003144:	01010413          	addi	s0,sp,16
    PCB* new_handle;
    void (*start_r)(void *);
    void *arg;
    __asm__ volatile("mv %[start_r], a1" : [start_r] "=r"(start_r));
    80003148:	00058513          	mv	a0,a1
    __asm__ volatile("mv %[arg], a2" : [arg] "=r"(arg));
    8000314c:	00060593          	mv	a1,a2
    new_handle = PCB::createThread(start_r, arg);
    80003150:	ffffe097          	auipc	ra,0xffffe
    80003154:	3a0080e7          	jalr	928(ra) # 800014f0 <_ZN3PCB12createThreadEPFvPvES0_>
    __asm__ volatile("mv a0, %[res]" : : [res] "r" (new_handle));
    80003158:	00050513          	mv	a0,a0
    __asm__ volatile("sd a0, 13*8(%[fp])" : : [fp] "r" (ksyscall::fp));
    8000315c:	00007797          	auipc	a5,0x7
    80003160:	f947b783          	ld	a5,-108(a5) # 8000a0f0 <_ZN8ksyscall2fpE>
    80003164:	06a7b423          	sd	a0,104(a5)
}
    80003168:	00813083          	ld	ra,8(sp)
    8000316c:	00013403          	ld	s0,0(sp)
    80003170:	01010113          	addi	sp,sp,16
    80003174:	00008067          	ret

0000000080003178 <_ZN8ksyscall11thread_exitEv>:

void ksyscall::thread_exit() {
    80003178:	ff010113          	addi	sp,sp,-16
    8000317c:	00113423          	sd	ra,8(sp)
    80003180:	00813023          	sd	s0,0(sp)
    80003184:	01010413          	addi	s0,sp,16
    PCB::exitThread();
    80003188:	ffffe097          	auipc	ra,0xffffe
    8000318c:	524080e7          	jalr	1316(ra) # 800016ac <_ZN3PCB10exitThreadEv>
}
    80003190:	00813083          	ld	ra,8(sp)
    80003194:	00013403          	ld	s0,0(sp)
    80003198:	01010113          	addi	sp,sp,16
    8000319c:	00008067          	ret

00000000800031a0 <_ZN8ksyscall15thread_dispatchEv>:

void ksyscall::thread_dispatch() {
    800031a0:	ff010113          	addi	sp,sp,-16
    800031a4:	00113423          	sd	ra,8(sp)
    800031a8:	00813023          	sd	s0,0(sp)
    800031ac:	01010413          	addi	s0,sp,16
    PCB::timeSliceCounter = 0;
    800031b0:	00007797          	auipc	a5,0x7
    800031b4:	df07b783          	ld	a5,-528(a5) # 80009fa0 <_GLOBAL_OFFSET_TABLE_+0x70>
    800031b8:	0007b023          	sd	zero,0(a5)
    PCB::dispatch();
    800031bc:	ffffe097          	auipc	ra,0xffffe
    800031c0:	47c080e7          	jalr	1148(ra) # 80001638 <_ZN3PCB8dispatchEv>
}
    800031c4:	00813083          	ld	ra,8(sp)
    800031c8:	00013403          	ld	s0,0(sp)
    800031cc:	01010113          	addi	sp,sp,16
    800031d0:	00008067          	ret

00000000800031d4 <_ZN8ksyscall8sem_openEv>:

void ksyscall::sem_open() {
    800031d4:	ff010113          	addi	sp,sp,-16
    800031d8:	00113423          	sd	ra,8(sp)
    800031dc:	00813023          	sd	s0,0(sp)
    800031e0:	01010413          	addi	s0,sp,16
    SEM* new_handle;
    int init;
    __asm__ volatile("mv %[init], a1" : [init] "=r" (init));
    800031e4:	00058513          	mv	a0,a1
    new_handle = SEM::createSEM(init);
    800031e8:	0005051b          	sext.w	a0,a0
    800031ec:	00002097          	auipc	ra,0x2
    800031f0:	010080e7          	jalr	16(ra) # 800051fc <_ZN3SEM9createSEMEi>
    __asm__ volatile("mv a0, %[res]" : : [res] "r" (new_handle));
    800031f4:	00050513          	mv	a0,a0
    __asm__ volatile("sd a0, 13*8(%[fp])" : : [fp] "r" (ksyscall::fp));
    800031f8:	00007797          	auipc	a5,0x7
    800031fc:	ef87b783          	ld	a5,-264(a5) # 8000a0f0 <_ZN8ksyscall2fpE>
    80003200:	06a7b423          	sd	a0,104(a5)
}
    80003204:	00813083          	ld	ra,8(sp)
    80003208:	00013403          	ld	s0,0(sp)
    8000320c:	01010113          	addi	sp,sp,16
    80003210:	00008067          	ret

0000000080003214 <_ZN8ksyscall9sem_closeEv>:

void ksyscall::sem_close() {
    80003214:	fe010113          	addi	sp,sp,-32
    80003218:	00113c23          	sd	ra,24(sp)
    8000321c:	00813823          	sd	s0,16(sp)
    80003220:	00913423          	sd	s1,8(sp)
    80003224:	01213023          	sd	s2,0(sp)
    80003228:	02010413          	addi	s0,sp,32
    SEM* id;
    __asm__ volatile("mv %[id], a1" : [id] "=r" (id));
    8000322c:	00058913          	mv	s2,a1
    int res = id->close();
    80003230:	00090513          	mv	a0,s2
    80003234:	00002097          	auipc	ra,0x2
    80003238:	148080e7          	jalr	328(ra) # 8000537c <_ZN3SEM5closeEv>
    8000323c:	00050493          	mv	s1,a0
    SEM::freeObject(id);
    80003240:	00090513          	mv	a0,s2
    80003244:	00002097          	auipc	ra,0x2
    80003248:	18c080e7          	jalr	396(ra) # 800053d0 <_ZN3SEM10freeObjectEPS_>
    __asm__ volatile("mv a0, %[res]" : : [res] "r" (res));
    8000324c:	00048513          	mv	a0,s1
    __asm__ volatile("sd a0, 10*8(%[fp])" : : [fp] "r" (ksyscall::fp));
    80003250:	00007797          	auipc	a5,0x7
    80003254:	ea07b783          	ld	a5,-352(a5) # 8000a0f0 <_ZN8ksyscall2fpE>
    80003258:	04a7b823          	sd	a0,80(a5)
}
    8000325c:	01813083          	ld	ra,24(sp)
    80003260:	01013403          	ld	s0,16(sp)
    80003264:	00813483          	ld	s1,8(sp)
    80003268:	00013903          	ld	s2,0(sp)
    8000326c:	02010113          	addi	sp,sp,32
    80003270:	00008067          	ret

0000000080003274 <_ZN8ksyscall8sem_waitEv>:

void ksyscall::sem_wait() {
    80003274:	ff010113          	addi	sp,sp,-16
    80003278:	00113423          	sd	ra,8(sp)
    8000327c:	00813023          	sd	s0,0(sp)
    80003280:	01010413          	addi	s0,sp,16
    SEM* id;
    __asm__ volatile("mv %[id], a1" : [id] "=r" (id));
    80003284:	00058513          	mv	a0,a1
    int res = id->wait();
    80003288:	00002097          	auipc	ra,0x2
    8000328c:	ff8080e7          	jalr	-8(ra) # 80005280 <_ZN3SEM4waitEv>
    __asm__ volatile("mv a0, %[res]" : : [res] "r" (res));
    80003290:	00050513          	mv	a0,a0
    __asm__ volatile("sd a0, 10*8(%[fp])" : : [fp] "r" (ksyscall::fp));
    80003294:	00007797          	auipc	a5,0x7
    80003298:	e5c7b783          	ld	a5,-420(a5) # 8000a0f0 <_ZN8ksyscall2fpE>
    8000329c:	04a7b823          	sd	a0,80(a5)
}
    800032a0:	00813083          	ld	ra,8(sp)
    800032a4:	00013403          	ld	s0,0(sp)
    800032a8:	01010113          	addi	sp,sp,16
    800032ac:	00008067          	ret

00000000800032b0 <_ZN8ksyscall10sem_signalEv>:

void ksyscall::sem_signal() {
    800032b0:	ff010113          	addi	sp,sp,-16
    800032b4:	00113423          	sd	ra,8(sp)
    800032b8:	00813023          	sd	s0,0(sp)
    800032bc:	01010413          	addi	s0,sp,16
    SEM* id;
    __asm__ volatile("mv %[id], a1" : [id] "=r" (id));
    800032c0:	00058513          	mv	a0,a1
    int res = id->signal();
    800032c4:	00002097          	auipc	ra,0x2
    800032c8:	054080e7          	jalr	84(ra) # 80005318 <_ZN3SEM6signalEv>
    __asm__ volatile("mv a0, %[res]" : : [res] "r" (res));
    800032cc:	00050513          	mv	a0,a0
    __asm__ volatile("sd a0, 10*8(%[fp])" : : [fp] "r" (ksyscall::fp));
    800032d0:	00007797          	auipc	a5,0x7
    800032d4:	e207b783          	ld	a5,-480(a5) # 8000a0f0 <_ZN8ksyscall2fpE>
    800032d8:	04a7b823          	sd	a0,80(a5)
}
    800032dc:	00813083          	ld	ra,8(sp)
    800032e0:	00013403          	ld	s0,0(sp)
    800032e4:	01010113          	addi	sp,sp,16
    800032e8:	00008067          	ret

00000000800032ec <_ZN8ksyscall12thread_sleepEv>:

void ksyscall::thread_sleep() {
    800032ec:	ff010113          	addi	sp,sp,-16
    800032f0:	00113423          	sd	ra,8(sp)
    800032f4:	00813023          	sd	s0,0(sp)
    800032f8:	01010413          	addi	s0,sp,16
    time_t time;
    __asm__ volatile("mv %[time], a1" : [time] "=r" (time));
    800032fc:	00058513          	mv	a0,a1
    PCB::addToSleepQ(time);
    80003300:	ffffe097          	auipc	ra,0xffffe
    80003304:	3f4080e7          	jalr	1012(ra) # 800016f4 <_ZN3PCB11addToSleepQEm>
}
    80003308:	00813083          	ld	ra,8(sp)
    8000330c:	00013403          	ld	s0,0(sp)
    80003310:	01010113          	addi	sp,sp,16
    80003314:	00008067          	ret

0000000080003318 <_ZN8ksyscall4getcEv>:

void ksyscall::getc() {
    80003318:	ff010113          	addi	sp,sp,-16
    8000331c:	00113423          	sd	ra,8(sp)
    80003320:	00813023          	sd	s0,0(sp)
    80003324:	01010413          	addi	s0,sp,16
    void operator=(ConsoleHandler const &) = delete;

    static ConsoleHandler *createConsoleHandler();

    static ConsoleHandler *getInstance(){
        if(instance == nullptr){
    80003328:	00007797          	auipc	a5,0x7
    8000332c:	c307b783          	ld	a5,-976(a5) # 80009f58 <_GLOBAL_OFFSET_TABLE_+0x28>
    80003330:	0007b783          	ld	a5,0(a5)
    80003334:	02078c63          	beqz	a5,8000336c <_ZN8ksyscall4getcEv+0x54>
    char res = ConsoleHandler::getInstance()->sys_getc();
    80003338:	00007797          	auipc	a5,0x7
    8000333c:	c207b783          	ld	a5,-992(a5) # 80009f58 <_GLOBAL_OFFSET_TABLE_+0x28>
    80003340:	0007b503          	ld	a0,0(a5)
    80003344:	00001097          	auipc	ra,0x1
    80003348:	e60080e7          	jalr	-416(ra) # 800041a4 <_ZN14ConsoleHandler8sys_getcEv>
    __asm__ volatile("mv a0, %[res]" : : [res] "r" (res));
    8000334c:	00050513          	mv	a0,a0
    __asm__ volatile("sd a0, 10*8(%[fp])" : : [fp] "r" (ksyscall::fp));
    80003350:	00007797          	auipc	a5,0x7
    80003354:	da07b783          	ld	a5,-608(a5) # 8000a0f0 <_ZN8ksyscall2fpE>
    80003358:	04a7b823          	sd	a0,80(a5)
}
    8000335c:	00813083          	ld	ra,8(sp)
    80003360:	00013403          	ld	s0,0(sp)
    80003364:	01010113          	addi	sp,sp,16
    80003368:	00008067          	ret
            instance = ConsoleHandler::createConsoleHandler();
    8000336c:	00001097          	auipc	ra,0x1
    80003370:	ddc080e7          	jalr	-548(ra) # 80004148 <_ZN14ConsoleHandler20createConsoleHandlerEv>
    80003374:	00007797          	auipc	a5,0x7
    80003378:	be47b783          	ld	a5,-1052(a5) # 80009f58 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000337c:	00a7b023          	sd	a0,0(a5)
    80003380:	fb9ff06f          	j	80003338 <_ZN8ksyscall4getcEv+0x20>

0000000080003384 <_ZN8ksyscall4putcEv>:

void ksyscall::putc() {
    80003384:	fe010113          	addi	sp,sp,-32
    80003388:	00113c23          	sd	ra,24(sp)
    8000338c:	00813823          	sd	s0,16(sp)
    80003390:	00913423          	sd	s1,8(sp)
    80003394:	02010413          	addi	s0,sp,32
    char data;
    __asm__ volatile("mv %[data], a1" : [data] "=r"(data));
    80003398:	00058493          	mv	s1,a1
    8000339c:	0ff4f493          	andi	s1,s1,255
        if(instance == nullptr){
    800033a0:	00007797          	auipc	a5,0x7
    800033a4:	bb87b783          	ld	a5,-1096(a5) # 80009f58 <_GLOBAL_OFFSET_TABLE_+0x28>
    800033a8:	0007b783          	ld	a5,0(a5)
    800033ac:	02078863          	beqz	a5,800033dc <_ZN8ksyscall4putcEv+0x58>
    ConsoleHandler::getInstance()->sys_putc(data);
    800033b0:	00048593          	mv	a1,s1
    800033b4:	00007797          	auipc	a5,0x7
    800033b8:	ba47b783          	ld	a5,-1116(a5) # 80009f58 <_GLOBAL_OFFSET_TABLE_+0x28>
    800033bc:	0007b503          	ld	a0,0(a5)
    800033c0:	00001097          	auipc	ra,0x1
    800033c4:	e40080e7          	jalr	-448(ra) # 80004200 <_ZN14ConsoleHandler8sys_putcEc>
}
    800033c8:	01813083          	ld	ra,24(sp)
    800033cc:	01013403          	ld	s0,16(sp)
    800033d0:	00813483          	ld	s1,8(sp)
    800033d4:	02010113          	addi	sp,sp,32
    800033d8:	00008067          	ret
            instance = ConsoleHandler::createConsoleHandler();
    800033dc:	00001097          	auipc	ra,0x1
    800033e0:	d6c080e7          	jalr	-660(ra) # 80004148 <_ZN14ConsoleHandler20createConsoleHandlerEv>
    800033e4:	00007797          	auipc	a5,0x7
    800033e8:	b747b783          	ld	a5,-1164(a5) # 80009f58 <_GLOBAL_OFFSET_TABLE_+0x28>
    800033ec:	00a7b023          	sd	a0,0(a5)
    800033f0:	fc1ff06f          	j	800033b0 <_ZN8ksyscall4putcEv+0x2c>

00000000800033f4 <_ZN8ksyscall13hanldeSyscallEt>:
    switch(number) {
    800033f4:	0005071b          	sext.w	a4,a0
    800033f8:	02a00793          	li	a5,42
    800033fc:	0ce7e663          	bltu	a5,a4,800034c8 <_ZN8ksyscall13hanldeSyscallEt+0xd4>
void ksyscall::hanldeSyscall(unsigned short number){
    80003400:	ff010113          	addi	sp,sp,-16
    80003404:	00113423          	sd	ra,8(sp)
    80003408:	00813023          	sd	s0,0(sp)
    8000340c:	01010413          	addi	s0,sp,16
    80003410:	00251513          	slli	a0,a0,0x2
    80003414:	00005717          	auipc	a4,0x5
    80003418:	cb870713          	addi	a4,a4,-840 # 800080cc <CONSOLE_STATUS+0xbc>
    8000341c:	00e50533          	add	a0,a0,a4
    80003420:	00052783          	lw	a5,0(a0)
    80003424:	00e787b3          	add	a5,a5,a4
    80003428:	00078067          	jr	a5
            ksyscall::mem_alloc();
    8000342c:	00000097          	auipc	ra,0x0
    80003430:	c94080e7          	jalr	-876(ra) # 800030c0 <_ZN8ksyscall9mem_allocEv>
}
    80003434:	00813083          	ld	ra,8(sp)
    80003438:	00013403          	ld	s0,0(sp)
    8000343c:	01010113          	addi	sp,sp,16
    80003440:	00008067          	ret
            ksyscall::mem_free();
    80003444:	00000097          	auipc	ra,0x0
    80003448:	cb8080e7          	jalr	-840(ra) # 800030fc <_ZN8ksyscall8mem_freeEv>
            break;
    8000344c:	fe9ff06f          	j	80003434 <_ZN8ksyscall13hanldeSyscallEt+0x40>
            ksyscall::thread_create();
    80003450:	00000097          	auipc	ra,0x0
    80003454:	ce8080e7          	jalr	-792(ra) # 80003138 <_ZN8ksyscall13thread_createEv>
            break;
    80003458:	fddff06f          	j	80003434 <_ZN8ksyscall13hanldeSyscallEt+0x40>
            ksyscall::thread_exit();
    8000345c:	00000097          	auipc	ra,0x0
    80003460:	d1c080e7          	jalr	-740(ra) # 80003178 <_ZN8ksyscall11thread_exitEv>
            break;
    80003464:	fd1ff06f          	j	80003434 <_ZN8ksyscall13hanldeSyscallEt+0x40>
            ksyscall::thread_dispatch();
    80003468:	00000097          	auipc	ra,0x0
    8000346c:	d38080e7          	jalr	-712(ra) # 800031a0 <_ZN8ksyscall15thread_dispatchEv>
            break;
    80003470:	fc5ff06f          	j	80003434 <_ZN8ksyscall13hanldeSyscallEt+0x40>
            ksyscall::sem_open();
    80003474:	00000097          	auipc	ra,0x0
    80003478:	d60080e7          	jalr	-672(ra) # 800031d4 <_ZN8ksyscall8sem_openEv>
            break;
    8000347c:	fb9ff06f          	j	80003434 <_ZN8ksyscall13hanldeSyscallEt+0x40>
            ksyscall::sem_close();
    80003480:	00000097          	auipc	ra,0x0
    80003484:	d94080e7          	jalr	-620(ra) # 80003214 <_ZN8ksyscall9sem_closeEv>
            break;
    80003488:	fadff06f          	j	80003434 <_ZN8ksyscall13hanldeSyscallEt+0x40>
            ksyscall::sem_wait();
    8000348c:	00000097          	auipc	ra,0x0
    80003490:	de8080e7          	jalr	-536(ra) # 80003274 <_ZN8ksyscall8sem_waitEv>
            break;
    80003494:	fa1ff06f          	j	80003434 <_ZN8ksyscall13hanldeSyscallEt+0x40>
            ksyscall::sem_signal();
    80003498:	00000097          	auipc	ra,0x0
    8000349c:	e18080e7          	jalr	-488(ra) # 800032b0 <_ZN8ksyscall10sem_signalEv>
            break;
    800034a0:	f95ff06f          	j	80003434 <_ZN8ksyscall13hanldeSyscallEt+0x40>
            ksyscall::thread_sleep();
    800034a4:	00000097          	auipc	ra,0x0
    800034a8:	e48080e7          	jalr	-440(ra) # 800032ec <_ZN8ksyscall12thread_sleepEv>
            break;
    800034ac:	f89ff06f          	j	80003434 <_ZN8ksyscall13hanldeSyscallEt+0x40>
            ksyscall::getc();
    800034b0:	00000097          	auipc	ra,0x0
    800034b4:	e68080e7          	jalr	-408(ra) # 80003318 <_ZN8ksyscall4getcEv>
            break;
    800034b8:	f7dff06f          	j	80003434 <_ZN8ksyscall13hanldeSyscallEt+0x40>
            ksyscall::putc();
    800034bc:	00000097          	auipc	ra,0x0
    800034c0:	ec8080e7          	jalr	-312(ra) # 80003384 <_ZN8ksyscall4putcEv>
}
    800034c4:	f71ff06f          	j	80003434 <_ZN8ksyscall13hanldeSyscallEt+0x40>
    800034c8:	00008067          	ret

00000000800034cc <_Z18kernel_printStringPKc>:
#include "../h/KernelPrint.hpp"

void kernel_printString(char const *string)
{
    800034cc:	fe010113          	addi	sp,sp,-32
    800034d0:	00113c23          	sd	ra,24(sp)
    800034d4:	00813823          	sd	s0,16(sp)
    800034d8:	00913423          	sd	s1,8(sp)
    800034dc:	02010413          	addi	s0,sp,32
    800034e0:	00050493          	mv	s1,a0
    800034e4:	0200006f          	j	80003504 <_Z18kernel_printStringPKc+0x38>
    while (*string != '\0')
    {
        ConsoleHandler::getInstance()->sys_putc(*string);
    800034e8:	0004c583          	lbu	a1,0(s1)
    800034ec:	00007797          	auipc	a5,0x7
    800034f0:	a6c7b783          	ld	a5,-1428(a5) # 80009f58 <_GLOBAL_OFFSET_TABLE_+0x28>
    800034f4:	0007b503          	ld	a0,0(a5)
    800034f8:	00001097          	auipc	ra,0x1
    800034fc:	d08080e7          	jalr	-760(ra) # 80004200 <_ZN14ConsoleHandler8sys_putcEc>
        string++;
    80003500:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80003504:	0004c783          	lbu	a5,0(s1)
    80003508:	02078663          	beqz	a5,80003534 <_Z18kernel_printStringPKc+0x68>
    void operator=(ConsoleHandler const &) = delete;

    static ConsoleHandler *createConsoleHandler();

    static ConsoleHandler *getInstance(){
        if(instance == nullptr){
    8000350c:	00007797          	auipc	a5,0x7
    80003510:	a4c7b783          	ld	a5,-1460(a5) # 80009f58 <_GLOBAL_OFFSET_TABLE_+0x28>
    80003514:	0007b783          	ld	a5,0(a5)
    80003518:	fc0798e3          	bnez	a5,800034e8 <_Z18kernel_printStringPKc+0x1c>
            instance = ConsoleHandler::createConsoleHandler();
    8000351c:	00001097          	auipc	ra,0x1
    80003520:	c2c080e7          	jalr	-980(ra) # 80004148 <_ZN14ConsoleHandler20createConsoleHandlerEv>
    80003524:	00007797          	auipc	a5,0x7
    80003528:	a347b783          	ld	a5,-1484(a5) # 80009f58 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000352c:	00a7b023          	sd	a0,0(a5)
    80003530:	fb9ff06f          	j	800034e8 <_Z18kernel_printStringPKc+0x1c>
    }
}
    80003534:	01813083          	ld	ra,24(sp)
    80003538:	01013403          	ld	s0,16(sp)
    8000353c:	00813483          	ld	s1,8(sp)
    80003540:	02010113          	addi	sp,sp,32
    80003544:	00008067          	ret

0000000080003548 <_Z15kernel_printIntiii>:

char k_digits[] = "0123456789ABCDEF";
void kernel_printInt(int xx, int base, int sgn)
{
    80003548:	fd010113          	addi	sp,sp,-48
    8000354c:	02113423          	sd	ra,40(sp)
    80003550:	02813023          	sd	s0,32(sp)
    80003554:	00913c23          	sd	s1,24(sp)
    80003558:	03010413          	addi	s0,sp,48
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    8000355c:	00060463          	beqz	a2,80003564 <_Z15kernel_printIntiii+0x1c>
    80003560:	06054663          	bltz	a0,800035cc <_Z15kernel_printIntiii+0x84>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80003564:	0005051b          	sext.w	a0,a0
    neg = 0;
    80003568:	00000813          	li	a6,0
    }

    i = 0;
    8000356c:	00000493          	li	s1,0
    do{
        buf[i++] = k_digits[x % base];
    80003570:	0005879b          	sext.w	a5,a1
    80003574:	02b5773b          	remuw	a4,a0,a1
    80003578:	00048613          	mv	a2,s1
    8000357c:	0014849b          	addiw	s1,s1,1
    80003580:	02071693          	slli	a3,a4,0x20
    80003584:	0206d693          	srli	a3,a3,0x20
    80003588:	00007717          	auipc	a4,0x7
    8000358c:	99070713          	addi	a4,a4,-1648 # 80009f18 <k_digits>
    80003590:	00d70733          	add	a4,a4,a3
    80003594:	00074683          	lbu	a3,0(a4)
    80003598:	fe040713          	addi	a4,s0,-32
    8000359c:	00c70733          	add	a4,a4,a2
    800035a0:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    800035a4:	0005071b          	sext.w	a4,a0
    800035a8:	02b5553b          	divuw	a0,a0,a1
    800035ac:	fcf772e3          	bgeu	a4,a5,80003570 <_Z15kernel_printIntiii+0x28>
    if(neg)
    800035b0:	04080463          	beqz	a6,800035f8 <_Z15kernel_printIntiii+0xb0>
        buf[i++] = '-';
    800035b4:	fe040793          	addi	a5,s0,-32
    800035b8:	009784b3          	add	s1,a5,s1
    800035bc:	02d00793          	li	a5,45
    800035c0:	fef48823          	sb	a5,-16(s1)
    800035c4:	0026049b          	addiw	s1,a2,2
    800035c8:	0300006f          	j	800035f8 <_Z15kernel_printIntiii+0xb0>
        x = -xx;
    800035cc:	40a0053b          	negw	a0,a0
        neg = 1;
    800035d0:	00100813          	li	a6,1
        x = -xx;
    800035d4:	f99ff06f          	j	8000356c <_Z15kernel_printIntiii+0x24>

    while(--i >= 0)
        ConsoleHandler::getInstance()->sys_putc(buf[i]);
    800035d8:	fe040793          	addi	a5,s0,-32
    800035dc:	009787b3          	add	a5,a5,s1
    800035e0:	ff07c583          	lbu	a1,-16(a5)
    800035e4:	00007797          	auipc	a5,0x7
    800035e8:	9747b783          	ld	a5,-1676(a5) # 80009f58 <_GLOBAL_OFFSET_TABLE_+0x28>
    800035ec:	0007b503          	ld	a0,0(a5)
    800035f0:	00001097          	auipc	ra,0x1
    800035f4:	c10080e7          	jalr	-1008(ra) # 80004200 <_ZN14ConsoleHandler8sys_putcEc>
    while(--i >= 0)
    800035f8:	fff4849b          	addiw	s1,s1,-1
    800035fc:	0204c663          	bltz	s1,80003628 <_Z15kernel_printIntiii+0xe0>
        if(instance == nullptr){
    80003600:	00007797          	auipc	a5,0x7
    80003604:	9587b783          	ld	a5,-1704(a5) # 80009f58 <_GLOBAL_OFFSET_TABLE_+0x28>
    80003608:	0007b783          	ld	a5,0(a5)
    8000360c:	fc0796e3          	bnez	a5,800035d8 <_Z15kernel_printIntiii+0x90>
            instance = ConsoleHandler::createConsoleHandler();
    80003610:	00001097          	auipc	ra,0x1
    80003614:	b38080e7          	jalr	-1224(ra) # 80004148 <_ZN14ConsoleHandler20createConsoleHandlerEv>
    80003618:	00007797          	auipc	a5,0x7
    8000361c:	9407b783          	ld	a5,-1728(a5) # 80009f58 <_GLOBAL_OFFSET_TABLE_+0x28>
    80003620:	00a7b023          	sd	a0,0(a5)
    80003624:	fb5ff06f          	j	800035d8 <_Z15kernel_printIntiii+0x90>

    80003628:	02813083          	ld	ra,40(sp)
    8000362c:	02013403          	ld	s0,32(sp)
    80003630:	01813483          	ld	s1,24(sp)
    80003634:	03010113          	addi	sp,sp,48
    80003638:	00008067          	ret

000000008000363c <_ZN5Riscv10popSppSpieEv>:
#include "../h/PCB.hpp"
#include "../h/SEM.hpp"
#include "../h/ksyscall.hpp"

void Riscv::popSppSpie()
{
    8000363c:	ff010113          	addi	sp,sp,-16
    80003640:	00813423          	sd	s0,8(sp)
    80003644:	01010413          	addi	s0,sp,16
    if(PCB::running == PCB::main_t || PCB::running == PCB::console_t){ //|| PCB::running == PCB::user_main_t){
    80003648:	00007797          	auipc	a5,0x7
    8000364c:	9987b783          	ld	a5,-1640(a5) # 80009fe0 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80003650:	0007b783          	ld	a5,0(a5)
    80003654:	00007717          	auipc	a4,0x7
    80003658:	95c73703          	ld	a4,-1700(a4) # 80009fb0 <_GLOBAL_OFFSET_TABLE_+0x80>
    8000365c:	00073703          	ld	a4,0(a4)
    80003660:	02e78063          	beq	a5,a4,80003680 <_ZN5Riscv10popSppSpieEv+0x44>
    80003664:	00007717          	auipc	a4,0x7
    80003668:	93473703          	ld	a4,-1740(a4) # 80009f98 <_GLOBAL_OFFSET_TABLE_+0x68>
    8000366c:	00073703          	ld	a4,0(a4)
    80003670:	00e78863          	beq	a5,a4,80003680 <_ZN5Riscv10popSppSpieEv+0x44>
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(BitMaskSstatus::SSTATUS_SPP));
    }else{
        __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(BitMaskSstatus::SSTATUS_SPP));
    80003674:	10000793          	li	a5,256
    80003678:	1007b073          	csrc	sstatus,a5
    8000367c:	00c0006f          	j	80003688 <_ZN5Riscv10popSppSpieEv+0x4c>
        __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(BitMaskSstatus::SSTATUS_SPP));
    80003680:	10000793          	li	a5,256
    80003684:	1007a073          	csrs	sstatus,a5
    }
    __asm__ volatile("csrw sepc, ra");
    80003688:	14109073          	csrw	sepc,ra
    __asm__ volatile("sret");
    8000368c:	10200073          	sret
}
    80003690:	00813403          	ld	s0,8(sp)
    80003694:	01010113          	addi	sp,sp,16
    80003698:	00008067          	ret

000000008000369c <_ZN5Riscv20handleSupervisorTrapEt>:

void Riscv::handleSupervisorTrap(unsigned short number) {
    8000369c:	f8010113          	addi	sp,sp,-128
    800036a0:	06113c23          	sd	ra,120(sp)
    800036a4:	06813823          	sd	s0,112(sp)
    800036a8:	08010413          	addi	s0,sp,128
};

inline uint64 Riscv::r_scause()
{
    uint64 volatile scause;
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    800036ac:	142027f3          	csrr	a5,scause
    800036b0:	faf43c23          	sd	a5,-72(s0)
    return scause;
    800036b4:	fb843703          	ld	a4,-72(s0)
    uint64 scauseVar = Riscv::r_scause();
    if (scauseVar == USER_ECALL || scauseVar == SYSTEM_ECALL) {
    800036b8:	ff870693          	addi	a3,a4,-8
    800036bc:	00100793          	li	a5,1
    800036c0:	02d7fa63          	bgeu	a5,a3,800036f4 <_ZN5Riscv20handleSupervisorTrapEt+0x58>
        saveFp(ksyscall::fp);
        ksyscall::hanldeSyscall(number);

        Riscv::w_sstatus(sstatus);
        Riscv::w_sepc(sepc);
    }else if(scauseVar == TIMER_INT){
    800036c4:	fff00793          	li	a5,-1
    800036c8:	03f79793          	slli	a5,a5,0x3f
    800036cc:	00178793          	addi	a5,a5,1
    800036d0:	08f70663          	beq	a4,a5,8000375c <_ZN5Riscv20handleSupervisorTrapEt+0xc0>
            PCB::timeSliceCounter = 0;
            PCB::dispatch();
            w_sstatus(sstatus);
            w_sepc(sepc);
        }
    }else if(scauseVar == EXTERNAL_INT){
    800036d4:	fff00793          	li	a5,-1
    800036d8:	03f79793          	slli	a5,a5,0x3f
    800036dc:	00978793          	addi	a5,a5,9
    800036e0:	0ef70e63          	beq	a4,a5,800037dc <_ZN5Riscv20handleSupervisorTrapEt+0x140>
        Riscv::w_sstatus(sstatus);
        Riscv::w_sepc(sepc);
    }else{
        // unexpected trap
    }
    800036e4:	07813083          	ld	ra,120(sp)
    800036e8:	07013403          	ld	s0,112(sp)
    800036ec:	08010113          	addi	sp,sp,128
    800036f0:	00008067          	ret
    __asm__ volatile ("csrs sip, %[mask]" : : [mask] "r"(mask));
}

inline void Riscv::mc_sip(uint64 mask)
{
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    800036f4:	00200793          	li	a5,2
    800036f8:	1447b073          	csrc	sip,a5
    800036fc:	02000793          	li	a5,32
    80003700:	1447b073          	csrc	sip,a5
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80003704:	141027f3          	csrr	a5,sepc
    80003708:	fcf43423          	sd	a5,-56(s0)
    return sepc;
    8000370c:	fc843783          	ld	a5,-56(s0)
        uint64 volatile sepc = Riscv::r_sepc();
    80003710:	f8f43423          	sd	a5,-120(s0)
}

inline uint64 Riscv::r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80003714:	100027f3          	csrr	a5,sstatus
    80003718:	fcf43023          	sd	a5,-64(s0)
    return sstatus;
    8000371c:	fc043783          	ld	a5,-64(s0)
        uint64 volatile sstatus = r_sstatus();
    80003720:	f8f43823          	sd	a5,-112(s0)
        sepc += 4;
    80003724:	f8843783          	ld	a5,-120(s0)
    80003728:	00478793          	addi	a5,a5,4
    8000372c:	f8f43423          	sd	a5,-120(s0)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
}

inline void Riscv::saveFp(uint64 &frame_pointer){
    __asm__ volatile ("mv %[fp], fp" : [fp] "=r" (frame_pointer));
    80003730:	00040713          	mv	a4,s0
    80003734:	00007797          	auipc	a5,0x7
    80003738:	88c7b783          	ld	a5,-1908(a5) # 80009fc0 <_GLOBAL_OFFSET_TABLE_+0x90>
    8000373c:	00e7b023          	sd	a4,0(a5)
        ksyscall::hanldeSyscall(number);
    80003740:	00000097          	auipc	ra,0x0
    80003744:	cb4080e7          	jalr	-844(ra) # 800033f4 <_ZN8ksyscall13hanldeSyscallEt>
        Riscv::w_sstatus(sstatus);
    80003748:	f9043783          	ld	a5,-112(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    8000374c:	10079073          	csrw	sstatus,a5
        Riscv::w_sepc(sepc);
    80003750:	f8843783          	ld	a5,-120(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80003754:	14179073          	csrw	sepc,a5
}
    80003758:	f8dff06f          	j	800036e4 <_ZN5Riscv20handleSupervisorTrapEt+0x48>
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    8000375c:	00200793          	li	a5,2
    80003760:	1447b073          	csrc	sip,a5
        PCB::wakingUp();
    80003764:	ffffe097          	auipc	ra,0xffffe
    80003768:	fe8080e7          	jalr	-24(ra) # 8000174c <_ZN3PCB8wakingUpEv>
        PCB::timeSliceCounter++;
    8000376c:	00007717          	auipc	a4,0x7
    80003770:	83473703          	ld	a4,-1996(a4) # 80009fa0 <_GLOBAL_OFFSET_TABLE_+0x70>
    80003774:	00073783          	ld	a5,0(a4)
    80003778:	00178793          	addi	a5,a5,1
    8000377c:	00f73023          	sd	a5,0(a4)
        if(PCB::timeSliceCounter >= PCB::running->getTimeSlice()){
    80003780:	00007717          	auipc	a4,0x7
    80003784:	86073703          	ld	a4,-1952(a4) # 80009fe0 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80003788:	00073703          	ld	a4,0(a4)

    uint64 getTimeSlice() const { return timeSlice; }
    8000378c:	03073703          	ld	a4,48(a4)
    80003790:	f4e7eae3          	bltu	a5,a4,800036e4 <_ZN5Riscv20handleSupervisorTrapEt+0x48>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80003794:	141027f3          	csrr	a5,sepc
    80003798:	fcf43c23          	sd	a5,-40(s0)
    return sepc;
    8000379c:	fd843783          	ld	a5,-40(s0)
            uint64 volatile sepc = r_sepc();
    800037a0:	f8f43c23          	sd	a5,-104(s0)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800037a4:	100027f3          	csrr	a5,sstatus
    800037a8:	fcf43823          	sd	a5,-48(s0)
    return sstatus;
    800037ac:	fd043783          	ld	a5,-48(s0)
            uint64 volatile sstatus = r_sstatus();
    800037b0:	faf43023          	sd	a5,-96(s0)
            PCB::timeSliceCounter = 0;
    800037b4:	00006797          	auipc	a5,0x6
    800037b8:	7ec7b783          	ld	a5,2028(a5) # 80009fa0 <_GLOBAL_OFFSET_TABLE_+0x70>
    800037bc:	0007b023          	sd	zero,0(a5)
            PCB::dispatch();
    800037c0:	ffffe097          	auipc	ra,0xffffe
    800037c4:	e78080e7          	jalr	-392(ra) # 80001638 <_ZN3PCB8dispatchEv>
            w_sstatus(sstatus);
    800037c8:	fa043783          	ld	a5,-96(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800037cc:	10079073          	csrw	sstatus,a5
            w_sepc(sepc);
    800037d0:	f9843783          	ld	a5,-104(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800037d4:	14179073          	csrw	sepc,a5
}
    800037d8:	f0dff06f          	j	800036e4 <_ZN5Riscv20handleSupervisorTrapEt+0x48>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800037dc:	141027f3          	csrr	a5,sepc
    800037e0:	fef43423          	sd	a5,-24(s0)
    return sepc;
    800037e4:	fe843783          	ld	a5,-24(s0)
        uint64 volatile sepc = Riscv::r_sepc();
    800037e8:	faf43423          	sd	a5,-88(s0)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800037ec:	100027f3          	csrr	a5,sstatus
    800037f0:	fef43023          	sd	a5,-32(s0)
    return sstatus;
    800037f4:	fe043783          	ld	a5,-32(s0)
        uint64 volatile sstatus = r_sstatus();
    800037f8:	faf43823          	sd	a5,-80(s0)
        int volatile irq = plic_claim();
    800037fc:	00002097          	auipc	ra,0x2
    80003800:	488080e7          	jalr	1160(ra) # 80005c84 <plic_claim>
    80003804:	f8a42223          	sw	a0,-124(s0)
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80003808:	20000793          	li	a5,512
    8000380c:	1447b073          	csrc	sip,a5
    80003810:	02000793          	li	a5,32
    80003814:	1447b073          	csrc	sip,a5
        if(irq == 0x0a){
    80003818:	f8442783          	lw	a5,-124(s0)
    8000381c:	0007879b          	sext.w	a5,a5
    80003820:	00a00713          	li	a4,10
    80003824:	02e78463          	beq	a5,a4,8000384c <_ZN5Riscv20handleSupervisorTrapEt+0x1b0>
        plic_complete(irq);
    80003828:	f8442503          	lw	a0,-124(s0)
    8000382c:	0005051b          	sext.w	a0,a0
    80003830:	00002097          	auipc	ra,0x2
    80003834:	48c080e7          	jalr	1164(ra) # 80005cbc <plic_complete>
        Riscv::w_sstatus(sstatus);
    80003838:	fb043783          	ld	a5,-80(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    8000383c:	10079073          	csrw	sstatus,a5
        Riscv::w_sepc(sepc);
    80003840:	fa843783          	ld	a5,-88(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80003844:	14179073          	csrw	sepc,a5
    80003848:	e9dff06f          	j	800036e4 <_ZN5Riscv20handleSupervisorTrapEt+0x48>
            char volatile *status = (char *)CONSOLE_STATUS;
    8000384c:	00006797          	auipc	a5,0x6
    80003850:	7047b783          	ld	a5,1796(a5) # 80009f50 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003854:	0007b783          	ld	a5,0(a5)
            if(*status & CONSOLE_RX_STATUS_BIT){
    80003858:	0007c783          	lbu	a5,0(a5)
    8000385c:	0017f793          	andi	a5,a5,1
    80003860:	fc0784e3          	beqz	a5,80003828 <_ZN5Riscv20handleSupervisorTrapEt+0x18c>
                char volatile r = *(char *)CONSOLE_RX_DATA;
    80003864:	00006797          	auipc	a5,0x6
    80003868:	6e47b783          	ld	a5,1764(a5) # 80009f48 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000386c:	0007b783          	ld	a5,0(a5)
    80003870:	0007c783          	lbu	a5,0(a5)
    80003874:	f8f401a3          	sb	a5,-125(s0)
        if(instance == nullptr){
    80003878:	00006797          	auipc	a5,0x6
    8000387c:	6e07b783          	ld	a5,1760(a5) # 80009f58 <_GLOBAL_OFFSET_TABLE_+0x28>
    80003880:	0007b783          	ld	a5,0(a5)
    80003884:	02078263          	beqz	a5,800038a8 <_ZN5Riscv20handleSupervisorTrapEt+0x20c>
                ConsoleHandler::getInstance()->writeDataInput(r);
    80003888:	f8344583          	lbu	a1,-125(s0)
    8000388c:	0ff5f593          	andi	a1,a1,255
    80003890:	00006797          	auipc	a5,0x6
    80003894:	6c87b783          	ld	a5,1736(a5) # 80009f58 <_GLOBAL_OFFSET_TABLE_+0x28>
    80003898:	0007b503          	ld	a0,0(a5)
    8000389c:	00001097          	auipc	ra,0x1
    800038a0:	938080e7          	jalr	-1736(ra) # 800041d4 <_ZN14ConsoleHandler14writeDataInputEc>
    800038a4:	f85ff06f          	j	80003828 <_ZN5Riscv20handleSupervisorTrapEt+0x18c>
            instance = ConsoleHandler::createConsoleHandler();
    800038a8:	00001097          	auipc	ra,0x1
    800038ac:	8a0080e7          	jalr	-1888(ra) # 80004148 <_ZN14ConsoleHandler20createConsoleHandlerEv>
    800038b0:	00006797          	auipc	a5,0x6
    800038b4:	6a87b783          	ld	a5,1704(a5) # 80009f58 <_GLOBAL_OFFSET_TABLE_+0x28>
    800038b8:	00a7b023          	sd	a0,0(a5)
    800038bc:	fcdff06f          	j	80003888 <_ZN5Riscv20handleSupervisorTrapEt+0x1ec>

00000000800038c0 <_ZN13ConsoleBufferC1Ei>:
#include "../h/ConsoleBuffer.hpp"
#include "../h/SEM.hpp"

ConsoleBuffer::ConsoleBuffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800038c0:	fe010113          	addi	sp,sp,-32
    800038c4:	00113c23          	sd	ra,24(sp)
    800038c8:	00813823          	sd	s0,16(sp)
    800038cc:	00913423          	sd	s1,8(sp)
    800038d0:	01213023          	sd	s2,0(sp)
    800038d4:	02010413          	addi	s0,sp,32
    800038d8:	00050493          	mv	s1,a0
    800038dc:	00058913          	mv	s2,a1
    800038e0:	0015851b          	addiw	a0,a1,1
    800038e4:	00a4a023          	sw	a0,0(s1)
    800038e8:	0004a823          	sw	zero,16(s1)
    800038ec:	0004aa23          	sw	zero,20(s1)
    buffer = (char *)MemoryAllocator::sys_mem_alloc(sizeof(char) * cap);
    800038f0:	0005051b          	sext.w	a0,a0
    800038f4:	00000097          	auipc	ra,0x0
    800038f8:	664080e7          	jalr	1636(ra) # 80003f58 <_ZN15MemoryAllocator13sys_mem_allocEm>
    800038fc:	00a4b423          	sd	a0,8(s1)
    itemAvailable = SEM::createSEM(0);
    80003900:	00000513          	li	a0,0
    80003904:	00002097          	auipc	ra,0x2
    80003908:	8f8080e7          	jalr	-1800(ra) # 800051fc <_ZN3SEM9createSEMEi>
    8000390c:	02a4b023          	sd	a0,32(s1)
    spaceAvailable = SEM::createSEM(_cap);
    80003910:	00090513          	mv	a0,s2
    80003914:	00002097          	auipc	ra,0x2
    80003918:	8e8080e7          	jalr	-1816(ra) # 800051fc <_ZN3SEM9createSEMEi>
    8000391c:	00a4bc23          	sd	a0,24(s1)
    mutexHead = SEM::createSEM(1);
    80003920:	00100513          	li	a0,1
    80003924:	00002097          	auipc	ra,0x2
    80003928:	8d8080e7          	jalr	-1832(ra) # 800051fc <_ZN3SEM9createSEMEi>
    8000392c:	02a4b423          	sd	a0,40(s1)
    mutexTail = SEM::createSEM(1);
    80003930:	00100513          	li	a0,1
    80003934:	00002097          	auipc	ra,0x2
    80003938:	8c8080e7          	jalr	-1848(ra) # 800051fc <_ZN3SEM9createSEMEi>
    8000393c:	02a4b823          	sd	a0,48(s1)
}
    80003940:	01813083          	ld	ra,24(sp)
    80003944:	01013403          	ld	s0,16(sp)
    80003948:	00813483          	ld	s1,8(sp)
    8000394c:	00013903          	ld	s2,0(sp)
    80003950:	02010113          	addi	sp,sp,32
    80003954:	00008067          	ret

0000000080003958 <_ZN13ConsoleBuffer19createConsoleBufferEi>:

ConsoleBuffer *ConsoleBuffer::createConsoleBuffer(int _cap) {
    80003958:	fe010113          	addi	sp,sp,-32
    8000395c:	00113c23          	sd	ra,24(sp)
    80003960:	00813823          	sd	s0,16(sp)
    80003964:	00913423          	sd	s1,8(sp)
    80003968:	01213023          	sd	s2,0(sp)
    8000396c:	02010413          	addi	s0,sp,32
    80003970:	00050913          	mv	s2,a0
    ConsoleBuffer *ret = (ConsoleBuffer *)kmalloc(sizeof(ConsoleBuffer));
    80003974:	03800513          	li	a0,56
    80003978:	00001097          	auipc	ra,0x1
    8000397c:	754080e7          	jalr	1876(ra) # 800050cc <_Z7kmallocm>
    80003980:	00050493          	mv	s1,a0
    if(ret == nullptr) return nullptr;
    80003984:	04050e63          	beqz	a0,800039e0 <_ZN13ConsoleBuffer19createConsoleBufferEi+0x88>

    ret->head = 0;
    80003988:	00052823          	sw	zero,16(a0)
    ret->tail = 0;
    8000398c:	00052a23          	sw	zero,20(a0)
    ret->buffer = (char *)kmalloc(sizeof(char)*_cap);
    80003990:	00090513          	mv	a0,s2
    80003994:	00001097          	auipc	ra,0x1
    80003998:	738080e7          	jalr	1848(ra) # 800050cc <_Z7kmallocm>
    8000399c:	00a4b423          	sd	a0,8(s1)
    ret->itemAvailable = SEM::createSEM(0);
    800039a0:	00000513          	li	a0,0
    800039a4:	00002097          	auipc	ra,0x2
    800039a8:	858080e7          	jalr	-1960(ra) # 800051fc <_ZN3SEM9createSEMEi>
    800039ac:	02a4b023          	sd	a0,32(s1)
    ret->spaceAvailable = SEM::createSEM(_cap);
    800039b0:	00090513          	mv	a0,s2
    800039b4:	00002097          	auipc	ra,0x2
    800039b8:	848080e7          	jalr	-1976(ra) # 800051fc <_ZN3SEM9createSEMEi>
    800039bc:	00a4bc23          	sd	a0,24(s1)
    ret->mutexHead = SEM::createSEM(1);
    800039c0:	00100513          	li	a0,1
    800039c4:	00002097          	auipc	ra,0x2
    800039c8:	838080e7          	jalr	-1992(ra) # 800051fc <_ZN3SEM9createSEMEi>
    800039cc:	02a4b423          	sd	a0,40(s1)
    ret->mutexTail = SEM::createSEM(1);
    800039d0:	00100513          	li	a0,1
    800039d4:	00002097          	auipc	ra,0x2
    800039d8:	828080e7          	jalr	-2008(ra) # 800051fc <_ZN3SEM9createSEMEi>
    800039dc:	02a4b823          	sd	a0,48(s1)
    return ret;
}
    800039e0:	00048513          	mv	a0,s1
    800039e4:	01813083          	ld	ra,24(sp)
    800039e8:	01013403          	ld	s0,16(sp)
    800039ec:	00813483          	ld	s1,8(sp)
    800039f0:	00013903          	ld	s2,0(sp)
    800039f4:	02010113          	addi	sp,sp,32
    800039f8:	00008067          	ret

00000000800039fc <_ZN13ConsoleBuffer3putEi>:
    MemoryAllocator::sys_mem_free(spaceAvailable);
    MemoryAllocator::sys_mem_free(mutexTail);
    MemoryAllocator::sys_mem_free(mutexHead);
}

void ConsoleBuffer::put(int val) {
    800039fc:	fe010113          	addi	sp,sp,-32
    80003a00:	00113c23          	sd	ra,24(sp)
    80003a04:	00813823          	sd	s0,16(sp)
    80003a08:	00913423          	sd	s1,8(sp)
    80003a0c:	01213023          	sd	s2,0(sp)
    80003a10:	02010413          	addi	s0,sp,32
    80003a14:	00050493          	mv	s1,a0
    80003a18:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80003a1c:	01853503          	ld	a0,24(a0)
    80003a20:	00002097          	auipc	ra,0x2
    80003a24:	860080e7          	jalr	-1952(ra) # 80005280 <_ZN3SEM4waitEv>

    mutexTail->wait();
    80003a28:	0304b503          	ld	a0,48(s1)
    80003a2c:	00002097          	auipc	ra,0x2
    80003a30:	854080e7          	jalr	-1964(ra) # 80005280 <_ZN3SEM4waitEv>
    buffer[tail] = val;
    80003a34:	0084b783          	ld	a5,8(s1)
    80003a38:	0144a703          	lw	a4,20(s1)
    80003a3c:	00e787b3          	add	a5,a5,a4
    80003a40:	01278023          	sb	s2,0(a5)
    tail = (tail + 1) % cap;
    80003a44:	0144a783          	lw	a5,20(s1)
    80003a48:	0017879b          	addiw	a5,a5,1
    80003a4c:	0004a703          	lw	a4,0(s1)
    80003a50:	02e7e7bb          	remw	a5,a5,a4
    80003a54:	00f4aa23          	sw	a5,20(s1)

    mutexTail->signal();
    80003a58:	0304b503          	ld	a0,48(s1)
    80003a5c:	00002097          	auipc	ra,0x2
    80003a60:	8bc080e7          	jalr	-1860(ra) # 80005318 <_ZN3SEM6signalEv>

    itemAvailable->signal();
    80003a64:	0204b503          	ld	a0,32(s1)
    80003a68:	00002097          	auipc	ra,0x2
    80003a6c:	8b0080e7          	jalr	-1872(ra) # 80005318 <_ZN3SEM6signalEv>

}
    80003a70:	01813083          	ld	ra,24(sp)
    80003a74:	01013403          	ld	s0,16(sp)
    80003a78:	00813483          	ld	s1,8(sp)
    80003a7c:	00013903          	ld	s2,0(sp)
    80003a80:	02010113          	addi	sp,sp,32
    80003a84:	00008067          	ret

0000000080003a88 <_ZN13ConsoleBuffer3getEv>:

int ConsoleBuffer::get() {
    80003a88:	fe010113          	addi	sp,sp,-32
    80003a8c:	00113c23          	sd	ra,24(sp)
    80003a90:	00813823          	sd	s0,16(sp)
    80003a94:	00913423          	sd	s1,8(sp)
    80003a98:	01213023          	sd	s2,0(sp)
    80003a9c:	02010413          	addi	s0,sp,32
    80003aa0:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80003aa4:	02053503          	ld	a0,32(a0)
    80003aa8:	00001097          	auipc	ra,0x1
    80003aac:	7d8080e7          	jalr	2008(ra) # 80005280 <_ZN3SEM4waitEv>

    mutexHead->wait();
    80003ab0:	0284b503          	ld	a0,40(s1)
    80003ab4:	00001097          	auipc	ra,0x1
    80003ab8:	7cc080e7          	jalr	1996(ra) # 80005280 <_ZN3SEM4waitEv>

    int ret = buffer[head];
    80003abc:	0084b703          	ld	a4,8(s1)
    80003ac0:	0104a783          	lw	a5,16(s1)
    80003ac4:	00f70733          	add	a4,a4,a5
    80003ac8:	00074903          	lbu	s2,0(a4)
    head = (head + 1) % cap;
    80003acc:	0017879b          	addiw	a5,a5,1
    80003ad0:	0004a703          	lw	a4,0(s1)
    80003ad4:	02e7e7bb          	remw	a5,a5,a4
    80003ad8:	00f4a823          	sw	a5,16(s1)

    mutexHead->signal();
    80003adc:	0284b503          	ld	a0,40(s1)
    80003ae0:	00002097          	auipc	ra,0x2
    80003ae4:	838080e7          	jalr	-1992(ra) # 80005318 <_ZN3SEM6signalEv>

    spaceAvailable->signal();
    80003ae8:	0184b503          	ld	a0,24(s1)
    80003aec:	00002097          	auipc	ra,0x2
    80003af0:	82c080e7          	jalr	-2004(ra) # 80005318 <_ZN3SEM6signalEv>

    return ret;
}
    80003af4:	00090513          	mv	a0,s2
    80003af8:	01813083          	ld	ra,24(sp)
    80003afc:	01013403          	ld	s0,16(sp)
    80003b00:	00813483          	ld	s1,8(sp)
    80003b04:	00013903          	ld	s2,0(sp)
    80003b08:	02010113          	addi	sp,sp,32
    80003b0c:	00008067          	ret

0000000080003b10 <_ZN13ConsoleBuffer6getCntEv>:

int ConsoleBuffer::getCnt() {
    80003b10:	fe010113          	addi	sp,sp,-32
    80003b14:	00113c23          	sd	ra,24(sp)
    80003b18:	00813823          	sd	s0,16(sp)
    80003b1c:	00913423          	sd	s1,8(sp)
    80003b20:	01213023          	sd	s2,0(sp)
    80003b24:	02010413          	addi	s0,sp,32
    80003b28:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80003b2c:	02853503          	ld	a0,40(a0)
    80003b30:	00001097          	auipc	ra,0x1
    80003b34:	750080e7          	jalr	1872(ra) # 80005280 <_ZN3SEM4waitEv>
    mutexTail->wait();
    80003b38:	0304b503          	ld	a0,48(s1)
    80003b3c:	00001097          	auipc	ra,0x1
    80003b40:	744080e7          	jalr	1860(ra) # 80005280 <_ZN3SEM4waitEv>

    if (tail >= head) {
    80003b44:	0144a783          	lw	a5,20(s1)
    80003b48:	0104a903          	lw	s2,16(s1)
    80003b4c:	0327ce63          	blt	a5,s2,80003b88 <_ZN13ConsoleBuffer6getCntEv+0x78>
        ret = tail - head;
    80003b50:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80003b54:	0304b503          	ld	a0,48(s1)
    80003b58:	00001097          	auipc	ra,0x1
    80003b5c:	7c0080e7          	jalr	1984(ra) # 80005318 <_ZN3SEM6signalEv>
    mutexHead->signal();
    80003b60:	0284b503          	ld	a0,40(s1)
    80003b64:	00001097          	auipc	ra,0x1
    80003b68:	7b4080e7          	jalr	1972(ra) # 80005318 <_ZN3SEM6signalEv>

    return ret;
}
    80003b6c:	00090513          	mv	a0,s2
    80003b70:	01813083          	ld	ra,24(sp)
    80003b74:	01013403          	ld	s0,16(sp)
    80003b78:	00813483          	ld	s1,8(sp)
    80003b7c:	00013903          	ld	s2,0(sp)
    80003b80:	02010113          	addi	sp,sp,32
    80003b84:	00008067          	ret
        ret = cap - head + tail;
    80003b88:	0004a703          	lw	a4,0(s1)
    80003b8c:	4127093b          	subw	s2,a4,s2
    80003b90:	00f9093b          	addw	s2,s2,a5
    80003b94:	fc1ff06f          	j	80003b54 <_ZN13ConsoleBuffer6getCntEv+0x44>

0000000080003b98 <_ZN13ConsoleBufferD1Ev>:
ConsoleBuffer::~ConsoleBuffer() {
    80003b98:	fe010113          	addi	sp,sp,-32
    80003b9c:	00113c23          	sd	ra,24(sp)
    80003ba0:	00813823          	sd	s0,16(sp)
    80003ba4:	00913423          	sd	s1,8(sp)
    80003ba8:	02010413          	addi	s0,sp,32
    80003bac:	00050493          	mv	s1,a0
    while (getCnt() > 0) {
    80003bb0:	00048513          	mv	a0,s1
    80003bb4:	00000097          	auipc	ra,0x0
    80003bb8:	f5c080e7          	jalr	-164(ra) # 80003b10 <_ZN13ConsoleBuffer6getCntEv>
    80003bbc:	00a05e63          	blez	a0,80003bd8 <_ZN13ConsoleBufferD1Ev+0x40>
        head = (head + 1) % cap;
    80003bc0:	0104a783          	lw	a5,16(s1)
    80003bc4:	0017879b          	addiw	a5,a5,1
    80003bc8:	0004a703          	lw	a4,0(s1)
    80003bcc:	02e7e7bb          	remw	a5,a5,a4
    80003bd0:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80003bd4:	fddff06f          	j	80003bb0 <_ZN13ConsoleBufferD1Ev+0x18>
    MemoryAllocator::sys_mem_free(buffer);
    80003bd8:	0084b503          	ld	a0,8(s1)
    80003bdc:	00000097          	auipc	ra,0x0
    80003be0:	4a8080e7          	jalr	1192(ra) # 80004084 <_ZN15MemoryAllocator12sys_mem_freeEPv>
    itemAvailable->close();
    80003be4:	0204b503          	ld	a0,32(s1)
    80003be8:	00001097          	auipc	ra,0x1
    80003bec:	794080e7          	jalr	1940(ra) # 8000537c <_ZN3SEM5closeEv>
    spaceAvailable->close();
    80003bf0:	0184b503          	ld	a0,24(s1)
    80003bf4:	00001097          	auipc	ra,0x1
    80003bf8:	788080e7          	jalr	1928(ra) # 8000537c <_ZN3SEM5closeEv>
    mutexTail->close();
    80003bfc:	0304b503          	ld	a0,48(s1)
    80003c00:	00001097          	auipc	ra,0x1
    80003c04:	77c080e7          	jalr	1916(ra) # 8000537c <_ZN3SEM5closeEv>
    mutexHead->close();
    80003c08:	0284b503          	ld	a0,40(s1)
    80003c0c:	00001097          	auipc	ra,0x1
    80003c10:	770080e7          	jalr	1904(ra) # 8000537c <_ZN3SEM5closeEv>
    MemoryAllocator::sys_mem_free(itemAvailable);
    80003c14:	0204b503          	ld	a0,32(s1)
    80003c18:	00000097          	auipc	ra,0x0
    80003c1c:	46c080e7          	jalr	1132(ra) # 80004084 <_ZN15MemoryAllocator12sys_mem_freeEPv>
    MemoryAllocator::sys_mem_free(spaceAvailable);
    80003c20:	0184b503          	ld	a0,24(s1)
    80003c24:	00000097          	auipc	ra,0x0
    80003c28:	460080e7          	jalr	1120(ra) # 80004084 <_ZN15MemoryAllocator12sys_mem_freeEPv>
    MemoryAllocator::sys_mem_free(mutexTail);
    80003c2c:	0304b503          	ld	a0,48(s1)
    80003c30:	00000097          	auipc	ra,0x0
    80003c34:	454080e7          	jalr	1108(ra) # 80004084 <_ZN15MemoryAllocator12sys_mem_freeEPv>
    MemoryAllocator::sys_mem_free(mutexHead);
    80003c38:	0284b503          	ld	a0,40(s1)
    80003c3c:	00000097          	auipc	ra,0x0
    80003c40:	448080e7          	jalr	1096(ra) # 80004084 <_ZN15MemoryAllocator12sys_mem_freeEPv>
}
    80003c44:	01813083          	ld	ra,24(sp)
    80003c48:	01013403          	ld	s0,16(sp)
    80003c4c:	00813483          	ld	s1,8(sp)
    80003c50:	02010113          	addi	sp,sp,32
    80003c54:	00008067          	ret

0000000080003c58 <_ZN6SleepQ3putEP3PCBm>:
SleepQ::ElemQ *SleepQ::head = nullptr;
SleepQ::ElemQ *SleepQ::last = nullptr;

kmem_cache_t *SleepQ::ElemQ::cache = nullptr;

void SleepQ::put(PCB *pcb, time_t time){
    80003c58:	fd010113          	addi	sp,sp,-48
    80003c5c:	02113423          	sd	ra,40(sp)
    80003c60:	02813023          	sd	s0,32(sp)
    80003c64:	00913c23          	sd	s1,24(sp)
    80003c68:	01213823          	sd	s2,16(sp)
    80003c6c:	01313423          	sd	s3,8(sp)
    80003c70:	03010413          	addi	s0,sp,48
    80003c74:	00050913          	mv	s2,a0
    80003c78:	00058493          	mv	s1,a1
    if(head == nullptr){
    80003c7c:	00006797          	auipc	a5,0x6
    80003c80:	47c7b783          	ld	a5,1148(a5) # 8000a0f8 <_ZN6SleepQ4headE>
    80003c84:	06078263          	beqz	a5,80003ce8 <_ZN6SleepQ3putEP3PCBm+0x90>

        static kmem_cache_t *cache;
        ElemQ(PCB* p, time_t r, ElemQ* n = nullptr): pcb(p), rang(r), next(n) {}

        static ElemQ *createElemQ(PCB *p, time_t r, ElemQ* n = nullptr){
            ElemQ *ret = (ElemQ *) kmem_cache_alloc(ElemQ::cache);
    80003c88:	00006997          	auipc	s3,0x6
    80003c8c:	47098993          	addi	s3,s3,1136 # 8000a0f8 <_ZN6SleepQ4headE>
    80003c90:	0089b503          	ld	a0,8(s3)
    80003c94:	00001097          	auipc	ra,0x1
    80003c98:	488080e7          	jalr	1160(ra) # 8000511c <_Z16kmem_cache_allocP10kmem_cache>
            ret->pcb = p;
    80003c9c:	01253023          	sd	s2,0(a0)
            ret->rang = r;
    80003ca0:	00953423          	sd	s1,8(a0)
            ret->next = n;
    80003ca4:	00053823          	sd	zero,16(a0)
        new_e->next = nullptr;
        head = new_e;
        last = new_e;
    }else{
        ElemQ *new_e = ElemQ::createElemQ(pcb, time);//new ElemQ(pcb, time);
        if(time <= head->rang){
    80003ca8:	0009b603          	ld	a2,0(s3)
    80003cac:	00863583          	ld	a1,8(a2)
    80003cb0:	0695e263          	bltu	a1,s1,80003d14 <_ZN6SleepQ3putEP3PCBm+0xbc>
            new_e->next = head;
    80003cb4:	00c53823          	sd	a2,16(a0)
            head->rang = head->rang - new_e->rang;
    80003cb8:	00863583          	ld	a1,8(a2)
    80003cbc:	409584b3          	sub	s1,a1,s1
    80003cc0:	00963423          	sd	s1,8(a2)
            head = new_e;
    80003cc4:	00006797          	auipc	a5,0x6
    80003cc8:	42a7ba23          	sd	a0,1076(a5) # 8000a0f8 <_ZN6SleepQ4headE>
                last->next = new_e;
                last = new_e;
            }
        }
    }
}
    80003ccc:	02813083          	ld	ra,40(sp)
    80003cd0:	02013403          	ld	s0,32(sp)
    80003cd4:	01813483          	ld	s1,24(sp)
    80003cd8:	01013903          	ld	s2,16(sp)
    80003cdc:	00813983          	ld	s3,8(sp)
    80003ce0:	03010113          	addi	sp,sp,48
    80003ce4:	00008067          	ret
            ElemQ *ret = (ElemQ *) kmem_cache_alloc(ElemQ::cache);
    80003ce8:	00006997          	auipc	s3,0x6
    80003cec:	41098993          	addi	s3,s3,1040 # 8000a0f8 <_ZN6SleepQ4headE>
    80003cf0:	0089b503          	ld	a0,8(s3)
    80003cf4:	00001097          	auipc	ra,0x1
    80003cf8:	428080e7          	jalr	1064(ra) # 8000511c <_Z16kmem_cache_allocP10kmem_cache>
            ret->pcb = p;
    80003cfc:	01253023          	sd	s2,0(a0)
            ret->rang = r;
    80003d00:	00953423          	sd	s1,8(a0)
            ret->next = n;
    80003d04:	00053823          	sd	zero,16(a0)
        head = new_e;
    80003d08:	00a9b023          	sd	a0,0(s3)
        last = new_e;
    80003d0c:	00a9b823          	sd	a0,16(s3)
    80003d10:	fbdff06f          	j	80003ccc <_ZN6SleepQ3putEP3PCBm+0x74>
            ElemQ *tmp = head->next;
    80003d14:	01063783          	ld	a5,16(a2)
            new_e->rang = new_e->rang - head->rang;
    80003d18:	40b484b3          	sub	s1,s1,a1
    80003d1c:	00953423          	sd	s1,8(a0)
    80003d20:	0140006f          	j	80003d34 <_ZN6SleepQ3putEP3PCBm+0xdc>
                new_e->rang = new_e->rang - tmp->rang;
    80003d24:	40d70733          	sub	a4,a4,a3
    80003d28:	00e53423          	sd	a4,8(a0)
                prev = tmp;
    80003d2c:	00078613          	mv	a2,a5
                tmp = tmp->next;
    80003d30:	0107b783          	ld	a5,16(a5)
            while(tmp != nullptr){
    80003d34:	02078063          	beqz	a5,80003d54 <_ZN6SleepQ3putEP3PCBm+0xfc>
                if(new_e->rang <= tmp->rang){
    80003d38:	00853703          	ld	a4,8(a0)
    80003d3c:	0087b683          	ld	a3,8(a5)
    80003d40:	fee6e2e3          	bltu	a3,a4,80003d24 <_ZN6SleepQ3putEP3PCBm+0xcc>
                    tmp->rang = tmp->rang - new_e->rang;
    80003d44:	40e68733          	sub	a4,a3,a4
    80003d48:	00e7b423          	sd	a4,8(a5)
                    prev->next = new_e;
    80003d4c:	00a63823          	sd	a0,16(a2)
                    new_e->next = tmp;
    80003d50:	00f53823          	sd	a5,16(a0)
            if(tmp == nullptr){
    80003d54:	f6079ce3          	bnez	a5,80003ccc <_ZN6SleepQ3putEP3PCBm+0x74>
                last->next = new_e;
    80003d58:	00006797          	auipc	a5,0x6
    80003d5c:	3a078793          	addi	a5,a5,928 # 8000a0f8 <_ZN6SleepQ4headE>
    80003d60:	0107b703          	ld	a4,16(a5)
    80003d64:	00a73823          	sd	a0,16(a4)
                last = new_e;
    80003d68:	00a7b823          	sd	a0,16(a5)
}
    80003d6c:	f61ff06f          	j	80003ccc <_ZN6SleepQ3putEP3PCBm+0x74>

0000000080003d70 <_ZN6SleepQ3getEv>:

PCB *SleepQ::get(){
    80003d70:	fe010113          	addi	sp,sp,-32
    80003d74:	00113c23          	sd	ra,24(sp)
    80003d78:	00813823          	sd	s0,16(sp)
    80003d7c:	00913423          	sd	s1,8(sp)
    80003d80:	02010413          	addi	s0,sp,32
    if(!head) return nullptr;
    80003d84:	00006597          	auipc	a1,0x6
    80003d88:	3745b583          	ld	a1,884(a1) # 8000a0f8 <_ZN6SleepQ4headE>
    80003d8c:	04058663          	beqz	a1,80003dd8 <_ZN6SleepQ3getEv+0x68>

    ElemQ *tmp = head;
    head = head->next;
    80003d90:	0105b783          	ld	a5,16(a1)
    80003d94:	00006717          	auipc	a4,0x6
    80003d98:	36f73223          	sd	a5,868(a4) # 8000a0f8 <_ZN6SleepQ4headE>
    if(!head) last = nullptr;
    80003d9c:	02078863          	beqz	a5,80003dcc <_ZN6SleepQ3getEv+0x5c>

    PCB *res = tmp->pcb;
    80003da0:	0005b483          	ld	s1,0(a1)
            return ret;
        }

        static void freeObject(ElemQ *obj){
            kmem_cache_free(ElemQ::cache, (void *)obj);
    80003da4:	00006517          	auipc	a0,0x6
    80003da8:	35c53503          	ld	a0,860(a0) # 8000a100 <_ZN6SleepQ5ElemQ5cacheE>
    80003dac:	00001097          	auipc	ra,0x1
    80003db0:	398080e7          	jalr	920(ra) # 80005144 <_Z15kmem_cache_freeP10kmem_cachePv>
    //MemoryAllocator::sys_mem_free(tmp);
    ElemQ::freeObject(tmp);
    return res;
}
    80003db4:	00048513          	mv	a0,s1
    80003db8:	01813083          	ld	ra,24(sp)
    80003dbc:	01013403          	ld	s0,16(sp)
    80003dc0:	00813483          	ld	s1,8(sp)
    80003dc4:	02010113          	addi	sp,sp,32
    80003dc8:	00008067          	ret
    if(!head) last = nullptr;
    80003dcc:	00006797          	auipc	a5,0x6
    80003dd0:	3207be23          	sd	zero,828(a5) # 8000a108 <_ZN6SleepQ4lastE>
    80003dd4:	fcdff06f          	j	80003da0 <_ZN6SleepQ3getEv+0x30>
    if(!head) return nullptr;
    80003dd8:	00058493          	mv	s1,a1
    80003ddc:	fd9ff06f          	j	80003db4 <_ZN6SleepQ3getEv+0x44>

0000000080003de0 <_ZN6SleepQ6updateEv>:

void SleepQ::update() {
    80003de0:	ff010113          	addi	sp,sp,-16
    80003de4:	00813423          	sd	s0,8(sp)
    80003de8:	01010413          	addi	s0,sp,16
    if(head != nullptr) {
    80003dec:	00006797          	auipc	a5,0x6
    80003df0:	30c7b783          	ld	a5,780(a5) # 8000a0f8 <_ZN6SleepQ4headE>
    80003df4:	00078a63          	beqz	a5,80003e08 <_ZN6SleepQ6updateEv+0x28>
        if(head->rang != 0) head->rang--;
    80003df8:	0087b703          	ld	a4,8(a5)
    80003dfc:	00070663          	beqz	a4,80003e08 <_ZN6SleepQ6updateEv+0x28>
    80003e00:	fff70713          	addi	a4,a4,-1
    80003e04:	00e7b423          	sd	a4,8(a5)
    }
    80003e08:	00813403          	ld	s0,8(sp)
    80003e0c:	01010113          	addi	sp,sp,16
    80003e10:	00008067          	ret

0000000080003e14 <_ZN9Scheduler3getEv>:
#include "../h/scheduler.hpp"
#include "../h/PCB_List.hpp"

PCB_List *Scheduler::readyThreadQueue;

PCB *Scheduler::get(){
    80003e14:	ff010113          	addi	sp,sp,-16
    80003e18:	00113423          	sd	ra,8(sp)
    80003e1c:	00813023          	sd	s0,0(sp)
    80003e20:	01010413          	addi	s0,sp,16
    return readyThreadQueue->removeFirst();
    80003e24:	00006517          	auipc	a0,0x6
    80003e28:	2ec53503          	ld	a0,748(a0) # 8000a110 <_ZN9Scheduler16readyThreadQueueE>
    80003e2c:	ffffe097          	auipc	ra,0xffffe
    80003e30:	1b0080e7          	jalr	432(ra) # 80001fdc <_ZN8PCB_List11removeFirstEv>
}
    80003e34:	00813083          	ld	ra,8(sp)
    80003e38:	00013403          	ld	s0,0(sp)
    80003e3c:	01010113          	addi	sp,sp,16
    80003e40:	00008067          	ret

0000000080003e44 <_ZN9Scheduler3putEP3PCB>:

int Scheduler::put(PCB *pcb) {
    80003e44:	ff010113          	addi	sp,sp,-16
    80003e48:	00113423          	sd	ra,8(sp)
    80003e4c:	00813023          	sd	s0,0(sp)
    80003e50:	01010413          	addi	s0,sp,16
    80003e54:	00050593          	mv	a1,a0
    return readyThreadQueue->addLast(pcb);
    80003e58:	00006517          	auipc	a0,0x6
    80003e5c:	2b853503          	ld	a0,696(a0) # 8000a110 <_ZN9Scheduler16readyThreadQueueE>
    80003e60:	ffffe097          	auipc	ra,0xffffe
    80003e64:	0fc080e7          	jalr	252(ra) # 80001f5c <_ZN8PCB_List7addLastEP3PCB>
}
    80003e68:	00813083          	ld	ra,8(sp)
    80003e6c:	00013403          	ld	s0,0(sp)
    80003e70:	01010113          	addi	sp,sp,16
    80003e74:	00008067          	ret

0000000080003e78 <_ZN9Scheduler15createSchedulerEP10kmem_cache>:

void Scheduler::createScheduler(kmem_cache_t *cache) {
    80003e78:	ff010113          	addi	sp,sp,-16
    80003e7c:	00113423          	sd	ra,8(sp)
    80003e80:	00813023          	sd	s0,0(sp)
    80003e84:	01010413          	addi	s0,sp,16
    readyThreadQueue = (PCB_List *)kmem_cache_alloc(cache);
    80003e88:	00001097          	auipc	ra,0x1
    80003e8c:	294080e7          	jalr	660(ra) # 8000511c <_Z16kmem_cache_allocP10kmem_cache>
    80003e90:	00006797          	auipc	a5,0x6
    80003e94:	28a7b023          	sd	a0,640(a5) # 8000a110 <_ZN9Scheduler16readyThreadQueueE>
}
    80003e98:	00813083          	ld	ra,8(sp)
    80003e9c:	00013403          	ld	s0,0(sp)
    80003ea0:	01010113          	addi	sp,sp,16
    80003ea4:	00008067          	ret

0000000080003ea8 <_Z41__static_initialization_and_destruction_0ii>:
        }
        prev = tmp;
        tmp = tmp->next;
    }
    return (void*)-1;
    80003ea8:	ff010113          	addi	sp,sp,-16
    80003eac:	00813423          	sd	s0,8(sp)
    80003eb0:	01010413          	addi	s0,sp,16
    80003eb4:	00100793          	li	a5,1
    80003eb8:	00f50863          	beq	a0,a5,80003ec8 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80003ebc:	00813403          	ld	s0,8(sp)
    80003ec0:	01010113          	addi	sp,sp,16
    80003ec4:	00008067          	ret
    80003ec8:	000107b7          	lui	a5,0x10
    80003ecc:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80003ed0:	fef596e3          	bne	a1,a5,80003ebc <_Z41__static_initialization_and_destruction_0ii+0x14>
const void* MemoryAllocator::MEM_START = (void *)HEAP_START_ADDR;
    80003ed4:	00006797          	auipc	a5,0x6
    80003ed8:	24478793          	addi	a5,a5,580 # 8000a118 <_ZN15MemoryAllocator9MEM_STARTE>
    80003edc:	00006717          	auipc	a4,0x6
    80003ee0:	08473703          	ld	a4,132(a4) # 80009f60 <_GLOBAL_OFFSET_TABLE_+0x30>
    80003ee4:	00073703          	ld	a4,0(a4)
    80003ee8:	00e7b023          	sd	a4,0(a5)
const void* MemoryAllocator::MEM_END = (void *)HEAP_END_ADDR;
    80003eec:	00006717          	auipc	a4,0x6
    80003ef0:	0fc73703          	ld	a4,252(a4) # 80009fe8 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003ef4:	00073703          	ld	a4,0(a4)
    80003ef8:	00e7b423          	sd	a4,8(a5)
    80003efc:	fc1ff06f          	j	80003ebc <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080003f00 <_ZN15MemoryAllocator8mem_initEPvS0_>:
void MemoryAllocator::mem_init(void* START, void* END){
    80003f00:	ff010113          	addi	sp,sp,-16
    80003f04:	00813423          	sd	s0,8(sp)
    80003f08:	01010413          	addi	s0,sp,16
    MEM_START = START;
    80003f0c:	00006797          	auipc	a5,0x6
    80003f10:	20c78793          	addi	a5,a5,524 # 8000a118 <_ZN15MemoryAllocator9MEM_STARTE>
    80003f14:	00a7b023          	sd	a0,0(a5)
    MEM_END = END;
    80003f18:	00b7b423          	sd	a1,8(a5)
}
    80003f1c:	00813403          	ld	s0,8(sp)
    80003f20:	01010113          	addi	sp,sp,16
    80003f24:	00008067          	ret

0000000080003f28 <_ZN15MemoryAllocator10emptySpaceEmm>:
void MemoryAllocator::emptySpace(uint64 startAddr, uint64 size) {
    80003f28:	ff010113          	addi	sp,sp,-16
    80003f2c:	00813423          	sd	s0,8(sp)
    80003f30:	01010413          	addi	s0,sp,16
    uint64 addr = startAddr;
    80003f34:	00050793          	mv	a5,a0
    while(addr < startAddr + size){
    80003f38:	00b50733          	add	a4,a0,a1
    80003f3c:	00e7f863          	bgeu	a5,a4,80003f4c <_ZN15MemoryAllocator10emptySpaceEmm+0x24>
        *memory = 0;
    80003f40:	00078023          	sb	zero,0(a5)
        addr++;
    80003f44:	00178793          	addi	a5,a5,1
    while(addr < startAddr + size){
    80003f48:	ff1ff06f          	j	80003f38 <_ZN15MemoryAllocator10emptySpaceEmm+0x10>
}
    80003f4c:	00813403          	ld	s0,8(sp)
    80003f50:	01010113          	addi	sp,sp,16
    80003f54:	00008067          	ret

0000000080003f58 <_ZN15MemoryAllocator13sys_mem_allocEm>:
void* MemoryAllocator::sys_mem_alloc(size_t size){
    80003f58:	ff010113          	addi	sp,sp,-16
    80003f5c:	00813423          	sd	s0,8(sp)
    80003f60:	01010413          	addi	s0,sp,16
    size_t realSize = ((size + sizeof(struct Allocator)) / MEM_BLOCK_SIZE) * MEM_BLOCK_SIZE + MEM_BLOCK_SIZE;
    80003f64:	01850613          	addi	a2,a0,24
    80003f68:	fc067613          	andi	a2,a2,-64
    80003f6c:	04060613          	addi	a2,a2,64
    uint64 addr = (uint64)MEM_START;
    80003f70:	00006717          	auipc	a4,0x6
    80003f74:	1a870713          	addi	a4,a4,424 # 8000a118 <_ZN15MemoryAllocator9MEM_STARTE>
    80003f78:	00073783          	ld	a5,0(a4)
    struct Allocator *head= alloc_head;
    80003f7c:	01073683          	ld	a3,16(a4)
    if(head == nullptr){
    80003f80:	04068063          	beqz	a3,80003fc0 <_ZN15MemoryAllocator13sys_mem_allocEm+0x68>
    if(realSize < alloc_head->start_addr - (uint64)MEM_START){
    80003f84:	0006b703          	ld	a4,0(a3)
    80003f88:	40f70733          	sub	a4,a4,a5
    80003f8c:	06e66663          	bltu	a2,a4,80003ff8 <_ZN15MemoryAllocator13sys_mem_allocEm+0xa0>
    struct Allocator *tmp = alloc_head->next;
    80003f90:	0106b503          	ld	a0,16(a3)
    while(tmp != nullptr){
    80003f94:	0a050a63          	beqz	a0,80004048 <_ZN15MemoryAllocator13sys_mem_allocEm+0xf0>
        if(realSize < tmp->start_addr - 1 - (prev->start_addr + prev->size)){
    80003f98:	00053783          	ld	a5,0(a0)
    80003f9c:	0006b703          	ld	a4,0(a3)
    80003fa0:	0086b583          	ld	a1,8(a3)
    80003fa4:	00b70733          	add	a4,a4,a1
    80003fa8:	40e787b3          	sub	a5,a5,a4
    80003fac:	fff78793          	addi	a5,a5,-1
    80003fb0:	06f66c63          	bltu	a2,a5,80004028 <_ZN15MemoryAllocator13sys_mem_allocEm+0xd0>
        prev = tmp;
    80003fb4:	00050693          	mv	a3,a0
        tmp = tmp->next;
    80003fb8:	01053503          	ld	a0,16(a0)
    while(tmp != nullptr){
    80003fbc:	fd9ff06f          	j	80003f94 <_ZN15MemoryAllocator13sys_mem_allocEm+0x3c>
        if(realSize < (uint64)MEM_END - (uint64)MEM_START){
    80003fc0:	00006717          	auipc	a4,0x6
    80003fc4:	16073703          	ld	a4,352(a4) # 8000a120 <_ZN15MemoryAllocator7MEM_ENDE>
    80003fc8:	40f70733          	sub	a4,a4,a5
    80003fcc:	02e67263          	bgeu	a2,a4,80003ff0 <_ZN15MemoryAllocator13sys_mem_allocEm+0x98>
            new_m->size = realSize;
    80003fd0:	00c7b423          	sd	a2,8(a5)
            new_m->next = nullptr;
    80003fd4:	0007b823          	sd	zero,16(a5)
            new_m->start_addr = addr;
    80003fd8:	00f7b023          	sd	a5,0(a5)
            alloc_head = new_m;
    80003fdc:	00006717          	auipc	a4,0x6
    80003fe0:	14f73623          	sd	a5,332(a4) # 8000a128 <_ZN15MemoryAllocator10alloc_headE>
            res = new_m->start_addr + sizeof(struct Allocator) + 1;
    80003fe4:	0007b503          	ld	a0,0(a5)
    80003fe8:	01950513          	addi	a0,a0,25
    80003fec:	0300006f          	j	8000401c <_ZN15MemoryAllocator13sys_mem_allocEm+0xc4>
            res = -1;
    80003ff0:	fff00513          	li	a0,-1
        return (void *)res;
    80003ff4:	0280006f          	j	8000401c <_ZN15MemoryAllocator13sys_mem_allocEm+0xc4>
        new_m->size = realSize;
    80003ff8:	00c7b423          	sd	a2,8(a5)
        new_m->start_addr = addr;
    80003ffc:	00f7b023          	sd	a5,0(a5)
        new_m->next = alloc_head;
    80004000:	00006717          	auipc	a4,0x6
    80004004:	11870713          	addi	a4,a4,280 # 8000a118 <_ZN15MemoryAllocator9MEM_STARTE>
    80004008:	01073683          	ld	a3,16(a4)
    8000400c:	00d7b823          	sd	a3,16(a5)
        alloc_head = new_m;
    80004010:	00f73823          	sd	a5,16(a4)
        res = new_m->start_addr + sizeof(struct Allocator);
    80004014:	0007b503          	ld	a0,0(a5)
    80004018:	01850513          	addi	a0,a0,24
}
    8000401c:	00813403          	ld	s0,8(sp)
    80004020:	01010113          	addi	sp,sp,16
    80004024:	00008067          	ret
            addr = prev->start_addr + prev->size + 1;
    80004028:	00170793          	addi	a5,a4,1
            new_m->start_addr = addr;
    8000402c:	00f730a3          	sd	a5,1(a4)
            new_m->size = realSize;
    80004030:	00c734a3          	sd	a2,9(a4)
            new_m->next = tmp;
    80004034:	00a738a3          	sd	a0,17(a4)
            prev->next = new_m;
    80004038:	00f6b823          	sd	a5,16(a3)
            res = new_m->start_addr + sizeof(struct Allocator) + 1;
    8000403c:	00173503          	ld	a0,1(a4)
    80004040:	01950513          	addi	a0,a0,25
            return (void *)res;
    80004044:	fd9ff06f          	j	8000401c <_ZN15MemoryAllocator13sys_mem_allocEm+0xc4>
    if(realSize < (uint64)MEM_END - (tmp->start_addr + tmp->size + 1)){
    80004048:	0006b703          	ld	a4,0(a3)
    8000404c:	0086b783          	ld	a5,8(a3)
    80004050:	00f70733          	add	a4,a4,a5
    80004054:	00006797          	auipc	a5,0x6
    80004058:	0cc7b783          	ld	a5,204(a5) # 8000a120 <_ZN15MemoryAllocator7MEM_ENDE>
    8000405c:	40e787b3          	sub	a5,a5,a4
    80004060:	fff78793          	addi	a5,a5,-1
    80004064:	faf67ce3          	bgeu	a2,a5,8000401c <_ZN15MemoryAllocator13sys_mem_allocEm+0xc4>
        addr = tmp->start_addr + tmp->size + 1;
    80004068:	00170793          	addi	a5,a4,1
        new_m->start_addr = addr;
    8000406c:	00f730a3          	sd	a5,1(a4)
        new_m->size = realSize;
    80004070:	00c734a3          	sd	a2,9(a4)
        new_m->next = nullptr;
    80004074:	000738a3          	sd	zero,17(a4)
        tmp->next = new_m;
    80004078:	00f6b823          	sd	a5,16(a3)
        res = addr + sizeof(struct Allocator) + 1;
    8000407c:	01a70513          	addi	a0,a4,26
        return (void *)res;
    80004080:	f9dff06f          	j	8000401c <_ZN15MemoryAllocator13sys_mem_allocEm+0xc4>

0000000080004084 <_ZN15MemoryAllocator12sys_mem_freeEPv>:
    struct Allocator *tmp = alloc_head;
    80004084:	00006797          	auipc	a5,0x6
    80004088:	0a47b783          	ld	a5,164(a5) # 8000a128 <_ZN15MemoryAllocator10alloc_headE>
    struct Allocator *prev = 0;
    8000408c:	00000693          	li	a3,0
    while(tmp != 0){
    80004090:	06078e63          	beqz	a5,8000410c <_ZN15MemoryAllocator12sys_mem_freeEPv+0x88>
        if(tmp->start_addr + sizeof(struct Allocator) == (uint64)addr){
    80004094:	0007b703          	ld	a4,0(a5)
    80004098:	01870713          	addi	a4,a4,24
    8000409c:	00a70863          	beq	a4,a0,800040ac <_ZN15MemoryAllocator12sys_mem_freeEPv+0x28>
        prev = tmp;
    800040a0:	00078693          	mv	a3,a5
        tmp = tmp->next;
    800040a4:	0107b783          	ld	a5,16(a5)
    while(tmp != 0){
    800040a8:	fe9ff06f          	j	80004090 <_ZN15MemoryAllocator12sys_mem_freeEPv+0xc>
void* MemoryAllocator::sys_mem_free(void *addr){
    800040ac:	ff010113          	addi	sp,sp,-16
    800040b0:	00113423          	sd	ra,8(sp)
    800040b4:	00813023          	sd	s0,0(sp)
    800040b8:	01010413          	addi	s0,sp,16
            if(prev == 0){ //if head is that must be deleted then...
    800040bc:	02068863          	beqz	a3,800040ec <_ZN15MemoryAllocator12sys_mem_freeEPv+0x68>
                prev->next = tmp->next;
    800040c0:	0107b703          	ld	a4,16(a5)
    800040c4:	00e6b823          	sd	a4,16(a3)
                emptySpace(tmp->start_addr, tmp->size);
    800040c8:	0087b583          	ld	a1,8(a5)
    800040cc:	0007b503          	ld	a0,0(a5)
    800040d0:	00000097          	auipc	ra,0x0
    800040d4:	e58080e7          	jalr	-424(ra) # 80003f28 <_ZN15MemoryAllocator10emptySpaceEmm>
            return 0;
    800040d8:	00000513          	li	a0,0
    800040dc:	00813083          	ld	ra,8(sp)
    800040e0:	00013403          	ld	s0,0(sp)
    800040e4:	01010113          	addi	sp,sp,16
    800040e8:	00008067          	ret
                alloc_head = tmp->next;
    800040ec:	0107b703          	ld	a4,16(a5)
    800040f0:	00006697          	auipc	a3,0x6
    800040f4:	02e6bc23          	sd	a4,56(a3) # 8000a128 <_ZN15MemoryAllocator10alloc_headE>
                emptySpace(tmp->start_addr, tmp->size);
    800040f8:	0087b583          	ld	a1,8(a5)
    800040fc:	0007b503          	ld	a0,0(a5)
    80004100:	00000097          	auipc	ra,0x0
    80004104:	e28080e7          	jalr	-472(ra) # 80003f28 <_ZN15MemoryAllocator10emptySpaceEmm>
    80004108:	fd1ff06f          	j	800040d8 <_ZN15MemoryAllocator12sys_mem_freeEPv+0x54>
    return (void*)-1;
    8000410c:	fff00513          	li	a0,-1
    80004110:	00008067          	ret

0000000080004114 <_GLOBAL__sub_I__ZN15MemoryAllocator10alloc_headE>:
    80004114:	ff010113          	addi	sp,sp,-16
    80004118:	00113423          	sd	ra,8(sp)
    8000411c:	00813023          	sd	s0,0(sp)
    80004120:	01010413          	addi	s0,sp,16
    80004124:	000105b7          	lui	a1,0x10
    80004128:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    8000412c:	00100513          	li	a0,1
    80004130:	00000097          	auipc	ra,0x0
    80004134:	d78080e7          	jalr	-648(ra) # 80003ea8 <_Z41__static_initialization_and_destruction_0ii>
    80004138:	00813083          	ld	ra,8(sp)
    8000413c:	00013403          	ld	s0,0(sp)
    80004140:	01010113          	addi	sp,sp,16
    80004144:	00008067          	ret

0000000080004148 <_ZN14ConsoleHandler20createConsoleHandlerEv>:
#include "../h/ConsoleHandler.hpp"
#include "../h/PCB.hpp"

ConsoleHandler *ConsoleHandler::instance = nullptr;

ConsoleHandler *ConsoleHandler::createConsoleHandler() {
    80004148:	fe010113          	addi	sp,sp,-32
    8000414c:	00113c23          	sd	ra,24(sp)
    80004150:	00813823          	sd	s0,16(sp)
    80004154:	00913423          	sd	s1,8(sp)
    80004158:	02010413          	addi	s0,sp,32
    ConsoleHandler *ret = (ConsoleHandler *)kmalloc(sizeof(ConsoleHandler));
    8000415c:	01000513          	li	a0,16
    80004160:	00001097          	auipc	ra,0x1
    80004164:	f6c080e7          	jalr	-148(ra) # 800050cc <_Z7kmallocm>
    80004168:	00050493          	mv	s1,a0
    ret->input = ConsoleBuffer::createConsoleBuffer(65536); //65536
    8000416c:	00010537          	lui	a0,0x10
    80004170:	fffff097          	auipc	ra,0xfffff
    80004174:	7e8080e7          	jalr	2024(ra) # 80003958 <_ZN13ConsoleBuffer19createConsoleBufferEi>
    80004178:	00a4b023          	sd	a0,0(s1)
    ret->output = ConsoleBuffer::createConsoleBuffer(65536);
    8000417c:	00010537          	lui	a0,0x10
    80004180:	fffff097          	auipc	ra,0xfffff
    80004184:	7d8080e7          	jalr	2008(ra) # 80003958 <_ZN13ConsoleBuffer19createConsoleBufferEi>
    80004188:	00a4b423          	sd	a0,8(s1)
    return ret;
}
    8000418c:	00048513          	mv	a0,s1
    80004190:	01813083          	ld	ra,24(sp)
    80004194:	01013403          	ld	s0,16(sp)
    80004198:	00813483          	ld	s1,8(sp)
    8000419c:	02010113          	addi	sp,sp,32
    800041a0:	00008067          	ret

00000000800041a4 <_ZN14ConsoleHandler8sys_getcEv>:


char ConsoleHandler::sys_getc() {
    800041a4:	ff010113          	addi	sp,sp,-16
    800041a8:	00113423          	sd	ra,8(sp)
    800041ac:	00813023          	sd	s0,0(sp)
    800041b0:	01010413          	addi	s0,sp,16
    return (char)input->get();
    800041b4:	00053503          	ld	a0,0(a0) # 10000 <_entry-0x7fff0000>
    800041b8:	00000097          	auipc	ra,0x0
    800041bc:	8d0080e7          	jalr	-1840(ra) # 80003a88 <_ZN13ConsoleBuffer3getEv>
}
    800041c0:	0ff57513          	andi	a0,a0,255
    800041c4:	00813083          	ld	ra,8(sp)
    800041c8:	00013403          	ld	s0,0(sp)
    800041cc:	01010113          	addi	sp,sp,16
    800041d0:	00008067          	ret

00000000800041d4 <_ZN14ConsoleHandler14writeDataInputEc>:

void ConsoleHandler::writeDataInput(char c) {
    800041d4:	ff010113          	addi	sp,sp,-16
    800041d8:	00113423          	sd	ra,8(sp)
    800041dc:	00813023          	sd	s0,0(sp)
    800041e0:	01010413          	addi	s0,sp,16
    input->put(c);
    800041e4:	00053503          	ld	a0,0(a0)
    800041e8:	00000097          	auipc	ra,0x0
    800041ec:	814080e7          	jalr	-2028(ra) # 800039fc <_ZN13ConsoleBuffer3putEi>
}
    800041f0:	00813083          	ld	ra,8(sp)
    800041f4:	00013403          	ld	s0,0(sp)
    800041f8:	01010113          	addi	sp,sp,16
    800041fc:	00008067          	ret

0000000080004200 <_ZN14ConsoleHandler8sys_putcEc>:

void ConsoleHandler::sys_putc(char c) {
    if(output != nullptr) {
    80004200:	00853503          	ld	a0,8(a0)
    80004204:	02050663          	beqz	a0,80004230 <_ZN14ConsoleHandler8sys_putcEc+0x30>
void ConsoleHandler::sys_putc(char c) {
    80004208:	ff010113          	addi	sp,sp,-16
    8000420c:	00113423          	sd	ra,8(sp)
    80004210:	00813023          	sd	s0,0(sp)
    80004214:	01010413          	addi	s0,sp,16
        output->put(c);
    80004218:	fffff097          	auipc	ra,0xfffff
    8000421c:	7e4080e7          	jalr	2020(ra) # 800039fc <_ZN13ConsoleBuffer3putEi>
    }
}
    80004220:	00813083          	ld	ra,8(sp)
    80004224:	00013403          	ld	s0,0(sp)
    80004228:	01010113          	addi	sp,sp,16
    8000422c:	00008067          	ret
    80004230:	00008067          	ret

0000000080004234 <_ZN14ConsoleHandler17sendDataToConsoleEv>:

[[noreturn]] void ConsoleHandler::sendDataToConsole() {
    80004234:	ff010113          	addi	sp,sp,-16
    80004238:	00113423          	sd	ra,8(sp)
    8000423c:	00813023          	sd	s0,0(sp)
    80004240:	01010413          	addi	s0,sp,16
    80004244:	0280006f          	j	8000426c <_ZN14ConsoleHandler17sendDataToConsoleEv+0x38>
    while(1) {
        char *status = (char *)CONSOLE_STATUS;
        if (*status & CONSOLE_TX_STATUS_BIT) {
            char data = (char) ConsoleHandler::getInstance()->output->get();
    80004248:	00006797          	auipc	a5,0x6
    8000424c:	ee87b783          	ld	a5,-280(a5) # 8000a130 <_ZN14ConsoleHandler8instanceE>
    80004250:	0087b503          	ld	a0,8(a5)
    80004254:	00000097          	auipc	ra,0x0
    80004258:	834080e7          	jalr	-1996(ra) # 80003a88 <_ZN13ConsoleBuffer3getEv>
            *((char *)CONSOLE_TX_DATA) = data;
    8000425c:	00006797          	auipc	a5,0x6
    80004260:	d2c7b783          	ld	a5,-724(a5) # 80009f88 <_GLOBAL_OFFSET_TABLE_+0x58>
    80004264:	0007b783          	ld	a5,0(a5)
    80004268:	00a78023          	sb	a0,0(a5)
        char *status = (char *)CONSOLE_STATUS;
    8000426c:	00006797          	auipc	a5,0x6
    80004270:	ce47b783          	ld	a5,-796(a5) # 80009f50 <_GLOBAL_OFFSET_TABLE_+0x20>
    80004274:	0007b783          	ld	a5,0(a5)
        if (*status & CONSOLE_TX_STATUS_BIT) {
    80004278:	0007c783          	lbu	a5,0(a5)
    8000427c:	0207f793          	andi	a5,a5,32
    80004280:	fe0786e3          	beqz	a5,8000426c <_ZN14ConsoleHandler17sendDataToConsoleEv+0x38>
        if(instance == nullptr){
    80004284:	00006797          	auipc	a5,0x6
    80004288:	eac7b783          	ld	a5,-340(a5) # 8000a130 <_ZN14ConsoleHandler8instanceE>
    8000428c:	fa079ee3          	bnez	a5,80004248 <_ZN14ConsoleHandler17sendDataToConsoleEv+0x14>
            instance = ConsoleHandler::createConsoleHandler();
    80004290:	00000097          	auipc	ra,0x0
    80004294:	eb8080e7          	jalr	-328(ra) # 80004148 <_ZN14ConsoleHandler20createConsoleHandlerEv>
    80004298:	00006797          	auipc	a5,0x6
    8000429c:	e8a7bc23          	sd	a0,-360(a5) # 8000a130 <_ZN14ConsoleHandler8instanceE>
    800042a0:	fa9ff06f          	j	80004248 <_ZN14ConsoleHandler17sendDataToConsoleEv+0x14>

00000000800042a4 <_ZN6BufferC1Ei>:
#include "../h/buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800042a4:	fe010113          	addi	sp,sp,-32
    800042a8:	00113c23          	sd	ra,24(sp)
    800042ac:	00813823          	sd	s0,16(sp)
    800042b0:	00913423          	sd	s1,8(sp)
    800042b4:	01213023          	sd	s2,0(sp)
    800042b8:	02010413          	addi	s0,sp,32
    800042bc:	00050493          	mv	s1,a0
    800042c0:	00058913          	mv	s2,a1
    800042c4:	0015879b          	addiw	a5,a1,1
    800042c8:	0007851b          	sext.w	a0,a5
    800042cc:	00f4a023          	sw	a5,0(s1)
    800042d0:	0004a823          	sw	zero,16(s1)
    800042d4:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800042d8:	00251513          	slli	a0,a0,0x2
    800042dc:	ffffd097          	auipc	ra,0xffffd
    800042e0:	e68080e7          	jalr	-408(ra) # 80001144 <_Z9mem_allocm>
    800042e4:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    800042e8:	00000593          	li	a1,0
    800042ec:	02048513          	addi	a0,s1,32
    800042f0:	ffffd097          	auipc	ra,0xffffd
    800042f4:	f4c080e7          	jalr	-180(ra) # 8000123c <_Z8sem_openPP3SEMj>
    sem_open(&spaceAvailable, _cap);
    800042f8:	00090593          	mv	a1,s2
    800042fc:	01848513          	addi	a0,s1,24
    80004300:	ffffd097          	auipc	ra,0xffffd
    80004304:	f3c080e7          	jalr	-196(ra) # 8000123c <_Z8sem_openPP3SEMj>
    sem_open(&mutexHead, 1);
    80004308:	00100593          	li	a1,1
    8000430c:	02848513          	addi	a0,s1,40
    80004310:	ffffd097          	auipc	ra,0xffffd
    80004314:	f2c080e7          	jalr	-212(ra) # 8000123c <_Z8sem_openPP3SEMj>
    sem_open(&mutexTail, 1);
    80004318:	00100593          	li	a1,1
    8000431c:	03048513          	addi	a0,s1,48
    80004320:	ffffd097          	auipc	ra,0xffffd
    80004324:	f1c080e7          	jalr	-228(ra) # 8000123c <_Z8sem_openPP3SEMj>
}
    80004328:	01813083          	ld	ra,24(sp)
    8000432c:	01013403          	ld	s0,16(sp)
    80004330:	00813483          	ld	s1,8(sp)
    80004334:	00013903          	ld	s2,0(sp)
    80004338:	02010113          	addi	sp,sp,32
    8000433c:	00008067          	ret

0000000080004340 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80004340:	fe010113          	addi	sp,sp,-32
    80004344:	00113c23          	sd	ra,24(sp)
    80004348:	00813823          	sd	s0,16(sp)
    8000434c:	00913423          	sd	s1,8(sp)
    80004350:	01213023          	sd	s2,0(sp)
    80004354:	02010413          	addi	s0,sp,32
    80004358:	00050493          	mv	s1,a0
    8000435c:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80004360:	01853503          	ld	a0,24(a0)
    80004364:	ffffd097          	auipc	ra,0xffffd
    80004368:	f58080e7          	jalr	-168(ra) # 800012bc <_Z8sem_waitP3SEM>

    sem_wait(mutexTail);
    8000436c:	0304b503          	ld	a0,48(s1)
    80004370:	ffffd097          	auipc	ra,0xffffd
    80004374:	f4c080e7          	jalr	-180(ra) # 800012bc <_Z8sem_waitP3SEM>
    buffer[tail] = val;
    80004378:	0084b783          	ld	a5,8(s1)
    8000437c:	0144a703          	lw	a4,20(s1)
    80004380:	00271713          	slli	a4,a4,0x2
    80004384:	00e787b3          	add	a5,a5,a4
    80004388:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    8000438c:	0144a783          	lw	a5,20(s1)
    80004390:	0017879b          	addiw	a5,a5,1
    80004394:	0004a703          	lw	a4,0(s1)
    80004398:	02e7e7bb          	remw	a5,a5,a4
    8000439c:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    800043a0:	0304b503          	ld	a0,48(s1)
    800043a4:	ffffd097          	auipc	ra,0xffffd
    800043a8:	f54080e7          	jalr	-172(ra) # 800012f8 <_Z10sem_signalP3SEM>

    sem_signal(itemAvailable);
    800043ac:	0204b503          	ld	a0,32(s1)
    800043b0:	ffffd097          	auipc	ra,0xffffd
    800043b4:	f48080e7          	jalr	-184(ra) # 800012f8 <_Z10sem_signalP3SEM>

}
    800043b8:	01813083          	ld	ra,24(sp)
    800043bc:	01013403          	ld	s0,16(sp)
    800043c0:	00813483          	ld	s1,8(sp)
    800043c4:	00013903          	ld	s2,0(sp)
    800043c8:	02010113          	addi	sp,sp,32
    800043cc:	00008067          	ret

00000000800043d0 <_ZN6Buffer3getEv>:

int Buffer::get() {
    800043d0:	fe010113          	addi	sp,sp,-32
    800043d4:	00113c23          	sd	ra,24(sp)
    800043d8:	00813823          	sd	s0,16(sp)
    800043dc:	00913423          	sd	s1,8(sp)
    800043e0:	01213023          	sd	s2,0(sp)
    800043e4:	02010413          	addi	s0,sp,32
    800043e8:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    800043ec:	02053503          	ld	a0,32(a0)
    800043f0:	ffffd097          	auipc	ra,0xffffd
    800043f4:	ecc080e7          	jalr	-308(ra) # 800012bc <_Z8sem_waitP3SEM>

    sem_wait(mutexHead);
    800043f8:	0284b503          	ld	a0,40(s1)
    800043fc:	ffffd097          	auipc	ra,0xffffd
    80004400:	ec0080e7          	jalr	-320(ra) # 800012bc <_Z8sem_waitP3SEM>

    int ret = buffer[head];
    80004404:	0084b703          	ld	a4,8(s1)
    80004408:	0104a783          	lw	a5,16(s1)
    8000440c:	00279693          	slli	a3,a5,0x2
    80004410:	00d70733          	add	a4,a4,a3
    80004414:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80004418:	0017879b          	addiw	a5,a5,1
    8000441c:	0004a703          	lw	a4,0(s1)
    80004420:	02e7e7bb          	remw	a5,a5,a4
    80004424:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80004428:	0284b503          	ld	a0,40(s1)
    8000442c:	ffffd097          	auipc	ra,0xffffd
    80004430:	ecc080e7          	jalr	-308(ra) # 800012f8 <_Z10sem_signalP3SEM>

    sem_signal(spaceAvailable);
    80004434:	0184b503          	ld	a0,24(s1)
    80004438:	ffffd097          	auipc	ra,0xffffd
    8000443c:	ec0080e7          	jalr	-320(ra) # 800012f8 <_Z10sem_signalP3SEM>

    return ret;
}
    80004440:	00090513          	mv	a0,s2
    80004444:	01813083          	ld	ra,24(sp)
    80004448:	01013403          	ld	s0,16(sp)
    8000444c:	00813483          	ld	s1,8(sp)
    80004450:	00013903          	ld	s2,0(sp)
    80004454:	02010113          	addi	sp,sp,32
    80004458:	00008067          	ret

000000008000445c <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    8000445c:	fe010113          	addi	sp,sp,-32
    80004460:	00113c23          	sd	ra,24(sp)
    80004464:	00813823          	sd	s0,16(sp)
    80004468:	00913423          	sd	s1,8(sp)
    8000446c:	01213023          	sd	s2,0(sp)
    80004470:	02010413          	addi	s0,sp,32
    80004474:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80004478:	02853503          	ld	a0,40(a0)
    8000447c:	ffffd097          	auipc	ra,0xffffd
    80004480:	e40080e7          	jalr	-448(ra) # 800012bc <_Z8sem_waitP3SEM>
    sem_wait(mutexTail);
    80004484:	0304b503          	ld	a0,48(s1)
    80004488:	ffffd097          	auipc	ra,0xffffd
    8000448c:	e34080e7          	jalr	-460(ra) # 800012bc <_Z8sem_waitP3SEM>

    if (tail >= head) {
    80004490:	0144a783          	lw	a5,20(s1)
    80004494:	0104a903          	lw	s2,16(s1)
    80004498:	0327ce63          	blt	a5,s2,800044d4 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    8000449c:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    800044a0:	0304b503          	ld	a0,48(s1)
    800044a4:	ffffd097          	auipc	ra,0xffffd
    800044a8:	e54080e7          	jalr	-428(ra) # 800012f8 <_Z10sem_signalP3SEM>
    sem_signal(mutexHead);
    800044ac:	0284b503          	ld	a0,40(s1)
    800044b0:	ffffd097          	auipc	ra,0xffffd
    800044b4:	e48080e7          	jalr	-440(ra) # 800012f8 <_Z10sem_signalP3SEM>

    return ret;
}
    800044b8:	00090513          	mv	a0,s2
    800044bc:	01813083          	ld	ra,24(sp)
    800044c0:	01013403          	ld	s0,16(sp)
    800044c4:	00813483          	ld	s1,8(sp)
    800044c8:	00013903          	ld	s2,0(sp)
    800044cc:	02010113          	addi	sp,sp,32
    800044d0:	00008067          	ret
        ret = cap - head + tail;
    800044d4:	0004a703          	lw	a4,0(s1)
    800044d8:	4127093b          	subw	s2,a4,s2
    800044dc:	00f9093b          	addw	s2,s2,a5
    800044e0:	fc1ff06f          	j	800044a0 <_ZN6Buffer6getCntEv+0x44>

00000000800044e4 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    800044e4:	fe010113          	addi	sp,sp,-32
    800044e8:	00113c23          	sd	ra,24(sp)
    800044ec:	00813823          	sd	s0,16(sp)
    800044f0:	00913423          	sd	s1,8(sp)
    800044f4:	02010413          	addi	s0,sp,32
    800044f8:	00050493          	mv	s1,a0
    putc('\n');
    800044fc:	00a00513          	li	a0,10
    80004500:	ffffd097          	auipc	ra,0xffffd
    80004504:	e90080e7          	jalr	-368(ra) # 80001390 <_Z4putcc>
    printString("Buffer deleted!\n");
    80004508:	00004517          	auipc	a0,0x4
    8000450c:	b1850513          	addi	a0,a0,-1256 # 80008020 <CONSOLE_STATUS+0x10>
    80004510:	ffffe097          	auipc	ra,0xffffe
    80004514:	bd0080e7          	jalr	-1072(ra) # 800020e0 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80004518:	00048513          	mv	a0,s1
    8000451c:	00000097          	auipc	ra,0x0
    80004520:	f40080e7          	jalr	-192(ra) # 8000445c <_ZN6Buffer6getCntEv>
    80004524:	02a05c63          	blez	a0,8000455c <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80004528:	0084b783          	ld	a5,8(s1)
    8000452c:	0104a703          	lw	a4,16(s1)
    80004530:	00271713          	slli	a4,a4,0x2
    80004534:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80004538:	0007c503          	lbu	a0,0(a5)
    8000453c:	ffffd097          	auipc	ra,0xffffd
    80004540:	e54080e7          	jalr	-428(ra) # 80001390 <_Z4putcc>
        head = (head + 1) % cap;
    80004544:	0104a783          	lw	a5,16(s1)
    80004548:	0017879b          	addiw	a5,a5,1
    8000454c:	0004a703          	lw	a4,0(s1)
    80004550:	02e7e7bb          	remw	a5,a5,a4
    80004554:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80004558:	fc1ff06f          	j	80004518 <_ZN6BufferD1Ev+0x34>
    putc('!');
    8000455c:	02100513          	li	a0,33
    80004560:	ffffd097          	auipc	ra,0xffffd
    80004564:	e30080e7          	jalr	-464(ra) # 80001390 <_Z4putcc>
    putc('\n');
    80004568:	00a00513          	li	a0,10
    8000456c:	ffffd097          	auipc	ra,0xffffd
    80004570:	e24080e7          	jalr	-476(ra) # 80001390 <_Z4putcc>
    mem_free(buffer);
    80004574:	0084b503          	ld	a0,8(s1)
    80004578:	ffffd097          	auipc	ra,0xffffd
    8000457c:	bf8080e7          	jalr	-1032(ra) # 80001170 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80004580:	0204b503          	ld	a0,32(s1)
    80004584:	ffffd097          	auipc	ra,0xffffd
    80004588:	cfc080e7          	jalr	-772(ra) # 80001280 <_Z9sem_closeP3SEM>
    sem_close(spaceAvailable);
    8000458c:	0184b503          	ld	a0,24(s1)
    80004590:	ffffd097          	auipc	ra,0xffffd
    80004594:	cf0080e7          	jalr	-784(ra) # 80001280 <_Z9sem_closeP3SEM>
    sem_close(mutexTail);
    80004598:	0304b503          	ld	a0,48(s1)
    8000459c:	ffffd097          	auipc	ra,0xffffd
    800045a0:	ce4080e7          	jalr	-796(ra) # 80001280 <_Z9sem_closeP3SEM>
    sem_close(mutexHead);
    800045a4:	0284b503          	ld	a0,40(s1)
    800045a8:	ffffd097          	auipc	ra,0xffffd
    800045ac:	cd8080e7          	jalr	-808(ra) # 80001280 <_Z9sem_closeP3SEM>
}
    800045b0:	01813083          	ld	ra,24(sp)
    800045b4:	01013403          	ld	s0,16(sp)
    800045b8:	00813483          	ld	s1,8(sp)
    800045bc:	02010113          	addi	sp,sp,32
    800045c0:	00008067          	ret

00000000800045c4 <_ZN10kmem_cache12cache_createEPcmPFvPvES3_>:
#include "../h/kmem_cache.hpp"

void kmem_cache::cache_create(char *n, size_t s, void (*ct)(void *), void (*dt)(void *)) {
    800045c4:	ff010113          	addi	sp,sp,-16
    800045c8:	00813423          	sd	s0,8(sp)
    800045cc:	01010413          	addi	s0,sp,16
    name = n;
    800045d0:	00b53023          	sd	a1,0(a0)
    sizeOfObject = s;
    800045d4:	00c53423          	sd	a2,8(a0)
    ctor = ct;
    800045d8:	00d53823          	sd	a3,16(a0)
    dtor = dt;
    800045dc:	00e53c23          	sd	a4,24(a0)
    number_of_slabs = 0;
    800045e0:	04053023          	sd	zero,64(a0)
    num_of_alloc_objects = 0;
    800045e4:	04052423          	sw	zero,72(a0)
    error_indicator = 0;
    800045e8:	02052023          	sw	zero,32(a0)

    empty_slabs = nullptr;
    800045ec:	02053423          	sd	zero,40(a0)
    not_empty_slabs = nullptr;
    800045f0:	02053823          	sd	zero,48(a0)
    full_slabs = nullptr;
    800045f4:	02053c23          	sd	zero,56(a0)
}
    800045f8:	00813403          	ld	s0,8(sp)
    800045fc:	01010113          	addi	sp,sp,16
    80004600:	00008067          	ret

0000000080004604 <_ZN10kmem_cache8add_slabEPPNS_4slabES1_>:

void kmem_cache::add_slab(kmem_cache::slab **head, kmem_cache::slab *slab) {
    80004604:	ff010113          	addi	sp,sp,-16
    80004608:	00813423          	sd	s0,8(sp)
    8000460c:	01010413          	addi	s0,sp,16
    slab->next = nullptr;
    80004610:	02063423          	sd	zero,40(a2)
    if(*head == nullptr){
    80004614:	0005b783          	ld	a5,0(a1)
    80004618:	02078063          	beqz	a5,80004638 <_ZN10kmem_cache8add_slabEPPNS_4slabES1_+0x34>
        *head = slab;
    }else{
        kmem_cache::slab *tmp = *head;
        while(tmp->next != nullptr){
    8000461c:	00078713          	mv	a4,a5
    80004620:	0287b783          	ld	a5,40(a5)
    80004624:	fe079ce3          	bnez	a5,8000461c <_ZN10kmem_cache8add_slabEPPNS_4slabES1_+0x18>
            tmp = tmp->next;
        }
        tmp->next = slab;
    80004628:	02c73423          	sd	a2,40(a4)
    }
}
    8000462c:	00813403          	ld	s0,8(sp)
    80004630:	01010113          	addi	sp,sp,16
    80004634:	00008067          	ret
        *head = slab;
    80004638:	00c5b023          	sd	a2,0(a1)
    8000463c:	ff1ff06f          	j	8000462c <_ZN10kmem_cache8add_slabEPPNS_4slabES1_+0x28>

0000000080004640 <_ZN10kmem_cache11delete_slabEPPNS_4slabES1_>:

int kmem_cache::delete_slab(kmem_cache::slab **head, kmem_cache::slab *slab) {
    80004640:	fe010113          	addi	sp,sp,-32
    80004644:	00113c23          	sd	ra,24(sp)
    80004648:	00813823          	sd	s0,16(sp)
    8000464c:	00913423          	sd	s1,8(sp)
    80004650:	02010413          	addi	s0,sp,32
    80004654:	00060493          	mv	s1,a2
    kmem_cache::slab* prev = nullptr;
    kmem_cache::slab* tmp = *head;
    80004658:	0005b783          	ld	a5,0(a1)

    if(tmp != nullptr && tmp == slab){
    8000465c:	02078663          	beqz	a5,80004688 <_ZN10kmem_cache11delete_slabEPPNS_4slabES1_+0x48>
    80004660:	00c78e63          	beq	a5,a2,8000467c <_ZN10kmem_cache11delete_slabEPPNS_4slabES1_+0x3c>
    80004664:	00000713          	li	a4,0
        *head = tmp->next;
    }else{
        while(tmp != nullptr && tmp != slab){
    80004668:	02078463          	beqz	a5,80004690 <_ZN10kmem_cache11delete_slabEPPNS_4slabES1_+0x50>
    8000466c:	02978263          	beq	a5,s1,80004690 <_ZN10kmem_cache11delete_slabEPPNS_4slabES1_+0x50>
            prev = tmp;
    80004670:	00078713          	mv	a4,a5
            tmp = tmp->next;
    80004674:	0287b783          	ld	a5,40(a5)
        while(tmp != nullptr && tmp != slab){
    80004678:	ff1ff06f          	j	80004668 <_ZN10kmem_cache11delete_slabEPPNS_4slabES1_+0x28>
        *head = tmp->next;
    8000467c:	0287b783          	ld	a5,40(a5)
    80004680:	00f5b023          	sd	a5,0(a1)
    80004684:	01c0006f          	j	800046a0 <_ZN10kmem_cache11delete_slabEPPNS_4slabES1_+0x60>
    80004688:	00078713          	mv	a4,a5
    8000468c:	fddff06f          	j	80004668 <_ZN10kmem_cache11delete_slabEPPNS_4slabES1_+0x28>
        }

        //if slab was not found
        if(tmp == nullptr)
    80004690:	04078e63          	beqz	a5,800046ec <_ZN10kmem_cache11delete_slabEPPNS_4slabES1_+0xac>
            return -1;

        if(prev != nullptr)
    80004694:	00070663          	beqz	a4,800046a0 <_ZN10kmem_cache11delete_slabEPPNS_4slabES1_+0x60>
            prev->next = tmp->next;
    80004698:	0287b783          	ld	a5,40(a5)
    8000469c:	02f73423          	sd	a5,40(a4)
    }
    slab->next = nullptr;
    800046a0:	0204b423          	sd	zero,40(s1)
    slab->limit = 0;
    800046a4:	0004b823          	sd	zero,16(s1)
    Buddy::buddy_free(slab->address);
    800046a8:	0004b503          	ld	a0,0(s1)
    800046ac:	ffffd097          	auipc	ra,0xffffd
    800046b0:	698080e7          	jalr	1688(ra) # 80001d44 <_ZN5Buddy10buddy_freeEPv>
    Buddy::buddy_free(slab->allocateArray);
    800046b4:	0204b503          	ld	a0,32(s1)
    800046b8:	ffffd097          	auipc	ra,0xffffd
    800046bc:	68c080e7          	jalr	1676(ra) # 80001d44 <_ZN5Buddy10buddy_freeEPv>
    slab->address = nullptr;
    800046c0:	0004b023          	sd	zero,0(s1)
    slab->allocateArray = nullptr;
    800046c4:	0204b023          	sd	zero,32(s1)
    Buddy::buddy_free(slab);
    800046c8:	00048513          	mv	a0,s1
    800046cc:	ffffd097          	auipc	ra,0xffffd
    800046d0:	678080e7          	jalr	1656(ra) # 80001d44 <_ZN5Buddy10buddy_freeEPv>
    return 0;
    800046d4:	00000513          	li	a0,0
}
    800046d8:	01813083          	ld	ra,24(sp)
    800046dc:	01013403          	ld	s0,16(sp)
    800046e0:	00813483          	ld	s1,8(sp)
    800046e4:	02010113          	addi	sp,sp,32
    800046e8:	00008067          	ret
            return -1;
    800046ec:	fff00513          	li	a0,-1
    800046f0:	fe9ff06f          	j	800046d8 <_ZN10kmem_cache11delete_slabEPPNS_4slabES1_+0x98>

00000000800046f4 <_ZN10kmem_cache18cache_alloc_bufferEm>:

int kmem_cache::cache_alloc_buffer(size_t size) {
    800046f4:	fd010113          	addi	sp,sp,-48
    800046f8:	02113423          	sd	ra,40(sp)
    800046fc:	02813023          	sd	s0,32(sp)
    80004700:	00913c23          	sd	s1,24(sp)
    80004704:	01213823          	sd	s2,16(sp)
    80004708:	01313423          	sd	s3,8(sp)
    8000470c:	01413023          	sd	s4,0(sp)
    80004710:	03010413          	addi	s0,sp,48
    80004714:	00050993          	mv	s3,a0
    80004718:	00058913          	mv	s2,a1
    void *res = Buddy::buddy_allocate(size);
    8000471c:	00058513          	mv	a0,a1
    80004720:	ffffd097          	auipc	ra,0xffffd
    80004724:	448080e7          	jalr	1096(ra) # 80001b68 <_ZN5Buddy14buddy_allocateEm>
    if(res == nullptr){
    80004728:	08050663          	beqz	a0,800047b4 <_ZN10kmem_cache18cache_alloc_bufferEm+0xc0>
    8000472c:	00050a13          	mv	s4,a0
        error_indicator = -1;
        return -1;
    }
    //add this empty slab to empty_slabs - buffer = slab
    slab *new_slab = (slab *)Buddy::buddy_allocate(sizeof(slab));
    80004730:	03000513          	li	a0,48
    80004734:	ffffd097          	auipc	ra,0xffffd
    80004738:	434080e7          	jalr	1076(ra) # 80001b68 <_ZN5Buddy14buddy_allocateEm>
    8000473c:	00050493          	mv	s1,a0
    if(new_slab == nullptr){
    80004740:	08050263          	beqz	a0,800047c4 <_ZN10kmem_cache18cache_alloc_bufferEm+0xd0>
        Buddy::buddy_free(res);
        error_indicator = -1;
        return -1;
    }
    number_of_slabs++;
    80004744:	0409b783          	ld	a5,64(s3)
    80004748:	00178793          	addi	a5,a5,1
    8000474c:	04f9b023          	sd	a5,64(s3)
    new_slab->address = res;
    80004750:	01453023          	sd	s4,0(a0)
    new_slab->counter = 0;
    80004754:	00053423          	sd	zero,8(a0)
    new_slab->sizeInBlocks = (size/BLOCK_SIZE) + (size%BLOCK_SIZE == 0 ? 0 : 1);
    80004758:	00c95793          	srli	a5,s2,0xc
    8000475c:	000015b7          	lui	a1,0x1
    80004760:	fff58593          	addi	a1,a1,-1 # fff <_entry-0x7ffff001>
    80004764:	00b97933          	and	s2,s2,a1
    80004768:	01203933          	snez	s2,s2
    8000476c:	01278933          	add	s2,a5,s2
    80004770:	01253c23          	sd	s2,24(a0)
    new_slab->limit = (new_slab->sizeInBlocks * BLOCK_SIZE) / this->sizeOfObject;
    80004774:	00c91913          	slli	s2,s2,0xc
    80004778:	0089b503          	ld	a0,8(s3)
    8000477c:	02a95533          	divu	a0,s2,a0
    80004780:	00a4b823          	sd	a0,16(s1)

    new_slab->allocateArray = (uint8 *)Buddy::buddy_allocate(sizeof(uint8)*new_slab->limit);
    80004784:	ffffd097          	auipc	ra,0xffffd
    80004788:	3e4080e7          	jalr	996(ra) # 80001b68 <_ZN5Buddy14buddy_allocateEm>
    8000478c:	02a4b023          	sd	a0,32(s1)
    if(new_slab->allocateArray == nullptr){
    80004790:	04050863          	beqz	a0,800047e0 <_ZN10kmem_cache18cache_alloc_bufferEm+0xec>
        Buddy::buddy_free(new_slab);
        error_indicator = -1;
        return -1;
    }
    //Buffer is totally empty
    for(uint64 i = 0; i < new_slab->limit; i++){
    80004794:	00000793          	li	a5,0
    80004798:	0104b703          	ld	a4,16(s1)
    8000479c:	06e7f663          	bgeu	a5,a4,80004808 <_ZN10kmem_cache18cache_alloc_bufferEm+0x114>
        new_slab->allocateArray[i] = 0;
    800047a0:	0204b703          	ld	a4,32(s1)
    800047a4:	00f70733          	add	a4,a4,a5
    800047a8:	00070023          	sb	zero,0(a4)
    for(uint64 i = 0; i < new_slab->limit; i++){
    800047ac:	00178793          	addi	a5,a5,1
    800047b0:	fe9ff06f          	j	80004798 <_ZN10kmem_cache18cache_alloc_bufferEm+0xa4>
        error_indicator = -1;
    800047b4:	fff00793          	li	a5,-1
    800047b8:	02f9a023          	sw	a5,32(s3)
        return -1;
    800047bc:	fff00513          	li	a0,-1
    800047c0:	0600006f          	j	80004820 <_ZN10kmem_cache18cache_alloc_bufferEm+0x12c>
        Buddy::buddy_free(res);
    800047c4:	000a0513          	mv	a0,s4
    800047c8:	ffffd097          	auipc	ra,0xffffd
    800047cc:	57c080e7          	jalr	1404(ra) # 80001d44 <_ZN5Buddy10buddy_freeEPv>
        error_indicator = -1;
    800047d0:	fff00793          	li	a5,-1
    800047d4:	02f9a023          	sw	a5,32(s3)
        return -1;
    800047d8:	fff00513          	li	a0,-1
    800047dc:	0440006f          	j	80004820 <_ZN10kmem_cache18cache_alloc_bufferEm+0x12c>
        Buddy::buddy_free(res);
    800047e0:	000a0513          	mv	a0,s4
    800047e4:	ffffd097          	auipc	ra,0xffffd
    800047e8:	560080e7          	jalr	1376(ra) # 80001d44 <_ZN5Buddy10buddy_freeEPv>
        Buddy::buddy_free(new_slab);
    800047ec:	00048513          	mv	a0,s1
    800047f0:	ffffd097          	auipc	ra,0xffffd
    800047f4:	554080e7          	jalr	1364(ra) # 80001d44 <_ZN5Buddy10buddy_freeEPv>
        error_indicator = -1;
    800047f8:	fff00793          	li	a5,-1
    800047fc:	02f9a023          	sw	a5,32(s3)
        return -1;
    80004800:	fff00513          	li	a0,-1
    80004804:	01c0006f          	j	80004820 <_ZN10kmem_cache18cache_alloc_bufferEm+0x12c>
    }

    add_slab(&empty_slabs, new_slab);
    80004808:	00048613          	mv	a2,s1
    8000480c:	02898593          	addi	a1,s3,40
    80004810:	00098513          	mv	a0,s3
    80004814:	00000097          	auipc	ra,0x0
    80004818:	df0080e7          	jalr	-528(ra) # 80004604 <_ZN10kmem_cache8add_slabEPPNS_4slabES1_>
    return 0;
    8000481c:	00000513          	li	a0,0
}
    80004820:	02813083          	ld	ra,40(sp)
    80004824:	02013403          	ld	s0,32(sp)
    80004828:	01813483          	ld	s1,24(sp)
    8000482c:	01013903          	ld	s2,16(sp)
    80004830:	00813983          	ld	s3,8(sp)
    80004834:	00013a03          	ld	s4,0(sp)
    80004838:	03010113          	addi	sp,sp,48
    8000483c:	00008067          	ret

0000000080004840 <_ZN10kmem_cache6shrinkEv>:

int kmem_cache::shrink() {
    80004840:	fd010113          	addi	sp,sp,-48
    80004844:	02113423          	sd	ra,40(sp)
    80004848:	02813023          	sd	s0,32(sp)
    8000484c:	00913c23          	sd	s1,24(sp)
    80004850:	01213823          	sd	s2,16(sp)
    80004854:	01313423          	sd	s3,8(sp)
    80004858:	01413023          	sd	s4,0(sp)
    8000485c:	03010413          	addi	s0,sp,48
    int res = 0;
    if(empty_slabs == nullptr) return res; //can't shrink
    80004860:	02853983          	ld	s3,40(a0)
    80004864:	06098a63          	beqz	s3,800048d8 <_ZN10kmem_cache6shrinkEv+0x98>
    80004868:	00050913          	mv	s2,a0
    slab* tmp;

    if(not_empty_slabs != nullptr)
    8000486c:	03053783          	ld	a5,48(a0)
    80004870:	00078463          	beqz	a5,80004878 <_ZN10kmem_cache6shrinkEv+0x38>
        tmp = empty_slabs->next;
    80004874:	0289b983          	ld	s3,40(s3)
int kmem_cache::shrink() {
    80004878:	00098493          	mv	s1,s3
    int res = 0;
    8000487c:	00000a13          	li	s4,0
    else
        tmp = empty_slabs;

    slab *forDelet = tmp;
    while(tmp != nullptr){
    80004880:	02048463          	beqz	s1,800048a8 <_ZN10kmem_cache6shrinkEv+0x68>
        tmp = tmp->next;
    80004884:	0284b483          	ld	s1,40(s1)
        res += forDelet->sizeInBlocks;
    80004888:	0189b783          	ld	a5,24(s3)
    8000488c:	01478a3b          	addw	s4,a5,s4
        delete_slab(&empty_slabs, forDelet);
    80004890:	00098613          	mv	a2,s3
    80004894:	02890593          	addi	a1,s2,40
    80004898:	00090513          	mv	a0,s2
    8000489c:	00000097          	auipc	ra,0x0
    800048a0:	da4080e7          	jalr	-604(ra) # 80004640 <_ZN10kmem_cache11delete_slabEPPNS_4slabES1_>
    while(tmp != nullptr){
    800048a4:	fddff06f          	j	80004880 <_ZN10kmem_cache6shrinkEv+0x40>
    }
    number_of_slabs -= (uint64)res;
    800048a8:	04093783          	ld	a5,64(s2)
    800048ac:	414787b3          	sub	a5,a5,s4
    800048b0:	04f93023          	sd	a5,64(s2)
    return res;
}
    800048b4:	000a0513          	mv	a0,s4
    800048b8:	02813083          	ld	ra,40(sp)
    800048bc:	02013403          	ld	s0,32(sp)
    800048c0:	01813483          	ld	s1,24(sp)
    800048c4:	01013903          	ld	s2,16(sp)
    800048c8:	00813983          	ld	s3,8(sp)
    800048cc:	00013a03          	ld	s4,0(sp)
    800048d0:	03010113          	addi	sp,sp,48
    800048d4:	00008067          	ret
    if(empty_slabs == nullptr) return res; //can't shrink
    800048d8:	00000a13          	li	s4,0
    800048dc:	fd9ff06f          	j	800048b4 <_ZN10kmem_cache6shrinkEv+0x74>

00000000800048e0 <_ZN10kmem_cache12alloc_objectEv>:

void *kmem_cache::alloc_object() {
    800048e0:	fd010113          	addi	sp,sp,-48
    800048e4:	02113423          	sd	ra,40(sp)
    800048e8:	02813023          	sd	s0,32(sp)
    800048ec:	00913c23          	sd	s1,24(sp)
    800048f0:	01213823          	sd	s2,16(sp)
    800048f4:	01313423          	sd	s3,8(sp)
    800048f8:	03010413          	addi	s0,sp,48
    800048fc:	00050913          	mv	s2,a0
    void *addr;

    if(not_empty_slabs != nullptr){
    80004900:	03053483          	ld	s1,48(a0)
    80004904:	0a048a63          	beqz	s1,800049b8 <_ZN10kmem_cache12alloc_objectEv+0xd8>
        slab *p_slab = not_empty_slabs;

        //find free space in slab
        uint64 offset = 0;
    80004908:	00000793          	li	a5,0
        for(;offset < p_slab->limit; offset++){
    8000490c:	0104b703          	ld	a4,16(s1)
    80004910:	02e7f263          	bgeu	a5,a4,80004934 <_ZN10kmem_cache12alloc_objectEv+0x54>
            if(p_slab->allocateArray[offset] == 0){
    80004914:	0204b703          	ld	a4,32(s1)
    80004918:	00f70733          	add	a4,a4,a5
    8000491c:	00074683          	lbu	a3,0(a4)
    80004920:	00068663          	beqz	a3,8000492c <_ZN10kmem_cache12alloc_objectEv+0x4c>
        for(;offset < p_slab->limit; offset++){
    80004924:	00178793          	addi	a5,a5,1
    80004928:	fe5ff06f          	j	8000490c <_ZN10kmem_cache12alloc_objectEv+0x2c>
                p_slab->allocateArray[offset] = 1;
    8000492c:	00100693          	li	a3,1
    80004930:	00d70023          	sb	a3,0(a4)
                break;
            }
        }
        addr = (void *)((uint64)p_slab->address + offset * this->sizeOfObject);
    80004934:	0004b703          	ld	a4,0(s1)
    80004938:	00893983          	ld	s3,8(s2)
    8000493c:	02f987b3          	mul	a5,s3,a5
    80004940:	00f709b3          	add	s3,a4,a5
        if(ctor != nullptr) {
    80004944:	01093783          	ld	a5,16(s2)
    80004948:	00078663          	beqz	a5,80004954 <_ZN10kmem_cache12alloc_objectEv+0x74>
            ctor(addr);
    8000494c:	00098513          	mv	a0,s3
    80004950:	000780e7          	jalr	a5
        }

        p_slab->counter++;
    80004954:	0084b783          	ld	a5,8(s1)
    80004958:	00178793          	addi	a5,a5,1
    8000495c:	00f4b423          	sd	a5,8(s1)
        if(p_slab->counter == p_slab->limit){
    80004960:	0104b703          	ld	a4,16(s1)
    80004964:	02e78863          	beq	a5,a4,80004994 <_ZN10kmem_cache12alloc_objectEv+0xb4>
            //add slab to full_slabs list and remove from not_empty-slabs
            not_empty_slabs = not_empty_slabs->next;
            add_slab(&full_slabs, p_slab);
        }
        num_of_alloc_objects++;
    80004968:	04892783          	lw	a5,72(s2)
    8000496c:	0017879b          	addiw	a5,a5,1
    80004970:	04f92423          	sw	a5,72(s2)
            num_of_alloc_objects++;
            return addr;
        }
    }
    return nullptr;
}
    80004974:	00098513          	mv	a0,s3
    80004978:	02813083          	ld	ra,40(sp)
    8000497c:	02013403          	ld	s0,32(sp)
    80004980:	01813483          	ld	s1,24(sp)
    80004984:	01013903          	ld	s2,16(sp)
    80004988:	00813983          	ld	s3,8(sp)
    8000498c:	03010113          	addi	sp,sp,48
    80004990:	00008067          	ret
            not_empty_slabs = not_empty_slabs->next;
    80004994:	03093783          	ld	a5,48(s2)
    80004998:	0287b783          	ld	a5,40(a5)
    8000499c:	02f93823          	sd	a5,48(s2)
            add_slab(&full_slabs, p_slab);
    800049a0:	00048613          	mv	a2,s1
    800049a4:	03890593          	addi	a1,s2,56
    800049a8:	00090513          	mv	a0,s2
    800049ac:	00000097          	auipc	ra,0x0
    800049b0:	c58080e7          	jalr	-936(ra) # 80004604 <_ZN10kmem_cache8add_slabEPPNS_4slabES1_>
    800049b4:	fb5ff06f          	j	80004968 <_ZN10kmem_cache12alloc_objectEv+0x88>
    }else if(empty_slabs != nullptr){
    800049b8:	02853483          	ld	s1,40(a0)
    800049bc:	08048663          	beqz	s1,80004a48 <_ZN10kmem_cache12alloc_objectEv+0x168>
        p_slab->allocateArray[offset] = 1;
    800049c0:	0204b783          	ld	a5,32(s1)
    800049c4:	00100713          	li	a4,1
    800049c8:	00e78023          	sb	a4,0(a5)
        addr = (void *)((uint64)p_slab->address + offset * this->sizeOfObject);
    800049cc:	0004b983          	ld	s3,0(s1)
        if(ctor != nullptr) {
    800049d0:	01053783          	ld	a5,16(a0)
    800049d4:	00078663          	beqz	a5,800049e0 <_ZN10kmem_cache12alloc_objectEv+0x100>
            ctor(addr);
    800049d8:	00098513          	mv	a0,s3
    800049dc:	000780e7          	jalr	a5
        p_slab->counter++;
    800049e0:	0084b783          	ld	a5,8(s1)
    800049e4:	00178793          	addi	a5,a5,1
    800049e8:	00f4b423          	sd	a5,8(s1)
        if(p_slab->counter == p_slab->limit){
    800049ec:	0104b703          	ld	a4,16(s1)
    800049f0:	02e78a63          	beq	a5,a4,80004a24 <_ZN10kmem_cache12alloc_objectEv+0x144>
            empty_slabs = empty_slabs->next;
    800049f4:	02893783          	ld	a5,40(s2)
    800049f8:	0287b783          	ld	a5,40(a5)
    800049fc:	02f93423          	sd	a5,40(s2)
            add_slab(&not_empty_slabs, p_slab);
    80004a00:	00048613          	mv	a2,s1
    80004a04:	03090593          	addi	a1,s2,48
    80004a08:	00090513          	mv	a0,s2
    80004a0c:	00000097          	auipc	ra,0x0
    80004a10:	bf8080e7          	jalr	-1032(ra) # 80004604 <_ZN10kmem_cache8add_slabEPPNS_4slabES1_>
        num_of_alloc_objects++;
    80004a14:	04892783          	lw	a5,72(s2)
    80004a18:	0017879b          	addiw	a5,a5,1
    80004a1c:	04f92423          	sw	a5,72(s2)
        return addr;
    80004a20:	f55ff06f          	j	80004974 <_ZN10kmem_cache12alloc_objectEv+0x94>
            empty_slabs = empty_slabs->next;
    80004a24:	02893783          	ld	a5,40(s2)
    80004a28:	0287b783          	ld	a5,40(a5)
    80004a2c:	02f93423          	sd	a5,40(s2)
            add_slab(&full_slabs, p_slab);
    80004a30:	00048613          	mv	a2,s1
    80004a34:	03890593          	addi	a1,s2,56
    80004a38:	00090513          	mv	a0,s2
    80004a3c:	00000097          	auipc	ra,0x0
    80004a40:	bc8080e7          	jalr	-1080(ra) # 80004604 <_ZN10kmem_cache8add_slabEPPNS_4slabES1_>
    80004a44:	fd1ff06f          	j	80004a14 <_ZN10kmem_cache12alloc_objectEv+0x134>
        if(cache_alloc_buffer(BLOCK_SIZE) == -1){
    80004a48:	000015b7          	lui	a1,0x1
    80004a4c:	00000097          	auipc	ra,0x0
    80004a50:	ca8080e7          	jalr	-856(ra) # 800046f4 <_ZN10kmem_cache18cache_alloc_bufferEm>
    80004a54:	fff00793          	li	a5,-1
    80004a58:	08f50a63          	beq	a0,a5,80004aec <_ZN10kmem_cache12alloc_objectEv+0x20c>
        if(empty_slabs != nullptr){
    80004a5c:	02893483          	ld	s1,40(s2)
    80004a60:	08048a63          	beqz	s1,80004af4 <_ZN10kmem_cache12alloc_objectEv+0x214>
            p_slab->allocateArray[offset] = 1;
    80004a64:	0204b783          	ld	a5,32(s1)
    80004a68:	00100713          	li	a4,1
    80004a6c:	00e78023          	sb	a4,0(a5)
            addr = (void *)((uint64)p_slab->address + offset * this->sizeOfObject);
    80004a70:	0004b983          	ld	s3,0(s1)
            if(ctor != nullptr) {
    80004a74:	01093783          	ld	a5,16(s2)
    80004a78:	00078663          	beqz	a5,80004a84 <_ZN10kmem_cache12alloc_objectEv+0x1a4>
                ctor(addr);
    80004a7c:	00098513          	mv	a0,s3
    80004a80:	000780e7          	jalr	a5
            p_slab->counter++;
    80004a84:	0084b783          	ld	a5,8(s1)
    80004a88:	00178793          	addi	a5,a5,1
    80004a8c:	00f4b423          	sd	a5,8(s1)
            if(p_slab->counter == p_slab->limit){
    80004a90:	0104b703          	ld	a4,16(s1)
    80004a94:	02e78a63          	beq	a5,a4,80004ac8 <_ZN10kmem_cache12alloc_objectEv+0x1e8>
                empty_slabs = empty_slabs->next;
    80004a98:	02893783          	ld	a5,40(s2)
    80004a9c:	0287b783          	ld	a5,40(a5)
    80004aa0:	02f93423          	sd	a5,40(s2)
                add_slab(&not_empty_slabs, p_slab);
    80004aa4:	00048613          	mv	a2,s1
    80004aa8:	03090593          	addi	a1,s2,48
    80004aac:	00090513          	mv	a0,s2
    80004ab0:	00000097          	auipc	ra,0x0
    80004ab4:	b54080e7          	jalr	-1196(ra) # 80004604 <_ZN10kmem_cache8add_slabEPPNS_4slabES1_>
            num_of_alloc_objects++;
    80004ab8:	04892783          	lw	a5,72(s2)
    80004abc:	0017879b          	addiw	a5,a5,1
    80004ac0:	04f92423          	sw	a5,72(s2)
            return addr;
    80004ac4:	eb1ff06f          	j	80004974 <_ZN10kmem_cache12alloc_objectEv+0x94>
                empty_slabs = empty_slabs->next;
    80004ac8:	02893783          	ld	a5,40(s2)
    80004acc:	0287b783          	ld	a5,40(a5)
    80004ad0:	02f93423          	sd	a5,40(s2)
                add_slab(&full_slabs, p_slab);
    80004ad4:	00048613          	mv	a2,s1
    80004ad8:	03890593          	addi	a1,s2,56
    80004adc:	00090513          	mv	a0,s2
    80004ae0:	00000097          	auipc	ra,0x0
    80004ae4:	b24080e7          	jalr	-1244(ra) # 80004604 <_ZN10kmem_cache8add_slabEPPNS_4slabES1_>
    80004ae8:	fd1ff06f          	j	80004ab8 <_ZN10kmem_cache12alloc_objectEv+0x1d8>
            return nullptr;
    80004aec:	00048993          	mv	s3,s1
    80004af0:	e85ff06f          	j	80004974 <_ZN10kmem_cache12alloc_objectEv+0x94>
    return nullptr;
    80004af4:	00048993          	mv	s3,s1
    80004af8:	e7dff06f          	j	80004974 <_ZN10kmem_cache12alloc_objectEv+0x94>

0000000080004afc <_ZN10kmem_cache13deallocInSlabEPNS_4slabEPv>:

void kmem_cache::deallocInSlab(slab *p_slab, void *objp) {
    80004afc:	00050813          	mv	a6,a0
    uint64 offset = 0;
    80004b00:	00000793          	li	a5,0
    for(; offset < p_slab->limit; offset++){
    80004b04:	0105b703          	ld	a4,16(a1) # 1010 <_entry-0x7fffeff0>
    80004b08:	06e7fa63          	bgeu	a5,a4,80004b7c <_ZN10kmem_cache13deallocInSlabEPNS_4slabEPv+0x80>
        if((uint64)objp == (uint64)p_slab->address + offset * this->sizeOfObject){
    80004b0c:	0005b703          	ld	a4,0(a1)
    80004b10:	00883683          	ld	a3,8(a6)
    80004b14:	02f686b3          	mul	a3,a3,a5
    80004b18:	00d70733          	add	a4,a4,a3
    80004b1c:	00c70663          	beq	a4,a2,80004b28 <_ZN10kmem_cache13deallocInSlabEPNS_4slabEPv+0x2c>
    for(; offset < p_slab->limit; offset++){
    80004b20:	00178793          	addi	a5,a5,1
    80004b24:	fe1ff06f          	j	80004b04 <_ZN10kmem_cache13deallocInSlabEPNS_4slabEPv+0x8>
            p_slab->allocateArray[offset] = 0;
    80004b28:	0205b703          	ld	a4,32(a1)
    80004b2c:	00f707b3          	add	a5,a4,a5
    80004b30:	00078023          	sb	zero,0(a5)
            num_of_alloc_objects--;
    80004b34:	04882783          	lw	a5,72(a6)
    80004b38:	fff7879b          	addiw	a5,a5,-1
    80004b3c:	04f82423          	sw	a5,72(a6)
            p_slab->counter--;
    80004b40:	0085b783          	ld	a5,8(a1)
    80004b44:	fff78793          	addi	a5,a5,-1
    80004b48:	00f5b423          	sd	a5,8(a1)
            if(dtor != nullptr) {
    80004b4c:	01883783          	ld	a5,24(a6)
    80004b50:	02078663          	beqz	a5,80004b7c <_ZN10kmem_cache13deallocInSlabEPNS_4slabEPv+0x80>
void kmem_cache::deallocInSlab(slab *p_slab, void *objp) {
    80004b54:	ff010113          	addi	sp,sp,-16
    80004b58:	00113423          	sd	ra,8(sp)
    80004b5c:	00813023          	sd	s0,0(sp)
    80004b60:	01010413          	addi	s0,sp,16
                dtor(objp);
    80004b64:	00060513          	mv	a0,a2
    80004b68:	000780e7          	jalr	a5
            }
            //MAYBE SHOULD BE CLEARD WHOLE SPACE - CHANGE IN FUTURE
            return;
        }
    }
}
    80004b6c:	00813083          	ld	ra,8(sp)
    80004b70:	00013403          	ld	s0,0(sp)
    80004b74:	01010113          	addi	sp,sp,16
    80004b78:	00008067          	ret
    80004b7c:	00008067          	ret

0000000080004b80 <_ZN10kmem_cache11free_objectEPv>:

void kmem_cache::free_object(void *objp) {
    80004b80:	fd010113          	addi	sp,sp,-48
    80004b84:	02113423          	sd	ra,40(sp)
    80004b88:	02813023          	sd	s0,32(sp)
    80004b8c:	00913c23          	sd	s1,24(sp)
    80004b90:	01213823          	sd	s2,16(sp)
    80004b94:	01313423          	sd	s3,8(sp)
    80004b98:	03010413          	addi	s0,sp,48
    80004b9c:	00050993          	mv	s3,a0
    80004ba0:	00058613          	mv	a2,a1
    //check if object is part of full_slabs
    slab *prev = nullptr;
    slab *tmp = full_slabs;
    80004ba4:	03853483          	ld	s1,56(a0)
    slab *prev = nullptr;
    80004ba8:	00000913          	li	s2,0
    80004bac:	01c0006f          	j	80004bc8 <_ZN10kmem_cache11free_objectEPv+0x48>
    while(tmp != nullptr){
        if((uint64)objp >= (uint64)tmp->address && (uint64)objp < (uint64)tmp->address + this->sizeOfObject * tmp->limit){
            deallocInSlab(tmp, objp);
            //remove slab from full_slabs and put in not_empty_slabs
            if(prev == nullptr){
                full_slabs = full_slabs->next;
    80004bb0:	0389b783          	ld	a5,56(s3)
    80004bb4:	0287b783          	ld	a5,40(a5)
    80004bb8:	02f9bc23          	sd	a5,56(s3)
    80004bbc:	0480006f          	j	80004c04 <_ZN10kmem_cache11free_objectEPv+0x84>
                prev->next = tmp->next;
            }
            add_slab(&not_empty_slabs, tmp);
            return;
        }
        prev = tmp;
    80004bc0:	00048913          	mv	s2,s1
        tmp = tmp->next;
    80004bc4:	0284b483          	ld	s1,40(s1)
    while(tmp != nullptr){
    80004bc8:	04048a63          	beqz	s1,80004c1c <_ZN10kmem_cache11free_objectEPv+0x9c>
        if((uint64)objp >= (uint64)tmp->address && (uint64)objp < (uint64)tmp->address + this->sizeOfObject * tmp->limit){
    80004bcc:	0004b783          	ld	a5,0(s1)
    80004bd0:	fef668e3          	bltu	a2,a5,80004bc0 <_ZN10kmem_cache11free_objectEPv+0x40>
    80004bd4:	0089b703          	ld	a4,8(s3)
    80004bd8:	0104b583          	ld	a1,16(s1)
    80004bdc:	02b70733          	mul	a4,a4,a1
    80004be0:	00e787b3          	add	a5,a5,a4
    80004be4:	fcf67ee3          	bgeu	a2,a5,80004bc0 <_ZN10kmem_cache11free_objectEPv+0x40>
            deallocInSlab(tmp, objp);
    80004be8:	00048593          	mv	a1,s1
    80004bec:	00098513          	mv	a0,s3
    80004bf0:	00000097          	auipc	ra,0x0
    80004bf4:	f0c080e7          	jalr	-244(ra) # 80004afc <_ZN10kmem_cache13deallocInSlabEPNS_4slabEPv>
            if(prev == nullptr){
    80004bf8:	fa090ce3          	beqz	s2,80004bb0 <_ZN10kmem_cache11free_objectEPv+0x30>
                prev->next = tmp->next;
    80004bfc:	0284b783          	ld	a5,40(s1)
    80004c00:	02f93423          	sd	a5,40(s2)
            add_slab(&not_empty_slabs, tmp);
    80004c04:	00048613          	mv	a2,s1
    80004c08:	03098593          	addi	a1,s3,48
    80004c0c:	00098513          	mv	a0,s3
    80004c10:	00000097          	auipc	ra,0x0
    80004c14:	9f4080e7          	jalr	-1548(ra) # 80004604 <_ZN10kmem_cache8add_slabEPPNS_4slabES1_>
            return;
    80004c18:	0880006f          	j	80004ca0 <_ZN10kmem_cache11free_objectEPv+0x120>
    }
    //check if object is part of not_empty_slabs
    prev = nullptr;
    tmp = not_empty_slabs;
    80004c1c:	0309b903          	ld	s2,48(s3)
    80004c20:	01c0006f          	j	80004c3c <_ZN10kmem_cache11free_objectEPv+0xbc>
        if((uint64)objp >= (uint64)tmp->address && (uint64)objp < (uint64)tmp->address + this->sizeOfObject * tmp->limit){
            deallocInSlab(tmp, objp);
            if(tmp->counter == 0){
                //remove slab from not_empty_slabs and put in empty_slabs
                if(prev == nullptr){
                    not_empty_slabs = not_empty_slabs->next;
    80004c24:	0309b783          	ld	a5,48(s3)
    80004c28:	0287b783          	ld	a5,40(a5)
    80004c2c:	02f9b823          	sd	a5,48(s3)
    80004c30:	0500006f          	j	80004c80 <_ZN10kmem_cache11free_objectEPv+0x100>
                }
                add_slab(&empty_slabs, tmp);
            }
            return;
        }
        prev = tmp;
    80004c34:	00090493          	mv	s1,s2
        tmp = tmp->next;
    80004c38:	02893903          	ld	s2,40(s2)
    while(tmp != nullptr){
    80004c3c:	04090e63          	beqz	s2,80004c98 <_ZN10kmem_cache11free_objectEPv+0x118>
        if((uint64)objp >= (uint64)tmp->address && (uint64)objp < (uint64)tmp->address + this->sizeOfObject * tmp->limit){
    80004c40:	00093783          	ld	a5,0(s2)
    80004c44:	fef668e3          	bltu	a2,a5,80004c34 <_ZN10kmem_cache11free_objectEPv+0xb4>
    80004c48:	0089b703          	ld	a4,8(s3)
    80004c4c:	01093583          	ld	a1,16(s2)
    80004c50:	02b70733          	mul	a4,a4,a1
    80004c54:	00e787b3          	add	a5,a5,a4
    80004c58:	fcf67ee3          	bgeu	a2,a5,80004c34 <_ZN10kmem_cache11free_objectEPv+0xb4>
            deallocInSlab(tmp, objp);
    80004c5c:	00090593          	mv	a1,s2
    80004c60:	00098513          	mv	a0,s3
    80004c64:	00000097          	auipc	ra,0x0
    80004c68:	e98080e7          	jalr	-360(ra) # 80004afc <_ZN10kmem_cache13deallocInSlabEPNS_4slabEPv>
            if(tmp->counter == 0){
    80004c6c:	00893783          	ld	a5,8(s2)
    80004c70:	02079863          	bnez	a5,80004ca0 <_ZN10kmem_cache11free_objectEPv+0x120>
                if(prev == nullptr){
    80004c74:	fa0488e3          	beqz	s1,80004c24 <_ZN10kmem_cache11free_objectEPv+0xa4>
                    prev->next = tmp->next;
    80004c78:	02893783          	ld	a5,40(s2)
    80004c7c:	02f4b423          	sd	a5,40(s1)
                add_slab(&empty_slabs, tmp);
    80004c80:	00090613          	mv	a2,s2
    80004c84:	02898593          	addi	a1,s3,40
    80004c88:	00098513          	mv	a0,s3
    80004c8c:	00000097          	auipc	ra,0x0
    80004c90:	978080e7          	jalr	-1672(ra) # 80004604 <_ZN10kmem_cache8add_slabEPPNS_4slabES1_>
            return;
    80004c94:	00c0006f          	j	80004ca0 <_ZN10kmem_cache11free_objectEPv+0x120>
    }

    error_indicator = -2;
    80004c98:	ffe00793          	li	a5,-2
    80004c9c:	02f9a023          	sw	a5,32(s3)
}
    80004ca0:	02813083          	ld	ra,40(sp)
    80004ca4:	02013403          	ld	s0,32(sp)
    80004ca8:	01813483          	ld	s1,24(sp)
    80004cac:	01013903          	ld	s2,16(sp)
    80004cb0:	00813983          	ld	s3,8(sp)
    80004cb4:	03010113          	addi	sp,sp,48
    80004cb8:	00008067          	ret

0000000080004cbc <_ZN10kmem_cache10destructorEv>:

void kmem_cache::destructor() {
    80004cbc:	fe010113          	addi	sp,sp,-32
    80004cc0:	00113c23          	sd	ra,24(sp)
    80004cc4:	00813823          	sd	s0,16(sp)
    80004cc8:	00913423          	sd	s1,8(sp)
    80004ccc:	02010413          	addi	s0,sp,32
    80004cd0:	00050493          	mv	s1,a0
    //destroy all slabs
    while(empty_slabs != nullptr){
    80004cd4:	0284b603          	ld	a2,40(s1)
    80004cd8:	00060c63          	beqz	a2,80004cf0 <_ZN10kmem_cache10destructorEv+0x34>
        slab *p_slab = empty_slabs;
        delete_slab(&empty_slabs, p_slab);
    80004cdc:	02848593          	addi	a1,s1,40
    80004ce0:	00048513          	mv	a0,s1
    80004ce4:	00000097          	auipc	ra,0x0
    80004ce8:	95c080e7          	jalr	-1700(ra) # 80004640 <_ZN10kmem_cache11delete_slabEPPNS_4slabES1_>
    while(empty_slabs != nullptr){
    80004cec:	fe9ff06f          	j	80004cd4 <_ZN10kmem_cache10destructorEv+0x18>
    }
    while(not_empty_slabs != nullptr){
    80004cf0:	0304b603          	ld	a2,48(s1)
    80004cf4:	00060c63          	beqz	a2,80004d0c <_ZN10kmem_cache10destructorEv+0x50>
        slab *p_slab = not_empty_slabs;
        delete_slab(&not_empty_slabs, p_slab);
    80004cf8:	03048593          	addi	a1,s1,48
    80004cfc:	00048513          	mv	a0,s1
    80004d00:	00000097          	auipc	ra,0x0
    80004d04:	940080e7          	jalr	-1728(ra) # 80004640 <_ZN10kmem_cache11delete_slabEPPNS_4slabES1_>
    while(not_empty_slabs != nullptr){
    80004d08:	fe9ff06f          	j	80004cf0 <_ZN10kmem_cache10destructorEv+0x34>
    }
    while(full_slabs != nullptr){
    80004d0c:	0384b603          	ld	a2,56(s1)
    80004d10:	00060c63          	beqz	a2,80004d28 <_ZN10kmem_cache10destructorEv+0x6c>
        slab *p_slab = full_slabs;
        delete_slab(&full_slabs, p_slab);
    80004d14:	03848593          	addi	a1,s1,56
    80004d18:	00048513          	mv	a0,s1
    80004d1c:	00000097          	auipc	ra,0x0
    80004d20:	924080e7          	jalr	-1756(ra) # 80004640 <_ZN10kmem_cache11delete_slabEPPNS_4slabES1_>
    while(full_slabs != nullptr){
    80004d24:	fe9ff06f          	j	80004d0c <_ZN10kmem_cache10destructorEv+0x50>
    }
}
    80004d28:	01813083          	ld	ra,24(sp)
    80004d2c:	01013403          	ld	s0,16(sp)
    80004d30:	00813483          	ld	s1,8(sp)
    80004d34:	02010113          	addi	sp,sp,32
    80004d38:	00008067          	ret

0000000080004d3c <_ZN10kmem_cache11sizeOfCacheEv>:

int kmem_cache::sizeOfCache() {
    80004d3c:	ff010113          	addi	sp,sp,-16
    80004d40:	00813423          	sd	s0,8(sp)
    80004d44:	01010413          	addi	s0,sp,16
    80004d48:	00050693          	mv	a3,a0
    int res = 0;
    slab *p_slab = empty_slabs;
    80004d4c:	02853783          	ld	a5,40(a0)
    int res = 0;
    80004d50:	00000513          	li	a0,0
    while(p_slab != nullptr){
    80004d54:	00078a63          	beqz	a5,80004d68 <_ZN10kmem_cache11sizeOfCacheEv+0x2c>
        res += p_slab->sizeInBlocks;
    80004d58:	0187b703          	ld	a4,24(a5)
    80004d5c:	00a7053b          	addw	a0,a4,a0
        p_slab = p_slab->next;
    80004d60:	0287b783          	ld	a5,40(a5)
    while(p_slab != nullptr){
    80004d64:	ff1ff06f          	j	80004d54 <_ZN10kmem_cache11sizeOfCacheEv+0x18>
    }
    p_slab = not_empty_slabs;
    80004d68:	0306b783          	ld	a5,48(a3)
    while(p_slab != nullptr){
    80004d6c:	00078a63          	beqz	a5,80004d80 <_ZN10kmem_cache11sizeOfCacheEv+0x44>
        res += p_slab->sizeInBlocks;
    80004d70:	0187b703          	ld	a4,24(a5)
    80004d74:	00a7053b          	addw	a0,a4,a0
        p_slab = p_slab->next;
    80004d78:	0287b783          	ld	a5,40(a5)
    while(p_slab != nullptr){
    80004d7c:	ff1ff06f          	j	80004d6c <_ZN10kmem_cache11sizeOfCacheEv+0x30>
    }
    p_slab = full_slabs;
    80004d80:	0386b783          	ld	a5,56(a3)
    while(p_slab != nullptr){
    80004d84:	00078a63          	beqz	a5,80004d98 <_ZN10kmem_cache11sizeOfCacheEv+0x5c>
        res += p_slab->sizeInBlocks;
    80004d88:	0187b703          	ld	a4,24(a5)
    80004d8c:	00a7053b          	addw	a0,a4,a0
        p_slab = p_slab->next;
    80004d90:	0287b783          	ld	a5,40(a5)
    while(p_slab != nullptr){
    80004d94:	ff1ff06f          	j	80004d84 <_ZN10kmem_cache11sizeOfCacheEv+0x48>
    }
    return res;
}
    80004d98:	00813403          	ld	s0,8(sp)
    80004d9c:	01010113          	addi	sp,sp,16
    80004da0:	00008067          	ret

0000000080004da4 <_ZN10kmem_cache9printInfoEv>:

void kmem_cache::printInfo() {
    80004da4:	fe010113          	addi	sp,sp,-32
    80004da8:	00113c23          	sd	ra,24(sp)
    80004dac:	00813823          	sd	s0,16(sp)
    80004db0:	00913423          	sd	s1,8(sp)
    80004db4:	01213023          	sd	s2,0(sp)
    80004db8:	02010413          	addi	s0,sp,32
    80004dbc:	00050493          	mv	s1,a0
    kernel_printString("===============\n");
    80004dc0:	00003517          	auipc	a0,0x3
    80004dc4:	3b850513          	addi	a0,a0,952 # 80008178 <CONSOLE_STATUS+0x168>
    80004dc8:	ffffe097          	auipc	ra,0xffffe
    80004dcc:	704080e7          	jalr	1796(ra) # 800034cc <_Z18kernel_printStringPKc>
    kernel_printString("Cache: ");
    80004dd0:	00003517          	auipc	a0,0x3
    80004dd4:	3c050513          	addi	a0,a0,960 # 80008190 <CONSOLE_STATUS+0x180>
    80004dd8:	ffffe097          	auipc	ra,0xffffe
    80004ddc:	6f4080e7          	jalr	1780(ra) # 800034cc <_Z18kernel_printStringPKc>
    kernel_printString(this->name);
    80004de0:	0004b503          	ld	a0,0(s1)
    80004de4:	ffffe097          	auipc	ra,0xffffe
    80004de8:	6e8080e7          	jalr	1768(ra) # 800034cc <_Z18kernel_printStringPKc>
    kernel_printString("\n");
    80004dec:	00003517          	auipc	a0,0x3
    80004df0:	5cc50513          	addi	a0,a0,1484 # 800083b8 <CONSOLE_STATUS+0x3a8>
    80004df4:	ffffe097          	auipc	ra,0xffffe
    80004df8:	6d8080e7          	jalr	1752(ra) # 800034cc <_Z18kernel_printStringPKc>

    kernel_printString("Size of one object: ");
    80004dfc:	00003517          	auipc	a0,0x3
    80004e00:	39c50513          	addi	a0,a0,924 # 80008198 <CONSOLE_STATUS+0x188>
    80004e04:	ffffe097          	auipc	ra,0xffffe
    80004e08:	6c8080e7          	jalr	1736(ra) # 800034cc <_Z18kernel_printStringPKc>
    kernel_printInt((int)this->sizeOfObject);
    80004e0c:	00000613          	li	a2,0
    80004e10:	00a00593          	li	a1,10
    80004e14:	0084a503          	lw	a0,8(s1)
    80004e18:	ffffe097          	auipc	ra,0xffffe
    80004e1c:	730080e7          	jalr	1840(ra) # 80003548 <_Z15kernel_printIntiii>
    kernel_printString(" bytes\n");
    80004e20:	00003517          	auipc	a0,0x3
    80004e24:	39050513          	addi	a0,a0,912 # 800081b0 <CONSOLE_STATUS+0x1a0>
    80004e28:	ffffe097          	auipc	ra,0xffffe
    80004e2c:	6a4080e7          	jalr	1700(ra) # 800034cc <_Z18kernel_printStringPKc>

    int cacheSize = sizeOfCache();
    80004e30:	00048513          	mv	a0,s1
    80004e34:	00000097          	auipc	ra,0x0
    80004e38:	f08080e7          	jalr	-248(ra) # 80004d3c <_ZN10kmem_cache11sizeOfCacheEv>
    80004e3c:	00050913          	mv	s2,a0
    kernel_printString("Size of cache: ");
    80004e40:	00003517          	auipc	a0,0x3
    80004e44:	37850513          	addi	a0,a0,888 # 800081b8 <CONSOLE_STATUS+0x1a8>
    80004e48:	ffffe097          	auipc	ra,0xffffe
    80004e4c:	684080e7          	jalr	1668(ra) # 800034cc <_Z18kernel_printStringPKc>
    kernel_printInt(cacheSize);
    80004e50:	00000613          	li	a2,0
    80004e54:	00a00593          	li	a1,10
    80004e58:	00090513          	mv	a0,s2
    80004e5c:	ffffe097          	auipc	ra,0xffffe
    80004e60:	6ec080e7          	jalr	1772(ra) # 80003548 <_Z15kernel_printIntiii>
    kernel_printString(" blocks\n");
    80004e64:	00003517          	auipc	a0,0x3
    80004e68:	36450513          	addi	a0,a0,868 # 800081c8 <CONSOLE_STATUS+0x1b8>
    80004e6c:	ffffe097          	auipc	ra,0xffffe
    80004e70:	660080e7          	jalr	1632(ra) # 800034cc <_Z18kernel_printStringPKc>

    kernel_printString("Number of slabs: ");
    80004e74:	00003517          	auipc	a0,0x3
    80004e78:	36450513          	addi	a0,a0,868 # 800081d8 <CONSOLE_STATUS+0x1c8>
    80004e7c:	ffffe097          	auipc	ra,0xffffe
    80004e80:	650080e7          	jalr	1616(ra) # 800034cc <_Z18kernel_printStringPKc>
    kernel_printInt((int)number_of_slabs);
    80004e84:	00000613          	li	a2,0
    80004e88:	00a00593          	li	a1,10
    80004e8c:	0404a503          	lw	a0,64(s1)
    80004e90:	ffffe097          	auipc	ra,0xffffe
    80004e94:	6b8080e7          	jalr	1720(ra) # 80003548 <_Z15kernel_printIntiii>
    kernel_printString("\n");
    80004e98:	00003517          	auipc	a0,0x3
    80004e9c:	52050513          	addi	a0,a0,1312 # 800083b8 <CONSOLE_STATUS+0x3a8>
    80004ea0:	ffffe097          	auipc	ra,0xffffe
    80004ea4:	62c080e7          	jalr	1580(ra) # 800034cc <_Z18kernel_printStringPKc>

    kernel_printString("Number of objects in one slab: ");
    80004ea8:	00003517          	auipc	a0,0x3
    80004eac:	34850513          	addi	a0,a0,840 # 800081f0 <CONSOLE_STATUS+0x1e0>
    80004eb0:	ffffe097          	auipc	ra,0xffffe
    80004eb4:	61c080e7          	jalr	1564(ra) # 800034cc <_Z18kernel_printStringPKc>
    kernel_printInt(BLOCK_SIZE/sizeOfObject);
    80004eb8:	0084b783          	ld	a5,8(s1)
    80004ebc:	00000613          	li	a2,0
    80004ec0:	00a00593          	li	a1,10
    80004ec4:	00001537          	lui	a0,0x1
    80004ec8:	02f55533          	divu	a0,a0,a5
    80004ecc:	ffffe097          	auipc	ra,0xffffe
    80004ed0:	67c080e7          	jalr	1660(ra) # 80003548 <_Z15kernel_printIntiii>
    kernel_printString("\n");
    80004ed4:	00003517          	auipc	a0,0x3
    80004ed8:	4e450513          	addi	a0,a0,1252 # 800083b8 <CONSOLE_STATUS+0x3a8>
    80004edc:	ffffe097          	auipc	ra,0xffffe
    80004ee0:	5f0080e7          	jalr	1520(ra) # 800034cc <_Z18kernel_printStringPKc>

    kernel_printString("Percentage of cache occupancy: ");
    80004ee4:	00003517          	auipc	a0,0x3
    80004ee8:	32c50513          	addi	a0,a0,812 # 80008210 <CONSOLE_STATUS+0x200>
    80004eec:	ffffe097          	auipc	ra,0xffffe
    80004ef0:	5e0080e7          	jalr	1504(ra) # 800034cc <_Z18kernel_printStringPKc>
    int onePer = cacheSize*BLOCK_SIZE / 100;
    80004ef4:	00c9191b          	slliw	s2,s2,0xc
    80004ef8:	06400513          	li	a0,100
    80004efc:	02a9493b          	divw	s2,s2,a0

    kernel_printInt(num_of_alloc_objects*(int)sizeOfObject/onePer);
    80004f00:	0484a783          	lw	a5,72(s1)
    80004f04:	0084b503          	ld	a0,8(s1)
    80004f08:	02f5053b          	mulw	a0,a0,a5
    80004f0c:	00000613          	li	a2,0
    80004f10:	00a00593          	li	a1,10
    80004f14:	0325453b          	divw	a0,a0,s2
    80004f18:	ffffe097          	auipc	ra,0xffffe
    80004f1c:	630080e7          	jalr	1584(ra) # 80003548 <_Z15kernel_printIntiii>
    kernel_printString("%\n");
    80004f20:	00003517          	auipc	a0,0x3
    80004f24:	31050513          	addi	a0,a0,784 # 80008230 <CONSOLE_STATUS+0x220>
    80004f28:	ffffe097          	auipc	ra,0xffffe
    80004f2c:	5a4080e7          	jalr	1444(ra) # 800034cc <_Z18kernel_printStringPKc>
    kernel_printString("===============\n");
    80004f30:	00003517          	auipc	a0,0x3
    80004f34:	24850513          	addi	a0,a0,584 # 80008178 <CONSOLE_STATUS+0x168>
    80004f38:	ffffe097          	auipc	ra,0xffffe
    80004f3c:	594080e7          	jalr	1428(ra) # 800034cc <_Z18kernel_printStringPKc>

}
    80004f40:	01813083          	ld	ra,24(sp)
    80004f44:	01013403          	ld	s0,16(sp)
    80004f48:	00813483          	ld	s1,8(sp)
    80004f4c:	00013903          	ld	s2,0(sp)
    80004f50:	02010113          	addi	sp,sp,32
    80004f54:	00008067          	ret

0000000080004f58 <_ZN10kmem_cache10printErrorEv>:

int kmem_cache::printError() {
    80004f58:	fe010113          	addi	sp,sp,-32
    80004f5c:	00113c23          	sd	ra,24(sp)
    80004f60:	00813823          	sd	s0,16(sp)
    80004f64:	00913423          	sd	s1,8(sp)
    80004f68:	02010413          	addi	s0,sp,32
    80004f6c:	00050493          	mv	s1,a0
    switch(error_indicator){
    80004f70:	02052783          	lw	a5,32(a0)
    80004f74:	fff00713          	li	a4,-1
    80004f78:	02e78e63          	beq	a5,a4,80004fb4 <_ZN10kmem_cache10printErrorEv+0x5c>
    80004f7c:	02078263          	beqz	a5,80004fa0 <_ZN10kmem_cache10printErrorEv+0x48>
    80004f80:	ffe00713          	li	a4,-2
    80004f84:	04e78263          	beq	a5,a4,80004fc8 <_ZN10kmem_cache10printErrorEv+0x70>
        case -2:
            kernel_printString("Error: object was not able to be deallocated.\n");
            break;
    }
    return error_indicator;
    80004f88:	0204a503          	lw	a0,32(s1)
    80004f8c:	01813083          	ld	ra,24(sp)
    80004f90:	01013403          	ld	s0,16(sp)
    80004f94:	00813483          	ld	s1,8(sp)
    80004f98:	02010113          	addi	sp,sp,32
    80004f9c:	00008067          	ret
            kernel_printString("No errors.\n");
    80004fa0:	00003517          	auipc	a0,0x3
    80004fa4:	29850513          	addi	a0,a0,664 # 80008238 <CONSOLE_STATUS+0x228>
    80004fa8:	ffffe097          	auipc	ra,0xffffe
    80004fac:	524080e7          	jalr	1316(ra) # 800034cc <_Z18kernel_printStringPKc>
            break;
    80004fb0:	fd9ff06f          	j	80004f88 <_ZN10kmem_cache10printErrorEv+0x30>
            kernel_printString("Error: not enough space for another slab.\n");
    80004fb4:	00003517          	auipc	a0,0x3
    80004fb8:	29450513          	addi	a0,a0,660 # 80008248 <CONSOLE_STATUS+0x238>
    80004fbc:	ffffe097          	auipc	ra,0xffffe
    80004fc0:	510080e7          	jalr	1296(ra) # 800034cc <_Z18kernel_printStringPKc>
            break;
    80004fc4:	fc5ff06f          	j	80004f88 <_ZN10kmem_cache10printErrorEv+0x30>
            kernel_printString("Error: object was not able to be deallocated.\n");
    80004fc8:	00003517          	auipc	a0,0x3
    80004fcc:	2b050513          	addi	a0,a0,688 # 80008278 <CONSOLE_STATUS+0x268>
    80004fd0:	ffffe097          	auipc	ra,0xffffe
    80004fd4:	4fc080e7          	jalr	1276(ra) # 800034cc <_Z18kernel_printStringPKc>
            break;
    80004fd8:	fb1ff06f          	j	80004f88 <_ZN10kmem_cache10printErrorEv+0x30>

0000000080004fdc <_Z9kmem_initPvi>:
#include "../h/slab.hpp"
#include "../h/KernelSlab.hpp"

void kmem_init(void *space, int block_num){
    80004fdc:	ff010113          	addi	sp,sp,-16
    80004fe0:	00113423          	sd	ra,8(sp)
    80004fe4:	00813023          	sd	s0,0(sp)
    80004fe8:	01010413          	addi	s0,sp,16
    uint64 realSize = (uint64)block_num * BLOCK_SIZE;
    80004fec:	00c59593          	slli	a1,a1,0xc
    void* end = (void *)((uint64)space + realSize);
    Buddy::buddy_init(space, end);
    80004ff0:	00b505b3          	add	a1,a0,a1
    80004ff4:	ffffd097          	auipc	ra,0xffffd
    80004ff8:	940080e7          	jalr	-1728(ra) # 80001934 <_ZN5Buddy10buddy_initEPvS0_>
    KernelSlab::kernel_slab_init();
    80004ffc:	ffffc097          	auipc	ra,0xffffc
    80005000:	3bc080e7          	jalr	956(ra) # 800013b8 <_ZN10KernelSlab16kernel_slab_initEv>
}
    80005004:	00813083          	ld	ra,8(sp)
    80005008:	00013403          	ld	s0,0(sp)
    8000500c:	01010113          	addi	sp,sp,16
    80005010:	00008067          	ret

0000000080005014 <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t *kmem_cache_create(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)){
    80005014:	fc010113          	addi	sp,sp,-64
    80005018:	02113c23          	sd	ra,56(sp)
    8000501c:	02813823          	sd	s0,48(sp)
    80005020:	02913423          	sd	s1,40(sp)
    80005024:	03213023          	sd	s2,32(sp)
    80005028:	01313c23          	sd	s3,24(sp)
    8000502c:	01413823          	sd	s4,16(sp)
    80005030:	01513423          	sd	s5,8(sp)
    80005034:	04010413          	addi	s0,sp,64
    80005038:	00050913          	mv	s2,a0
    8000503c:	00058993          	mv	s3,a1
    80005040:	00060a13          	mv	s4,a2
    80005044:	00068a93          	mv	s5,a3
   kmem_cache_t *res = (kmem_cache_t *)Buddy::buddy_allocate(sizeof(kmem_cache_t));
    80005048:	05000513          	li	a0,80
    8000504c:	ffffd097          	auipc	ra,0xffffd
    80005050:	b1c080e7          	jalr	-1252(ra) # 80001b68 <_ZN5Buddy14buddy_allocateEm>
    80005054:	00050493          	mv	s1,a0
   res->cache_create((char *)name, size, ctor, dtor);
    80005058:	000a8713          	mv	a4,s5
    8000505c:	000a0693          	mv	a3,s4
    80005060:	00098613          	mv	a2,s3
    80005064:	00090593          	mv	a1,s2
    80005068:	fffff097          	auipc	ra,0xfffff
    8000506c:	55c080e7          	jalr	1372(ra) # 800045c4 <_ZN10kmem_cache12cache_createEPcmPFvPvES3_>
   KernelSlab::addCache(res);
    80005070:	00048513          	mv	a0,s1
    80005074:	ffffc097          	auipc	ra,0xffffc
    80005078:	364080e7          	jalr	868(ra) # 800013d8 <_ZN10KernelSlab8addCacheEP10kmem_cache>
   return res;
}
    8000507c:	00048513          	mv	a0,s1
    80005080:	03813083          	ld	ra,56(sp)
    80005084:	03013403          	ld	s0,48(sp)
    80005088:	02813483          	ld	s1,40(sp)
    8000508c:	02013903          	ld	s2,32(sp)
    80005090:	01813983          	ld	s3,24(sp)
    80005094:	01013a03          	ld	s4,16(sp)
    80005098:	00813a83          	ld	s5,8(sp)
    8000509c:	04010113          	addi	sp,sp,64
    800050a0:	00008067          	ret

00000000800050a4 <_Z17kmem_cache_shrinkP10kmem_cache>:

int kmem_cache_shrink(kmem_cache_t *cachep){
    800050a4:	ff010113          	addi	sp,sp,-16
    800050a8:	00113423          	sd	ra,8(sp)
    800050ac:	00813023          	sd	s0,0(sp)
    800050b0:	01010413          	addi	s0,sp,16
    return cachep->shrink();
    800050b4:	fffff097          	auipc	ra,0xfffff
    800050b8:	78c080e7          	jalr	1932(ra) # 80004840 <_ZN10kmem_cache6shrinkEv>
}
    800050bc:	00813083          	ld	ra,8(sp)
    800050c0:	00013403          	ld	s0,0(sp)
    800050c4:	01010113          	addi	sp,sp,16
    800050c8:	00008067          	ret

00000000800050cc <_Z7kmallocm>:

void *kmalloc(size_t size){
    800050cc:	ff010113          	addi	sp,sp,-16
    800050d0:	00113423          	sd	ra,8(sp)
    800050d4:	00813023          	sd	s0,0(sp)
    800050d8:	01010413          	addi	s0,sp,16
    return Buddy::buddy_allocate(size);
    800050dc:	ffffd097          	auipc	ra,0xffffd
    800050e0:	a8c080e7          	jalr	-1396(ra) # 80001b68 <_ZN5Buddy14buddy_allocateEm>
}
    800050e4:	00813083          	ld	ra,8(sp)
    800050e8:	00013403          	ld	s0,0(sp)
    800050ec:	01010113          	addi	sp,sp,16
    800050f0:	00008067          	ret

00000000800050f4 <_Z5kfreePKv>:

void kfree(const void *objp){
    800050f4:	ff010113          	addi	sp,sp,-16
    800050f8:	00113423          	sd	ra,8(sp)
    800050fc:	00813023          	sd	s0,0(sp)
    80005100:	01010413          	addi	s0,sp,16
    Buddy::buddy_free((void *)objp);
    80005104:	ffffd097          	auipc	ra,0xffffd
    80005108:	c40080e7          	jalr	-960(ra) # 80001d44 <_ZN5Buddy10buddy_freeEPv>
}
    8000510c:	00813083          	ld	ra,8(sp)
    80005110:	00013403          	ld	s0,0(sp)
    80005114:	01010113          	addi	sp,sp,16
    80005118:	00008067          	ret

000000008000511c <_Z16kmem_cache_allocP10kmem_cache>:

void *kmem_cache_alloc(kmem_cache_t *cachep){
    8000511c:	ff010113          	addi	sp,sp,-16
    80005120:	00113423          	sd	ra,8(sp)
    80005124:	00813023          	sd	s0,0(sp)
    80005128:	01010413          	addi	s0,sp,16
    return cachep->alloc_object();
    8000512c:	fffff097          	auipc	ra,0xfffff
    80005130:	7b4080e7          	jalr	1972(ra) # 800048e0 <_ZN10kmem_cache12alloc_objectEv>
}
    80005134:	00813083          	ld	ra,8(sp)
    80005138:	00013403          	ld	s0,0(sp)
    8000513c:	01010113          	addi	sp,sp,16
    80005140:	00008067          	ret

0000000080005144 <_Z15kmem_cache_freeP10kmem_cachePv>:

void kmem_cache_free(kmem_cache_t *cachep, void *objp){
    80005144:	ff010113          	addi	sp,sp,-16
    80005148:	00113423          	sd	ra,8(sp)
    8000514c:	00813023          	sd	s0,0(sp)
    80005150:	01010413          	addi	s0,sp,16
    cachep->free_object(objp);
    80005154:	00000097          	auipc	ra,0x0
    80005158:	a2c080e7          	jalr	-1492(ra) # 80004b80 <_ZN10kmem_cache11free_objectEPv>
}
    8000515c:	00813083          	ld	ra,8(sp)
    80005160:	00013403          	ld	s0,0(sp)
    80005164:	01010113          	addi	sp,sp,16
    80005168:	00008067          	ret

000000008000516c <_Z18kmem_cache_destroyP10kmem_cache>:

void kmem_cache_destroy(kmem_cache_t *cachep){
    8000516c:	fe010113          	addi	sp,sp,-32
    80005170:	00113c23          	sd	ra,24(sp)
    80005174:	00813823          	sd	s0,16(sp)
    80005178:	00913423          	sd	s1,8(sp)
    8000517c:	02010413          	addi	s0,sp,32
    80005180:	00050493          	mv	s1,a0
    cachep->destructor();
    80005184:	00000097          	auipc	ra,0x0
    80005188:	b38080e7          	jalr	-1224(ra) # 80004cbc <_ZN10kmem_cache10destructorEv>
    KernelSlab::deleteCache(cachep);
    8000518c:	00048513          	mv	a0,s1
    80005190:	ffffc097          	auipc	ra,0xffffc
    80005194:	2b8080e7          	jalr	696(ra) # 80001448 <_ZN10KernelSlab11deleteCacheEP10kmem_cache>
}
    80005198:	01813083          	ld	ra,24(sp)
    8000519c:	01013403          	ld	s0,16(sp)
    800051a0:	00813483          	ld	s1,8(sp)
    800051a4:	02010113          	addi	sp,sp,32
    800051a8:	00008067          	ret

00000000800051ac <_Z15kmem_cache_infoP10kmem_cache>:

void kmem_cache_info(kmem_cache_t *cachep){
    800051ac:	ff010113          	addi	sp,sp,-16
    800051b0:	00113423          	sd	ra,8(sp)
    800051b4:	00813023          	sd	s0,0(sp)
    800051b8:	01010413          	addi	s0,sp,16
    cachep->printInfo();
    800051bc:	00000097          	auipc	ra,0x0
    800051c0:	be8080e7          	jalr	-1048(ra) # 80004da4 <_ZN10kmem_cache9printInfoEv>
}
    800051c4:	00813083          	ld	ra,8(sp)
    800051c8:	00013403          	ld	s0,0(sp)
    800051cc:	01010113          	addi	sp,sp,16
    800051d0:	00008067          	ret

00000000800051d4 <_Z16kmem_cache_errorP10kmem_cache>:

int kmem_cache_error(kmem_cache_t *cachep){
    800051d4:	ff010113          	addi	sp,sp,-16
    800051d8:	00113423          	sd	ra,8(sp)
    800051dc:	00813023          	sd	s0,0(sp)
    800051e0:	01010413          	addi	s0,sp,16
    return cachep->printError();
    800051e4:	00000097          	auipc	ra,0x0
    800051e8:	d74080e7          	jalr	-652(ra) # 80004f58 <_ZN10kmem_cache10printErrorEv>
    800051ec:	00813083          	ld	ra,8(sp)
    800051f0:	00013403          	ld	s0,0(sp)
    800051f4:	01010113          	addi	sp,sp,16
    800051f8:	00008067          	ret

00000000800051fc <_ZN3SEM9createSEMEi>:
#include "../h/SEM.hpp"

kmem_cache_t *SEM::cache = nullptr;

SEM *SEM::createSEM(int val) {
    800051fc:	fe010113          	addi	sp,sp,-32
    80005200:	00113c23          	sd	ra,24(sp)
    80005204:	00813823          	sd	s0,16(sp)
    80005208:	00913423          	sd	s1,8(sp)
    8000520c:	01213023          	sd	s2,0(sp)
    80005210:	02010413          	addi	s0,sp,32
    80005214:	00050913          	mv	s2,a0
    SEM* ret = (SEM *)kmem_cache_alloc(SEM::cache);
    80005218:	00005517          	auipc	a0,0x5
    8000521c:	f2053503          	ld	a0,-224(a0) # 8000a138 <_ZN3SEM5cacheE>
    80005220:	00000097          	auipc	ra,0x0
    80005224:	efc080e7          	jalr	-260(ra) # 8000511c <_Z16kmem_cache_allocP10kmem_cache>
    80005228:	00050493          	mv	s1,a0
    if(ret == nullptr) return nullptr;
    8000522c:	00050e63          	beqz	a0,80005248 <_ZN3SEM9createSEMEi+0x4c>
    ret->val = val;
    80005230:	01252023          	sw	s2,0(a0)
    ret->q = Queue::createQueue();
    80005234:	ffffd097          	auipc	ra,0xffffd
    80005238:	158080e7          	jalr	344(ra) # 8000238c <_ZN5Queue11createQueueEv>
    8000523c:	00050913          	mv	s2,a0
    80005240:	00a4b423          	sd	a0,8(s1)
    if(ret->q == nullptr){
    80005244:	02050063          	beqz	a0,80005264 <_ZN3SEM9createSEMEi+0x68>
        kmem_cache_free(SEM::cache, ret);
        return nullptr;
    }
    return ret;
}
    80005248:	00048513          	mv	a0,s1
    8000524c:	01813083          	ld	ra,24(sp)
    80005250:	01013403          	ld	s0,16(sp)
    80005254:	00813483          	ld	s1,8(sp)
    80005258:	00013903          	ld	s2,0(sp)
    8000525c:	02010113          	addi	sp,sp,32
    80005260:	00008067          	ret
        kmem_cache_free(SEM::cache, ret);
    80005264:	00048593          	mv	a1,s1
    80005268:	00005517          	auipc	a0,0x5
    8000526c:	ed053503          	ld	a0,-304(a0) # 8000a138 <_ZN3SEM5cacheE>
    80005270:	00000097          	auipc	ra,0x0
    80005274:	ed4080e7          	jalr	-300(ra) # 80005144 <_Z15kmem_cache_freeP10kmem_cachePv>
        return nullptr;
    80005278:	00090493          	mv	s1,s2
    8000527c:	fcdff06f          	j	80005248 <_ZN3SEM9createSEMEi+0x4c>

0000000080005280 <_ZN3SEM4waitEv>:

int SEM::wait(){
    if(--val < 0){
    80005280:	00052783          	lw	a5,0(a0)
    80005284:	fff7879b          	addiw	a5,a5,-1
    80005288:	00f52023          	sw	a5,0(a0)
    8000528c:	02079713          	slli	a4,a5,0x20
    80005290:	00074663          	bltz	a4,8000529c <_ZN3SEM4waitEv+0x1c>
        }

        PCB::running->status = ThreadStatus::BLOCKED;
        PCB::dispatch();
    }
    return 0;
    80005294:	00000513          	li	a0,0
}
    80005298:	00008067          	ret
int SEM::wait(){
    8000529c:	fe010113          	addi	sp,sp,-32
    800052a0:	00113c23          	sd	ra,24(sp)
    800052a4:	00813823          	sd	s0,16(sp)
    800052a8:	00913423          	sd	s1,8(sp)
    800052ac:	02010413          	addi	s0,sp,32
    800052b0:	00050493          	mv	s1,a0
        if(q->put(PCB::running) == -1) {
    800052b4:	00005797          	auipc	a5,0x5
    800052b8:	d2c7b783          	ld	a5,-724(a5) # 80009fe0 <_GLOBAL_OFFSET_TABLE_+0xb0>
    800052bc:	0007b583          	ld	a1,0(a5)
    800052c0:	00853503          	ld	a0,8(a0)
    800052c4:	ffffd097          	auipc	ra,0xffffd
    800052c8:	148080e7          	jalr	328(ra) # 8000240c <_ZN5Queue3putEP3PCB>
    800052cc:	fff00793          	li	a5,-1
    800052d0:	02f50c63          	beq	a0,a5,80005308 <_ZN3SEM4waitEv+0x88>
        PCB::running->status = ThreadStatus::BLOCKED;
    800052d4:	00005797          	auipc	a5,0x5
    800052d8:	d0c7b783          	ld	a5,-756(a5) # 80009fe0 <_GLOBAL_OFFSET_TABLE_+0xb0>
    800052dc:	0007b783          	ld	a5,0(a5)
    800052e0:	00100713          	li	a4,1
    800052e4:	00e7a023          	sw	a4,0(a5)
        PCB::dispatch();
    800052e8:	ffffc097          	auipc	ra,0xffffc
    800052ec:	350080e7          	jalr	848(ra) # 80001638 <_ZN3PCB8dispatchEv>
    return 0;
    800052f0:	00000513          	li	a0,0
}
    800052f4:	01813083          	ld	ra,24(sp)
    800052f8:	01013403          	ld	s0,16(sp)
    800052fc:	00813483          	ld	s1,8(sp)
    80005300:	02010113          	addi	sp,sp,32
    80005304:	00008067          	ret
            val++;
    80005308:	0004a783          	lw	a5,0(s1)
    8000530c:	0017879b          	addiw	a5,a5,1
    80005310:	00f4a023          	sw	a5,0(s1)
            return -1;
    80005314:	fe1ff06f          	j	800052f4 <_ZN3SEM4waitEv+0x74>

0000000080005318 <_ZN3SEM6signalEv>:

int SEM::signal() {
    80005318:	fe010113          	addi	sp,sp,-32
    8000531c:	00113c23          	sd	ra,24(sp)
    80005320:	00813823          	sd	s0,16(sp)
    80005324:	00913423          	sd	s1,8(sp)
    80005328:	02010413          	addi	s0,sp,32
    8000532c:	00050493          	mv	s1,a0
    if(val < 0){
    80005330:	00052783          	lw	a5,0(a0)
    80005334:	0207c463          	bltz	a5,8000535c <_ZN3SEM6signalEv+0x44>
        if(tmp){
            tmp->status = READY;
            Scheduler::put(tmp);
        }
    }
    val++;
    80005338:	0004a783          	lw	a5,0(s1)
    8000533c:	0017879b          	addiw	a5,a5,1
    80005340:	00f4a023          	sw	a5,0(s1)
    return 0;
}
    80005344:	00000513          	li	a0,0
    80005348:	01813083          	ld	ra,24(sp)
    8000534c:	01013403          	ld	s0,16(sp)
    80005350:	00813483          	ld	s1,8(sp)
    80005354:	02010113          	addi	sp,sp,32
    80005358:	00008067          	ret
        PCB* tmp = q->get();
    8000535c:	00853503          	ld	a0,8(a0)
    80005360:	ffffd097          	auipc	ra,0xffffd
    80005364:	0f8080e7          	jalr	248(ra) # 80002458 <_ZN5Queue3getEv>
        if(tmp){
    80005368:	fc0508e3          	beqz	a0,80005338 <_ZN3SEM6signalEv+0x20>
            tmp->status = READY;
    8000536c:	00052023          	sw	zero,0(a0)
            Scheduler::put(tmp);
    80005370:	fffff097          	auipc	ra,0xfffff
    80005374:	ad4080e7          	jalr	-1324(ra) # 80003e44 <_ZN9Scheduler3putEP3PCB>
    80005378:	fc1ff06f          	j	80005338 <_ZN3SEM6signalEv+0x20>

000000008000537c <_ZN3SEM5closeEv>:

int SEM::close() {
    8000537c:	fe010113          	addi	sp,sp,-32
    80005380:	00113c23          	sd	ra,24(sp)
    80005384:	00813823          	sd	s0,16(sp)
    80005388:	00913423          	sd	s1,8(sp)
    8000538c:	02010413          	addi	s0,sp,32
    80005390:	00050493          	mv	s1,a0
    PCB* tmp = q->get();
    80005394:	00853503          	ld	a0,8(a0)
    80005398:	ffffd097          	auipc	ra,0xffffd
    8000539c:	0c0080e7          	jalr	192(ra) # 80002458 <_ZN5Queue3getEv>
    while(tmp != nullptr){
    800053a0:	00050c63          	beqz	a0,800053b8 <_ZN3SEM5closeEv+0x3c>
        tmp->status = ThreadStatus::READY;
    800053a4:	00052023          	sw	zero,0(a0)
        tmp = q->get();
    800053a8:	0084b503          	ld	a0,8(s1)
    800053ac:	ffffd097          	auipc	ra,0xffffd
    800053b0:	0ac080e7          	jalr	172(ra) # 80002458 <_ZN5Queue3getEv>
    while(tmp != nullptr){
    800053b4:	fedff06f          	j	800053a0 <_ZN3SEM5closeEv+0x24>
    }
    return 0;
}
    800053b8:	00000513          	li	a0,0
    800053bc:	01813083          	ld	ra,24(sp)
    800053c0:	01013403          	ld	s0,16(sp)
    800053c4:	00813483          	ld	s1,8(sp)
    800053c8:	02010113          	addi	sp,sp,32
    800053cc:	00008067          	ret

00000000800053d0 <_ZN3SEM10freeObjectEPS_>:

void SEM::freeObject(SEM *s){
    800053d0:	ff010113          	addi	sp,sp,-16
    800053d4:	00113423          	sd	ra,8(sp)
    800053d8:	00813023          	sd	s0,0(sp)
    800053dc:	01010413          	addi	s0,sp,16
    800053e0:	00050593          	mv	a1,a0
    kmem_cache_free(SEM::cache, (void *)s);
    800053e4:	00005517          	auipc	a0,0x5
    800053e8:	d5453503          	ld	a0,-684(a0) # 8000a138 <_ZN3SEM5cacheE>
    800053ec:	00000097          	auipc	ra,0x0
    800053f0:	d58080e7          	jalr	-680(ra) # 80005144 <_Z15kmem_cache_freeP10kmem_cachePv>
}
    800053f4:	00813083          	ld	ra,8(sp)
    800053f8:	00013403          	ld	s0,0(sp)
    800053fc:	01010113          	addi	sp,sp,16
    80005400:	00008067          	ret

0000000080005404 <_ZN3SEM4dtorEPS_>:

void SEM::dtor(SEM *s){
    80005404:	ff010113          	addi	sp,sp,-16
    80005408:	00113423          	sd	ra,8(sp)
    8000540c:	00813023          	sd	s0,0(sp)
    80005410:	01010413          	addi	s0,sp,16
    Queue::freeObject(s->q);
    80005414:	00853503          	ld	a0,8(a0)
    80005418:	ffffd097          	auipc	ra,0xffffd
    8000541c:	078080e7          	jalr	120(ra) # 80002490 <_ZN5Queue10freeObjectEPS_>
    80005420:	00813083          	ld	ra,8(sp)
    80005424:	00013403          	ld	s0,0(sp)
    80005428:	01010113          	addi	sp,sp,16
    8000542c:	00008067          	ret

0000000080005430 <start>:
    80005430:	ff010113          	addi	sp,sp,-16
    80005434:	00813423          	sd	s0,8(sp)
    80005438:	01010413          	addi	s0,sp,16
    8000543c:	300027f3          	csrr	a5,mstatus
    80005440:	ffffe737          	lui	a4,0xffffe
    80005444:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff345f>
    80005448:	00e7f7b3          	and	a5,a5,a4
    8000544c:	00001737          	lui	a4,0x1
    80005450:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005454:	00e7e7b3          	or	a5,a5,a4
    80005458:	30079073          	csrw	mstatus,a5
    8000545c:	00000797          	auipc	a5,0x0
    80005460:	16078793          	addi	a5,a5,352 # 800055bc <system_main>
    80005464:	34179073          	csrw	mepc,a5
    80005468:	00000793          	li	a5,0
    8000546c:	18079073          	csrw	satp,a5
    80005470:	000107b7          	lui	a5,0x10
    80005474:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80005478:	30279073          	csrw	medeleg,a5
    8000547c:	30379073          	csrw	mideleg,a5
    80005480:	104027f3          	csrr	a5,sie
    80005484:	2227e793          	ori	a5,a5,546
    80005488:	10479073          	csrw	sie,a5
    8000548c:	fff00793          	li	a5,-1
    80005490:	00a7d793          	srli	a5,a5,0xa
    80005494:	3b079073          	csrw	pmpaddr0,a5
    80005498:	00f00793          	li	a5,15
    8000549c:	3a079073          	csrw	pmpcfg0,a5
    800054a0:	f14027f3          	csrr	a5,mhartid
    800054a4:	0200c737          	lui	a4,0x200c
    800054a8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800054ac:	0007869b          	sext.w	a3,a5
    800054b0:	00269713          	slli	a4,a3,0x2
    800054b4:	000f4637          	lui	a2,0xf4
    800054b8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800054bc:	00d70733          	add	a4,a4,a3
    800054c0:	0037979b          	slliw	a5,a5,0x3
    800054c4:	020046b7          	lui	a3,0x2004
    800054c8:	00d787b3          	add	a5,a5,a3
    800054cc:	00c585b3          	add	a1,a1,a2
    800054d0:	00371693          	slli	a3,a4,0x3
    800054d4:	00005717          	auipc	a4,0x5
    800054d8:	c6c70713          	addi	a4,a4,-916 # 8000a140 <timer_scratch>
    800054dc:	00b7b023          	sd	a1,0(a5)
    800054e0:	00d70733          	add	a4,a4,a3
    800054e4:	00f73c23          	sd	a5,24(a4)
    800054e8:	02c73023          	sd	a2,32(a4)
    800054ec:	34071073          	csrw	mscratch,a4
    800054f0:	00000797          	auipc	a5,0x0
    800054f4:	6e078793          	addi	a5,a5,1760 # 80005bd0 <timervec>
    800054f8:	30579073          	csrw	mtvec,a5
    800054fc:	300027f3          	csrr	a5,mstatus
    80005500:	0087e793          	ori	a5,a5,8
    80005504:	30079073          	csrw	mstatus,a5
    80005508:	304027f3          	csrr	a5,mie
    8000550c:	0807e793          	ori	a5,a5,128
    80005510:	30479073          	csrw	mie,a5
    80005514:	f14027f3          	csrr	a5,mhartid
    80005518:	0007879b          	sext.w	a5,a5
    8000551c:	00078213          	mv	tp,a5
    80005520:	30200073          	mret
    80005524:	00813403          	ld	s0,8(sp)
    80005528:	01010113          	addi	sp,sp,16
    8000552c:	00008067          	ret

0000000080005530 <timerinit>:
    80005530:	ff010113          	addi	sp,sp,-16
    80005534:	00813423          	sd	s0,8(sp)
    80005538:	01010413          	addi	s0,sp,16
    8000553c:	f14027f3          	csrr	a5,mhartid
    80005540:	0200c737          	lui	a4,0x200c
    80005544:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005548:	0007869b          	sext.w	a3,a5
    8000554c:	00269713          	slli	a4,a3,0x2
    80005550:	000f4637          	lui	a2,0xf4
    80005554:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005558:	00d70733          	add	a4,a4,a3
    8000555c:	0037979b          	slliw	a5,a5,0x3
    80005560:	020046b7          	lui	a3,0x2004
    80005564:	00d787b3          	add	a5,a5,a3
    80005568:	00c585b3          	add	a1,a1,a2
    8000556c:	00371693          	slli	a3,a4,0x3
    80005570:	00005717          	auipc	a4,0x5
    80005574:	bd070713          	addi	a4,a4,-1072 # 8000a140 <timer_scratch>
    80005578:	00b7b023          	sd	a1,0(a5)
    8000557c:	00d70733          	add	a4,a4,a3
    80005580:	00f73c23          	sd	a5,24(a4)
    80005584:	02c73023          	sd	a2,32(a4)
    80005588:	34071073          	csrw	mscratch,a4
    8000558c:	00000797          	auipc	a5,0x0
    80005590:	64478793          	addi	a5,a5,1604 # 80005bd0 <timervec>
    80005594:	30579073          	csrw	mtvec,a5
    80005598:	300027f3          	csrr	a5,mstatus
    8000559c:	0087e793          	ori	a5,a5,8
    800055a0:	30079073          	csrw	mstatus,a5
    800055a4:	304027f3          	csrr	a5,mie
    800055a8:	0807e793          	ori	a5,a5,128
    800055ac:	30479073          	csrw	mie,a5
    800055b0:	00813403          	ld	s0,8(sp)
    800055b4:	01010113          	addi	sp,sp,16
    800055b8:	00008067          	ret

00000000800055bc <system_main>:
    800055bc:	fe010113          	addi	sp,sp,-32
    800055c0:	00813823          	sd	s0,16(sp)
    800055c4:	00913423          	sd	s1,8(sp)
    800055c8:	00113c23          	sd	ra,24(sp)
    800055cc:	02010413          	addi	s0,sp,32
    800055d0:	00000097          	auipc	ra,0x0
    800055d4:	0c4080e7          	jalr	196(ra) # 80005694 <cpuid>
    800055d8:	00005497          	auipc	s1,0x5
    800055dc:	a5848493          	addi	s1,s1,-1448 # 8000a030 <started>
    800055e0:	02050263          	beqz	a0,80005604 <system_main+0x48>
    800055e4:	0004a783          	lw	a5,0(s1)
    800055e8:	0007879b          	sext.w	a5,a5
    800055ec:	fe078ce3          	beqz	a5,800055e4 <system_main+0x28>
    800055f0:	0ff0000f          	fence
    800055f4:	00003517          	auipc	a0,0x3
    800055f8:	ce450513          	addi	a0,a0,-796 # 800082d8 <CONSOLE_STATUS+0x2c8>
    800055fc:	00001097          	auipc	ra,0x1
    80005600:	a70080e7          	jalr	-1424(ra) # 8000606c <panic>
    80005604:	00001097          	auipc	ra,0x1
    80005608:	9c4080e7          	jalr	-1596(ra) # 80005fc8 <consoleinit>
    8000560c:	00001097          	auipc	ra,0x1
    80005610:	150080e7          	jalr	336(ra) # 8000675c <printfinit>
    80005614:	00003517          	auipc	a0,0x3
    80005618:	da450513          	addi	a0,a0,-604 # 800083b8 <CONSOLE_STATUS+0x3a8>
    8000561c:	00001097          	auipc	ra,0x1
    80005620:	aac080e7          	jalr	-1364(ra) # 800060c8 <__printf>
    80005624:	00003517          	auipc	a0,0x3
    80005628:	c8450513          	addi	a0,a0,-892 # 800082a8 <CONSOLE_STATUS+0x298>
    8000562c:	00001097          	auipc	ra,0x1
    80005630:	a9c080e7          	jalr	-1380(ra) # 800060c8 <__printf>
    80005634:	00003517          	auipc	a0,0x3
    80005638:	d8450513          	addi	a0,a0,-636 # 800083b8 <CONSOLE_STATUS+0x3a8>
    8000563c:	00001097          	auipc	ra,0x1
    80005640:	a8c080e7          	jalr	-1396(ra) # 800060c8 <__printf>
    80005644:	00001097          	auipc	ra,0x1
    80005648:	4a4080e7          	jalr	1188(ra) # 80006ae8 <kinit>
    8000564c:	00000097          	auipc	ra,0x0
    80005650:	148080e7          	jalr	328(ra) # 80005794 <trapinit>
    80005654:	00000097          	auipc	ra,0x0
    80005658:	16c080e7          	jalr	364(ra) # 800057c0 <trapinithart>
    8000565c:	00000097          	auipc	ra,0x0
    80005660:	5b4080e7          	jalr	1460(ra) # 80005c10 <plicinit>
    80005664:	00000097          	auipc	ra,0x0
    80005668:	5d4080e7          	jalr	1492(ra) # 80005c38 <plicinithart>
    8000566c:	00000097          	auipc	ra,0x0
    80005670:	078080e7          	jalr	120(ra) # 800056e4 <userinit>
    80005674:	0ff0000f          	fence
    80005678:	00100793          	li	a5,1
    8000567c:	00003517          	auipc	a0,0x3
    80005680:	c4450513          	addi	a0,a0,-956 # 800082c0 <CONSOLE_STATUS+0x2b0>
    80005684:	00f4a023          	sw	a5,0(s1)
    80005688:	00001097          	auipc	ra,0x1
    8000568c:	a40080e7          	jalr	-1472(ra) # 800060c8 <__printf>
    80005690:	0000006f          	j	80005690 <system_main+0xd4>

0000000080005694 <cpuid>:
    80005694:	ff010113          	addi	sp,sp,-16
    80005698:	00813423          	sd	s0,8(sp)
    8000569c:	01010413          	addi	s0,sp,16
    800056a0:	00020513          	mv	a0,tp
    800056a4:	00813403          	ld	s0,8(sp)
    800056a8:	0005051b          	sext.w	a0,a0
    800056ac:	01010113          	addi	sp,sp,16
    800056b0:	00008067          	ret

00000000800056b4 <mycpu>:
    800056b4:	ff010113          	addi	sp,sp,-16
    800056b8:	00813423          	sd	s0,8(sp)
    800056bc:	01010413          	addi	s0,sp,16
    800056c0:	00020793          	mv	a5,tp
    800056c4:	00813403          	ld	s0,8(sp)
    800056c8:	0007879b          	sext.w	a5,a5
    800056cc:	00779793          	slli	a5,a5,0x7
    800056d0:	00006517          	auipc	a0,0x6
    800056d4:	aa050513          	addi	a0,a0,-1376 # 8000b170 <cpus>
    800056d8:	00f50533          	add	a0,a0,a5
    800056dc:	01010113          	addi	sp,sp,16
    800056e0:	00008067          	ret

00000000800056e4 <userinit>:
    800056e4:	ff010113          	addi	sp,sp,-16
    800056e8:	00813423          	sd	s0,8(sp)
    800056ec:	01010413          	addi	s0,sp,16
    800056f0:	00813403          	ld	s0,8(sp)
    800056f4:	01010113          	addi	sp,sp,16
    800056f8:	ffffd317          	auipc	t1,0xffffd
    800056fc:	4b430067          	jr	1204(t1) # 80002bac <main>

0000000080005700 <either_copyout>:
    80005700:	ff010113          	addi	sp,sp,-16
    80005704:	00813023          	sd	s0,0(sp)
    80005708:	00113423          	sd	ra,8(sp)
    8000570c:	01010413          	addi	s0,sp,16
    80005710:	02051663          	bnez	a0,8000573c <either_copyout+0x3c>
    80005714:	00058513          	mv	a0,a1
    80005718:	00060593          	mv	a1,a2
    8000571c:	0006861b          	sext.w	a2,a3
    80005720:	00002097          	auipc	ra,0x2
    80005724:	c54080e7          	jalr	-940(ra) # 80007374 <__memmove>
    80005728:	00813083          	ld	ra,8(sp)
    8000572c:	00013403          	ld	s0,0(sp)
    80005730:	00000513          	li	a0,0
    80005734:	01010113          	addi	sp,sp,16
    80005738:	00008067          	ret
    8000573c:	00003517          	auipc	a0,0x3
    80005740:	bc450513          	addi	a0,a0,-1084 # 80008300 <CONSOLE_STATUS+0x2f0>
    80005744:	00001097          	auipc	ra,0x1
    80005748:	928080e7          	jalr	-1752(ra) # 8000606c <panic>

000000008000574c <either_copyin>:
    8000574c:	ff010113          	addi	sp,sp,-16
    80005750:	00813023          	sd	s0,0(sp)
    80005754:	00113423          	sd	ra,8(sp)
    80005758:	01010413          	addi	s0,sp,16
    8000575c:	02059463          	bnez	a1,80005784 <either_copyin+0x38>
    80005760:	00060593          	mv	a1,a2
    80005764:	0006861b          	sext.w	a2,a3
    80005768:	00002097          	auipc	ra,0x2
    8000576c:	c0c080e7          	jalr	-1012(ra) # 80007374 <__memmove>
    80005770:	00813083          	ld	ra,8(sp)
    80005774:	00013403          	ld	s0,0(sp)
    80005778:	00000513          	li	a0,0
    8000577c:	01010113          	addi	sp,sp,16
    80005780:	00008067          	ret
    80005784:	00003517          	auipc	a0,0x3
    80005788:	ba450513          	addi	a0,a0,-1116 # 80008328 <CONSOLE_STATUS+0x318>
    8000578c:	00001097          	auipc	ra,0x1
    80005790:	8e0080e7          	jalr	-1824(ra) # 8000606c <panic>

0000000080005794 <trapinit>:
    80005794:	ff010113          	addi	sp,sp,-16
    80005798:	00813423          	sd	s0,8(sp)
    8000579c:	01010413          	addi	s0,sp,16
    800057a0:	00813403          	ld	s0,8(sp)
    800057a4:	00003597          	auipc	a1,0x3
    800057a8:	bac58593          	addi	a1,a1,-1108 # 80008350 <CONSOLE_STATUS+0x340>
    800057ac:	00006517          	auipc	a0,0x6
    800057b0:	a4450513          	addi	a0,a0,-1468 # 8000b1f0 <tickslock>
    800057b4:	01010113          	addi	sp,sp,16
    800057b8:	00001317          	auipc	t1,0x1
    800057bc:	5c030067          	jr	1472(t1) # 80006d78 <initlock>

00000000800057c0 <trapinithart>:
    800057c0:	ff010113          	addi	sp,sp,-16
    800057c4:	00813423          	sd	s0,8(sp)
    800057c8:	01010413          	addi	s0,sp,16
    800057cc:	00000797          	auipc	a5,0x0
    800057d0:	2f478793          	addi	a5,a5,756 # 80005ac0 <kernelvec>
    800057d4:	10579073          	csrw	stvec,a5
    800057d8:	00813403          	ld	s0,8(sp)
    800057dc:	01010113          	addi	sp,sp,16
    800057e0:	00008067          	ret

00000000800057e4 <usertrap>:
    800057e4:	ff010113          	addi	sp,sp,-16
    800057e8:	00813423          	sd	s0,8(sp)
    800057ec:	01010413          	addi	s0,sp,16
    800057f0:	00813403          	ld	s0,8(sp)
    800057f4:	01010113          	addi	sp,sp,16
    800057f8:	00008067          	ret

00000000800057fc <usertrapret>:
    800057fc:	ff010113          	addi	sp,sp,-16
    80005800:	00813423          	sd	s0,8(sp)
    80005804:	01010413          	addi	s0,sp,16
    80005808:	00813403          	ld	s0,8(sp)
    8000580c:	01010113          	addi	sp,sp,16
    80005810:	00008067          	ret

0000000080005814 <kerneltrap>:
    80005814:	fe010113          	addi	sp,sp,-32
    80005818:	00813823          	sd	s0,16(sp)
    8000581c:	00113c23          	sd	ra,24(sp)
    80005820:	00913423          	sd	s1,8(sp)
    80005824:	02010413          	addi	s0,sp,32
    80005828:	142025f3          	csrr	a1,scause
    8000582c:	100027f3          	csrr	a5,sstatus
    80005830:	0027f793          	andi	a5,a5,2
    80005834:	10079c63          	bnez	a5,8000594c <kerneltrap+0x138>
    80005838:	142027f3          	csrr	a5,scause
    8000583c:	0207ce63          	bltz	a5,80005878 <kerneltrap+0x64>
    80005840:	00003517          	auipc	a0,0x3
    80005844:	b5850513          	addi	a0,a0,-1192 # 80008398 <CONSOLE_STATUS+0x388>
    80005848:	00001097          	auipc	ra,0x1
    8000584c:	880080e7          	jalr	-1920(ra) # 800060c8 <__printf>
    80005850:	141025f3          	csrr	a1,sepc
    80005854:	14302673          	csrr	a2,stval
    80005858:	00003517          	auipc	a0,0x3
    8000585c:	b5050513          	addi	a0,a0,-1200 # 800083a8 <CONSOLE_STATUS+0x398>
    80005860:	00001097          	auipc	ra,0x1
    80005864:	868080e7          	jalr	-1944(ra) # 800060c8 <__printf>
    80005868:	00003517          	auipc	a0,0x3
    8000586c:	b5850513          	addi	a0,a0,-1192 # 800083c0 <CONSOLE_STATUS+0x3b0>
    80005870:	00000097          	auipc	ra,0x0
    80005874:	7fc080e7          	jalr	2044(ra) # 8000606c <panic>
    80005878:	0ff7f713          	andi	a4,a5,255
    8000587c:	00900693          	li	a3,9
    80005880:	04d70063          	beq	a4,a3,800058c0 <kerneltrap+0xac>
    80005884:	fff00713          	li	a4,-1
    80005888:	03f71713          	slli	a4,a4,0x3f
    8000588c:	00170713          	addi	a4,a4,1
    80005890:	fae798e3          	bne	a5,a4,80005840 <kerneltrap+0x2c>
    80005894:	00000097          	auipc	ra,0x0
    80005898:	e00080e7          	jalr	-512(ra) # 80005694 <cpuid>
    8000589c:	06050663          	beqz	a0,80005908 <kerneltrap+0xf4>
    800058a0:	144027f3          	csrr	a5,sip
    800058a4:	ffd7f793          	andi	a5,a5,-3
    800058a8:	14479073          	csrw	sip,a5
    800058ac:	01813083          	ld	ra,24(sp)
    800058b0:	01013403          	ld	s0,16(sp)
    800058b4:	00813483          	ld	s1,8(sp)
    800058b8:	02010113          	addi	sp,sp,32
    800058bc:	00008067          	ret
    800058c0:	00000097          	auipc	ra,0x0
    800058c4:	3c4080e7          	jalr	964(ra) # 80005c84 <plic_claim>
    800058c8:	00a00793          	li	a5,10
    800058cc:	00050493          	mv	s1,a0
    800058d0:	06f50863          	beq	a0,a5,80005940 <kerneltrap+0x12c>
    800058d4:	fc050ce3          	beqz	a0,800058ac <kerneltrap+0x98>
    800058d8:	00050593          	mv	a1,a0
    800058dc:	00003517          	auipc	a0,0x3
    800058e0:	a9c50513          	addi	a0,a0,-1380 # 80008378 <CONSOLE_STATUS+0x368>
    800058e4:	00000097          	auipc	ra,0x0
    800058e8:	7e4080e7          	jalr	2020(ra) # 800060c8 <__printf>
    800058ec:	01013403          	ld	s0,16(sp)
    800058f0:	01813083          	ld	ra,24(sp)
    800058f4:	00048513          	mv	a0,s1
    800058f8:	00813483          	ld	s1,8(sp)
    800058fc:	02010113          	addi	sp,sp,32
    80005900:	00000317          	auipc	t1,0x0
    80005904:	3bc30067          	jr	956(t1) # 80005cbc <plic_complete>
    80005908:	00006517          	auipc	a0,0x6
    8000590c:	8e850513          	addi	a0,a0,-1816 # 8000b1f0 <tickslock>
    80005910:	00001097          	auipc	ra,0x1
    80005914:	48c080e7          	jalr	1164(ra) # 80006d9c <acquire>
    80005918:	00004717          	auipc	a4,0x4
    8000591c:	71c70713          	addi	a4,a4,1820 # 8000a034 <ticks>
    80005920:	00072783          	lw	a5,0(a4)
    80005924:	00006517          	auipc	a0,0x6
    80005928:	8cc50513          	addi	a0,a0,-1844 # 8000b1f0 <tickslock>
    8000592c:	0017879b          	addiw	a5,a5,1
    80005930:	00f72023          	sw	a5,0(a4)
    80005934:	00001097          	auipc	ra,0x1
    80005938:	534080e7          	jalr	1332(ra) # 80006e68 <release>
    8000593c:	f65ff06f          	j	800058a0 <kerneltrap+0x8c>
    80005940:	00001097          	auipc	ra,0x1
    80005944:	090080e7          	jalr	144(ra) # 800069d0 <uartintr>
    80005948:	fa5ff06f          	j	800058ec <kerneltrap+0xd8>
    8000594c:	00003517          	auipc	a0,0x3
    80005950:	a0c50513          	addi	a0,a0,-1524 # 80008358 <CONSOLE_STATUS+0x348>
    80005954:	00000097          	auipc	ra,0x0
    80005958:	718080e7          	jalr	1816(ra) # 8000606c <panic>

000000008000595c <clockintr>:
    8000595c:	fe010113          	addi	sp,sp,-32
    80005960:	00813823          	sd	s0,16(sp)
    80005964:	00913423          	sd	s1,8(sp)
    80005968:	00113c23          	sd	ra,24(sp)
    8000596c:	02010413          	addi	s0,sp,32
    80005970:	00006497          	auipc	s1,0x6
    80005974:	88048493          	addi	s1,s1,-1920 # 8000b1f0 <tickslock>
    80005978:	00048513          	mv	a0,s1
    8000597c:	00001097          	auipc	ra,0x1
    80005980:	420080e7          	jalr	1056(ra) # 80006d9c <acquire>
    80005984:	00004717          	auipc	a4,0x4
    80005988:	6b070713          	addi	a4,a4,1712 # 8000a034 <ticks>
    8000598c:	00072783          	lw	a5,0(a4)
    80005990:	01013403          	ld	s0,16(sp)
    80005994:	01813083          	ld	ra,24(sp)
    80005998:	00048513          	mv	a0,s1
    8000599c:	0017879b          	addiw	a5,a5,1
    800059a0:	00813483          	ld	s1,8(sp)
    800059a4:	00f72023          	sw	a5,0(a4)
    800059a8:	02010113          	addi	sp,sp,32
    800059ac:	00001317          	auipc	t1,0x1
    800059b0:	4bc30067          	jr	1212(t1) # 80006e68 <release>

00000000800059b4 <devintr>:
    800059b4:	142027f3          	csrr	a5,scause
    800059b8:	00000513          	li	a0,0
    800059bc:	0007c463          	bltz	a5,800059c4 <devintr+0x10>
    800059c0:	00008067          	ret
    800059c4:	fe010113          	addi	sp,sp,-32
    800059c8:	00813823          	sd	s0,16(sp)
    800059cc:	00113c23          	sd	ra,24(sp)
    800059d0:	00913423          	sd	s1,8(sp)
    800059d4:	02010413          	addi	s0,sp,32
    800059d8:	0ff7f713          	andi	a4,a5,255
    800059dc:	00900693          	li	a3,9
    800059e0:	04d70c63          	beq	a4,a3,80005a38 <devintr+0x84>
    800059e4:	fff00713          	li	a4,-1
    800059e8:	03f71713          	slli	a4,a4,0x3f
    800059ec:	00170713          	addi	a4,a4,1
    800059f0:	00e78c63          	beq	a5,a4,80005a08 <devintr+0x54>
    800059f4:	01813083          	ld	ra,24(sp)
    800059f8:	01013403          	ld	s0,16(sp)
    800059fc:	00813483          	ld	s1,8(sp)
    80005a00:	02010113          	addi	sp,sp,32
    80005a04:	00008067          	ret
    80005a08:	00000097          	auipc	ra,0x0
    80005a0c:	c8c080e7          	jalr	-884(ra) # 80005694 <cpuid>
    80005a10:	06050663          	beqz	a0,80005a7c <devintr+0xc8>
    80005a14:	144027f3          	csrr	a5,sip
    80005a18:	ffd7f793          	andi	a5,a5,-3
    80005a1c:	14479073          	csrw	sip,a5
    80005a20:	01813083          	ld	ra,24(sp)
    80005a24:	01013403          	ld	s0,16(sp)
    80005a28:	00813483          	ld	s1,8(sp)
    80005a2c:	00200513          	li	a0,2
    80005a30:	02010113          	addi	sp,sp,32
    80005a34:	00008067          	ret
    80005a38:	00000097          	auipc	ra,0x0
    80005a3c:	24c080e7          	jalr	588(ra) # 80005c84 <plic_claim>
    80005a40:	00a00793          	li	a5,10
    80005a44:	00050493          	mv	s1,a0
    80005a48:	06f50663          	beq	a0,a5,80005ab4 <devintr+0x100>
    80005a4c:	00100513          	li	a0,1
    80005a50:	fa0482e3          	beqz	s1,800059f4 <devintr+0x40>
    80005a54:	00048593          	mv	a1,s1
    80005a58:	00003517          	auipc	a0,0x3
    80005a5c:	92050513          	addi	a0,a0,-1760 # 80008378 <CONSOLE_STATUS+0x368>
    80005a60:	00000097          	auipc	ra,0x0
    80005a64:	668080e7          	jalr	1640(ra) # 800060c8 <__printf>
    80005a68:	00048513          	mv	a0,s1
    80005a6c:	00000097          	auipc	ra,0x0
    80005a70:	250080e7          	jalr	592(ra) # 80005cbc <plic_complete>
    80005a74:	00100513          	li	a0,1
    80005a78:	f7dff06f          	j	800059f4 <devintr+0x40>
    80005a7c:	00005517          	auipc	a0,0x5
    80005a80:	77450513          	addi	a0,a0,1908 # 8000b1f0 <tickslock>
    80005a84:	00001097          	auipc	ra,0x1
    80005a88:	318080e7          	jalr	792(ra) # 80006d9c <acquire>
    80005a8c:	00004717          	auipc	a4,0x4
    80005a90:	5a870713          	addi	a4,a4,1448 # 8000a034 <ticks>
    80005a94:	00072783          	lw	a5,0(a4)
    80005a98:	00005517          	auipc	a0,0x5
    80005a9c:	75850513          	addi	a0,a0,1880 # 8000b1f0 <tickslock>
    80005aa0:	0017879b          	addiw	a5,a5,1
    80005aa4:	00f72023          	sw	a5,0(a4)
    80005aa8:	00001097          	auipc	ra,0x1
    80005aac:	3c0080e7          	jalr	960(ra) # 80006e68 <release>
    80005ab0:	f65ff06f          	j	80005a14 <devintr+0x60>
    80005ab4:	00001097          	auipc	ra,0x1
    80005ab8:	f1c080e7          	jalr	-228(ra) # 800069d0 <uartintr>
    80005abc:	fadff06f          	j	80005a68 <devintr+0xb4>

0000000080005ac0 <kernelvec>:
    80005ac0:	f0010113          	addi	sp,sp,-256
    80005ac4:	00113023          	sd	ra,0(sp)
    80005ac8:	00213423          	sd	sp,8(sp)
    80005acc:	00313823          	sd	gp,16(sp)
    80005ad0:	00413c23          	sd	tp,24(sp)
    80005ad4:	02513023          	sd	t0,32(sp)
    80005ad8:	02613423          	sd	t1,40(sp)
    80005adc:	02713823          	sd	t2,48(sp)
    80005ae0:	02813c23          	sd	s0,56(sp)
    80005ae4:	04913023          	sd	s1,64(sp)
    80005ae8:	04a13423          	sd	a0,72(sp)
    80005aec:	04b13823          	sd	a1,80(sp)
    80005af0:	04c13c23          	sd	a2,88(sp)
    80005af4:	06d13023          	sd	a3,96(sp)
    80005af8:	06e13423          	sd	a4,104(sp)
    80005afc:	06f13823          	sd	a5,112(sp)
    80005b00:	07013c23          	sd	a6,120(sp)
    80005b04:	09113023          	sd	a7,128(sp)
    80005b08:	09213423          	sd	s2,136(sp)
    80005b0c:	09313823          	sd	s3,144(sp)
    80005b10:	09413c23          	sd	s4,152(sp)
    80005b14:	0b513023          	sd	s5,160(sp)
    80005b18:	0b613423          	sd	s6,168(sp)
    80005b1c:	0b713823          	sd	s7,176(sp)
    80005b20:	0b813c23          	sd	s8,184(sp)
    80005b24:	0d913023          	sd	s9,192(sp)
    80005b28:	0da13423          	sd	s10,200(sp)
    80005b2c:	0db13823          	sd	s11,208(sp)
    80005b30:	0dc13c23          	sd	t3,216(sp)
    80005b34:	0fd13023          	sd	t4,224(sp)
    80005b38:	0fe13423          	sd	t5,232(sp)
    80005b3c:	0ff13823          	sd	t6,240(sp)
    80005b40:	cd5ff0ef          	jal	ra,80005814 <kerneltrap>
    80005b44:	00013083          	ld	ra,0(sp)
    80005b48:	00813103          	ld	sp,8(sp)
    80005b4c:	01013183          	ld	gp,16(sp)
    80005b50:	02013283          	ld	t0,32(sp)
    80005b54:	02813303          	ld	t1,40(sp)
    80005b58:	03013383          	ld	t2,48(sp)
    80005b5c:	03813403          	ld	s0,56(sp)
    80005b60:	04013483          	ld	s1,64(sp)
    80005b64:	04813503          	ld	a0,72(sp)
    80005b68:	05013583          	ld	a1,80(sp)
    80005b6c:	05813603          	ld	a2,88(sp)
    80005b70:	06013683          	ld	a3,96(sp)
    80005b74:	06813703          	ld	a4,104(sp)
    80005b78:	07013783          	ld	a5,112(sp)
    80005b7c:	07813803          	ld	a6,120(sp)
    80005b80:	08013883          	ld	a7,128(sp)
    80005b84:	08813903          	ld	s2,136(sp)
    80005b88:	09013983          	ld	s3,144(sp)
    80005b8c:	09813a03          	ld	s4,152(sp)
    80005b90:	0a013a83          	ld	s5,160(sp)
    80005b94:	0a813b03          	ld	s6,168(sp)
    80005b98:	0b013b83          	ld	s7,176(sp)
    80005b9c:	0b813c03          	ld	s8,184(sp)
    80005ba0:	0c013c83          	ld	s9,192(sp)
    80005ba4:	0c813d03          	ld	s10,200(sp)
    80005ba8:	0d013d83          	ld	s11,208(sp)
    80005bac:	0d813e03          	ld	t3,216(sp)
    80005bb0:	0e013e83          	ld	t4,224(sp)
    80005bb4:	0e813f03          	ld	t5,232(sp)
    80005bb8:	0f013f83          	ld	t6,240(sp)
    80005bbc:	10010113          	addi	sp,sp,256
    80005bc0:	10200073          	sret
    80005bc4:	00000013          	nop
    80005bc8:	00000013          	nop
    80005bcc:	00000013          	nop

0000000080005bd0 <timervec>:
    80005bd0:	34051573          	csrrw	a0,mscratch,a0
    80005bd4:	00b53023          	sd	a1,0(a0)
    80005bd8:	00c53423          	sd	a2,8(a0)
    80005bdc:	00d53823          	sd	a3,16(a0)
    80005be0:	01853583          	ld	a1,24(a0)
    80005be4:	02053603          	ld	a2,32(a0)
    80005be8:	0005b683          	ld	a3,0(a1)
    80005bec:	00c686b3          	add	a3,a3,a2
    80005bf0:	00d5b023          	sd	a3,0(a1)
    80005bf4:	00200593          	li	a1,2
    80005bf8:	14459073          	csrw	sip,a1
    80005bfc:	01053683          	ld	a3,16(a0)
    80005c00:	00853603          	ld	a2,8(a0)
    80005c04:	00053583          	ld	a1,0(a0)
    80005c08:	34051573          	csrrw	a0,mscratch,a0
    80005c0c:	30200073          	mret

0000000080005c10 <plicinit>:
    80005c10:	ff010113          	addi	sp,sp,-16
    80005c14:	00813423          	sd	s0,8(sp)
    80005c18:	01010413          	addi	s0,sp,16
    80005c1c:	00813403          	ld	s0,8(sp)
    80005c20:	0c0007b7          	lui	a5,0xc000
    80005c24:	00100713          	li	a4,1
    80005c28:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80005c2c:	00e7a223          	sw	a4,4(a5)
    80005c30:	01010113          	addi	sp,sp,16
    80005c34:	00008067          	ret

0000000080005c38 <plicinithart>:
    80005c38:	ff010113          	addi	sp,sp,-16
    80005c3c:	00813023          	sd	s0,0(sp)
    80005c40:	00113423          	sd	ra,8(sp)
    80005c44:	01010413          	addi	s0,sp,16
    80005c48:	00000097          	auipc	ra,0x0
    80005c4c:	a4c080e7          	jalr	-1460(ra) # 80005694 <cpuid>
    80005c50:	0085171b          	slliw	a4,a0,0x8
    80005c54:	0c0027b7          	lui	a5,0xc002
    80005c58:	00e787b3          	add	a5,a5,a4
    80005c5c:	40200713          	li	a4,1026
    80005c60:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80005c64:	00813083          	ld	ra,8(sp)
    80005c68:	00013403          	ld	s0,0(sp)
    80005c6c:	00d5151b          	slliw	a0,a0,0xd
    80005c70:	0c2017b7          	lui	a5,0xc201
    80005c74:	00a78533          	add	a0,a5,a0
    80005c78:	00052023          	sw	zero,0(a0)
    80005c7c:	01010113          	addi	sp,sp,16
    80005c80:	00008067          	ret

0000000080005c84 <plic_claim>:
    80005c84:	ff010113          	addi	sp,sp,-16
    80005c88:	00813023          	sd	s0,0(sp)
    80005c8c:	00113423          	sd	ra,8(sp)
    80005c90:	01010413          	addi	s0,sp,16
    80005c94:	00000097          	auipc	ra,0x0
    80005c98:	a00080e7          	jalr	-1536(ra) # 80005694 <cpuid>
    80005c9c:	00813083          	ld	ra,8(sp)
    80005ca0:	00013403          	ld	s0,0(sp)
    80005ca4:	00d5151b          	slliw	a0,a0,0xd
    80005ca8:	0c2017b7          	lui	a5,0xc201
    80005cac:	00a78533          	add	a0,a5,a0
    80005cb0:	00452503          	lw	a0,4(a0)
    80005cb4:	01010113          	addi	sp,sp,16
    80005cb8:	00008067          	ret

0000000080005cbc <plic_complete>:
    80005cbc:	fe010113          	addi	sp,sp,-32
    80005cc0:	00813823          	sd	s0,16(sp)
    80005cc4:	00913423          	sd	s1,8(sp)
    80005cc8:	00113c23          	sd	ra,24(sp)
    80005ccc:	02010413          	addi	s0,sp,32
    80005cd0:	00050493          	mv	s1,a0
    80005cd4:	00000097          	auipc	ra,0x0
    80005cd8:	9c0080e7          	jalr	-1600(ra) # 80005694 <cpuid>
    80005cdc:	01813083          	ld	ra,24(sp)
    80005ce0:	01013403          	ld	s0,16(sp)
    80005ce4:	00d5179b          	slliw	a5,a0,0xd
    80005ce8:	0c201737          	lui	a4,0xc201
    80005cec:	00f707b3          	add	a5,a4,a5
    80005cf0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80005cf4:	00813483          	ld	s1,8(sp)
    80005cf8:	02010113          	addi	sp,sp,32
    80005cfc:	00008067          	ret

0000000080005d00 <consolewrite>:
    80005d00:	fb010113          	addi	sp,sp,-80
    80005d04:	04813023          	sd	s0,64(sp)
    80005d08:	04113423          	sd	ra,72(sp)
    80005d0c:	02913c23          	sd	s1,56(sp)
    80005d10:	03213823          	sd	s2,48(sp)
    80005d14:	03313423          	sd	s3,40(sp)
    80005d18:	03413023          	sd	s4,32(sp)
    80005d1c:	01513c23          	sd	s5,24(sp)
    80005d20:	05010413          	addi	s0,sp,80
    80005d24:	06c05c63          	blez	a2,80005d9c <consolewrite+0x9c>
    80005d28:	00060993          	mv	s3,a2
    80005d2c:	00050a13          	mv	s4,a0
    80005d30:	00058493          	mv	s1,a1
    80005d34:	00000913          	li	s2,0
    80005d38:	fff00a93          	li	s5,-1
    80005d3c:	01c0006f          	j	80005d58 <consolewrite+0x58>
    80005d40:	fbf44503          	lbu	a0,-65(s0)
    80005d44:	0019091b          	addiw	s2,s2,1
    80005d48:	00148493          	addi	s1,s1,1
    80005d4c:	00001097          	auipc	ra,0x1
    80005d50:	a9c080e7          	jalr	-1380(ra) # 800067e8 <uartputc>
    80005d54:	03298063          	beq	s3,s2,80005d74 <consolewrite+0x74>
    80005d58:	00048613          	mv	a2,s1
    80005d5c:	00100693          	li	a3,1
    80005d60:	000a0593          	mv	a1,s4
    80005d64:	fbf40513          	addi	a0,s0,-65
    80005d68:	00000097          	auipc	ra,0x0
    80005d6c:	9e4080e7          	jalr	-1564(ra) # 8000574c <either_copyin>
    80005d70:	fd5518e3          	bne	a0,s5,80005d40 <consolewrite+0x40>
    80005d74:	04813083          	ld	ra,72(sp)
    80005d78:	04013403          	ld	s0,64(sp)
    80005d7c:	03813483          	ld	s1,56(sp)
    80005d80:	02813983          	ld	s3,40(sp)
    80005d84:	02013a03          	ld	s4,32(sp)
    80005d88:	01813a83          	ld	s5,24(sp)
    80005d8c:	00090513          	mv	a0,s2
    80005d90:	03013903          	ld	s2,48(sp)
    80005d94:	05010113          	addi	sp,sp,80
    80005d98:	00008067          	ret
    80005d9c:	00000913          	li	s2,0
    80005da0:	fd5ff06f          	j	80005d74 <consolewrite+0x74>

0000000080005da4 <consoleread>:
    80005da4:	f9010113          	addi	sp,sp,-112
    80005da8:	06813023          	sd	s0,96(sp)
    80005dac:	04913c23          	sd	s1,88(sp)
    80005db0:	05213823          	sd	s2,80(sp)
    80005db4:	05313423          	sd	s3,72(sp)
    80005db8:	05413023          	sd	s4,64(sp)
    80005dbc:	03513c23          	sd	s5,56(sp)
    80005dc0:	03613823          	sd	s6,48(sp)
    80005dc4:	03713423          	sd	s7,40(sp)
    80005dc8:	03813023          	sd	s8,32(sp)
    80005dcc:	06113423          	sd	ra,104(sp)
    80005dd0:	01913c23          	sd	s9,24(sp)
    80005dd4:	07010413          	addi	s0,sp,112
    80005dd8:	00060b93          	mv	s7,a2
    80005ddc:	00050913          	mv	s2,a0
    80005de0:	00058c13          	mv	s8,a1
    80005de4:	00060b1b          	sext.w	s6,a2
    80005de8:	00005497          	auipc	s1,0x5
    80005dec:	43048493          	addi	s1,s1,1072 # 8000b218 <cons>
    80005df0:	00400993          	li	s3,4
    80005df4:	fff00a13          	li	s4,-1
    80005df8:	00a00a93          	li	s5,10
    80005dfc:	05705e63          	blez	s7,80005e58 <consoleread+0xb4>
    80005e00:	09c4a703          	lw	a4,156(s1)
    80005e04:	0984a783          	lw	a5,152(s1)
    80005e08:	0007071b          	sext.w	a4,a4
    80005e0c:	08e78463          	beq	a5,a4,80005e94 <consoleread+0xf0>
    80005e10:	07f7f713          	andi	a4,a5,127
    80005e14:	00e48733          	add	a4,s1,a4
    80005e18:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80005e1c:	0017869b          	addiw	a3,a5,1
    80005e20:	08d4ac23          	sw	a3,152(s1)
    80005e24:	00070c9b          	sext.w	s9,a4
    80005e28:	0b370663          	beq	a4,s3,80005ed4 <consoleread+0x130>
    80005e2c:	00100693          	li	a3,1
    80005e30:	f9f40613          	addi	a2,s0,-97
    80005e34:	000c0593          	mv	a1,s8
    80005e38:	00090513          	mv	a0,s2
    80005e3c:	f8e40fa3          	sb	a4,-97(s0)
    80005e40:	00000097          	auipc	ra,0x0
    80005e44:	8c0080e7          	jalr	-1856(ra) # 80005700 <either_copyout>
    80005e48:	01450863          	beq	a0,s4,80005e58 <consoleread+0xb4>
    80005e4c:	001c0c13          	addi	s8,s8,1
    80005e50:	fffb8b9b          	addiw	s7,s7,-1
    80005e54:	fb5c94e3          	bne	s9,s5,80005dfc <consoleread+0x58>
    80005e58:	000b851b          	sext.w	a0,s7
    80005e5c:	06813083          	ld	ra,104(sp)
    80005e60:	06013403          	ld	s0,96(sp)
    80005e64:	05813483          	ld	s1,88(sp)
    80005e68:	05013903          	ld	s2,80(sp)
    80005e6c:	04813983          	ld	s3,72(sp)
    80005e70:	04013a03          	ld	s4,64(sp)
    80005e74:	03813a83          	ld	s5,56(sp)
    80005e78:	02813b83          	ld	s7,40(sp)
    80005e7c:	02013c03          	ld	s8,32(sp)
    80005e80:	01813c83          	ld	s9,24(sp)
    80005e84:	40ab053b          	subw	a0,s6,a0
    80005e88:	03013b03          	ld	s6,48(sp)
    80005e8c:	07010113          	addi	sp,sp,112
    80005e90:	00008067          	ret
    80005e94:	00001097          	auipc	ra,0x1
    80005e98:	1d8080e7          	jalr	472(ra) # 8000706c <push_on>
    80005e9c:	0984a703          	lw	a4,152(s1)
    80005ea0:	09c4a783          	lw	a5,156(s1)
    80005ea4:	0007879b          	sext.w	a5,a5
    80005ea8:	fef70ce3          	beq	a4,a5,80005ea0 <consoleread+0xfc>
    80005eac:	00001097          	auipc	ra,0x1
    80005eb0:	234080e7          	jalr	564(ra) # 800070e0 <pop_on>
    80005eb4:	0984a783          	lw	a5,152(s1)
    80005eb8:	07f7f713          	andi	a4,a5,127
    80005ebc:	00e48733          	add	a4,s1,a4
    80005ec0:	01874703          	lbu	a4,24(a4)
    80005ec4:	0017869b          	addiw	a3,a5,1
    80005ec8:	08d4ac23          	sw	a3,152(s1)
    80005ecc:	00070c9b          	sext.w	s9,a4
    80005ed0:	f5371ee3          	bne	a4,s3,80005e2c <consoleread+0x88>
    80005ed4:	000b851b          	sext.w	a0,s7
    80005ed8:	f96bf2e3          	bgeu	s7,s6,80005e5c <consoleread+0xb8>
    80005edc:	08f4ac23          	sw	a5,152(s1)
    80005ee0:	f7dff06f          	j	80005e5c <consoleread+0xb8>

0000000080005ee4 <consputc>:
    80005ee4:	10000793          	li	a5,256
    80005ee8:	00f50663          	beq	a0,a5,80005ef4 <consputc+0x10>
    80005eec:	00001317          	auipc	t1,0x1
    80005ef0:	9f430067          	jr	-1548(t1) # 800068e0 <uartputc_sync>
    80005ef4:	ff010113          	addi	sp,sp,-16
    80005ef8:	00113423          	sd	ra,8(sp)
    80005efc:	00813023          	sd	s0,0(sp)
    80005f00:	01010413          	addi	s0,sp,16
    80005f04:	00800513          	li	a0,8
    80005f08:	00001097          	auipc	ra,0x1
    80005f0c:	9d8080e7          	jalr	-1576(ra) # 800068e0 <uartputc_sync>
    80005f10:	02000513          	li	a0,32
    80005f14:	00001097          	auipc	ra,0x1
    80005f18:	9cc080e7          	jalr	-1588(ra) # 800068e0 <uartputc_sync>
    80005f1c:	00013403          	ld	s0,0(sp)
    80005f20:	00813083          	ld	ra,8(sp)
    80005f24:	00800513          	li	a0,8
    80005f28:	01010113          	addi	sp,sp,16
    80005f2c:	00001317          	auipc	t1,0x1
    80005f30:	9b430067          	jr	-1612(t1) # 800068e0 <uartputc_sync>

0000000080005f34 <consoleintr>:
    80005f34:	fe010113          	addi	sp,sp,-32
    80005f38:	00813823          	sd	s0,16(sp)
    80005f3c:	00913423          	sd	s1,8(sp)
    80005f40:	01213023          	sd	s2,0(sp)
    80005f44:	00113c23          	sd	ra,24(sp)
    80005f48:	02010413          	addi	s0,sp,32
    80005f4c:	00005917          	auipc	s2,0x5
    80005f50:	2cc90913          	addi	s2,s2,716 # 8000b218 <cons>
    80005f54:	00050493          	mv	s1,a0
    80005f58:	00090513          	mv	a0,s2
    80005f5c:	00001097          	auipc	ra,0x1
    80005f60:	e40080e7          	jalr	-448(ra) # 80006d9c <acquire>
    80005f64:	02048c63          	beqz	s1,80005f9c <consoleintr+0x68>
    80005f68:	0a092783          	lw	a5,160(s2)
    80005f6c:	09892703          	lw	a4,152(s2)
    80005f70:	07f00693          	li	a3,127
    80005f74:	40e7873b          	subw	a4,a5,a4
    80005f78:	02e6e263          	bltu	a3,a4,80005f9c <consoleintr+0x68>
    80005f7c:	00d00713          	li	a4,13
    80005f80:	04e48063          	beq	s1,a4,80005fc0 <consoleintr+0x8c>
    80005f84:	07f7f713          	andi	a4,a5,127
    80005f88:	00e90733          	add	a4,s2,a4
    80005f8c:	0017879b          	addiw	a5,a5,1
    80005f90:	0af92023          	sw	a5,160(s2)
    80005f94:	00970c23          	sb	s1,24(a4)
    80005f98:	08f92e23          	sw	a5,156(s2)
    80005f9c:	01013403          	ld	s0,16(sp)
    80005fa0:	01813083          	ld	ra,24(sp)
    80005fa4:	00813483          	ld	s1,8(sp)
    80005fa8:	00013903          	ld	s2,0(sp)
    80005fac:	00005517          	auipc	a0,0x5
    80005fb0:	26c50513          	addi	a0,a0,620 # 8000b218 <cons>
    80005fb4:	02010113          	addi	sp,sp,32
    80005fb8:	00001317          	auipc	t1,0x1
    80005fbc:	eb030067          	jr	-336(t1) # 80006e68 <release>
    80005fc0:	00a00493          	li	s1,10
    80005fc4:	fc1ff06f          	j	80005f84 <consoleintr+0x50>

0000000080005fc8 <consoleinit>:
    80005fc8:	fe010113          	addi	sp,sp,-32
    80005fcc:	00113c23          	sd	ra,24(sp)
    80005fd0:	00813823          	sd	s0,16(sp)
    80005fd4:	00913423          	sd	s1,8(sp)
    80005fd8:	02010413          	addi	s0,sp,32
    80005fdc:	00005497          	auipc	s1,0x5
    80005fe0:	23c48493          	addi	s1,s1,572 # 8000b218 <cons>
    80005fe4:	00048513          	mv	a0,s1
    80005fe8:	00002597          	auipc	a1,0x2
    80005fec:	3e858593          	addi	a1,a1,1000 # 800083d0 <CONSOLE_STATUS+0x3c0>
    80005ff0:	00001097          	auipc	ra,0x1
    80005ff4:	d88080e7          	jalr	-632(ra) # 80006d78 <initlock>
    80005ff8:	00000097          	auipc	ra,0x0
    80005ffc:	7ac080e7          	jalr	1964(ra) # 800067a4 <uartinit>
    80006000:	01813083          	ld	ra,24(sp)
    80006004:	01013403          	ld	s0,16(sp)
    80006008:	00000797          	auipc	a5,0x0
    8000600c:	d9c78793          	addi	a5,a5,-612 # 80005da4 <consoleread>
    80006010:	0af4bc23          	sd	a5,184(s1)
    80006014:	00000797          	auipc	a5,0x0
    80006018:	cec78793          	addi	a5,a5,-788 # 80005d00 <consolewrite>
    8000601c:	0cf4b023          	sd	a5,192(s1)
    80006020:	00813483          	ld	s1,8(sp)
    80006024:	02010113          	addi	sp,sp,32
    80006028:	00008067          	ret

000000008000602c <console_read>:
    8000602c:	ff010113          	addi	sp,sp,-16
    80006030:	00813423          	sd	s0,8(sp)
    80006034:	01010413          	addi	s0,sp,16
    80006038:	00813403          	ld	s0,8(sp)
    8000603c:	00005317          	auipc	t1,0x5
    80006040:	29433303          	ld	t1,660(t1) # 8000b2d0 <devsw+0x10>
    80006044:	01010113          	addi	sp,sp,16
    80006048:	00030067          	jr	t1

000000008000604c <console_write>:
    8000604c:	ff010113          	addi	sp,sp,-16
    80006050:	00813423          	sd	s0,8(sp)
    80006054:	01010413          	addi	s0,sp,16
    80006058:	00813403          	ld	s0,8(sp)
    8000605c:	00005317          	auipc	t1,0x5
    80006060:	27c33303          	ld	t1,636(t1) # 8000b2d8 <devsw+0x18>
    80006064:	01010113          	addi	sp,sp,16
    80006068:	00030067          	jr	t1

000000008000606c <panic>:
    8000606c:	fe010113          	addi	sp,sp,-32
    80006070:	00113c23          	sd	ra,24(sp)
    80006074:	00813823          	sd	s0,16(sp)
    80006078:	00913423          	sd	s1,8(sp)
    8000607c:	02010413          	addi	s0,sp,32
    80006080:	00050493          	mv	s1,a0
    80006084:	00002517          	auipc	a0,0x2
    80006088:	35450513          	addi	a0,a0,852 # 800083d8 <CONSOLE_STATUS+0x3c8>
    8000608c:	00005797          	auipc	a5,0x5
    80006090:	2e07a623          	sw	zero,748(a5) # 8000b378 <pr+0x18>
    80006094:	00000097          	auipc	ra,0x0
    80006098:	034080e7          	jalr	52(ra) # 800060c8 <__printf>
    8000609c:	00048513          	mv	a0,s1
    800060a0:	00000097          	auipc	ra,0x0
    800060a4:	028080e7          	jalr	40(ra) # 800060c8 <__printf>
    800060a8:	00002517          	auipc	a0,0x2
    800060ac:	31050513          	addi	a0,a0,784 # 800083b8 <CONSOLE_STATUS+0x3a8>
    800060b0:	00000097          	auipc	ra,0x0
    800060b4:	018080e7          	jalr	24(ra) # 800060c8 <__printf>
    800060b8:	00100793          	li	a5,1
    800060bc:	00004717          	auipc	a4,0x4
    800060c0:	f6f72e23          	sw	a5,-132(a4) # 8000a038 <panicked>
    800060c4:	0000006f          	j	800060c4 <panic+0x58>

00000000800060c8 <__printf>:
    800060c8:	f3010113          	addi	sp,sp,-208
    800060cc:	08813023          	sd	s0,128(sp)
    800060d0:	07313423          	sd	s3,104(sp)
    800060d4:	09010413          	addi	s0,sp,144
    800060d8:	05813023          	sd	s8,64(sp)
    800060dc:	08113423          	sd	ra,136(sp)
    800060e0:	06913c23          	sd	s1,120(sp)
    800060e4:	07213823          	sd	s2,112(sp)
    800060e8:	07413023          	sd	s4,96(sp)
    800060ec:	05513c23          	sd	s5,88(sp)
    800060f0:	05613823          	sd	s6,80(sp)
    800060f4:	05713423          	sd	s7,72(sp)
    800060f8:	03913c23          	sd	s9,56(sp)
    800060fc:	03a13823          	sd	s10,48(sp)
    80006100:	03b13423          	sd	s11,40(sp)
    80006104:	00005317          	auipc	t1,0x5
    80006108:	25c30313          	addi	t1,t1,604 # 8000b360 <pr>
    8000610c:	01832c03          	lw	s8,24(t1)
    80006110:	00b43423          	sd	a1,8(s0)
    80006114:	00c43823          	sd	a2,16(s0)
    80006118:	00d43c23          	sd	a3,24(s0)
    8000611c:	02e43023          	sd	a4,32(s0)
    80006120:	02f43423          	sd	a5,40(s0)
    80006124:	03043823          	sd	a6,48(s0)
    80006128:	03143c23          	sd	a7,56(s0)
    8000612c:	00050993          	mv	s3,a0
    80006130:	4a0c1663          	bnez	s8,800065dc <__printf+0x514>
    80006134:	60098c63          	beqz	s3,8000674c <__printf+0x684>
    80006138:	0009c503          	lbu	a0,0(s3)
    8000613c:	00840793          	addi	a5,s0,8
    80006140:	f6f43c23          	sd	a5,-136(s0)
    80006144:	00000493          	li	s1,0
    80006148:	22050063          	beqz	a0,80006368 <__printf+0x2a0>
    8000614c:	00002a37          	lui	s4,0x2
    80006150:	00018ab7          	lui	s5,0x18
    80006154:	000f4b37          	lui	s6,0xf4
    80006158:	00989bb7          	lui	s7,0x989
    8000615c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80006160:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80006164:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80006168:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000616c:	00148c9b          	addiw	s9,s1,1
    80006170:	02500793          	li	a5,37
    80006174:	01998933          	add	s2,s3,s9
    80006178:	38f51263          	bne	a0,a5,800064fc <__printf+0x434>
    8000617c:	00094783          	lbu	a5,0(s2)
    80006180:	00078c9b          	sext.w	s9,a5
    80006184:	1e078263          	beqz	a5,80006368 <__printf+0x2a0>
    80006188:	0024849b          	addiw	s1,s1,2
    8000618c:	07000713          	li	a4,112
    80006190:	00998933          	add	s2,s3,s1
    80006194:	38e78a63          	beq	a5,a4,80006528 <__printf+0x460>
    80006198:	20f76863          	bltu	a4,a5,800063a8 <__printf+0x2e0>
    8000619c:	42a78863          	beq	a5,a0,800065cc <__printf+0x504>
    800061a0:	06400713          	li	a4,100
    800061a4:	40e79663          	bne	a5,a4,800065b0 <__printf+0x4e8>
    800061a8:	f7843783          	ld	a5,-136(s0)
    800061ac:	0007a603          	lw	a2,0(a5)
    800061b0:	00878793          	addi	a5,a5,8
    800061b4:	f6f43c23          	sd	a5,-136(s0)
    800061b8:	42064a63          	bltz	a2,800065ec <__printf+0x524>
    800061bc:	00a00713          	li	a4,10
    800061c0:	02e677bb          	remuw	a5,a2,a4
    800061c4:	00002d97          	auipc	s11,0x2
    800061c8:	23cd8d93          	addi	s11,s11,572 # 80008400 <digits>
    800061cc:	00900593          	li	a1,9
    800061d0:	0006051b          	sext.w	a0,a2
    800061d4:	00000c93          	li	s9,0
    800061d8:	02079793          	slli	a5,a5,0x20
    800061dc:	0207d793          	srli	a5,a5,0x20
    800061e0:	00fd87b3          	add	a5,s11,a5
    800061e4:	0007c783          	lbu	a5,0(a5)
    800061e8:	02e656bb          	divuw	a3,a2,a4
    800061ec:	f8f40023          	sb	a5,-128(s0)
    800061f0:	14c5d863          	bge	a1,a2,80006340 <__printf+0x278>
    800061f4:	06300593          	li	a1,99
    800061f8:	00100c93          	li	s9,1
    800061fc:	02e6f7bb          	remuw	a5,a3,a4
    80006200:	02079793          	slli	a5,a5,0x20
    80006204:	0207d793          	srli	a5,a5,0x20
    80006208:	00fd87b3          	add	a5,s11,a5
    8000620c:	0007c783          	lbu	a5,0(a5)
    80006210:	02e6d73b          	divuw	a4,a3,a4
    80006214:	f8f400a3          	sb	a5,-127(s0)
    80006218:	12a5f463          	bgeu	a1,a0,80006340 <__printf+0x278>
    8000621c:	00a00693          	li	a3,10
    80006220:	00900593          	li	a1,9
    80006224:	02d777bb          	remuw	a5,a4,a3
    80006228:	02079793          	slli	a5,a5,0x20
    8000622c:	0207d793          	srli	a5,a5,0x20
    80006230:	00fd87b3          	add	a5,s11,a5
    80006234:	0007c503          	lbu	a0,0(a5)
    80006238:	02d757bb          	divuw	a5,a4,a3
    8000623c:	f8a40123          	sb	a0,-126(s0)
    80006240:	48e5f263          	bgeu	a1,a4,800066c4 <__printf+0x5fc>
    80006244:	06300513          	li	a0,99
    80006248:	02d7f5bb          	remuw	a1,a5,a3
    8000624c:	02059593          	slli	a1,a1,0x20
    80006250:	0205d593          	srli	a1,a1,0x20
    80006254:	00bd85b3          	add	a1,s11,a1
    80006258:	0005c583          	lbu	a1,0(a1)
    8000625c:	02d7d7bb          	divuw	a5,a5,a3
    80006260:	f8b401a3          	sb	a1,-125(s0)
    80006264:	48e57263          	bgeu	a0,a4,800066e8 <__printf+0x620>
    80006268:	3e700513          	li	a0,999
    8000626c:	02d7f5bb          	remuw	a1,a5,a3
    80006270:	02059593          	slli	a1,a1,0x20
    80006274:	0205d593          	srli	a1,a1,0x20
    80006278:	00bd85b3          	add	a1,s11,a1
    8000627c:	0005c583          	lbu	a1,0(a1)
    80006280:	02d7d7bb          	divuw	a5,a5,a3
    80006284:	f8b40223          	sb	a1,-124(s0)
    80006288:	46e57663          	bgeu	a0,a4,800066f4 <__printf+0x62c>
    8000628c:	02d7f5bb          	remuw	a1,a5,a3
    80006290:	02059593          	slli	a1,a1,0x20
    80006294:	0205d593          	srli	a1,a1,0x20
    80006298:	00bd85b3          	add	a1,s11,a1
    8000629c:	0005c583          	lbu	a1,0(a1)
    800062a0:	02d7d7bb          	divuw	a5,a5,a3
    800062a4:	f8b402a3          	sb	a1,-123(s0)
    800062a8:	46ea7863          	bgeu	s4,a4,80006718 <__printf+0x650>
    800062ac:	02d7f5bb          	remuw	a1,a5,a3
    800062b0:	02059593          	slli	a1,a1,0x20
    800062b4:	0205d593          	srli	a1,a1,0x20
    800062b8:	00bd85b3          	add	a1,s11,a1
    800062bc:	0005c583          	lbu	a1,0(a1)
    800062c0:	02d7d7bb          	divuw	a5,a5,a3
    800062c4:	f8b40323          	sb	a1,-122(s0)
    800062c8:	3eeaf863          	bgeu	s5,a4,800066b8 <__printf+0x5f0>
    800062cc:	02d7f5bb          	remuw	a1,a5,a3
    800062d0:	02059593          	slli	a1,a1,0x20
    800062d4:	0205d593          	srli	a1,a1,0x20
    800062d8:	00bd85b3          	add	a1,s11,a1
    800062dc:	0005c583          	lbu	a1,0(a1)
    800062e0:	02d7d7bb          	divuw	a5,a5,a3
    800062e4:	f8b403a3          	sb	a1,-121(s0)
    800062e8:	42eb7e63          	bgeu	s6,a4,80006724 <__printf+0x65c>
    800062ec:	02d7f5bb          	remuw	a1,a5,a3
    800062f0:	02059593          	slli	a1,a1,0x20
    800062f4:	0205d593          	srli	a1,a1,0x20
    800062f8:	00bd85b3          	add	a1,s11,a1
    800062fc:	0005c583          	lbu	a1,0(a1)
    80006300:	02d7d7bb          	divuw	a5,a5,a3
    80006304:	f8b40423          	sb	a1,-120(s0)
    80006308:	42ebfc63          	bgeu	s7,a4,80006740 <__printf+0x678>
    8000630c:	02079793          	slli	a5,a5,0x20
    80006310:	0207d793          	srli	a5,a5,0x20
    80006314:	00fd8db3          	add	s11,s11,a5
    80006318:	000dc703          	lbu	a4,0(s11)
    8000631c:	00a00793          	li	a5,10
    80006320:	00900c93          	li	s9,9
    80006324:	f8e404a3          	sb	a4,-119(s0)
    80006328:	00065c63          	bgez	a2,80006340 <__printf+0x278>
    8000632c:	f9040713          	addi	a4,s0,-112
    80006330:	00f70733          	add	a4,a4,a5
    80006334:	02d00693          	li	a3,45
    80006338:	fed70823          	sb	a3,-16(a4)
    8000633c:	00078c93          	mv	s9,a5
    80006340:	f8040793          	addi	a5,s0,-128
    80006344:	01978cb3          	add	s9,a5,s9
    80006348:	f7f40d13          	addi	s10,s0,-129
    8000634c:	000cc503          	lbu	a0,0(s9)
    80006350:	fffc8c93          	addi	s9,s9,-1
    80006354:	00000097          	auipc	ra,0x0
    80006358:	b90080e7          	jalr	-1136(ra) # 80005ee4 <consputc>
    8000635c:	ffac98e3          	bne	s9,s10,8000634c <__printf+0x284>
    80006360:	00094503          	lbu	a0,0(s2)
    80006364:	e00514e3          	bnez	a0,8000616c <__printf+0xa4>
    80006368:	1a0c1663          	bnez	s8,80006514 <__printf+0x44c>
    8000636c:	08813083          	ld	ra,136(sp)
    80006370:	08013403          	ld	s0,128(sp)
    80006374:	07813483          	ld	s1,120(sp)
    80006378:	07013903          	ld	s2,112(sp)
    8000637c:	06813983          	ld	s3,104(sp)
    80006380:	06013a03          	ld	s4,96(sp)
    80006384:	05813a83          	ld	s5,88(sp)
    80006388:	05013b03          	ld	s6,80(sp)
    8000638c:	04813b83          	ld	s7,72(sp)
    80006390:	04013c03          	ld	s8,64(sp)
    80006394:	03813c83          	ld	s9,56(sp)
    80006398:	03013d03          	ld	s10,48(sp)
    8000639c:	02813d83          	ld	s11,40(sp)
    800063a0:	0d010113          	addi	sp,sp,208
    800063a4:	00008067          	ret
    800063a8:	07300713          	li	a4,115
    800063ac:	1ce78a63          	beq	a5,a4,80006580 <__printf+0x4b8>
    800063b0:	07800713          	li	a4,120
    800063b4:	1ee79e63          	bne	a5,a4,800065b0 <__printf+0x4e8>
    800063b8:	f7843783          	ld	a5,-136(s0)
    800063bc:	0007a703          	lw	a4,0(a5)
    800063c0:	00878793          	addi	a5,a5,8
    800063c4:	f6f43c23          	sd	a5,-136(s0)
    800063c8:	28074263          	bltz	a4,8000664c <__printf+0x584>
    800063cc:	00002d97          	auipc	s11,0x2
    800063d0:	034d8d93          	addi	s11,s11,52 # 80008400 <digits>
    800063d4:	00f77793          	andi	a5,a4,15
    800063d8:	00fd87b3          	add	a5,s11,a5
    800063dc:	0007c683          	lbu	a3,0(a5)
    800063e0:	00f00613          	li	a2,15
    800063e4:	0007079b          	sext.w	a5,a4
    800063e8:	f8d40023          	sb	a3,-128(s0)
    800063ec:	0047559b          	srliw	a1,a4,0x4
    800063f0:	0047569b          	srliw	a3,a4,0x4
    800063f4:	00000c93          	li	s9,0
    800063f8:	0ee65063          	bge	a2,a4,800064d8 <__printf+0x410>
    800063fc:	00f6f693          	andi	a3,a3,15
    80006400:	00dd86b3          	add	a3,s11,a3
    80006404:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80006408:	0087d79b          	srliw	a5,a5,0x8
    8000640c:	00100c93          	li	s9,1
    80006410:	f8d400a3          	sb	a3,-127(s0)
    80006414:	0cb67263          	bgeu	a2,a1,800064d8 <__printf+0x410>
    80006418:	00f7f693          	andi	a3,a5,15
    8000641c:	00dd86b3          	add	a3,s11,a3
    80006420:	0006c583          	lbu	a1,0(a3)
    80006424:	00f00613          	li	a2,15
    80006428:	0047d69b          	srliw	a3,a5,0x4
    8000642c:	f8b40123          	sb	a1,-126(s0)
    80006430:	0047d593          	srli	a1,a5,0x4
    80006434:	28f67e63          	bgeu	a2,a5,800066d0 <__printf+0x608>
    80006438:	00f6f693          	andi	a3,a3,15
    8000643c:	00dd86b3          	add	a3,s11,a3
    80006440:	0006c503          	lbu	a0,0(a3)
    80006444:	0087d813          	srli	a6,a5,0x8
    80006448:	0087d69b          	srliw	a3,a5,0x8
    8000644c:	f8a401a3          	sb	a0,-125(s0)
    80006450:	28b67663          	bgeu	a2,a1,800066dc <__printf+0x614>
    80006454:	00f6f693          	andi	a3,a3,15
    80006458:	00dd86b3          	add	a3,s11,a3
    8000645c:	0006c583          	lbu	a1,0(a3)
    80006460:	00c7d513          	srli	a0,a5,0xc
    80006464:	00c7d69b          	srliw	a3,a5,0xc
    80006468:	f8b40223          	sb	a1,-124(s0)
    8000646c:	29067a63          	bgeu	a2,a6,80006700 <__printf+0x638>
    80006470:	00f6f693          	andi	a3,a3,15
    80006474:	00dd86b3          	add	a3,s11,a3
    80006478:	0006c583          	lbu	a1,0(a3)
    8000647c:	0107d813          	srli	a6,a5,0x10
    80006480:	0107d69b          	srliw	a3,a5,0x10
    80006484:	f8b402a3          	sb	a1,-123(s0)
    80006488:	28a67263          	bgeu	a2,a0,8000670c <__printf+0x644>
    8000648c:	00f6f693          	andi	a3,a3,15
    80006490:	00dd86b3          	add	a3,s11,a3
    80006494:	0006c683          	lbu	a3,0(a3)
    80006498:	0147d79b          	srliw	a5,a5,0x14
    8000649c:	f8d40323          	sb	a3,-122(s0)
    800064a0:	21067663          	bgeu	a2,a6,800066ac <__printf+0x5e4>
    800064a4:	02079793          	slli	a5,a5,0x20
    800064a8:	0207d793          	srli	a5,a5,0x20
    800064ac:	00fd8db3          	add	s11,s11,a5
    800064b0:	000dc683          	lbu	a3,0(s11)
    800064b4:	00800793          	li	a5,8
    800064b8:	00700c93          	li	s9,7
    800064bc:	f8d403a3          	sb	a3,-121(s0)
    800064c0:	00075c63          	bgez	a4,800064d8 <__printf+0x410>
    800064c4:	f9040713          	addi	a4,s0,-112
    800064c8:	00f70733          	add	a4,a4,a5
    800064cc:	02d00693          	li	a3,45
    800064d0:	fed70823          	sb	a3,-16(a4)
    800064d4:	00078c93          	mv	s9,a5
    800064d8:	f8040793          	addi	a5,s0,-128
    800064dc:	01978cb3          	add	s9,a5,s9
    800064e0:	f7f40d13          	addi	s10,s0,-129
    800064e4:	000cc503          	lbu	a0,0(s9)
    800064e8:	fffc8c93          	addi	s9,s9,-1
    800064ec:	00000097          	auipc	ra,0x0
    800064f0:	9f8080e7          	jalr	-1544(ra) # 80005ee4 <consputc>
    800064f4:	ff9d18e3          	bne	s10,s9,800064e4 <__printf+0x41c>
    800064f8:	0100006f          	j	80006508 <__printf+0x440>
    800064fc:	00000097          	auipc	ra,0x0
    80006500:	9e8080e7          	jalr	-1560(ra) # 80005ee4 <consputc>
    80006504:	000c8493          	mv	s1,s9
    80006508:	00094503          	lbu	a0,0(s2)
    8000650c:	c60510e3          	bnez	a0,8000616c <__printf+0xa4>
    80006510:	e40c0ee3          	beqz	s8,8000636c <__printf+0x2a4>
    80006514:	00005517          	auipc	a0,0x5
    80006518:	e4c50513          	addi	a0,a0,-436 # 8000b360 <pr>
    8000651c:	00001097          	auipc	ra,0x1
    80006520:	94c080e7          	jalr	-1716(ra) # 80006e68 <release>
    80006524:	e49ff06f          	j	8000636c <__printf+0x2a4>
    80006528:	f7843783          	ld	a5,-136(s0)
    8000652c:	03000513          	li	a0,48
    80006530:	01000d13          	li	s10,16
    80006534:	00878713          	addi	a4,a5,8
    80006538:	0007bc83          	ld	s9,0(a5)
    8000653c:	f6e43c23          	sd	a4,-136(s0)
    80006540:	00000097          	auipc	ra,0x0
    80006544:	9a4080e7          	jalr	-1628(ra) # 80005ee4 <consputc>
    80006548:	07800513          	li	a0,120
    8000654c:	00000097          	auipc	ra,0x0
    80006550:	998080e7          	jalr	-1640(ra) # 80005ee4 <consputc>
    80006554:	00002d97          	auipc	s11,0x2
    80006558:	eacd8d93          	addi	s11,s11,-340 # 80008400 <digits>
    8000655c:	03ccd793          	srli	a5,s9,0x3c
    80006560:	00fd87b3          	add	a5,s11,a5
    80006564:	0007c503          	lbu	a0,0(a5)
    80006568:	fffd0d1b          	addiw	s10,s10,-1
    8000656c:	004c9c93          	slli	s9,s9,0x4
    80006570:	00000097          	auipc	ra,0x0
    80006574:	974080e7          	jalr	-1676(ra) # 80005ee4 <consputc>
    80006578:	fe0d12e3          	bnez	s10,8000655c <__printf+0x494>
    8000657c:	f8dff06f          	j	80006508 <__printf+0x440>
    80006580:	f7843783          	ld	a5,-136(s0)
    80006584:	0007bc83          	ld	s9,0(a5)
    80006588:	00878793          	addi	a5,a5,8
    8000658c:	f6f43c23          	sd	a5,-136(s0)
    80006590:	000c9a63          	bnez	s9,800065a4 <__printf+0x4dc>
    80006594:	1080006f          	j	8000669c <__printf+0x5d4>
    80006598:	001c8c93          	addi	s9,s9,1
    8000659c:	00000097          	auipc	ra,0x0
    800065a0:	948080e7          	jalr	-1720(ra) # 80005ee4 <consputc>
    800065a4:	000cc503          	lbu	a0,0(s9)
    800065a8:	fe0518e3          	bnez	a0,80006598 <__printf+0x4d0>
    800065ac:	f5dff06f          	j	80006508 <__printf+0x440>
    800065b0:	02500513          	li	a0,37
    800065b4:	00000097          	auipc	ra,0x0
    800065b8:	930080e7          	jalr	-1744(ra) # 80005ee4 <consputc>
    800065bc:	000c8513          	mv	a0,s9
    800065c0:	00000097          	auipc	ra,0x0
    800065c4:	924080e7          	jalr	-1756(ra) # 80005ee4 <consputc>
    800065c8:	f41ff06f          	j	80006508 <__printf+0x440>
    800065cc:	02500513          	li	a0,37
    800065d0:	00000097          	auipc	ra,0x0
    800065d4:	914080e7          	jalr	-1772(ra) # 80005ee4 <consputc>
    800065d8:	f31ff06f          	j	80006508 <__printf+0x440>
    800065dc:	00030513          	mv	a0,t1
    800065e0:	00000097          	auipc	ra,0x0
    800065e4:	7bc080e7          	jalr	1980(ra) # 80006d9c <acquire>
    800065e8:	b4dff06f          	j	80006134 <__printf+0x6c>
    800065ec:	40c0053b          	negw	a0,a2
    800065f0:	00a00713          	li	a4,10
    800065f4:	02e576bb          	remuw	a3,a0,a4
    800065f8:	00002d97          	auipc	s11,0x2
    800065fc:	e08d8d93          	addi	s11,s11,-504 # 80008400 <digits>
    80006600:	ff700593          	li	a1,-9
    80006604:	02069693          	slli	a3,a3,0x20
    80006608:	0206d693          	srli	a3,a3,0x20
    8000660c:	00dd86b3          	add	a3,s11,a3
    80006610:	0006c683          	lbu	a3,0(a3)
    80006614:	02e557bb          	divuw	a5,a0,a4
    80006618:	f8d40023          	sb	a3,-128(s0)
    8000661c:	10b65e63          	bge	a2,a1,80006738 <__printf+0x670>
    80006620:	06300593          	li	a1,99
    80006624:	02e7f6bb          	remuw	a3,a5,a4
    80006628:	02069693          	slli	a3,a3,0x20
    8000662c:	0206d693          	srli	a3,a3,0x20
    80006630:	00dd86b3          	add	a3,s11,a3
    80006634:	0006c683          	lbu	a3,0(a3)
    80006638:	02e7d73b          	divuw	a4,a5,a4
    8000663c:	00200793          	li	a5,2
    80006640:	f8d400a3          	sb	a3,-127(s0)
    80006644:	bca5ece3          	bltu	a1,a0,8000621c <__printf+0x154>
    80006648:	ce5ff06f          	j	8000632c <__printf+0x264>
    8000664c:	40e007bb          	negw	a5,a4
    80006650:	00002d97          	auipc	s11,0x2
    80006654:	db0d8d93          	addi	s11,s11,-592 # 80008400 <digits>
    80006658:	00f7f693          	andi	a3,a5,15
    8000665c:	00dd86b3          	add	a3,s11,a3
    80006660:	0006c583          	lbu	a1,0(a3)
    80006664:	ff100613          	li	a2,-15
    80006668:	0047d69b          	srliw	a3,a5,0x4
    8000666c:	f8b40023          	sb	a1,-128(s0)
    80006670:	0047d59b          	srliw	a1,a5,0x4
    80006674:	0ac75e63          	bge	a4,a2,80006730 <__printf+0x668>
    80006678:	00f6f693          	andi	a3,a3,15
    8000667c:	00dd86b3          	add	a3,s11,a3
    80006680:	0006c603          	lbu	a2,0(a3)
    80006684:	00f00693          	li	a3,15
    80006688:	0087d79b          	srliw	a5,a5,0x8
    8000668c:	f8c400a3          	sb	a2,-127(s0)
    80006690:	d8b6e4e3          	bltu	a3,a1,80006418 <__printf+0x350>
    80006694:	00200793          	li	a5,2
    80006698:	e2dff06f          	j	800064c4 <__printf+0x3fc>
    8000669c:	00002c97          	auipc	s9,0x2
    800066a0:	d44c8c93          	addi	s9,s9,-700 # 800083e0 <CONSOLE_STATUS+0x3d0>
    800066a4:	02800513          	li	a0,40
    800066a8:	ef1ff06f          	j	80006598 <__printf+0x4d0>
    800066ac:	00700793          	li	a5,7
    800066b0:	00600c93          	li	s9,6
    800066b4:	e0dff06f          	j	800064c0 <__printf+0x3f8>
    800066b8:	00700793          	li	a5,7
    800066bc:	00600c93          	li	s9,6
    800066c0:	c69ff06f          	j	80006328 <__printf+0x260>
    800066c4:	00300793          	li	a5,3
    800066c8:	00200c93          	li	s9,2
    800066cc:	c5dff06f          	j	80006328 <__printf+0x260>
    800066d0:	00300793          	li	a5,3
    800066d4:	00200c93          	li	s9,2
    800066d8:	de9ff06f          	j	800064c0 <__printf+0x3f8>
    800066dc:	00400793          	li	a5,4
    800066e0:	00300c93          	li	s9,3
    800066e4:	dddff06f          	j	800064c0 <__printf+0x3f8>
    800066e8:	00400793          	li	a5,4
    800066ec:	00300c93          	li	s9,3
    800066f0:	c39ff06f          	j	80006328 <__printf+0x260>
    800066f4:	00500793          	li	a5,5
    800066f8:	00400c93          	li	s9,4
    800066fc:	c2dff06f          	j	80006328 <__printf+0x260>
    80006700:	00500793          	li	a5,5
    80006704:	00400c93          	li	s9,4
    80006708:	db9ff06f          	j	800064c0 <__printf+0x3f8>
    8000670c:	00600793          	li	a5,6
    80006710:	00500c93          	li	s9,5
    80006714:	dadff06f          	j	800064c0 <__printf+0x3f8>
    80006718:	00600793          	li	a5,6
    8000671c:	00500c93          	li	s9,5
    80006720:	c09ff06f          	j	80006328 <__printf+0x260>
    80006724:	00800793          	li	a5,8
    80006728:	00700c93          	li	s9,7
    8000672c:	bfdff06f          	j	80006328 <__printf+0x260>
    80006730:	00100793          	li	a5,1
    80006734:	d91ff06f          	j	800064c4 <__printf+0x3fc>
    80006738:	00100793          	li	a5,1
    8000673c:	bf1ff06f          	j	8000632c <__printf+0x264>
    80006740:	00900793          	li	a5,9
    80006744:	00800c93          	li	s9,8
    80006748:	be1ff06f          	j	80006328 <__printf+0x260>
    8000674c:	00002517          	auipc	a0,0x2
    80006750:	c9c50513          	addi	a0,a0,-868 # 800083e8 <CONSOLE_STATUS+0x3d8>
    80006754:	00000097          	auipc	ra,0x0
    80006758:	918080e7          	jalr	-1768(ra) # 8000606c <panic>

000000008000675c <printfinit>:
    8000675c:	fe010113          	addi	sp,sp,-32
    80006760:	00813823          	sd	s0,16(sp)
    80006764:	00913423          	sd	s1,8(sp)
    80006768:	00113c23          	sd	ra,24(sp)
    8000676c:	02010413          	addi	s0,sp,32
    80006770:	00005497          	auipc	s1,0x5
    80006774:	bf048493          	addi	s1,s1,-1040 # 8000b360 <pr>
    80006778:	00048513          	mv	a0,s1
    8000677c:	00002597          	auipc	a1,0x2
    80006780:	c7c58593          	addi	a1,a1,-900 # 800083f8 <CONSOLE_STATUS+0x3e8>
    80006784:	00000097          	auipc	ra,0x0
    80006788:	5f4080e7          	jalr	1524(ra) # 80006d78 <initlock>
    8000678c:	01813083          	ld	ra,24(sp)
    80006790:	01013403          	ld	s0,16(sp)
    80006794:	0004ac23          	sw	zero,24(s1)
    80006798:	00813483          	ld	s1,8(sp)
    8000679c:	02010113          	addi	sp,sp,32
    800067a0:	00008067          	ret

00000000800067a4 <uartinit>:
    800067a4:	ff010113          	addi	sp,sp,-16
    800067a8:	00813423          	sd	s0,8(sp)
    800067ac:	01010413          	addi	s0,sp,16
    800067b0:	100007b7          	lui	a5,0x10000
    800067b4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800067b8:	f8000713          	li	a4,-128
    800067bc:	00e781a3          	sb	a4,3(a5)
    800067c0:	00300713          	li	a4,3
    800067c4:	00e78023          	sb	a4,0(a5)
    800067c8:	000780a3          	sb	zero,1(a5)
    800067cc:	00e781a3          	sb	a4,3(a5)
    800067d0:	00700693          	li	a3,7
    800067d4:	00d78123          	sb	a3,2(a5)
    800067d8:	00e780a3          	sb	a4,1(a5)
    800067dc:	00813403          	ld	s0,8(sp)
    800067e0:	01010113          	addi	sp,sp,16
    800067e4:	00008067          	ret

00000000800067e8 <uartputc>:
    800067e8:	00004797          	auipc	a5,0x4
    800067ec:	8507a783          	lw	a5,-1968(a5) # 8000a038 <panicked>
    800067f0:	00078463          	beqz	a5,800067f8 <uartputc+0x10>
    800067f4:	0000006f          	j	800067f4 <uartputc+0xc>
    800067f8:	fd010113          	addi	sp,sp,-48
    800067fc:	02813023          	sd	s0,32(sp)
    80006800:	00913c23          	sd	s1,24(sp)
    80006804:	01213823          	sd	s2,16(sp)
    80006808:	01313423          	sd	s3,8(sp)
    8000680c:	02113423          	sd	ra,40(sp)
    80006810:	03010413          	addi	s0,sp,48
    80006814:	00004917          	auipc	s2,0x4
    80006818:	82c90913          	addi	s2,s2,-2004 # 8000a040 <uart_tx_r>
    8000681c:	00093783          	ld	a5,0(s2)
    80006820:	00004497          	auipc	s1,0x4
    80006824:	82848493          	addi	s1,s1,-2008 # 8000a048 <uart_tx_w>
    80006828:	0004b703          	ld	a4,0(s1)
    8000682c:	02078693          	addi	a3,a5,32
    80006830:	00050993          	mv	s3,a0
    80006834:	02e69c63          	bne	a3,a4,8000686c <uartputc+0x84>
    80006838:	00001097          	auipc	ra,0x1
    8000683c:	834080e7          	jalr	-1996(ra) # 8000706c <push_on>
    80006840:	00093783          	ld	a5,0(s2)
    80006844:	0004b703          	ld	a4,0(s1)
    80006848:	02078793          	addi	a5,a5,32
    8000684c:	00e79463          	bne	a5,a4,80006854 <uartputc+0x6c>
    80006850:	0000006f          	j	80006850 <uartputc+0x68>
    80006854:	00001097          	auipc	ra,0x1
    80006858:	88c080e7          	jalr	-1908(ra) # 800070e0 <pop_on>
    8000685c:	00093783          	ld	a5,0(s2)
    80006860:	0004b703          	ld	a4,0(s1)
    80006864:	02078693          	addi	a3,a5,32
    80006868:	fce688e3          	beq	a3,a4,80006838 <uartputc+0x50>
    8000686c:	01f77693          	andi	a3,a4,31
    80006870:	00005597          	auipc	a1,0x5
    80006874:	b1058593          	addi	a1,a1,-1264 # 8000b380 <uart_tx_buf>
    80006878:	00d586b3          	add	a3,a1,a3
    8000687c:	00170713          	addi	a4,a4,1
    80006880:	01368023          	sb	s3,0(a3)
    80006884:	00e4b023          	sd	a4,0(s1)
    80006888:	10000637          	lui	a2,0x10000
    8000688c:	02f71063          	bne	a4,a5,800068ac <uartputc+0xc4>
    80006890:	0340006f          	j	800068c4 <uartputc+0xdc>
    80006894:	00074703          	lbu	a4,0(a4)
    80006898:	00f93023          	sd	a5,0(s2)
    8000689c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800068a0:	00093783          	ld	a5,0(s2)
    800068a4:	0004b703          	ld	a4,0(s1)
    800068a8:	00f70e63          	beq	a4,a5,800068c4 <uartputc+0xdc>
    800068ac:	00564683          	lbu	a3,5(a2)
    800068b0:	01f7f713          	andi	a4,a5,31
    800068b4:	00e58733          	add	a4,a1,a4
    800068b8:	0206f693          	andi	a3,a3,32
    800068bc:	00178793          	addi	a5,a5,1
    800068c0:	fc069ae3          	bnez	a3,80006894 <uartputc+0xac>
    800068c4:	02813083          	ld	ra,40(sp)
    800068c8:	02013403          	ld	s0,32(sp)
    800068cc:	01813483          	ld	s1,24(sp)
    800068d0:	01013903          	ld	s2,16(sp)
    800068d4:	00813983          	ld	s3,8(sp)
    800068d8:	03010113          	addi	sp,sp,48
    800068dc:	00008067          	ret

00000000800068e0 <uartputc_sync>:
    800068e0:	ff010113          	addi	sp,sp,-16
    800068e4:	00813423          	sd	s0,8(sp)
    800068e8:	01010413          	addi	s0,sp,16
    800068ec:	00003717          	auipc	a4,0x3
    800068f0:	74c72703          	lw	a4,1868(a4) # 8000a038 <panicked>
    800068f4:	02071663          	bnez	a4,80006920 <uartputc_sync+0x40>
    800068f8:	00050793          	mv	a5,a0
    800068fc:	100006b7          	lui	a3,0x10000
    80006900:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80006904:	02077713          	andi	a4,a4,32
    80006908:	fe070ce3          	beqz	a4,80006900 <uartputc_sync+0x20>
    8000690c:	0ff7f793          	andi	a5,a5,255
    80006910:	00f68023          	sb	a5,0(a3)
    80006914:	00813403          	ld	s0,8(sp)
    80006918:	01010113          	addi	sp,sp,16
    8000691c:	00008067          	ret
    80006920:	0000006f          	j	80006920 <uartputc_sync+0x40>

0000000080006924 <uartstart>:
    80006924:	ff010113          	addi	sp,sp,-16
    80006928:	00813423          	sd	s0,8(sp)
    8000692c:	01010413          	addi	s0,sp,16
    80006930:	00003617          	auipc	a2,0x3
    80006934:	71060613          	addi	a2,a2,1808 # 8000a040 <uart_tx_r>
    80006938:	00003517          	auipc	a0,0x3
    8000693c:	71050513          	addi	a0,a0,1808 # 8000a048 <uart_tx_w>
    80006940:	00063783          	ld	a5,0(a2)
    80006944:	00053703          	ld	a4,0(a0)
    80006948:	04f70263          	beq	a4,a5,8000698c <uartstart+0x68>
    8000694c:	100005b7          	lui	a1,0x10000
    80006950:	00005817          	auipc	a6,0x5
    80006954:	a3080813          	addi	a6,a6,-1488 # 8000b380 <uart_tx_buf>
    80006958:	01c0006f          	j	80006974 <uartstart+0x50>
    8000695c:	0006c703          	lbu	a4,0(a3)
    80006960:	00f63023          	sd	a5,0(a2)
    80006964:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006968:	00063783          	ld	a5,0(a2)
    8000696c:	00053703          	ld	a4,0(a0)
    80006970:	00f70e63          	beq	a4,a5,8000698c <uartstart+0x68>
    80006974:	01f7f713          	andi	a4,a5,31
    80006978:	00e806b3          	add	a3,a6,a4
    8000697c:	0055c703          	lbu	a4,5(a1)
    80006980:	00178793          	addi	a5,a5,1
    80006984:	02077713          	andi	a4,a4,32
    80006988:	fc071ae3          	bnez	a4,8000695c <uartstart+0x38>
    8000698c:	00813403          	ld	s0,8(sp)
    80006990:	01010113          	addi	sp,sp,16
    80006994:	00008067          	ret

0000000080006998 <uartgetc>:
    80006998:	ff010113          	addi	sp,sp,-16
    8000699c:	00813423          	sd	s0,8(sp)
    800069a0:	01010413          	addi	s0,sp,16
    800069a4:	10000737          	lui	a4,0x10000
    800069a8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800069ac:	0017f793          	andi	a5,a5,1
    800069b0:	00078c63          	beqz	a5,800069c8 <uartgetc+0x30>
    800069b4:	00074503          	lbu	a0,0(a4)
    800069b8:	0ff57513          	andi	a0,a0,255
    800069bc:	00813403          	ld	s0,8(sp)
    800069c0:	01010113          	addi	sp,sp,16
    800069c4:	00008067          	ret
    800069c8:	fff00513          	li	a0,-1
    800069cc:	ff1ff06f          	j	800069bc <uartgetc+0x24>

00000000800069d0 <uartintr>:
    800069d0:	100007b7          	lui	a5,0x10000
    800069d4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800069d8:	0017f793          	andi	a5,a5,1
    800069dc:	0a078463          	beqz	a5,80006a84 <uartintr+0xb4>
    800069e0:	fe010113          	addi	sp,sp,-32
    800069e4:	00813823          	sd	s0,16(sp)
    800069e8:	00913423          	sd	s1,8(sp)
    800069ec:	00113c23          	sd	ra,24(sp)
    800069f0:	02010413          	addi	s0,sp,32
    800069f4:	100004b7          	lui	s1,0x10000
    800069f8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800069fc:	0ff57513          	andi	a0,a0,255
    80006a00:	fffff097          	auipc	ra,0xfffff
    80006a04:	534080e7          	jalr	1332(ra) # 80005f34 <consoleintr>
    80006a08:	0054c783          	lbu	a5,5(s1)
    80006a0c:	0017f793          	andi	a5,a5,1
    80006a10:	fe0794e3          	bnez	a5,800069f8 <uartintr+0x28>
    80006a14:	00003617          	auipc	a2,0x3
    80006a18:	62c60613          	addi	a2,a2,1580 # 8000a040 <uart_tx_r>
    80006a1c:	00003517          	auipc	a0,0x3
    80006a20:	62c50513          	addi	a0,a0,1580 # 8000a048 <uart_tx_w>
    80006a24:	00063783          	ld	a5,0(a2)
    80006a28:	00053703          	ld	a4,0(a0)
    80006a2c:	04f70263          	beq	a4,a5,80006a70 <uartintr+0xa0>
    80006a30:	100005b7          	lui	a1,0x10000
    80006a34:	00005817          	auipc	a6,0x5
    80006a38:	94c80813          	addi	a6,a6,-1716 # 8000b380 <uart_tx_buf>
    80006a3c:	01c0006f          	j	80006a58 <uartintr+0x88>
    80006a40:	0006c703          	lbu	a4,0(a3)
    80006a44:	00f63023          	sd	a5,0(a2)
    80006a48:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006a4c:	00063783          	ld	a5,0(a2)
    80006a50:	00053703          	ld	a4,0(a0)
    80006a54:	00f70e63          	beq	a4,a5,80006a70 <uartintr+0xa0>
    80006a58:	01f7f713          	andi	a4,a5,31
    80006a5c:	00e806b3          	add	a3,a6,a4
    80006a60:	0055c703          	lbu	a4,5(a1)
    80006a64:	00178793          	addi	a5,a5,1
    80006a68:	02077713          	andi	a4,a4,32
    80006a6c:	fc071ae3          	bnez	a4,80006a40 <uartintr+0x70>
    80006a70:	01813083          	ld	ra,24(sp)
    80006a74:	01013403          	ld	s0,16(sp)
    80006a78:	00813483          	ld	s1,8(sp)
    80006a7c:	02010113          	addi	sp,sp,32
    80006a80:	00008067          	ret
    80006a84:	00003617          	auipc	a2,0x3
    80006a88:	5bc60613          	addi	a2,a2,1468 # 8000a040 <uart_tx_r>
    80006a8c:	00003517          	auipc	a0,0x3
    80006a90:	5bc50513          	addi	a0,a0,1468 # 8000a048 <uart_tx_w>
    80006a94:	00063783          	ld	a5,0(a2)
    80006a98:	00053703          	ld	a4,0(a0)
    80006a9c:	04f70263          	beq	a4,a5,80006ae0 <uartintr+0x110>
    80006aa0:	100005b7          	lui	a1,0x10000
    80006aa4:	00005817          	auipc	a6,0x5
    80006aa8:	8dc80813          	addi	a6,a6,-1828 # 8000b380 <uart_tx_buf>
    80006aac:	01c0006f          	j	80006ac8 <uartintr+0xf8>
    80006ab0:	0006c703          	lbu	a4,0(a3)
    80006ab4:	00f63023          	sd	a5,0(a2)
    80006ab8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006abc:	00063783          	ld	a5,0(a2)
    80006ac0:	00053703          	ld	a4,0(a0)
    80006ac4:	02f70063          	beq	a4,a5,80006ae4 <uartintr+0x114>
    80006ac8:	01f7f713          	andi	a4,a5,31
    80006acc:	00e806b3          	add	a3,a6,a4
    80006ad0:	0055c703          	lbu	a4,5(a1)
    80006ad4:	00178793          	addi	a5,a5,1
    80006ad8:	02077713          	andi	a4,a4,32
    80006adc:	fc071ae3          	bnez	a4,80006ab0 <uartintr+0xe0>
    80006ae0:	00008067          	ret
    80006ae4:	00008067          	ret

0000000080006ae8 <kinit>:
    80006ae8:	fc010113          	addi	sp,sp,-64
    80006aec:	02913423          	sd	s1,40(sp)
    80006af0:	fffff7b7          	lui	a5,0xfffff
    80006af4:	00006497          	auipc	s1,0x6
    80006af8:	8ab48493          	addi	s1,s1,-1877 # 8000c39f <end+0xfff>
    80006afc:	02813823          	sd	s0,48(sp)
    80006b00:	01313c23          	sd	s3,24(sp)
    80006b04:	00f4f4b3          	and	s1,s1,a5
    80006b08:	02113c23          	sd	ra,56(sp)
    80006b0c:	03213023          	sd	s2,32(sp)
    80006b10:	01413823          	sd	s4,16(sp)
    80006b14:	01513423          	sd	s5,8(sp)
    80006b18:	04010413          	addi	s0,sp,64
    80006b1c:	000017b7          	lui	a5,0x1
    80006b20:	01100993          	li	s3,17
    80006b24:	00f487b3          	add	a5,s1,a5
    80006b28:	01b99993          	slli	s3,s3,0x1b
    80006b2c:	06f9e063          	bltu	s3,a5,80006b8c <kinit+0xa4>
    80006b30:	00005a97          	auipc	s5,0x5
    80006b34:	870a8a93          	addi	s5,s5,-1936 # 8000b3a0 <end>
    80006b38:	0754ec63          	bltu	s1,s5,80006bb0 <kinit+0xc8>
    80006b3c:	0734fa63          	bgeu	s1,s3,80006bb0 <kinit+0xc8>
    80006b40:	00088a37          	lui	s4,0x88
    80006b44:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80006b48:	00003917          	auipc	s2,0x3
    80006b4c:	50890913          	addi	s2,s2,1288 # 8000a050 <kmem>
    80006b50:	00ca1a13          	slli	s4,s4,0xc
    80006b54:	0140006f          	j	80006b68 <kinit+0x80>
    80006b58:	000017b7          	lui	a5,0x1
    80006b5c:	00f484b3          	add	s1,s1,a5
    80006b60:	0554e863          	bltu	s1,s5,80006bb0 <kinit+0xc8>
    80006b64:	0534f663          	bgeu	s1,s3,80006bb0 <kinit+0xc8>
    80006b68:	00001637          	lui	a2,0x1
    80006b6c:	00100593          	li	a1,1
    80006b70:	00048513          	mv	a0,s1
    80006b74:	00000097          	auipc	ra,0x0
    80006b78:	5e4080e7          	jalr	1508(ra) # 80007158 <__memset>
    80006b7c:	00093783          	ld	a5,0(s2)
    80006b80:	00f4b023          	sd	a5,0(s1)
    80006b84:	00993023          	sd	s1,0(s2)
    80006b88:	fd4498e3          	bne	s1,s4,80006b58 <kinit+0x70>
    80006b8c:	03813083          	ld	ra,56(sp)
    80006b90:	03013403          	ld	s0,48(sp)
    80006b94:	02813483          	ld	s1,40(sp)
    80006b98:	02013903          	ld	s2,32(sp)
    80006b9c:	01813983          	ld	s3,24(sp)
    80006ba0:	01013a03          	ld	s4,16(sp)
    80006ba4:	00813a83          	ld	s5,8(sp)
    80006ba8:	04010113          	addi	sp,sp,64
    80006bac:	00008067          	ret
    80006bb0:	00002517          	auipc	a0,0x2
    80006bb4:	86850513          	addi	a0,a0,-1944 # 80008418 <digits+0x18>
    80006bb8:	fffff097          	auipc	ra,0xfffff
    80006bbc:	4b4080e7          	jalr	1204(ra) # 8000606c <panic>

0000000080006bc0 <freerange>:
    80006bc0:	fc010113          	addi	sp,sp,-64
    80006bc4:	000017b7          	lui	a5,0x1
    80006bc8:	02913423          	sd	s1,40(sp)
    80006bcc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80006bd0:	009504b3          	add	s1,a0,s1
    80006bd4:	fffff537          	lui	a0,0xfffff
    80006bd8:	02813823          	sd	s0,48(sp)
    80006bdc:	02113c23          	sd	ra,56(sp)
    80006be0:	03213023          	sd	s2,32(sp)
    80006be4:	01313c23          	sd	s3,24(sp)
    80006be8:	01413823          	sd	s4,16(sp)
    80006bec:	01513423          	sd	s5,8(sp)
    80006bf0:	01613023          	sd	s6,0(sp)
    80006bf4:	04010413          	addi	s0,sp,64
    80006bf8:	00a4f4b3          	and	s1,s1,a0
    80006bfc:	00f487b3          	add	a5,s1,a5
    80006c00:	06f5e463          	bltu	a1,a5,80006c68 <freerange+0xa8>
    80006c04:	00004a97          	auipc	s5,0x4
    80006c08:	79ca8a93          	addi	s5,s5,1948 # 8000b3a0 <end>
    80006c0c:	0954e263          	bltu	s1,s5,80006c90 <freerange+0xd0>
    80006c10:	01100993          	li	s3,17
    80006c14:	01b99993          	slli	s3,s3,0x1b
    80006c18:	0734fc63          	bgeu	s1,s3,80006c90 <freerange+0xd0>
    80006c1c:	00058a13          	mv	s4,a1
    80006c20:	00003917          	auipc	s2,0x3
    80006c24:	43090913          	addi	s2,s2,1072 # 8000a050 <kmem>
    80006c28:	00002b37          	lui	s6,0x2
    80006c2c:	0140006f          	j	80006c40 <freerange+0x80>
    80006c30:	000017b7          	lui	a5,0x1
    80006c34:	00f484b3          	add	s1,s1,a5
    80006c38:	0554ec63          	bltu	s1,s5,80006c90 <freerange+0xd0>
    80006c3c:	0534fa63          	bgeu	s1,s3,80006c90 <freerange+0xd0>
    80006c40:	00001637          	lui	a2,0x1
    80006c44:	00100593          	li	a1,1
    80006c48:	00048513          	mv	a0,s1
    80006c4c:	00000097          	auipc	ra,0x0
    80006c50:	50c080e7          	jalr	1292(ra) # 80007158 <__memset>
    80006c54:	00093703          	ld	a4,0(s2)
    80006c58:	016487b3          	add	a5,s1,s6
    80006c5c:	00e4b023          	sd	a4,0(s1)
    80006c60:	00993023          	sd	s1,0(s2)
    80006c64:	fcfa76e3          	bgeu	s4,a5,80006c30 <freerange+0x70>
    80006c68:	03813083          	ld	ra,56(sp)
    80006c6c:	03013403          	ld	s0,48(sp)
    80006c70:	02813483          	ld	s1,40(sp)
    80006c74:	02013903          	ld	s2,32(sp)
    80006c78:	01813983          	ld	s3,24(sp)
    80006c7c:	01013a03          	ld	s4,16(sp)
    80006c80:	00813a83          	ld	s5,8(sp)
    80006c84:	00013b03          	ld	s6,0(sp)
    80006c88:	04010113          	addi	sp,sp,64
    80006c8c:	00008067          	ret
    80006c90:	00001517          	auipc	a0,0x1
    80006c94:	78850513          	addi	a0,a0,1928 # 80008418 <digits+0x18>
    80006c98:	fffff097          	auipc	ra,0xfffff
    80006c9c:	3d4080e7          	jalr	980(ra) # 8000606c <panic>

0000000080006ca0 <kfree>:
    80006ca0:	fe010113          	addi	sp,sp,-32
    80006ca4:	00813823          	sd	s0,16(sp)
    80006ca8:	00113c23          	sd	ra,24(sp)
    80006cac:	00913423          	sd	s1,8(sp)
    80006cb0:	02010413          	addi	s0,sp,32
    80006cb4:	03451793          	slli	a5,a0,0x34
    80006cb8:	04079c63          	bnez	a5,80006d10 <kfree+0x70>
    80006cbc:	00004797          	auipc	a5,0x4
    80006cc0:	6e478793          	addi	a5,a5,1764 # 8000b3a0 <end>
    80006cc4:	00050493          	mv	s1,a0
    80006cc8:	04f56463          	bltu	a0,a5,80006d10 <kfree+0x70>
    80006ccc:	01100793          	li	a5,17
    80006cd0:	01b79793          	slli	a5,a5,0x1b
    80006cd4:	02f57e63          	bgeu	a0,a5,80006d10 <kfree+0x70>
    80006cd8:	00001637          	lui	a2,0x1
    80006cdc:	00100593          	li	a1,1
    80006ce0:	00000097          	auipc	ra,0x0
    80006ce4:	478080e7          	jalr	1144(ra) # 80007158 <__memset>
    80006ce8:	00003797          	auipc	a5,0x3
    80006cec:	36878793          	addi	a5,a5,872 # 8000a050 <kmem>
    80006cf0:	0007b703          	ld	a4,0(a5)
    80006cf4:	01813083          	ld	ra,24(sp)
    80006cf8:	01013403          	ld	s0,16(sp)
    80006cfc:	00e4b023          	sd	a4,0(s1)
    80006d00:	0097b023          	sd	s1,0(a5)
    80006d04:	00813483          	ld	s1,8(sp)
    80006d08:	02010113          	addi	sp,sp,32
    80006d0c:	00008067          	ret
    80006d10:	00001517          	auipc	a0,0x1
    80006d14:	70850513          	addi	a0,a0,1800 # 80008418 <digits+0x18>
    80006d18:	fffff097          	auipc	ra,0xfffff
    80006d1c:	354080e7          	jalr	852(ra) # 8000606c <panic>

0000000080006d20 <kalloc>:
    80006d20:	fe010113          	addi	sp,sp,-32
    80006d24:	00813823          	sd	s0,16(sp)
    80006d28:	00913423          	sd	s1,8(sp)
    80006d2c:	00113c23          	sd	ra,24(sp)
    80006d30:	02010413          	addi	s0,sp,32
    80006d34:	00003797          	auipc	a5,0x3
    80006d38:	31c78793          	addi	a5,a5,796 # 8000a050 <kmem>
    80006d3c:	0007b483          	ld	s1,0(a5)
    80006d40:	02048063          	beqz	s1,80006d60 <kalloc+0x40>
    80006d44:	0004b703          	ld	a4,0(s1)
    80006d48:	00001637          	lui	a2,0x1
    80006d4c:	00500593          	li	a1,5
    80006d50:	00048513          	mv	a0,s1
    80006d54:	00e7b023          	sd	a4,0(a5)
    80006d58:	00000097          	auipc	ra,0x0
    80006d5c:	400080e7          	jalr	1024(ra) # 80007158 <__memset>
    80006d60:	01813083          	ld	ra,24(sp)
    80006d64:	01013403          	ld	s0,16(sp)
    80006d68:	00048513          	mv	a0,s1
    80006d6c:	00813483          	ld	s1,8(sp)
    80006d70:	02010113          	addi	sp,sp,32
    80006d74:	00008067          	ret

0000000080006d78 <initlock>:
    80006d78:	ff010113          	addi	sp,sp,-16
    80006d7c:	00813423          	sd	s0,8(sp)
    80006d80:	01010413          	addi	s0,sp,16
    80006d84:	00813403          	ld	s0,8(sp)
    80006d88:	00b53423          	sd	a1,8(a0)
    80006d8c:	00052023          	sw	zero,0(a0)
    80006d90:	00053823          	sd	zero,16(a0)
    80006d94:	01010113          	addi	sp,sp,16
    80006d98:	00008067          	ret

0000000080006d9c <acquire>:
    80006d9c:	fe010113          	addi	sp,sp,-32
    80006da0:	00813823          	sd	s0,16(sp)
    80006da4:	00913423          	sd	s1,8(sp)
    80006da8:	00113c23          	sd	ra,24(sp)
    80006dac:	01213023          	sd	s2,0(sp)
    80006db0:	02010413          	addi	s0,sp,32
    80006db4:	00050493          	mv	s1,a0
    80006db8:	10002973          	csrr	s2,sstatus
    80006dbc:	100027f3          	csrr	a5,sstatus
    80006dc0:	ffd7f793          	andi	a5,a5,-3
    80006dc4:	10079073          	csrw	sstatus,a5
    80006dc8:	fffff097          	auipc	ra,0xfffff
    80006dcc:	8ec080e7          	jalr	-1812(ra) # 800056b4 <mycpu>
    80006dd0:	07852783          	lw	a5,120(a0)
    80006dd4:	06078e63          	beqz	a5,80006e50 <acquire+0xb4>
    80006dd8:	fffff097          	auipc	ra,0xfffff
    80006ddc:	8dc080e7          	jalr	-1828(ra) # 800056b4 <mycpu>
    80006de0:	07852783          	lw	a5,120(a0)
    80006de4:	0004a703          	lw	a4,0(s1)
    80006de8:	0017879b          	addiw	a5,a5,1
    80006dec:	06f52c23          	sw	a5,120(a0)
    80006df0:	04071063          	bnez	a4,80006e30 <acquire+0x94>
    80006df4:	00100713          	li	a4,1
    80006df8:	00070793          	mv	a5,a4
    80006dfc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006e00:	0007879b          	sext.w	a5,a5
    80006e04:	fe079ae3          	bnez	a5,80006df8 <acquire+0x5c>
    80006e08:	0ff0000f          	fence
    80006e0c:	fffff097          	auipc	ra,0xfffff
    80006e10:	8a8080e7          	jalr	-1880(ra) # 800056b4 <mycpu>
    80006e14:	01813083          	ld	ra,24(sp)
    80006e18:	01013403          	ld	s0,16(sp)
    80006e1c:	00a4b823          	sd	a0,16(s1)
    80006e20:	00013903          	ld	s2,0(sp)
    80006e24:	00813483          	ld	s1,8(sp)
    80006e28:	02010113          	addi	sp,sp,32
    80006e2c:	00008067          	ret
    80006e30:	0104b903          	ld	s2,16(s1)
    80006e34:	fffff097          	auipc	ra,0xfffff
    80006e38:	880080e7          	jalr	-1920(ra) # 800056b4 <mycpu>
    80006e3c:	faa91ce3          	bne	s2,a0,80006df4 <acquire+0x58>
    80006e40:	00001517          	auipc	a0,0x1
    80006e44:	5e050513          	addi	a0,a0,1504 # 80008420 <digits+0x20>
    80006e48:	fffff097          	auipc	ra,0xfffff
    80006e4c:	224080e7          	jalr	548(ra) # 8000606c <panic>
    80006e50:	00195913          	srli	s2,s2,0x1
    80006e54:	fffff097          	auipc	ra,0xfffff
    80006e58:	860080e7          	jalr	-1952(ra) # 800056b4 <mycpu>
    80006e5c:	00197913          	andi	s2,s2,1
    80006e60:	07252e23          	sw	s2,124(a0)
    80006e64:	f75ff06f          	j	80006dd8 <acquire+0x3c>

0000000080006e68 <release>:
    80006e68:	fe010113          	addi	sp,sp,-32
    80006e6c:	00813823          	sd	s0,16(sp)
    80006e70:	00113c23          	sd	ra,24(sp)
    80006e74:	00913423          	sd	s1,8(sp)
    80006e78:	01213023          	sd	s2,0(sp)
    80006e7c:	02010413          	addi	s0,sp,32
    80006e80:	00052783          	lw	a5,0(a0)
    80006e84:	00079a63          	bnez	a5,80006e98 <release+0x30>
    80006e88:	00001517          	auipc	a0,0x1
    80006e8c:	5a050513          	addi	a0,a0,1440 # 80008428 <digits+0x28>
    80006e90:	fffff097          	auipc	ra,0xfffff
    80006e94:	1dc080e7          	jalr	476(ra) # 8000606c <panic>
    80006e98:	01053903          	ld	s2,16(a0)
    80006e9c:	00050493          	mv	s1,a0
    80006ea0:	fffff097          	auipc	ra,0xfffff
    80006ea4:	814080e7          	jalr	-2028(ra) # 800056b4 <mycpu>
    80006ea8:	fea910e3          	bne	s2,a0,80006e88 <release+0x20>
    80006eac:	0004b823          	sd	zero,16(s1)
    80006eb0:	0ff0000f          	fence
    80006eb4:	0f50000f          	fence	iorw,ow
    80006eb8:	0804a02f          	amoswap.w	zero,zero,(s1)
    80006ebc:	ffffe097          	auipc	ra,0xffffe
    80006ec0:	7f8080e7          	jalr	2040(ra) # 800056b4 <mycpu>
    80006ec4:	100027f3          	csrr	a5,sstatus
    80006ec8:	0027f793          	andi	a5,a5,2
    80006ecc:	04079a63          	bnez	a5,80006f20 <release+0xb8>
    80006ed0:	07852783          	lw	a5,120(a0)
    80006ed4:	02f05e63          	blez	a5,80006f10 <release+0xa8>
    80006ed8:	fff7871b          	addiw	a4,a5,-1
    80006edc:	06e52c23          	sw	a4,120(a0)
    80006ee0:	00071c63          	bnez	a4,80006ef8 <release+0x90>
    80006ee4:	07c52783          	lw	a5,124(a0)
    80006ee8:	00078863          	beqz	a5,80006ef8 <release+0x90>
    80006eec:	100027f3          	csrr	a5,sstatus
    80006ef0:	0027e793          	ori	a5,a5,2
    80006ef4:	10079073          	csrw	sstatus,a5
    80006ef8:	01813083          	ld	ra,24(sp)
    80006efc:	01013403          	ld	s0,16(sp)
    80006f00:	00813483          	ld	s1,8(sp)
    80006f04:	00013903          	ld	s2,0(sp)
    80006f08:	02010113          	addi	sp,sp,32
    80006f0c:	00008067          	ret
    80006f10:	00001517          	auipc	a0,0x1
    80006f14:	53850513          	addi	a0,a0,1336 # 80008448 <digits+0x48>
    80006f18:	fffff097          	auipc	ra,0xfffff
    80006f1c:	154080e7          	jalr	340(ra) # 8000606c <panic>
    80006f20:	00001517          	auipc	a0,0x1
    80006f24:	51050513          	addi	a0,a0,1296 # 80008430 <digits+0x30>
    80006f28:	fffff097          	auipc	ra,0xfffff
    80006f2c:	144080e7          	jalr	324(ra) # 8000606c <panic>

0000000080006f30 <holding>:
    80006f30:	00052783          	lw	a5,0(a0)
    80006f34:	00079663          	bnez	a5,80006f40 <holding+0x10>
    80006f38:	00000513          	li	a0,0
    80006f3c:	00008067          	ret
    80006f40:	fe010113          	addi	sp,sp,-32
    80006f44:	00813823          	sd	s0,16(sp)
    80006f48:	00913423          	sd	s1,8(sp)
    80006f4c:	00113c23          	sd	ra,24(sp)
    80006f50:	02010413          	addi	s0,sp,32
    80006f54:	01053483          	ld	s1,16(a0)
    80006f58:	ffffe097          	auipc	ra,0xffffe
    80006f5c:	75c080e7          	jalr	1884(ra) # 800056b4 <mycpu>
    80006f60:	01813083          	ld	ra,24(sp)
    80006f64:	01013403          	ld	s0,16(sp)
    80006f68:	40a48533          	sub	a0,s1,a0
    80006f6c:	00153513          	seqz	a0,a0
    80006f70:	00813483          	ld	s1,8(sp)
    80006f74:	02010113          	addi	sp,sp,32
    80006f78:	00008067          	ret

0000000080006f7c <push_off>:
    80006f7c:	fe010113          	addi	sp,sp,-32
    80006f80:	00813823          	sd	s0,16(sp)
    80006f84:	00113c23          	sd	ra,24(sp)
    80006f88:	00913423          	sd	s1,8(sp)
    80006f8c:	02010413          	addi	s0,sp,32
    80006f90:	100024f3          	csrr	s1,sstatus
    80006f94:	100027f3          	csrr	a5,sstatus
    80006f98:	ffd7f793          	andi	a5,a5,-3
    80006f9c:	10079073          	csrw	sstatus,a5
    80006fa0:	ffffe097          	auipc	ra,0xffffe
    80006fa4:	714080e7          	jalr	1812(ra) # 800056b4 <mycpu>
    80006fa8:	07852783          	lw	a5,120(a0)
    80006fac:	02078663          	beqz	a5,80006fd8 <push_off+0x5c>
    80006fb0:	ffffe097          	auipc	ra,0xffffe
    80006fb4:	704080e7          	jalr	1796(ra) # 800056b4 <mycpu>
    80006fb8:	07852783          	lw	a5,120(a0)
    80006fbc:	01813083          	ld	ra,24(sp)
    80006fc0:	01013403          	ld	s0,16(sp)
    80006fc4:	0017879b          	addiw	a5,a5,1
    80006fc8:	06f52c23          	sw	a5,120(a0)
    80006fcc:	00813483          	ld	s1,8(sp)
    80006fd0:	02010113          	addi	sp,sp,32
    80006fd4:	00008067          	ret
    80006fd8:	0014d493          	srli	s1,s1,0x1
    80006fdc:	ffffe097          	auipc	ra,0xffffe
    80006fe0:	6d8080e7          	jalr	1752(ra) # 800056b4 <mycpu>
    80006fe4:	0014f493          	andi	s1,s1,1
    80006fe8:	06952e23          	sw	s1,124(a0)
    80006fec:	fc5ff06f          	j	80006fb0 <push_off+0x34>

0000000080006ff0 <pop_off>:
    80006ff0:	ff010113          	addi	sp,sp,-16
    80006ff4:	00813023          	sd	s0,0(sp)
    80006ff8:	00113423          	sd	ra,8(sp)
    80006ffc:	01010413          	addi	s0,sp,16
    80007000:	ffffe097          	auipc	ra,0xffffe
    80007004:	6b4080e7          	jalr	1716(ra) # 800056b4 <mycpu>
    80007008:	100027f3          	csrr	a5,sstatus
    8000700c:	0027f793          	andi	a5,a5,2
    80007010:	04079663          	bnez	a5,8000705c <pop_off+0x6c>
    80007014:	07852783          	lw	a5,120(a0)
    80007018:	02f05a63          	blez	a5,8000704c <pop_off+0x5c>
    8000701c:	fff7871b          	addiw	a4,a5,-1
    80007020:	06e52c23          	sw	a4,120(a0)
    80007024:	00071c63          	bnez	a4,8000703c <pop_off+0x4c>
    80007028:	07c52783          	lw	a5,124(a0)
    8000702c:	00078863          	beqz	a5,8000703c <pop_off+0x4c>
    80007030:	100027f3          	csrr	a5,sstatus
    80007034:	0027e793          	ori	a5,a5,2
    80007038:	10079073          	csrw	sstatus,a5
    8000703c:	00813083          	ld	ra,8(sp)
    80007040:	00013403          	ld	s0,0(sp)
    80007044:	01010113          	addi	sp,sp,16
    80007048:	00008067          	ret
    8000704c:	00001517          	auipc	a0,0x1
    80007050:	3fc50513          	addi	a0,a0,1020 # 80008448 <digits+0x48>
    80007054:	fffff097          	auipc	ra,0xfffff
    80007058:	018080e7          	jalr	24(ra) # 8000606c <panic>
    8000705c:	00001517          	auipc	a0,0x1
    80007060:	3d450513          	addi	a0,a0,980 # 80008430 <digits+0x30>
    80007064:	fffff097          	auipc	ra,0xfffff
    80007068:	008080e7          	jalr	8(ra) # 8000606c <panic>

000000008000706c <push_on>:
    8000706c:	fe010113          	addi	sp,sp,-32
    80007070:	00813823          	sd	s0,16(sp)
    80007074:	00113c23          	sd	ra,24(sp)
    80007078:	00913423          	sd	s1,8(sp)
    8000707c:	02010413          	addi	s0,sp,32
    80007080:	100024f3          	csrr	s1,sstatus
    80007084:	100027f3          	csrr	a5,sstatus
    80007088:	0027e793          	ori	a5,a5,2
    8000708c:	10079073          	csrw	sstatus,a5
    80007090:	ffffe097          	auipc	ra,0xffffe
    80007094:	624080e7          	jalr	1572(ra) # 800056b4 <mycpu>
    80007098:	07852783          	lw	a5,120(a0)
    8000709c:	02078663          	beqz	a5,800070c8 <push_on+0x5c>
    800070a0:	ffffe097          	auipc	ra,0xffffe
    800070a4:	614080e7          	jalr	1556(ra) # 800056b4 <mycpu>
    800070a8:	07852783          	lw	a5,120(a0)
    800070ac:	01813083          	ld	ra,24(sp)
    800070b0:	01013403          	ld	s0,16(sp)
    800070b4:	0017879b          	addiw	a5,a5,1
    800070b8:	06f52c23          	sw	a5,120(a0)
    800070bc:	00813483          	ld	s1,8(sp)
    800070c0:	02010113          	addi	sp,sp,32
    800070c4:	00008067          	ret
    800070c8:	0014d493          	srli	s1,s1,0x1
    800070cc:	ffffe097          	auipc	ra,0xffffe
    800070d0:	5e8080e7          	jalr	1512(ra) # 800056b4 <mycpu>
    800070d4:	0014f493          	andi	s1,s1,1
    800070d8:	06952e23          	sw	s1,124(a0)
    800070dc:	fc5ff06f          	j	800070a0 <push_on+0x34>

00000000800070e0 <pop_on>:
    800070e0:	ff010113          	addi	sp,sp,-16
    800070e4:	00813023          	sd	s0,0(sp)
    800070e8:	00113423          	sd	ra,8(sp)
    800070ec:	01010413          	addi	s0,sp,16
    800070f0:	ffffe097          	auipc	ra,0xffffe
    800070f4:	5c4080e7          	jalr	1476(ra) # 800056b4 <mycpu>
    800070f8:	100027f3          	csrr	a5,sstatus
    800070fc:	0027f793          	andi	a5,a5,2
    80007100:	04078463          	beqz	a5,80007148 <pop_on+0x68>
    80007104:	07852783          	lw	a5,120(a0)
    80007108:	02f05863          	blez	a5,80007138 <pop_on+0x58>
    8000710c:	fff7879b          	addiw	a5,a5,-1
    80007110:	06f52c23          	sw	a5,120(a0)
    80007114:	07853783          	ld	a5,120(a0)
    80007118:	00079863          	bnez	a5,80007128 <pop_on+0x48>
    8000711c:	100027f3          	csrr	a5,sstatus
    80007120:	ffd7f793          	andi	a5,a5,-3
    80007124:	10079073          	csrw	sstatus,a5
    80007128:	00813083          	ld	ra,8(sp)
    8000712c:	00013403          	ld	s0,0(sp)
    80007130:	01010113          	addi	sp,sp,16
    80007134:	00008067          	ret
    80007138:	00001517          	auipc	a0,0x1
    8000713c:	33850513          	addi	a0,a0,824 # 80008470 <digits+0x70>
    80007140:	fffff097          	auipc	ra,0xfffff
    80007144:	f2c080e7          	jalr	-212(ra) # 8000606c <panic>
    80007148:	00001517          	auipc	a0,0x1
    8000714c:	30850513          	addi	a0,a0,776 # 80008450 <digits+0x50>
    80007150:	fffff097          	auipc	ra,0xfffff
    80007154:	f1c080e7          	jalr	-228(ra) # 8000606c <panic>

0000000080007158 <__memset>:
    80007158:	ff010113          	addi	sp,sp,-16
    8000715c:	00813423          	sd	s0,8(sp)
    80007160:	01010413          	addi	s0,sp,16
    80007164:	1a060e63          	beqz	a2,80007320 <__memset+0x1c8>
    80007168:	40a007b3          	neg	a5,a0
    8000716c:	0077f793          	andi	a5,a5,7
    80007170:	00778693          	addi	a3,a5,7
    80007174:	00b00813          	li	a6,11
    80007178:	0ff5f593          	andi	a1,a1,255
    8000717c:	fff6071b          	addiw	a4,a2,-1
    80007180:	1b06e663          	bltu	a3,a6,8000732c <__memset+0x1d4>
    80007184:	1cd76463          	bltu	a4,a3,8000734c <__memset+0x1f4>
    80007188:	1a078e63          	beqz	a5,80007344 <__memset+0x1ec>
    8000718c:	00b50023          	sb	a1,0(a0)
    80007190:	00100713          	li	a4,1
    80007194:	1ae78463          	beq	a5,a4,8000733c <__memset+0x1e4>
    80007198:	00b500a3          	sb	a1,1(a0)
    8000719c:	00200713          	li	a4,2
    800071a0:	1ae78a63          	beq	a5,a4,80007354 <__memset+0x1fc>
    800071a4:	00b50123          	sb	a1,2(a0)
    800071a8:	00300713          	li	a4,3
    800071ac:	18e78463          	beq	a5,a4,80007334 <__memset+0x1dc>
    800071b0:	00b501a3          	sb	a1,3(a0)
    800071b4:	00400713          	li	a4,4
    800071b8:	1ae78263          	beq	a5,a4,8000735c <__memset+0x204>
    800071bc:	00b50223          	sb	a1,4(a0)
    800071c0:	00500713          	li	a4,5
    800071c4:	1ae78063          	beq	a5,a4,80007364 <__memset+0x20c>
    800071c8:	00b502a3          	sb	a1,5(a0)
    800071cc:	00700713          	li	a4,7
    800071d0:	18e79e63          	bne	a5,a4,8000736c <__memset+0x214>
    800071d4:	00b50323          	sb	a1,6(a0)
    800071d8:	00700e93          	li	t4,7
    800071dc:	00859713          	slli	a4,a1,0x8
    800071e0:	00e5e733          	or	a4,a1,a4
    800071e4:	01059e13          	slli	t3,a1,0x10
    800071e8:	01c76e33          	or	t3,a4,t3
    800071ec:	01859313          	slli	t1,a1,0x18
    800071f0:	006e6333          	or	t1,t3,t1
    800071f4:	02059893          	slli	a7,a1,0x20
    800071f8:	40f60e3b          	subw	t3,a2,a5
    800071fc:	011368b3          	or	a7,t1,a7
    80007200:	02859813          	slli	a6,a1,0x28
    80007204:	0108e833          	or	a6,a7,a6
    80007208:	03059693          	slli	a3,a1,0x30
    8000720c:	003e589b          	srliw	a7,t3,0x3
    80007210:	00d866b3          	or	a3,a6,a3
    80007214:	03859713          	slli	a4,a1,0x38
    80007218:	00389813          	slli	a6,a7,0x3
    8000721c:	00f507b3          	add	a5,a0,a5
    80007220:	00e6e733          	or	a4,a3,a4
    80007224:	000e089b          	sext.w	a7,t3
    80007228:	00f806b3          	add	a3,a6,a5
    8000722c:	00e7b023          	sd	a4,0(a5)
    80007230:	00878793          	addi	a5,a5,8
    80007234:	fed79ce3          	bne	a5,a3,8000722c <__memset+0xd4>
    80007238:	ff8e7793          	andi	a5,t3,-8
    8000723c:	0007871b          	sext.w	a4,a5
    80007240:	01d787bb          	addw	a5,a5,t4
    80007244:	0ce88e63          	beq	a7,a4,80007320 <__memset+0x1c8>
    80007248:	00f50733          	add	a4,a0,a5
    8000724c:	00b70023          	sb	a1,0(a4)
    80007250:	0017871b          	addiw	a4,a5,1
    80007254:	0cc77663          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    80007258:	00e50733          	add	a4,a0,a4
    8000725c:	00b70023          	sb	a1,0(a4)
    80007260:	0027871b          	addiw	a4,a5,2
    80007264:	0ac77e63          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    80007268:	00e50733          	add	a4,a0,a4
    8000726c:	00b70023          	sb	a1,0(a4)
    80007270:	0037871b          	addiw	a4,a5,3
    80007274:	0ac77663          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    80007278:	00e50733          	add	a4,a0,a4
    8000727c:	00b70023          	sb	a1,0(a4)
    80007280:	0047871b          	addiw	a4,a5,4
    80007284:	08c77e63          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    80007288:	00e50733          	add	a4,a0,a4
    8000728c:	00b70023          	sb	a1,0(a4)
    80007290:	0057871b          	addiw	a4,a5,5
    80007294:	08c77663          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    80007298:	00e50733          	add	a4,a0,a4
    8000729c:	00b70023          	sb	a1,0(a4)
    800072a0:	0067871b          	addiw	a4,a5,6
    800072a4:	06c77e63          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    800072a8:	00e50733          	add	a4,a0,a4
    800072ac:	00b70023          	sb	a1,0(a4)
    800072b0:	0077871b          	addiw	a4,a5,7
    800072b4:	06c77663          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    800072b8:	00e50733          	add	a4,a0,a4
    800072bc:	00b70023          	sb	a1,0(a4)
    800072c0:	0087871b          	addiw	a4,a5,8
    800072c4:	04c77e63          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    800072c8:	00e50733          	add	a4,a0,a4
    800072cc:	00b70023          	sb	a1,0(a4)
    800072d0:	0097871b          	addiw	a4,a5,9
    800072d4:	04c77663          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    800072d8:	00e50733          	add	a4,a0,a4
    800072dc:	00b70023          	sb	a1,0(a4)
    800072e0:	00a7871b          	addiw	a4,a5,10
    800072e4:	02c77e63          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    800072e8:	00e50733          	add	a4,a0,a4
    800072ec:	00b70023          	sb	a1,0(a4)
    800072f0:	00b7871b          	addiw	a4,a5,11
    800072f4:	02c77663          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    800072f8:	00e50733          	add	a4,a0,a4
    800072fc:	00b70023          	sb	a1,0(a4)
    80007300:	00c7871b          	addiw	a4,a5,12
    80007304:	00c77e63          	bgeu	a4,a2,80007320 <__memset+0x1c8>
    80007308:	00e50733          	add	a4,a0,a4
    8000730c:	00b70023          	sb	a1,0(a4)
    80007310:	00d7879b          	addiw	a5,a5,13
    80007314:	00c7f663          	bgeu	a5,a2,80007320 <__memset+0x1c8>
    80007318:	00f507b3          	add	a5,a0,a5
    8000731c:	00b78023          	sb	a1,0(a5)
    80007320:	00813403          	ld	s0,8(sp)
    80007324:	01010113          	addi	sp,sp,16
    80007328:	00008067          	ret
    8000732c:	00b00693          	li	a3,11
    80007330:	e55ff06f          	j	80007184 <__memset+0x2c>
    80007334:	00300e93          	li	t4,3
    80007338:	ea5ff06f          	j	800071dc <__memset+0x84>
    8000733c:	00100e93          	li	t4,1
    80007340:	e9dff06f          	j	800071dc <__memset+0x84>
    80007344:	00000e93          	li	t4,0
    80007348:	e95ff06f          	j	800071dc <__memset+0x84>
    8000734c:	00000793          	li	a5,0
    80007350:	ef9ff06f          	j	80007248 <__memset+0xf0>
    80007354:	00200e93          	li	t4,2
    80007358:	e85ff06f          	j	800071dc <__memset+0x84>
    8000735c:	00400e93          	li	t4,4
    80007360:	e7dff06f          	j	800071dc <__memset+0x84>
    80007364:	00500e93          	li	t4,5
    80007368:	e75ff06f          	j	800071dc <__memset+0x84>
    8000736c:	00600e93          	li	t4,6
    80007370:	e6dff06f          	j	800071dc <__memset+0x84>

0000000080007374 <__memmove>:
    80007374:	ff010113          	addi	sp,sp,-16
    80007378:	00813423          	sd	s0,8(sp)
    8000737c:	01010413          	addi	s0,sp,16
    80007380:	0e060863          	beqz	a2,80007470 <__memmove+0xfc>
    80007384:	fff6069b          	addiw	a3,a2,-1
    80007388:	0006881b          	sext.w	a6,a3
    8000738c:	0ea5e863          	bltu	a1,a0,8000747c <__memmove+0x108>
    80007390:	00758713          	addi	a4,a1,7
    80007394:	00a5e7b3          	or	a5,a1,a0
    80007398:	40a70733          	sub	a4,a4,a0
    8000739c:	0077f793          	andi	a5,a5,7
    800073a0:	00f73713          	sltiu	a4,a4,15
    800073a4:	00174713          	xori	a4,a4,1
    800073a8:	0017b793          	seqz	a5,a5
    800073ac:	00e7f7b3          	and	a5,a5,a4
    800073b0:	10078863          	beqz	a5,800074c0 <__memmove+0x14c>
    800073b4:	00900793          	li	a5,9
    800073b8:	1107f463          	bgeu	a5,a6,800074c0 <__memmove+0x14c>
    800073bc:	0036581b          	srliw	a6,a2,0x3
    800073c0:	fff8081b          	addiw	a6,a6,-1
    800073c4:	02081813          	slli	a6,a6,0x20
    800073c8:	01d85893          	srli	a7,a6,0x1d
    800073cc:	00858813          	addi	a6,a1,8
    800073d0:	00058793          	mv	a5,a1
    800073d4:	00050713          	mv	a4,a0
    800073d8:	01088833          	add	a6,a7,a6
    800073dc:	0007b883          	ld	a7,0(a5)
    800073e0:	00878793          	addi	a5,a5,8
    800073e4:	00870713          	addi	a4,a4,8
    800073e8:	ff173c23          	sd	a7,-8(a4)
    800073ec:	ff0798e3          	bne	a5,a6,800073dc <__memmove+0x68>
    800073f0:	ff867713          	andi	a4,a2,-8
    800073f4:	02071793          	slli	a5,a4,0x20
    800073f8:	0207d793          	srli	a5,a5,0x20
    800073fc:	00f585b3          	add	a1,a1,a5
    80007400:	40e686bb          	subw	a3,a3,a4
    80007404:	00f507b3          	add	a5,a0,a5
    80007408:	06e60463          	beq	a2,a4,80007470 <__memmove+0xfc>
    8000740c:	0005c703          	lbu	a4,0(a1)
    80007410:	00e78023          	sb	a4,0(a5)
    80007414:	04068e63          	beqz	a3,80007470 <__memmove+0xfc>
    80007418:	0015c603          	lbu	a2,1(a1)
    8000741c:	00100713          	li	a4,1
    80007420:	00c780a3          	sb	a2,1(a5)
    80007424:	04e68663          	beq	a3,a4,80007470 <__memmove+0xfc>
    80007428:	0025c603          	lbu	a2,2(a1)
    8000742c:	00200713          	li	a4,2
    80007430:	00c78123          	sb	a2,2(a5)
    80007434:	02e68e63          	beq	a3,a4,80007470 <__memmove+0xfc>
    80007438:	0035c603          	lbu	a2,3(a1)
    8000743c:	00300713          	li	a4,3
    80007440:	00c781a3          	sb	a2,3(a5)
    80007444:	02e68663          	beq	a3,a4,80007470 <__memmove+0xfc>
    80007448:	0045c603          	lbu	a2,4(a1)
    8000744c:	00400713          	li	a4,4
    80007450:	00c78223          	sb	a2,4(a5)
    80007454:	00e68e63          	beq	a3,a4,80007470 <__memmove+0xfc>
    80007458:	0055c603          	lbu	a2,5(a1)
    8000745c:	00500713          	li	a4,5
    80007460:	00c782a3          	sb	a2,5(a5)
    80007464:	00e68663          	beq	a3,a4,80007470 <__memmove+0xfc>
    80007468:	0065c703          	lbu	a4,6(a1)
    8000746c:	00e78323          	sb	a4,6(a5)
    80007470:	00813403          	ld	s0,8(sp)
    80007474:	01010113          	addi	sp,sp,16
    80007478:	00008067          	ret
    8000747c:	02061713          	slli	a4,a2,0x20
    80007480:	02075713          	srli	a4,a4,0x20
    80007484:	00e587b3          	add	a5,a1,a4
    80007488:	f0f574e3          	bgeu	a0,a5,80007390 <__memmove+0x1c>
    8000748c:	02069613          	slli	a2,a3,0x20
    80007490:	02065613          	srli	a2,a2,0x20
    80007494:	fff64613          	not	a2,a2
    80007498:	00e50733          	add	a4,a0,a4
    8000749c:	00c78633          	add	a2,a5,a2
    800074a0:	fff7c683          	lbu	a3,-1(a5)
    800074a4:	fff78793          	addi	a5,a5,-1
    800074a8:	fff70713          	addi	a4,a4,-1
    800074ac:	00d70023          	sb	a3,0(a4)
    800074b0:	fec798e3          	bne	a5,a2,800074a0 <__memmove+0x12c>
    800074b4:	00813403          	ld	s0,8(sp)
    800074b8:	01010113          	addi	sp,sp,16
    800074bc:	00008067          	ret
    800074c0:	02069713          	slli	a4,a3,0x20
    800074c4:	02075713          	srli	a4,a4,0x20
    800074c8:	00170713          	addi	a4,a4,1
    800074cc:	00e50733          	add	a4,a0,a4
    800074d0:	00050793          	mv	a5,a0
    800074d4:	0005c683          	lbu	a3,0(a1)
    800074d8:	00178793          	addi	a5,a5,1
    800074dc:	00158593          	addi	a1,a1,1
    800074e0:	fed78fa3          	sb	a3,-1(a5)
    800074e4:	fee798e3          	bne	a5,a4,800074d4 <__memmove+0x160>
    800074e8:	f89ff06f          	j	80007470 <__memmove+0xfc>
	...
