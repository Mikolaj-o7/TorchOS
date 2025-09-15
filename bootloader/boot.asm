[BITS 16]
[ORG 0x7C00]

start:
  cli
  xor ax, ax
  mov ds, ax
  mov es, ax
  mov ss, ax
  mov sp, 0x7C00
  mov si, msg
  sti

print:
  lodsb              ; load byte at [SI] into AL
  cmp al, 0
  je done
  mov ah, 0x0E       ; teletype function
  int 0x10
  jmp print

done:
  cli
  hlt 

msg: db "Sparking the Operating System", 0

times 510-($-$$) db 0
dw 0xAA55
