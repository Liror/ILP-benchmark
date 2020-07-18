.686
.MODEL FLAT, c
PUBLIC c pipeline_data_bad
PUBLIC c pipeline_data_good
PUBLIC c loop_example_always
PUBLIC c loop_example_sometimes
.CODE

	; Data dependency for pipelining

	pipeline_data_bad PROC c
		; Loop setup (cdecl -> eax, ecx & edx are caller saved)
		XOR ecx, ecx

		; Main functionality executed in loop
		L_pipeline_data_bad:
		MOV eax, 12345678h
		IMUL eax, eax
		ADD eax, eax
		MOV edx, 23456789h
		IMUL edx, edx
		ADD edx, edx

		; Loop logic
		DEC ecx
		JNZ L_pipeline_data_bad
		RET
	pipeline_data_bad ENDP

	pipeline_data_good PROC c
		; Loop setup (cdecl -> eax, ecx & edx are caller saved)
		XOR ecx, ecx

		; Main functionality executed in loop
		L_pipeline_data_good:
		MOV eax, 12345678h
		MOV edx, 23456789h
		IMUL eax, eax
		IMUL edx, edx
		ADD eax, eax
		ADD edx, edx

		; Loop logic
		DEC ecx
		JNZ L_pipeline_data_good
		RET
	pipeline_data_good ENDP

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
