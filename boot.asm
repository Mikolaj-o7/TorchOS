[BITS 16]
[ORG 0x7C00]

_start:
  cli
  xor ax, ax
  mov ds, ax
  mov es, ax
  mov ss, ax
  mov sp, 0x7C00

  call print_message

hang:
  hlt
  jmp hang

msg db "Sparking the Operating System", 0

print_message:
  mov si, msg

  .next_char:
    lodsb              ; load byte at [SI] into AL
    cmp al, 0
    je .done
    mov ah, 0x0E       ; teletype function
    mov bh, 0x00       ; page
    mov bl, 0x07       ; attribute
    int 0x10
    jmp .next_char

  .done:
    ret

times 510-($-$$) db 0
dw 0xAA55
