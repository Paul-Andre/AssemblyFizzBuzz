;FizzBuzz.asm
;For 32-bit linux
;
;To assemble, do:
;  nasm -f elf FizzBuzz.asm
;  ld --strip-all FizzBuzz.o
;
section .data
	;These two chars will be used as a buffer to which numbers will be written
	;before being printed.
	writeNumberBuffer: times 3 db 's' 

	;ascii representation of a newline
	newlineString: db 10	
	
	fizzString: db "Fizz"
	fizzStringLength: equ $-fizzString
	
	buzzString: db "Buzz"
	buzzStringLength: equ $-buzzString
	
	maxNumber: equ 100

	
section .text
	global _start


_start:
		mov cx, 1
		mov edx, 0
	
	.startLoop:
	
	.caseFizzBuzz:
		mov ax, cx
		mov bl, 15
		div bl
		cmp ah, 0
		jne .caseFizz
		
		call printFizz
		call printBuzz
		
		jmp .endLoop
		
		
	.caseFizz:
		mov ax, cx
		mov bl, 3
		div bl
		cmp ah, 0
		jne .caseBuzz
		
		call printFizz
		
		jmp .endLoop
		
	.caseBuzz:
		mov ax, cx
		mov bl, 5
		div bl
		cmp ah, 0
		jne .caseElse
		
		call printBuzz
		
		jmp .endLoop
		
	.caseElse:	
		mov al, cl
		call writeNumber
		
	.endLoop:
		call printNewline
		inc cl
		cmp cl, maxNumber
		jle .startLoop

	.end:
		mov eax,1
		mov ebx,0
		int 0x80
	
	
	
writeNumber:
	; number comes in al

		push ecx
		
	.startBreakingUpNumber:
		mov cl, 0 ;counter
		mov bl, 10 ; 
		
	.continueBreakingUpNumber:	
		mov ah, 0
		div bl
		push eax
		inc cl
		
		cmp al, 0
		jne .continueBreakingUpNumber
	
	
	.startWritingNumber:
		mov dl, cl ; save the number of characters
		mov edi, writeNumberBuffer
		
	.writeNumber:
		cmp cl, 0
		je .end
		
		pop eax
		mov al, ah
		add al, '0' ; turn into ascii
		stosb
		
		dec cl
		jmp .writeNumber
	
	
	.end:
		mov eax, 4
		mov ebx, 1
		mov ecx, writeNumberBuffer
		; the length is in edx
		int 0x80

		pop ecx

ret


printNewline:
		push ecx
	
		mov eax, 4
		mov ebx, 1
		mov ecx, newlineString
		mov dl, 1
		int 0x80
		
		pop ecx
ret

printFizz:
		push ecx
		
		mov eax, 4
		mov ebx, 1
		mov ecx, fizzString
		mov dl, fizzStringLength
		int 0x80
		
		pop ecx

ret

printBuzz:
		push ecx
		
		mov eax, 4
		mov ebx, 1
		mov ecx, buzzString
		mov dl, buzzStringLength
		int 0x80
		
		pop ecx
ret

