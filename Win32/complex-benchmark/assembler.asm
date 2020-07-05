.686
.MODEL FLAT, c
PUBLIC c pipeline_data_bad_small
PUBLIC c pipeline_data_middle_small
PUBLIC c pipeline_data_good_small
PUBLIC c pipeline_data_bad_anomaly
PUBLIC c pipeline_data_good_anomaly
PUBLIC c pipeline_data_bad_large
PUBLIC c pipeline_data_good_large
PUBLIC c pipeline_bad
PUBLIC c pipeline_good
PUBLIC c pipeline_instruction_bad
PUBLIC c pipeline_instruction_good
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

	pipeline_data_middle_small PROC c
		; Loop setup (cdecl -> eax, ecx & edx are caller saved)
		XOR ecx, ecx

		; Main functionality executed in loop
		L_pipeline_data_middle_small:
		MOV eax, 12345678h
		MOV edx, 23456789h
		IMUL eax, eax
		IMUL edx, edx
		ADD eax, eax
		ADD edx, edx

		; Loop logic
		DEC ecx
		JNZ L_pipeline_data_middle_small
		RET
	pipeline_data_middle_small ENDP

	pipeline_data_good_small PROC c
		; Loop setup (cdecl -> eax, ecx & edx are caller saved)
		XOR ecx, ecx

		; Main functionality executed in loop
		L_pipeline_data_good_small:
		MOV eax, 12345678h
		IMUL eax, eax
		MOV edx, 23456789h
		IMUL edx, edx
		ADD eax, eax
		ADD edx, edx

		; Loop logic
		DEC ecx
		JNZ L_pipeline_data_good_small
		RET
	pipeline_data_good_small ENDP

	pipeline_data_bad_anomaly PROC c
		; Loop setup (cdecl -> eax, ecx & edx are caller saved)
		PUSH ebx
		XOR ecx, ecx

		; Main functionality executed in loop
		L_pipeline_data_bad_anomaly:
		MOV eax, 12345678h
		IMUL eax, eax
		ADD eax, eax
		MOV ebx, 23456789h
		IMUL ebx, ebx
		ADD ebx, ebx
		MOV edx, 34567890h
		IMUL edx, edx
		ADD edx, edx

		; Loop logic
		DEC ecx
		JNZ L_pipeline_data_bad_anomaly
		POP ebx
		RET
	pipeline_data_bad_anomaly ENDP

	pipeline_data_good_anomaly PROC c
		; Loop setup (cdecl -> eax, ecx & edx are caller saved)
		PUSH ebx
		XOR ecx, ecx

		; Main functionality executed in loop
		L_pipeline_data_good_anomaly:
		MOV eax, 12345678h
		IMUL eax, eax
		MOV ebx, 23456789h
		IMUL ebx, ebx
		MOV edx, 34567890h
		IMUL edx, edx
		ADD eax, eax
		ADD ebx, ebx
		ADD edx, edx
		; only anomaly if MOV-MOV-MOV-IMUL-IMUL-IMUL-ADD-ADD-ADD

		; Loop logic
		DEC ecx
		JNZ L_pipeline_data_good_anomaly
		POP ebx
		RET
	pipeline_data_good_anomaly ENDP

	pipeline_data_bad_large PROC c
		; Loop setup (cdecl -> eax, ecx & edx are caller saved)
		PUSH ebx
		PUSH edi
		XOR edi, edi

		; Main functionality executed in loop
		L_pipeline_data_bad_large:
		MOV eax, 12345678h
		IMUL eax, eax
		ADD eax, eax
		MOV ebx, 23456789h
		IMUL ebx, ebx
		ADD ebx, ebx
		MOV ecx, 34567890h
		IMUL ecx, ecx
		ADD ecx, ecx
		MOV edx, 45678901h
		IMUL edx, edx
		ADD edx, edx

		; Loop logic
		DEC edi
		JNZ L_pipeline_data_bad_large
		POP edi
		POP ebx
		RET
	pipeline_data_bad_large ENDP

	pipeline_data_good_large PROC c
		; Loop setup (cdecl -> eax, ecx & edx are caller saved)
		PUSH ebx
		PUSH edi
		XOR edi, edi

		; Main functionality executed in loop
		L_pipeline_data_good_large:
		MOV eax, 12345678h
		MOV ebx, 23456789h
		MOV ecx, 34567890h
		MOV edx, 45678901h
		IMUL eax, eax
		IMUL ebx, ebx
		IMUL ecx, ecx
		IMUL edx, edx
		ADD eax, eax
		ADD ebx, ebx
		ADD ecx, ecx
		ADD edx, edx

		; Loop logic
		DEC edi
		JNZ L_pipeline_data_good_large
		POP edi
		POP ebx
		RET
	pipeline_data_good_large ENDP

	pipeline_bad PROC c
		; Loop setup (cdecl -> eax, ecx & edx are caller saved)
		XOR ecx, ecx
		SUB esp, 4
		MOV DWORD PTR[esp+0], ecx

		; Main functionality executed in loop
		L_pipeline_bad:
		ADD DWORD PTR[esp+0], 12345678h
		ADD DWORD PTR[esp+0], 12345678h
		ADD DWORD PTR[esp+0], 12345678h
		ADD DWORD PTR[esp+0], 12345678h

		; Loop logic
		DEC ecx
		JNZ L_pipeline_bad
		ADD esp, 4
		RET
	pipeline_bad ENDP

	pipeline_good PROC c
		; Loop setup (cdecl -> eax, ecx & edx are caller saved)
		XOR ecx, ecx
		SUB esp, 10h
		MOV DWORD PTR[esp+0], ecx
		MOV DWORD PTR[esp+4], ecx
		MOV DWORD PTR[esp+8], ecx
		MOV DWORD PTR[esp+12], ecx

		; Main functionality executed in loop
		L_pipeline_good:
		ADD DWORD PTR[esp+0], 12345678h
		ADD DWORD PTR[esp+4], 12345678h
		ADD DWORD PTR[esp+8], 12345678h
		ADD DWORD PTR[esp+12], 12345678h

		; Loop logic
		DEC ecx
		JNZ L_pipeline_good
		ADD esp, 10h
		RET
	pipeline_good ENDP

	; Execution unit dependency for pipelining
	
	pipeline_instruction_bad PROC c
		; Loop setup (cdecl -> eax, ecx & edx are caller saved)
		PUSHAD
		XOR edi, edi
		SUB esp, 20h
		MOV DWORD PTR[esp+0], edi
		MOV DWORD PTR[esp+4], edi
		MOV DWORD PTR[esp+8], edi
		MOV DWORD PTR[esp+12], edi
		MOV DWORD PTR[esp+16], edi
		MOV DWORD PTR[esp+20], edi
		MOV DWORD PTR[esp+24], edi
		MOV DWORD PTR[esp+28], edi
		XOR eax, eax
		XOR ebx, ebx
		XOR ecx, ecx
		XOR edx, edx

		; Main functionality executed in loop
		L_pipeline_instruction_bad:
		ADC DWORD PTR[esp+0], 12345678h
		ADC DWORD PTR[esp+4], 12345678h
		ADC DWORD PTR[esp+8], 12345678h
		ADC DWORD PTR[esp+12], 12345678h
		ADC DWORD PTR[esp+16], 12345678h
		ADC DWORD PTR[esp+20], 12345678h
		ADC DWORD PTR[esp+24], 12345678h
		ADC DWORD PTR[esp+28], 12345678h
		ADC eax, 87654321h
		ADC ebx, 87654321h
		ADC ecx, 87654321h
		ADC edx, 87654321h
		ADC eax, 87654321h
		ADC ebx, 87654321h
		ADC ecx, 87654321h
		ADC edx, 87654321h

		; Loop logic
		DEC edi
		JNZ L_pipeline_instruction_bad
		ADD esp, 20h
		POPAD
		RET
	pipeline_instruction_bad ENDP

	pipeline_instruction_good PROC c
		; Loop setup (cdecl -> eax, ecx & edx are caller saved)
		PUSHAD
		XOR edi, edi
		SUB esp, 20h
		MOV DWORD PTR[esp+0], edi
		MOV DWORD PTR[esp+4], edi
		MOV DWORD PTR[esp+8], edi
		MOV DWORD PTR[esp+12], edi
		MOV DWORD PTR[esp+16], edi
		MOV DWORD PTR[esp+20], edi
		MOV DWORD PTR[esp+24], edi
		MOV DWORD PTR[esp+28], edi
		XOR eax, eax
		XOR ebx, ebx
		XOR ecx, ecx
		XOR edx, edx

		; Main functionality executed in loop
		L_pipeline_instruction_good:
		ADC DWORD PTR[esp+0], 12345678h
		ADC eax, 87654321h
		ADC DWORD PTR[esp+4], 12345678h
		ADC ebx, 87654321h
		ADC DWORD PTR[esp+8], 12345678h
		ADC ecx, 87654321h
		ADC DWORD PTR[esp+12], 12345678h
		ADC edx, 87654321h
		ADC DWORD PTR[esp+16], 12345678h
		ADC eax, 87654321h
		ADC DWORD PTR[esp+20], 12345678h
		ADC ebx, 87654321h
		ADC DWORD PTR[esp+24], 12345678h
		ADC ecx, 87654321h
		ADC DWORD PTR[esp+28], 12345678h
		ADC edx, 87654321h

		; Loop logic
		DEC edi
		JNZ L_pipeline_instruction_good
		ADD esp, 20h
		POPAD
		RET
	pipeline_instruction_good ENDP

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
