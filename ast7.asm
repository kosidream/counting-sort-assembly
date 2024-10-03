;  Name: kosi nwambuonwor
;  NSHE_ID: 8001802295
;  Section: 1003 and 1004
;  Assignment: 7
;  Description: Sorts an array and calculates the minimum, maximum, sum, average, and median.


; =====================================================================
;  Macro to convert integer to undecimal value in ASCII format.
;  Reads <integer>, converts to ASCII/undecimal integer value into
;  a <string>, including inserting the terminating NULL.

;  Note, the macro is calling using RSI, so the macro itself should
;	 NOT use the RSI register until is saved elsewhere.

;  Note, STR_LENGTH is available gloabbly and can be used as needed.

;  Arguments:
;	%1 -> <integer-variable>, value
;	%2 -> <string-address>, string address

;  Macro usage
;	int2aUndec	<integer-variable>, <string-address>

;  Example usage:
;	int2aUndec	dword [sqAreas+rsi*4], tempString



;	YOUR CODE GOES HERE
; COPIED FROM ASSIGNMENT 6
    %macro    int2aUndec    2
        mov eax, %1
        mov rdi, %2
        mov rcx, STR_LENGTH-1
        mov ebx, 11

    %%convertToUndecimalLoop:
        cmp eax, 0
        je %%doneConversion            ; If zero, we're done converting

        mov edx, 0
        div ebx
        cmp edx, 10
        jne %%notTen
        mov edx, 'X'
        jmp %%storeDigit

    %%notTen:
        add edx, '0'                  ; Convert remainder to ASCII

    %%storeDigit:
        sub rcx, 1                    ; Move to the next position in the string
        mov [rdi+rcx], dl

        cmp eax, 0                    ; Check if there are more digits
        jne %%convertToUndecimalLoop   ; Loop again for next digit

    %%doneConversion:
    %%fillLeadingSpaces:
        cmp rcx, 0
        je %%addNullTerminator
        mov byte [rdi+rcx-1], ' '      ; Fill leading spaces
        sub rcx, 1
        jmp %%fillLeadingSpaces

    %%addNullTerminator:
        mov byte [rdi+STR_LENGTH-1], 0

    %endmacro



; =====================================================================
;  Simple macro to display a string to the console.
;	Call:	printString  <stringAddr>

;	Arguments:
;		%1 -> <stringAddr>, string address

;  Count characters (excluding NULL).
;  Display string starting at address <stringAddr>

%macro	printString	1
	push	rax			; save altered registers
	push	rdi
	push	rsi
	push	rdx
	push	rcx

	mov	rdx, 0
	mov	rdi, %1
%%countLoop:
	cmp	byte [rdi], NULL
	je	%%countLoopDone
	inc	rdi
	inc	rdx
	jmp	%%countLoop
%%countLoopDone:

	mov	rax, SYS_write		; system call for write (SYS_write)
	mov	rdi, STDOUT		; standard output
	mov	rsi, %1			; address of the string
	syscall				; call the kernel

	pop	rcx			; restore registers to original values
	pop	rdx
	pop	rsi
	pop	rdi
	pop	rax
%endmacro

; =====================================================================

section	.data

; -----
;  Define constants.

TRUE		equ	1
FALSE		equ	0

EXIT_SUCCESS	equ	0			; Successful operation

STDIN		equ	0			; standard input
STDOUT		equ	1			; standard output
STDERR		equ	2			; standard error

SYS_read	equ	0			; system call code for read
SYS_write	equ	1			; system call code for write
SYS_open	equ	2			; system call code for file open
SYS_close	equ	3			; system call code for file close
SYS_fork	equ	57			; system call code for fork
SYS_exit	equ	60			; system call code for terminate
SYS_creat	equ	85			; system call code for file open/create
SYS_time	equ	201			; system call code for get time

LF		equ	10
NULL		equ	0
ESC		equ	27

;  Program specfic constants

LIMIT		equ	10000
STR_LENGTH	equ	12

; -----
;  Provided data

