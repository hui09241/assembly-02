INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	num1 SDWORD ?
    num2 SDWORD ?
    num3 SDWORD ?
	Out1  byte  "請輸入數字:",0
    Out2  byte  "直角三角形",0
	Sum   SDWORD 1
.code
main PROC
    call   Clrscr      ;清除螢幕
    mov  edx,offset Out1;輸入數字1
	call WriteString

    Call ReadInt 
    mov num1,eax

    mov  edx,offset Out1;輸入數字2
	call WriteString

    Call ReadInt
	mov num2,eax
	mov ecx,0
    mov ecx,num1
    .if (eax<ecx)
        mov edx,num1
        mov num2,edx
        mov num1, eax
        jmp  L1
     .else
        jmp   L1
     .endif

L1: 
    mov  edx,offset Out1;輸入數字3
	call WriteString
    call ReadInt
	mov num3,eax
	mov ecx,0
    mov ecx,num1
    .If  (eax<ecx)
        mov  edx,num1
        mov  num1,eax
		mov eax,edx
        jmp  L2
      .else   
        jmp  L2
       .endif

L2:   
    mov ecx,0
    mov  ecx,num2
    .if (eax<ecx)
        mov edx,num2
        mov num2,eax
        mov num3,edx
        jmp  L3
    .else
        jmp  L3
    .endif

L3:
	  mov ebx,num1   ;判斷是否為三角形
	  add ebx,num2
	  sub ebx,num3
	  
	  .if(ebx<0)
		mov eax,ebx
		 call WriteInt
			 jmp L5
       .endif
       mov  eax,num1
       mov  edx,num1
       imul eax,edx
       mov  Sum,eax

       mov  eax,num2
       mov  edx,num2
       imul eax,edx
       add  Sum,eax

       mov  eax,num3
       mov  edx,num3
       imul eax,edx
       mov  num3,eax
	
       mov eax,Sum
       sub eax,num3
       .if(eax==0)
			 jmp L4
       .else
			jmp L5
       .endif

L4:
        mov  edx,offset Out2;輸出是直角三角形
	    call WriteString
L5:
        call Crlf
	    call WaitMsg
	INVOKE ExitProcess , 0
main ENDP
END main