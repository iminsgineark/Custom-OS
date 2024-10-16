org 0x7c00
bits 16

%define ENDL 0x0D, 0x0A

start:
    jmp main

puts:
    push si
    push ax

.loop:
    lodsb               
    or al, al           
    jz .done            
    
    mov ah, 0x0e        
    int 0x10            

    jmp .loop           
    
.done:
    pop ax
    pop si
    ret

main:
    
    xor ax, ax          
    mov ds, ax          
    mov es, ax          


    mov ss, ax
    mov sp, 0x7C00      

    mov si, msg_hello
    call puts

    hlt                 

.halt:
    jmp .halt           
    
msg_hello: db 'Welcome to Ark OS', ENDL, 0

times 510-($-$$) db 0   
dw 0xAA55               
