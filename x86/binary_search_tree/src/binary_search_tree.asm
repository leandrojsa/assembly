debug:
    pusha
    pushf
    
    push eax
    mov eax, debug_msg1
    call print_string
    call print_nl
    call print_nl
    pop eax
    
    dump_regs 1               ; dump out register values
;    dump_mem 2, num_nodes, 1    ; dump out memory
    mov eax, debug_msg3
    call print_string
    mov eax, [tree]
    call print_int
    call print_nl
    
    push eax
    mov eax, debug_msg1
    call print_string
    call print_nl
    call print_nl
    pop eax

    popf
    popa

ret 

;init(*tree, *num_nodes)
init:
    push ebp
    mov ebp, esp
    
   ; push edi
    ;push esi
    ;push eax
    mov edi, [ebp + 8]  ;num_nodes
    mov esi, [ebp + 12] ;tree
    mov eax, 0
    mov [edi], eax
    mov [esi], eax
    
    ;pop eax
    ;pop esi
    ;pop edi
    
    pop ebp
ret

;
create_node:
    push ebp
    mov ebp, esp
    
    push ebx    
    mov	eax, 45		; sys_brk
	xor	ebx, ebx
	int	80h

	add	eax, 12	; reserve 12 bytes
	mov	ebx, eax
	mov	eax, 45		; sys_brk
	int	80h
    pop ebx
    
    pop ebp 
ret

;insert(int x, *tree, *num_nodes)
insert:
    push ebp
    mov ebp, esp
    
    mov ebx, [ebp + 16] ;x
    mov edi, [ebp + 12] ;tree
    mov esi, [ebp + 8]  ;num_nodes
    

    
    cmp dword [edi], 0  ;verify if tree is null
    je empty  
    mov edx, [edi] 
    cmp ebx, [edx]       ; compare x with tree->value
    jl insert_sub_tree_left
;sub_tree right    
    push ebx
    mov ecx, [edi]
    sub ecx, 4 ;get left child
    push dword ecx
    push esi
    call insert
    add esp, 12
    jmp end
    
    
    insert_sub_tree_left:
    push ebx
    mov ecx, [edi]
    sub ecx, 8 ;get left child
    push dword ecx
    push dword esi
    call insert
    add esp, 12
    jmp end
    
    empty:
    call create_node
    
    
    mov [eax], ebx    ;value node
    mov ecx, 0
    mov [eax -4], ecx ;right pointer
    mov [eax -8], ecx ;left pointer
    mov [edi], eax    ;connect node in the tree
    inc dword [esi]   ;increments num_nodes
     
     
    end:
    pop ebp
ret

;search(*tree, int x)
search_value:
    push ebp
    mov ebp, esp
    push ebx
    push edx
    
        mov edi, [ebp + 12] ;tree
        mov ebx, [ebp + 8]  ;x
        cmp dword [edi], 0
        je didnt_find
            mov edx, [edi]
            cmp ebx, [edx]
            jl search_sub_tree_left
            jg search_sub_tree_right
            
            ;found
            mov eax, 1
            jmp search_end
            
            search_sub_tree_left:
            sub edx, 8
            push edx
            push ebx
            call search_value
            add esp, 8
            jmp search_end
            
            search_sub_tree_right:
            sub edx, 4
            push edx
            push ebx
            call search_value
            add esp, 8
            jmp search_end
            
             
        didnt_find:
            mov eax, 0
        search_end:
    pop edx
    pop ebx
    pop ebp
ret
    

;print_pre_order(*tree)
print_pre_order:
    push ebp
    mov ebp, esp
    pusha
    pushf
        mov edi, [ebp+8] ;tree_address
        
   
        
        cmp dword [edi], 0
        je dont_print
            mov edx, [edi]
            mov eax, [edx]
            call print_int
            mov al, '-'
            call print_char
            
            sub edx, 8
            push edx
            call print_pre_order
            add  esp, 4
            
            add edx, 4
            push edx
            call print_pre_order
            add  esp, 4
            
        dont_print:
    popf
    popa
    pop ebp
ret



