INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
 Out1  BYTE "�п�JN�ȡG",0
 Out2  BYTE "�`�M�G",0
 Out3  BYTE "��X���G�G",0
 Out4  BYTE "�[�W�᭱�|����",0 
 Out5  BYTE "�[�W:",0
 N     SDWORD   0
 count BYTE     1  ;�ݦ췸��e�i�s�X�Ӿ��
 num   BYTE     1
 Sum   WORD     0
 Odd   BYTE     2
 Arr   BYTE     ?
 
.code
main PROC
 call   Clrscr      ;�M���ù�
 mov edx,OFFSET Out1
 call WriteString
 call Crlf
 call ReadInt
 mov  N,eax

 mov esi,OFFSET Arr
 mov ecx,100
 
L1:                   ;�гy�}�C
 mov eax,0
 mov al,num 
 mov bl,num
 mul bl
 
 .if (ax>255)     ;8bit����
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
	.elseif(dx>255);�w����
		jmp  L4
	.elseif(bx>0)&&(dx<255);�|���ƻݿ�X�B�L����
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
	add esi,2    ;���ƪ������٬O���Ƥ��Υ[
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