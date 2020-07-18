.686
.MODEL FLAT, c
PUBLIC c loop_example_always
PUBLIC c loop_example_sometimes
.CODE

	; Branch prediction examples

	loop_example_always PROC c
		XOR ecx, ecx
		L_start1:
		TEST ecx, 0
		JZ $+2
		DEC ecx
		JNZ L_start1
		RET
	loop_example_always ENDP

	loop_example_sometimes PROC c
		XOR ecx, ecx
		L_start2:
		TEST ecx, 1
		JZ $+2
		DEC ecx
		JNZ L_start2
		RET
	loop_example_sometimes ENDP

.DATA
END
