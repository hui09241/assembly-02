INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	Input SDWORD 1
	Out1  byte  "請輸入數字:",0
	Out2  byte  "答案為:",0
	Sum   SDWORD 1
	count  SDWORD 1
.code
main PROC

    call   Clrscr      ;清除螢幕
	mov  edx,offset Out1
	call WriteString

	call ReadInt
	mov  Input,eax
	
	mov  ecx,eax ;要跑幾次迴圈

	L1:
		mov eax,count
		mov edx,Sum
		imul eax,edx
		mov  Sum,eax
		add count,1
		loop L1
		
	mov	edx,OFFSET Out2
	call	Writestring
	mov	eax,Sum
	call	Writeint

	call Crlf

	INVOKE ExitProcess , 0
main ENDP
END main