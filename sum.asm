; ----------------------------------------------------------------------------------------
; Writes sum of odd numbers from 0 to 15 to the console using only system calls. Runs on 64-bit Linux only. (for mac there is $0x2000000 offset for every system call)
; To assemble and run:
;
;     nasm -felf64 sum.asm && ld -o sum.out sum.o && gdb sum.out
; ----------------------------------------------------------------------------------------


section .data
    lpCount dq  15
    sum1 dq  0
    sum2 dq  0

section .text
    global _start

_start:
    mov rcx, qword [lpCount]
    mov rax, 1
    call _first_sum_loop
    mov rax, 1
    mov ecx, dword[lpCount]
    call _second_sum_loop
_end: 
  mov rax, 60
  mov rdi, 0
  syscall

_first_sum_loop:
    add qword[sum1], rax
    add rax, 2 ; move to next odd number
    dec rcx
    cmp rcx, 0
    jne _first_sum_loop
    ret ; return to call

_second_sum_loop:
    add qword[sum2], rax
    add rax, 2
    loop _second_sum_loop
    ret
