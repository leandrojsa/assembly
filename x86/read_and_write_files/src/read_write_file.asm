;read_file(*filename, *buffer, *buffer_length))
read_file:
mov eax, 5 ;__NR_open
  push ebp
  mov ebp, esp
  
      mov ebx, [esp+16] ;filename
      mov ecx, 2 ; open mode
      mov edx, 700 ; file permissions (if we're creating it) - usually octal!
      int 80h
      cmp eax, -4096
      ja error_read
      
      mov ebx, eax ; Move our file descriptor into ebx
      mov eax, 0x03 ; syscall for read = 3
      mov ecx, [esp+12] ; Our 2kb byte buffer
      mov edx, [esp+8] ; The size of our buffer
      int 0x80
      
      error_read:

    pop ebp
ret


;write_file(*filename, *buffer, *buffer_length)
write_file:
push ebp
  mov ebp, esp
  
      mov ebx, [esp+16] ;filename
      mov ecx, 2 ; open mode
      mov edx, 700 ; file permissions (if we're creating it) - usually octal!
      int 80h
      cmp eax, -4096
      ja error_write
      
      mov ebx, eax ; Move our file descriptor into ebx
      mov eax, 0x04 ; syscall for write = 4
      mov ecx, [esp+12] ; Our 2kb byte buffer
      mov edx, [esp+8] ; The size of our buffer
      int 0x80
      
      error_write:
    pop ebp
ret

;close_file(file_descriptor)
close_file:
push ebp
mov ebp, esp
  mov eax, 6  ; __NR_close
  mov ebx, [esp+8]
  int 80h
  
pop ebp
ret



