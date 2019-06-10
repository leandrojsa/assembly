
%include "lib/asm_io.inc"


segment .data
  

; filename db "test.txt", 0
 buflen dd 2048


segment .bss

   filename resb 128

   buffer resb 2048 


segment .text  

%include "src/read_write_file.asm"

        global  asm_main
asm_main:

    mov edi, filename
    lp:
        call read_char
        cmp al, 10
        je over
        stosb
        jmp lp
    over:
    mov byte [edi], 0
    mov eax, filename
    call print_string
        
    
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







