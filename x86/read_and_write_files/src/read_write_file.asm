;read_file(filename, *buffer, buffer_length))
read_file:

  push ebp
  mov ebp, esp
      mov eax, 5 ;__NR_open  
      mov ebx, [ebp+16] ;filename
      mov ecx, 2 ; open mode
      mov edx, 700 ; file permissions (if we're creating it) - usually octal!
      int 80h
      cmp eax, -4096
      ja error_read
      
      mov ebx, eax ; Move our file descriptor into ebx
      mov eax, 0x03 ; syscall for read = 3
      mov ecx, [ebp+12] ; Our 2kb byte buffer
      mov edx, [ebp+8] ; The size of our buffer
      int 0x80
      
      error_read:

    pop ebp
ret

; This function write in the file the content stored in the memory buffer (according the buffer size in parameter buffer_length). After it, the file is closed..
;write_file(filename, *buffer, buffer_length)
write_file:
push ebp
mov ebp, esp
    mov eax, 8
    mov ebx, [ebp+16] ;filename
    mov ecx, 0x0700
    int 0x80
    mov ebx, eax
    mov eax, 4
    mov ecx, [ebp+12] ;buffer
    mov edx, [ebp+8] ;buffer_length
    int 0x80
    mov eax, 6
    int 0x80
    mov eax, 1
    int 0x80
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



