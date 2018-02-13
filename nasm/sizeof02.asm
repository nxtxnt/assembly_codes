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
  
;-----------------------------------------------------------------------------------------
;                           EXPRESSING OUR RESULT AS CHAR

;--------------------------------
;         get numerator

    init01:
      mov ax, [random_data_size]  ;we initialize ax with the 
      
    get_num:
      mov bl, -1                  ;bl is initialized at -1 so that if numerator is zero the increment will set it to 0 and not 1
      div ax, 10                  ;we divide ax by 10 each time, if eax is inferior to 10, bl will end up with null value
      inc bl
      cmp eax, 0
      call write_on_array
      jg get_num                  ;while eax is greater than 0


;--------------------------------
;     write on char array

      write_on_char_array:
        
      
      get_val:
      