list		dd	 6572,  7624,   128,   113,  3112
		dd	 1121,   320,  4540,  5679,  1190
		dd	 9129,   116,   192,   117,   127
		dd	 5677,   101,  3727,   125,  3184
		dd	 1104,   124,   112,   143,   176
		dd	 7534,  2126,  6112,   156,  1103
		dd	 6759,  6326,  2171,   147,  5628
		dd	 7527,  7569,  3177,  6785,  3514
		dd	 1156,   164,  4165,   155,  5156
		dd	 5634,  7526,  3413,  7686,  7563
		dd	 2147,   113,   143,   140,   165
		dd	  169,   126,   571,   147,   228
		dd	  127,    90,   177,   175,   114
		dd	 1181,  1125,   115,   122,  1217
		dd	  127,   164,   140,   172,   124
		dd	 2161,   134,   151,   132,   112
		dd	 1113,  1232,  2146,  3376,  5120
		dd	 2356,  3164,  3565,  3155,  3157
		dd	 1001,   128,    33,   105,  8327
		dd	  101,   115,   108,  1233,  2115
		dd	 1227,  1226,  5129,   117,   107
		dd	  105,   109,   730,   150,  3414
		dd	 1107,  6103,  1245,  6440,   465
		dd	 2311,   254,  4528,   913,  6722
		dd	 1149,  2126,  5671,  4647,  4628
		dd	  327,  2390,   177,  8275,  5614
		dd	 3121,   415,   615,   122,  7217
		dd	 1221,   134,  6151,   432,   114
		dd	  629,   114,   522,  2413,   131
		dd	 5639,   126,    62,   141,   127
		dd	 2101,   133,   133,   150,  4532
		dd	 1219,  3116,   162,   117,   127
		dd	  147,  1123,  2245,  4440,   165
		dd	 6787,  4569,   179,  5675,    14
		dd	 7881,  8320,  3467,  4559,  1190
		dd	  186,   134,  1125,  5675,  3476
		dd	 2137,  2113,  1647,   114,   115
		dd	 5721,  5615,  4568,  7813,  1231
		dd	 5527,  6364,   330,   172,   124
		dd	 7525,  5616,  5662,  6328,  2342
        
length		dd	200

minimum		dd	0
median		dd	0
maximum		dd	0
sum		    dd	0
average		dd	0

; -----
;  Misc. data definitions (if any).


; -----
;  Provided string definitions.

newLine		db	LF, NULL

hdr		db	"---------------------------"
		db	"---------------------------"
		db	LF, ESC, "[1m", "CS 218 - Assignment #7", ESC, "[0m"
		db	LF, "Counting Sort", LF, LF, NULL

hdrMin		db	"Minimum:  ", NULL
hdrMax		db	"Maximum:  ", NULL
hdrMed		db	"Median:   ", NULL
hdrSum		db	"Sum:      ", NULL
hdrAve		db	"Average:  ", NULL

; ---------------------------------------------

section .bss

count		resd	LIMIT * 4
tmpString	resb	STR_LENGTH

; ---------------------------------------------

section	.text
global	_start
_start:

; -------------------------------------------------------
;  Counting Sort Algorithm:

;	for  i = 0 to (len-1)
;	    count[list[i]] = count[list[i]] + 1
;	endFor

;	p = 0
;	for  i = 0 to (limit-1) do
;	    if  count[i] <> 0  then
;		for  j = 1 to count[i]
;		    list[p] = i
;		    p = p + 1
;		endFor
;	    endIf
;	endFor

; ******************************
;  Sort data using counting sort.


