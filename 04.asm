INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	Input       SDWORD  99 Dup(?)
	count       SDWORD  2
	total       SDWORD  99;�H99��}�l�˼ơA�Ĥ@��99��A�ĤG��98��
	subtotal    SDWORD  0;�P99��ۤ�n�ִX��
	num         SDWORD  0 ;�ΨӦs�{�b�O��ƪ���
	out1         BYTE  "2~100��������Ƭ�:",0
.code
main PROC
	call   Clrscr      ;�M���ù�
    mov  ecx,total
	mov esi,OFFSET Input
L1:                     ;��J�Ʀr
   mov  eax,count
   mov  [esi],eax
   add  count,1
   add  esi,4
   loop L1

L2:                      ;�վ�C�@���n�]���ƥ�
	mov eax,total
	sub eax,subtotal
	mov ecx,eax
	mov esi,offset Input
	mov eax,subtotal
	imul eax,4
	add esi,eax
L3:
	mov eax,[esi]
	.if (eax>0) ;�����
	  mov num,eax
	  jmp L4   ;���ܽվ�ƥ�
    .endif
	 add subtotal,1
	 add esi,4
	loop L2

	jmp  L6

L4:
	mov eax,total         ;�]�m�]�X���j��
	sub eax,subtotal
	sub eax,1
	mov ecx,eax
	mov esi,offset Input
	mov eax,subtotal      ;�q�L���U�@�Ӷ}�l��
	add eax,1
	imul eax,4
	add esi,eax
L5:
	mov ebx,num
	mov edx,0
	mov eax,[esi]
	idiv ebx
	mov  ebx,edx   ;ebx�Ψө�l��
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
    mov  edx,offset out1  ;��X
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