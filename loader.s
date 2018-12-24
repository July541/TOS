.set MAGIC, 0x1badb002 # make sure loader can be read
.set FLAGS, (1<<0 | 1<<1)
.set CHECKSUM, -(MAGIC + FLAGS)

.section .multiboot:
    .long MAGIC
    .long FLAGS
    .long CHECKSUM


.section .text
.extern kernalMain
.extern callConstructors
.global loader

loader:
    mov $kernal_stack, %esp

    call callConstructors

    push %eax
    push %ebx
    call kernalMain

_stop:
    cli
    hlt
    jmp _stop

.section .bss
.space 2*1024*1024; # 2MiB
kernal_stack:
