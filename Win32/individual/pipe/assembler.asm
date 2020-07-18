.686
.MODEL FLAT, c
PUBLIC c pipeline_data_bad
PUBLIC c pipeline_data_middle
PUBLIC c pipeline_data_good
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

	pipeline_data_middle PROC c
		; Loop setup (cdecl -> eax, ecx & edx are caller saved)
		XOR ecx, ecx

		; Main functionality executed in loop
		L_pipeline_data_middle:
		MOV eax, 12345678h
		IMUL eax, eax
		MOV edx, 23456789h
		IMUL edx, edx
		ADD eax, eax
		ADD edx, edx

		; Loop logic
		DEC ecx
		JNZ L_pipeline_data_middle
		RET
	pipeline_data_middle ENDP

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

.DATA
END
