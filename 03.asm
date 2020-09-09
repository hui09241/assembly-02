INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
 Out1  BYTE "請輸入N值：",0
 Out2  BYTE "總和：",0
 Out3  BYTE "輸出結果：",0
 Out4  BYTE "加上後面會溢位",0 
 Out5  BYTE "加上:",0
 N     SDWORD   0
 count BYTE     1  ;看位溢位前可存幾個整數
 num   BYTE     1
 Sum   WORD     0
 Odd   BYTE     2
 Arr   BYTE     ?
 
.code
main PROC
 call   Clrscr      ;清除螢幕
 mov edx,OFFSET Out1
 call WriteString
 call Crlf
 call ReadInt
 mov  N,eax

 mov esi,OFFSET Arr
 mov ecx,100
 
L1:                   ;創造陣列
 mov eax,0
 mov al,num 
 mov bl,num
 mul bl
 
 .if (ax>255)     ;8bit溢位
  jmp L2
 .else
  mov [esi],al
 .endif  
  add esi,1
  add num,1
  add count,1
  loop L1

L2: 
	
	mov edx,OFFSET Out3
    call WriteString
	mov cl,count
	mov esi,OFFSET Arr
	call crlf
L3:
	mov eax,0 
	mov al,[esi]
	mov ebx,N
	mov dx,Sum
	add dx,ax
	.if (ebx==0)
		jmp  L5
	.elseif(dx>255);已溢位
		jmp  L4
	.elseif(bx>0)&&(dx<255);尚有數需輸出且無溢位
		mov Sum,dx
		mov edx,OFFSET Out5
		call WriteString
	    mov al,[esi]
		call WriteDec 
		mov edx,OFFSET Out2
		call WriteString
		mov ax,Sum
		call WriteDec
		mov ebx,N
		sub ebx,1
		mov N,ebx
	.endif
	add esi,2    ;偶數的平方還是偶數不用加
	call Crlf
	loop L3
	call Crlf

L4:
	mov edx,OFFSET Out4
    call WriteString
	call Crlf
L5:
	
 INVOKE ExitProcess , 0
main ENDP
END main