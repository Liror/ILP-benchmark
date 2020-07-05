.686
.MODEL FLAT, c
PUBLIC c pipeline_data_bad_small
PUBLIC c pipeline_data_good_small
PUBLIC c loop_example_bad
PUBLIC c loop_example_good
.CODE

	; Data dependency for pipelining

	pipeline_data_bad_small PROC c
		; Loop setup (cdecl -> eax, ecx & edx are caller saved)
		XOR ecx, ecx

		; Main functionality executed in loop
		L_pipeline_data_bad_small:
		MOV eax, 12345678h
		IMUL eax, eax
		ADD eax, eax
		MOV edx, 23456789h
		IMUL edx, edx
		ADD edx, edx

		; Loop logic
		DEC ecx
		JNZ L_pipeline_data_bad_small
		RET
	pipeline_data_bad_small ENDP

	pipeline_data_good_small PROC c
		; Loop setup (cdecl -> eax, ecx & edx are caller saved)
		XOR ecx, ecx

		; Main functionality executed in loop
		L_pipeline_data_good_small:
		MOV eax, 12345678h
		MOV edx, 23456789h
		IMUL eax, eax
		IMUL edx, edx
		ADD eax, eax
		ADD edx, edx

		; Loop logic
		DEC ecx
		JNZ L_pipeline_data_good_small
		RET
	pipeline_data_good_small ENDP

	; Branch prediction examples

	loop_example_bad PROC c
		XOR ecx, ecx
		L_start2:
		TEST ecx, 1
		JZ $+2
		DEC ecx
		JNZ L_start2
		RET
	loop_example_bad ENDP

	loop_example_good PROC c
		XOR ecx, ecx
		L_start1:
		TEST ecx, 0
		JZ $+2
		DEC ecx
		JNZ L_start1
		RET
	loop_example_good ENDP

.DATA
END
