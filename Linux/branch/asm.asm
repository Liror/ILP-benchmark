global loop_example_always
global loop_example_sometimes
section .text

; Always jumping example
loop_example_always:
	    XOR ecx, ecx
	L_start1:
	    TEST ecx, 0
		JZ $+2
		DEC ecx
		JNZ L_start1
		RET

; Sometimes jumping example
loop_example_sometimes:
		XOR ecx, ecx
	L_start2:
		TEST ecx, 1
		JZ $+2
		DEC ecx
		JNZ L_start2
		RET

