global pipeline_bad
global pipeline_good
section .text

	; Data dependency for pipelining
	
pipeline_bad:
		; Loop setup (cdecl -> eax, ecx & edx are caller saved)
		XOR ecx, ecx
		SUB esp, 4
		MOV DWORD[esp+0], ecx

		; Main functionality executed in loop
	L_pipeline_bad:
		ADD DWORD[esp+0], 12345678h
		ADD DWORD[esp+0], 12345678h
		ADD DWORD[esp+0], 12345678h
		ADD DWORD[esp+0], 12345678h

		; Loop logic
		DEC ecx
		JNZ L_pipeline_bad
		ADD esp, 4
		RET

pipeline_good:
		; Loop setup (cdecl -> eax, ecx & edx are caller saved)
		XOR ecx, ecx
		SUB esp, 10h
		MOV DWORD[esp+0], ecx
		MOV DWORD[esp+4], ecx
		MOV DWORD[esp+8], ecx
		MOV DWORD[esp+12], ecx

		; Main functionality executed in loop
	L_pipeline_good:
		ADD DWORD[esp+0], 12345678h
		ADD DWORD[esp+4], 12345678h
		ADD DWORD[esp+8], 12345678h
		ADD DWORD[esp+12], 12345678h

		; Loop logic
		DEC ecx
		JNZ L_pipeline_good
		ADD esp, 10h
		RET


