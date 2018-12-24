
.section .text

.set IRQ_BASE, 0x20

.extern _ZN16InterruptManager15handleInterruptEhj

.macro HandleException num
.global _ZN16InterruptManager16handleException\num\()Ev
    movb $\num + IRQ_BASE, (interruptnumber)
    jmp int_bottom
.endm

HandleInterruptRequest 0x00
HandleInterruptRequest 0x01

int_bottom:
    pusha
    puahl %ds
    pushl %es
    pushl %fs
    pushl %gs

    push %esp
    push (interruptnumber)
    call _ZN16InterruptManager15handleInterruptEhj

    mov %eax, %esp

    popl %gs
    popl %fs
    popl %es
    popl %ds
    popa

    iret

.data
    interruptnumber: .byte 0
