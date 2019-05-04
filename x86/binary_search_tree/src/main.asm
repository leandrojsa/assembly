
%include "lib/asm_io.inc"


segment .data
  

    debug_msg1 db "===== DEBUG ====", 0
    debug_msg2 db "AQUI",10, 0
    debug_msg3 db "Memory: ", 0


segment .bss

    tree resd 1
    num_nodes resd 1


segment .text  

%include "src/binary_search_tree.asm"

        global  asm_main
asm_main:
    
    push tree
    push num_nodes
    call init
    add esp, 8
    
    call debug
    
    push dword 15
    push tree
    push num_nodes
    call insert
    add esp, 12
    
    call debug
    
    push dword 10
    push tree
    push num_nodes
    call insert
    add esp, 12
    
    call debug
    
    push dword 20
    push tree
    push num_nodes
    call insert
    add esp, 12
    
    call debug
    
    push dword 5
    push tree
    push num_nodes
    call insert
    add esp, 12
    
    call debug
    
    
    ;mov eax, [num_nodes]
    ;call print_int

   push tree
   call print_pre_order
   add esp, 4
   call print_nl
   
   push tree
   push dword 18
   call search_value
   add esp, 8
   call print_int
   call print_nl
   

    leave                     
    ret







