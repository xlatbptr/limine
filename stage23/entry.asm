extern bss_begin
extern bss_end
extern entry
extern gdt

section .entry

global _start
_start:
    cld

    ; zero out .bss
    mov edi, bss_begin
    
    ; write in series of DWORDs
    ; (edx : eax) / ebx
    mov eax, bss_end
    sub eax, bss_begin
    xor edx, edx
    mov ebx, 4
    div ebx
    
    mov ecx, eax
    xor eax, eax
    rep stosd
    
    ; write out the remainder bytes
    mov ecx, edx
    rep stosb

    lgdt [gdt]
    jmp 0x18:.reload_cs
  .reload_cs:
    mov eax, 0x20
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    jmp entry