;	YOUR CODE GOES HERE


    ; Step 1: Find the maximum value in the list
    mov edi, 0
    mov eax, [list + edi*4]
    mov ebx, eax
    mov ecx, [length]

    find_max_loop:
        add edi, 1
        cmp edi, ecx                ; If we've checked all elements, break
        jge count_occurrences_start
        mov eax, [list + edi*4]
        cmp eax, ebx
        jle find_max_loop           ; If it's smaller, continue
        mov ebx, eax                ; If it's larger, update max
        jmp find_max_loop

    ; Step 2: Initialize the count array to zero
    count_occurrences_start:
    mov edi, 0
    mov ecx, ebx

    init_count_array:
        mov dword [count + edi*4], 0
        add edi, 1
        cmp edi, ecx
        jle init_count_array

    ; Step 3: Count occurrences of each value in the list
    mov edi, 0
    mov ecx, [length]

    count_occurrences:
        mov eax, [list + edi*4]         ; Load the value from list[i]
        add dword [count + eax*4], 1
        add edi, 1                      ; Move to the next list element
        cmp edi, ecx                    ; If edi >= length, break the loop
        jl count_occurrences

    ; Step 4: Rebuild the sorted list based on counts
    mov edi, 0
    mov esi, 0
    mov ecx, ebx

    rebuild_list_outer:
        mov ebx, [count + edi*4]       ; Load count[i]
        cmp ebx, 0                     ; Check if count[i] is zero
        je skip_to_next_index           ; If count[i] == 0, skip to the next number

    rebuild_list_inner:
        mov [list + esi*4], edi
        add esi, 1                     ; Move to the next position in the list
        sub ebx, 1                     ; Decrease count[i]
        cmp ebx, 0
        jg rebuild_list_inner

    skip_to_next_index:
        add edi, 1
        cmp edi, ecx
        jle rebuild_list_outer


; ******************************
;  Find sum and compute the average.
;  Get/save min and max.
;  Find median.


;	YOUR CODE GOES HERE

    mov ecx, [length]
    cmp ecx, 0                    ; Ensure length is non-zero
    je skip_computation            ; If length is 0, skip calculations

    mov esi, 0
    mov eax, [list + esi*4]
    mov [minimum], eax
    mov [maximum], eax
    mov dword [sum], 0

calc_loop:
    mov eax, [list + esi*4]
    add dword [sum], eax          ; Add the element to the sum

    ; Compare for minimum
    cmp eax, dword [minimum]      ; If current element < minimum, update minimum
    jge not_new_min
    mov dword [minimum], eax
not_new_min:

    ; Compare for maximum
    cmp eax, dword [maximum]      ; If current element > maximum, update maximum
    jle not_new_max
    mov dword [maximum], eax
not_new_max:

    ; Move to the next element in the list
    add esi, 1
    cmp esi, ecx
    jl calc_loop

    ; Now calculate the average
    mov eax, [sum]
    mov edx, 0
    mov ecx, [length]
    div ecx                       ; eax = sum / length (calculate average)
    mov [average], eax            ; Store the average

        ; Now calculate the median
        mov ecx, [length]

        ; Divide length by 2 to get the middle index
        mov edi, 2
        mov edx, 0
        div edi                         ; ecx = length / 2

        cmp edx, 0
        jne odd_median

        ; Even length case: find the two middle elements and average them
        mov eax, [list + ecx*4 - 4]
        add eax, [list + ecx*4]
        mov edi, 2
        mov edx, 0                      ; Clear edx for division
        div edi                         ; eax = (first middle element + second middle element) / 2
        mov [median], eax
        jmp done_median

    odd_median:
        mov eax, [list + ecx*4]
        mov [median], eax

    done_median:

skip_computation:



; ******************************
;  Display results to screen in undecimal.

	printString	hdr

	printString	hdrMin
	int2aUndec	dword [minimum], tmpString
	printString	tmpString
	printString	newLine

	printString	hdrMax
	int2aUndec	dword [maximum], tmpString
	printString	tmpString
	printString	newLine

	printString	hdrMed
	int2aUndec	dword [median], tmpString
	printString	tmpString
	printString	newLine

	printString	hdrSum
	int2aUndec	dword [sum], tmpString
	printString	tmpString
	printString	newLine

	printString	hdrAve
	int2aUndec	dword [average], tmpString
	printString	tmpString
	printString	newLine
	printString	newLine

; ******************************
;  Done, terminate program.

last:
	mov	rax, SYS_exit
	mov	rdi, EXIT_SUCCESS
	syscall

