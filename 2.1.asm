%include "io64.inc"
%include "io64_float.inc"
section .rodata
n: dd 100
section .text
global CMAIN
CMAIN:
    mov rbp, rsp
    READ_DOUBLE xmm7              ; xmm7 - хранит x
    mov r8,1
    cvtsi2sd xmm9, r8              ; xmm9 - ИТОГ (изначально 1)
    mov r13,1
    mov r12,2
    mov r11, -1
    mov r10, 1
    mov r14, 1
    mov r9,1
    movsd xmm8, xmm7
    cvtsi2sd xmm10, r11
    cvtsi2sd xmm3, r8
  
    Cos:     
                       
        Fact:                      ; подсчет факториала от 1(r9) до r12( 2*n)
            cvtsi2sd xmm4, r9      
            mulsd xmm3, xmm4       ; xmm3 - итоговое значение факториала для одного слагаемого
            inc r9
            cmp r9d, r12d
            jbe Fact
        XinPower:                    ; возведение в степень идет от 1(r9) до r12( 2*n)
            mulsd xmm8, xmm7         ; xmm8 -  итоговое значение x в степени 2*n для одного слагаемого
            inc r14
            cmp r14d, r12d
            jl XinPower
        mov r10,0 
        movsd xmm11, xmm10  
        OneinPower:                    ; возведение в степень идет от 1(r9) до r13 (n)
            mulsd xmm11, xmm10         ; xmm11 -  итоговое значение (-1) в степени n для одного слагаемого
            inc r10
            cmp r10d, r13d
            jbe OneinPower    
        movsd xmm12, xmm8 ;xmm12 = х в степени
        divsd xmm12,xmm3 
        mulsd xmm12,xmm11
        addsd xmm9,xmm12
        inc r13
        xor r12,r12
        add r12, r13
        add r12, r13
        cmp r13d,[n]
        jle Cos
    PRINT_DOUBLE xmm9
    xor rax,rax
    xor eax,eax
    ret