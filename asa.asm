.386
.model flat,stdcall
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
extern ExitProcess@4:near
extern GetStdHandle@4:near
extern CloseHandle@4:near
extern lstrlenA@4:near
extern WriteConsoleA@20:near
extern ReadConsoleA@20:near
extern wsprintfA:near

_DATA SEGMENT

hin   dd 0
hout  dd 0
szstr db "Hello there,please write something ",0Dh,0Ah,">",0
lenn  dd 0
cnt   dd 0
Buff  db 255 dup(0)
Buff2 db 255 dup(0)
szstr2 db "I'm repeat,yes comrade you have writed %s",0Dh,0Ah,"Press enter to exit",0
Buff3 db 253 dup(0),0Dh,0Ah

_DATA ENDS

_TEXT SEGMENT
START:

push -0Ah
call GetStdHandle@4
mov hin,eax
push -0Bh
call GetStdHandle@4
mov hout,eax

push offset szstr
call lstrlenA@4
mov lenn,eax

push 0
push offset cnt
push lenn
push offset szstr
push hout
call WriteConsoleA@20

push 0
push offset cnt
push 255
push offset Buff
push hin
call ReadConsoleA@20

push offset Buff
call lstrlenA@4
mov  lenn,eax
push 0
push offset cnt
push lenn
push offset Buff
push hout
call WriteConsoleA@20

push offset Buff
push offset szstr2
push offset Buff3
call wsprintfA
add ebp,12

push 0
push offset cnt
push 255
push offset Buff3
push hout
call WriteConsoleA@20

push 0
push offset cnt
push 255
push offset Buff2
push hin
call ReadConsoleA@20



push hin
call CloseHandle@4
push hout
call CloseHandle@4
push 0
call ExitProcess@4

exampleproc proc
push ebp
mov  ebp,esp

mov eax,dword ptr[ebp+8]

mov esp,ebp
pop ebp
ret 4
exampleproc endp


_TEXT ENDS
END START