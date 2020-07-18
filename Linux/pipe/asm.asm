global pipeline_data_bad
global pipeline_data_middle
global pipeline_data_good
section .text

pipeline_data_bad:
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

pipeline_data_middle:
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

pipeline_data_good:
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

