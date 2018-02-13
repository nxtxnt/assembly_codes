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
;         GET NUMERATOR
                                  ;the numerator is number of times the value can be divided by 10, we will use it to isolate
                                  ;units, decimal, hundreds, thousands etc.

    init01:
      mov ax, [random_data_size]  ;we initialize ax with the 
      mov bl, ax                  ;bl (our counter) is initialized at random_data_size
      
    get_num:
      div ax, 10                  ;we divide ax by 10 each time, if eax is inferior to 10, bl will end up with null value
      dec bl                      ;bl is first decremented so always inferior to random_data_size
      cmp ax, 0
      call write_on_array
      jg get_num                  ;while eax is greater than 0


;--------------------------------
;         EXTRACT NUM
                                  ;here we extract the specefic number we want to extract, since ax is divided by 10 each time
                                  ;the number we want to extract next is always the last digit
                                  ;(or first if we count from right to left) 1 2 3 4 <--- last digit
                                  ;random_data_size_as_chars's memory address where the digit will be put
        write_on_array:
          mov cx, ax                ;ax's value will be used to point the location inside
          div cx, 10                ;123/10 = 12
          mul cx, 10                ;12*10 = 120
          mov cx, ax-dx             ;123-120 = 3 we isolated our digit !
          add cx, 48                ;expressing our digit as a readable character, 48 being the character '0'
          mov [random_data_size_as_chars+bl], byte cx
