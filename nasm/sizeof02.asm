section .data

section .bss
  val: dw 1
  val_as_chars: byte 10

section .text
  global _start
  
  _start:
    mov eax, [val]
    mov ebx, eax
    call get_numeration
    

;-----------------------
;   get the numerator

     get_numeration:
        shr eax, 1
        cmp eax, 0
        je incr

      incr:
        inc eax

;-----------------------
;    convert to char

    
