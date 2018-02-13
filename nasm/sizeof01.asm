; --------------------------------------------------------------------------
;|   assembly code that outputs a single digit-measurable variable's size   |
; --------------------------------------------------------------------------

section .data

section .bss
    random_data: resb 4                     ;here we declare our data we want to measure
    r_data_size: resb 1                     ;variable in which we're going to store random_data's size
        
    
section .text
    global _start
    
    _start:
    
    sizeof:                                 ;sizeof function
        mov al, r_data_size-random_data     ;here we set the value of r_data_size as the value of
        mov [r_data_size], al               ;random_data position in memory minus our current position in memory
        xor al, al
                       
    
    digit_to_char:                          ;converts a single digit to a char
        mov al, [r_data_size]               ;moving the value contained in r_data_size to register al
        add al, 48                          ;adding 48 so the value corresponds to an ascii value
        mov [r_data_size], al               ;get the value back to memory
        xor al, al
    
    print:                                  ;print function using the write_sys system call
        mov eax, 4
        mov ebx, 1
        mov ecx, r_data_size
        mov edx, 1
        int 80h
        
    exit:                                   ;exit function using the exit_sys system call
        mov eax, 1
        mov ebx, 1
        int 80h
            
