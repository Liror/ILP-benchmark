// main.cpp:

// Headers
#include <cstdio>
#include <cstdint>
#include "HR_Timer.h"

// MASM functions
#ifdef __cplusplus
	extern "C" {
#endif
	void __cdecl loop_example_always(void);
	void __cdecl loop_example_sometimes(void);
#ifdef __cplusplus
	}
#endif

// Main control function
int main(int argc, char* argv[])
{
	// Timer initialization
	HR_Timer timer = HR_Timer();
	timer.Reset();
	for(uint32_t i=1; i!=0; ++i)
		__asm { NOP }
	__int64 t = timer();
	
	// Branch prediction examples
	timer.Reset();
	loop_example_always();
	__int64 t0 = timer();

	timer.Reset();
	loop_example_sometimes();
	__int64 t1 = timer();
	
	printf("Always jumping loop execution time:    %lld ms\n", t0);
	printf("Sometimes jumping loop execution time: %lld ms\n", t1);

	return 0;
}
