; ---------------------------------------------------------------------------------------
;|second attempt at making a better sizeof that can print variables bigger than one digit|
; ---------------------------------------------------------------------------------------

section .data

section .bss
  random_data resb 22                   ;data to measure
  random_data_size resb 4               ;variable that will store the size of random_data
  random_data_size_as_chars: resb 10    ;variable that will contain the value of random_data_size expressed in chars
  size_random_data_size_as_chars equ $-random_data_size_as_chars ;we set the array's size at our current
                                                                 ;location minus the location of the previous variable

section .text
  global _start
  
  _start:
 
;-----------------------------------------------------------------------------------------
;                             GET THE SIZE OF THE RANDOM_DATA

  

;-----------------------------------------------------------------------------------------
;                           CONVERTING OUR RESULT AS CHAR

;--------------------------------
;         GET NUMERATOR
                                  ;the numerator is number of times the value can be divided by 10, we will use it to isolate
                                  ;units, decimal, hundreds, thousands etc.

    init01:
      mov al, [random_data_size]  ;we initialize ax with random_data_size let's it's say 123
      mov bl, al                  ;bl (our counter) is initialized at random_data_size
      
    get_num:
      mov bh, bl                  ;bh is bl's value kept intact kept intact (123)
      div bl, 10                  ;we divide ax by 10 each time, if eax is inferior to 10, bl will end up null, (123/10 = 12)
      cmp bl, 0                   ;<--+ 
      call write_on_array         ;   |
      jg get_num                  ;while eax is greater than 0


;--------------------------------
;         EXTRACT NUM
                                  ;here we extract the specefic number we want to extract, since ax is divided by 10 each time
                                  ;the number we want to extract next is always the last digit
                                  ;(or first if we count from right to left) 1 2 3 4 <--- last digit
                                  ;random_data_size_as_chars's memory address where the digit will be put
        write_on_array:
          mov cl, bl                ;ax's value will be used to point the location inside (cx = 12)
          mov dl, cl                ;dl will be used right after
          mul cl, 10                ;12*10 = 120
          mov cl, bh-dl             ;(bh = 123) - (dl = 120) = 3 we isolated our digit !
          add cl, 48                ;expressing our digit as a readable character, 48 being the character '0'
          mov [random_data_size_as_chars+bl], byte cl

;-------------------------------------------------------------------------------------------
;                                     PRINT OUR RESULT

        output:
          mov eax, 4
          mov ebx, 1
          mov ecx, random_data_size_as_chars
          mov edx, size_random_data_size_as_chars
          
;-------------------------------------------------------------------------------------------
;                                          EXIT

        exit:
          mov eax, 1
          int 80h
