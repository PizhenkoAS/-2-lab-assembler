%include "io64.inc"
%include "io64_float.inc"
section .bss
x: resq 1
y: resq 1
a: resq 1
s: resq 1
section .text
global CMAIN
CMAIN:
    mov rbp, rsp;
    finit
    mov rax, __float64__(3.0)
    mov qword[s], rax 
    FLD qword[s] ;хранение 3
    FLD1 ;1
    READ_DOUBLE [x]
    READ_DOUBLE [a]
    FLD qword[x]
    fsin            ;sin x
    FLD qword[a]
    fadd            ;sin x + a
    FYL2X           ;логарифм по основанию 2 (sin x + a)
    
    FLD1 ;1
    
    fldl2e ;логарифм по основанию 2 е
    
    
    fdiv            ;log e (sin x + a)
    
                ; возведение в степень 
    FYL2X ;вычисляем показатель
    FLD1 ;загружаем +1.0 в стек
    FLD ST1 ;дублируем показатель в стек
    FPREM ;получаем дробную часть
    F2XM1 ;возводим в дробную часть показателя
    FADD ;прибавляем 1 из стека
    FSCALE ;возводим в целую часть и умножаем
    FSTP ST1 ; выталкиваем лишнее из вершины
    

    READ_DOUBLE [y]
    FLD qword[y]
    
    fcomip ;сравнение
    fstp ST0
    ja false
    PRINT_STRING "Yes"
    xor rax, rax
    ret
    false:
    PRINT_STRING "No"
    xor rax, rax
    ret