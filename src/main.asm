org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

start:
    jmp main

;
; Coloca uma string na tela
; ds:si aponta para a string
;
puts:
    ; salva registros que serao modificados
    push si
    push ax

.loop:
    lodsb          ; carrega o proximo caractere em al
    or al, al       ; verifica se o proximo caractere eh nulo?
    jz .done

    mov ah, 0x0e    ; calls bio interrupt
    int 0x10

    jmp .loop

.done:
    pop ax
    pop si
    ret


main:

    ; define seguimentos de data
    mov ax, 0       ; nao pode escrever em ds/es diretamente
    mov ds, ax
    mov es, ax

    ; define stack
    mov ss, ax
    mov sp, 0x7C00  ; stack cresce de maneira decrecente de onde inicia na memoria

    ; mostrar mensagem hello world
    mov si, msg_hello
    call puts

    hlt

.halt:
    jmp .halt

msg_hello: db 'Hello World!', ENDL, 0

times 510-($-$$) db 0
dw 0AA55h