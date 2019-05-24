
%include "lib/asm_io.inc"


segment .data
  

 filename db "./output.txt", 0
 text db "This is the content of my file. The zero after this string indicates the end of file, ok?!", 0
 textlen equ $ - text


segment .bss

   buffer resb 2048


segment .text  

%include "src/read_write_file.asm"

        global  asm_main
asm_main:
    
    push filename
    push text
    push dword textlen
    call write_file
    add esp, 12

    leave                     
    ret







