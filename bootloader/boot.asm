; TorchOS Bootloader (Stage 1)
; Runs in 16-bit ReaL Mode after BIOS loads us at 0x7C00
; Prints a startup message  then halts.

[BITS 16]             ; 16-bit mode
[ORG 0x7C00]          ; BIOS loads boot sector at 0x7C00

start:
  cli                 ; Disable interrupts during setup
  xor ax, ax          ; Set ax to 0x00
  mov ds, ax          ; Set data segment to 0x00
  mov es, ax          ; Set extra segment to 0x00
  mov ss, ax          ; Set stack segment to 0x00
  mov sp, 0x7C00      ; Stack grows downward from 0x7C00 
  sti                 ; Re-enable interrupts
  mov si, msg         ; Load address of message into si

; Print loop: reads characters from si, prints until the end of it
.print:
  lodsb               ; Load next byte from si into al
  test al, al         ; Check whether it's the end of string
  jz .halt            ; Stop printing when it's the end of string
  mov ah, 0x0E        ; BIOS teletype function
  int 0x10            ; Call BIOS video interrupt
  jmp .print          ; Repeat for next character

; Halt: stop the CPU forever
.halt:
  hlt                 ; Low-power CPU wait
  jmp .halt           ; Stay here forever

; Data
msg: db "Sparking the Operating System", 0

; Boot sector padding & signature
times 510-($-$$) db 0 ; Pad remaining bytes with zeros
dw 0xAA55             ; Boot signature
