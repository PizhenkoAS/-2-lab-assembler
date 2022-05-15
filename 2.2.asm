%include "io64.inc"
%include "io64_float.inc"
section .bss
a: resq 1
b: resq 1
x: resq 1
section .text
global CMAIN
CMAIN:
    mov rbp, rsp
    READ_DOUBLE [b]
    fninit      ;сопроцессор 
    
            ; вычисление арккосинуса                      
    FLD qword[b]
    FLD qword[b]             
    fmul; b в квадрате
    fld1
    fsubrp; b в квадрате - 1
    fsqrt; корень из (b в квадрате - 1)
    FLD qword[b]  
    fpatan; арктангенс, но из-за вычислений выше он превратится в арккосинус
    
             ; это вычисление экспоненты 
    
    fldl2e  ;логарифм по основанию 2 е
    fld st0  
    frndint ; вычисление целой части
    fsub st1, st0 ; вычитание
    fxch st1 ;обмен
    f2xm1 ; возводим в дробную часть показателя
    fld1 ;загружаем +1.0 в стек
    fadd ;прибавляем 1 из стека
    fscale ;возведение в степень равную ближайшему  целому к ST0
    fstp st1 ;удаление
    
            ; возведение в степень 
    FYL2X ;вычисляем показатель
    FLD1 ;загружаем +1.0 в стек
    FLD ST1 ;дублируем показатель в стек
    FPREM ;получаем дробную часть
    F2XM1 ;возводим в дробную часть показателя
    FADD ;прибавляем 1 из стека
    FSCALE ;возводим в целую часть и умножаем
    FSTP ST1 ; выталкиваем лишнее из вершины
    
             ; вычитание a
    READ_DOUBLE [a]
    FLD qword[a] 
    fsub
    
    
    fstp qword[x]                       ;достаем искомое значение
    PRINT_DOUBLE [x]                    ;выводим искомое значение 
    ret