; ---------------------------------------------------------------------------------------
;|second attempt at making a better sizeof that can print variables bigger than one digit|
; ---------------------------------------------------------------------------------------

section .data

section .bss
  random_data resb 22                   ;data to measure
  random_data_size resb 4               ;variable that will store the size of random_data
  random_data_size_as_chars: resb 10    ;variable that will contain the value of random_data_size expressed in chars

section .text
  global _start
  
  _start:
  
  
;-----------------------
;convert 

    mov eax, [val]
    mov ebx, eax
    call get_numeration
    

;-----------------------
;   get the numerator   

     get_numeration:
        inc bl
        shr eax, 1
        cmp eax, 0
        jg get_numeration

;-----------------------
;    convert to char

    loop:
      cmp dl, cl
      jg
    
    to_char:
      mov eax, []
