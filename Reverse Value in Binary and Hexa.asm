.model small
.stack 100h
.data
number db 4Ah     

mZero db 0dh,0ah,'Number of zero: $'
mOne  db 0dh,0ah,'Number of one: $'
mEven db 0dh,0ah,'This is an even number$'
mOdd  db 0dh,0ah,'This is an odd number$'
mRevBin db 0dh,0ah,'Reversed value in binary: $'
mRevHex db 0dh,0ah,'Reversed value in hex: $'

count_zero db 0
count_one  db 0
rev_num    db 0

.code
main proc
    mov ax,@data
    mov ds,ax

    mov bl,number
    mov cl,8
cnt_loop:
    shl bl,1
    jc is_one
    inc count_zero
    jmp next_bit
is_one:
    inc count_one
next_bit:
    loop cnt_loop

    mov ah,9
    lea dx,mOne
    int 21h
    mov al,count_one
    add al,30h
    mov ah,2
    mov dl,al
    int 21h

    mov ah,9
    lea dx,mZero
    int 21h
    mov al,count_zero
    add al,30h
    mov ah,2
    mov dl,al
    int 21h

    mov al,number
    test al,1
    jnz odd
    mov ah,9
    lea dx,mEven
    int 21h
    jmp reverse

odd:
    mov ah,9
    lea dx,mOdd
    int 21h

reverse:
    mov al,number
    xor bl,bl
    mov cl,8

rev_loop:
    rol bl,1
    mov ah,al
    and ah,1
    or bl,ah
    shr al,1
    loop rev_loop

    mov rev_num,bl

    mov ah,9
    lea dx,mRevBin
    int 21h

    mov cl,8
print_bin:
    mov al,rev_num
    shl al,cl
    jc print_one
    mov dl,'0'
    jmp print_next
print_one:
    mov dl,'1'
print_next:
    mov ah,2
    int 21h
    dec cl
    jnz print_bin

    mov ah,9
    lea dx,mRevHex
    int 21h

    mov al,rev_num
    mov dl,al
    and dl,0F0h
    shr dl,4
    cmp dl,9
    jbe hex_hi_ok
    add dl,7
hex_hi_ok:
    add dl,30h
    mov ah,2
    int 21h

    mov dl,rev_num
    and dl,0Fh
    cmp dl,9
    jbe hex_lo_ok
    add dl,7
hex_lo_ok:
    add dl,30h
    mov ah,2
    int 21h

    mov ah,4Ch
    int 21h

main endp
end main
