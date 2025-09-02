.model small
.stack 100h

.data
    msg db 'Enter input: $'   
    msg2 db 13, 10, 'Character : $'                      
.code
main proc
    
    mov ax, @data
    mov ds, ax

    lea dx, msg                     
    mov ah, 9                
    int 21h

    mov dx, 0                        
    mov ah, 1                       
    int 21h                         

while_loop:
    cmp al, 0dh                     
    je endl                         
    inc dx                       
    int 21h                          
    jmp while_loop                 

endl:
    mov bl, dl                     
    mov ah,9                      
    int 21h
    add bl, 30h                      

    lea dx, msg2
    mov ah, 9
    int 21h

    mov dl, bl                    
    mov ah, 2                   
    int 21h                       
    
 
    mov ah, 4Ch                       
    int 21h                          

main endp
end main
