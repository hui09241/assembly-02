INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	Input       SDWORD  99 Dup(?)
	count       SDWORD  2
	total       SDWORD  99;以99圈開始倒數，第一次99圈，第二次98圈
	subtotal    SDWORD  0;與99圈相比要少幾圈
	num         SDWORD  0 ;用來存現在是質數的為
	out1         BYTE  "2~100之間的質數為:",0
.code
main PROC
	call   Clrscr      ;清除螢幕
    mov  ecx,total
	mov esi,OFFSET Input
L1:                     ;放入數字
   mov  eax,count
   mov  [esi],eax
   add  count,1
   add  esi,4
   loop L1

L2:                      ;調整每一次要跑的數目
	mov eax,total
	sub eax,subtotal
	mov ecx,eax
	mov esi,offset Input
	mov eax,subtotal
	imul eax,4
	add esi,eax
L3:
	mov eax,[esi]
	.if (eax>0) ;為質數
	  mov num,eax
	  jmp L4   ;跳至調整數目
    .endif
	 add subtotal,1
	 add esi,4
	loop L2

	jmp  L6

L4:
	mov eax,total         ;設置跑幾次迴圈
	sub eax,subtotal
	sub eax,1
	mov ecx,eax
	mov esi,offset Input
	mov eax,subtotal      ;從他的下一個開始比
	add eax,1
	imul eax,4
	add esi,eax
L5:
	mov ebx,num
	mov edx,0
	mov eax,[esi]
	idiv ebx
	mov  ebx,edx   ;ebx用來放餘數
	mov eax,[esi]
	.if (eax==0)
		add esi,4
	.elseif(ebx==0)
		mov [esi],ebx
	    add esi,4
	.else
		add esi,4
	.endif
		loop L5

	add subtotal,1 
	jmp L2

L6:  
	mov ecx,total
    mov esi,offset Input
    mov  edx,offset out1  ;輸出
	call WriteString
L7:
	mov eax,[esi]
	.if(eax>0)
		call WriteInt
	.endif
	add esi,4
	loop L7
	INVOKE ExitProcess , 0
main ENDP
END main


;	mov eax,[esi]
;	call WriteInt