
%include "lib/asm_io.inc"


segment .data
  

 filename db "test.txt", 0
 buflen dd 2048


segment .bss

   buffer resb 2048 


segment .text  

%include "src/read_write_file.asm"

        global  asm_main
asm_main:
    
    push filename
    push buffer
    push dword [buflen]
    call read_file
    add esp, 12
    
    mov esi, buffer
    cld 
    print:
        lodsb ;al = [esi] e esi+=1
        cmp al, 0
        je exit
        call print_char
    jmp print
    exit:
    call print_nl 
   

    leave                     
    ret







