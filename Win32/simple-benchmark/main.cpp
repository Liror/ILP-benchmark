// main.cpp:

// Headers
#include <cstdio>
#include <cstdint>
#include "HR_Timer.h"

// MASM functions
#ifdef __cplusplus
	extern "C" {
#endif
	void __cdecl pipeline_data_bad(void);
	void __cdecl pipeline_data_good(void);
	void __cdecl loop_example_always(void);
	void __cdecl loop_example_sometimes(void);
#ifdef __cplusplus
	}
#endif
	
// Restricted functions
void __declspec(noinline) normal(int* a, int* b, int* c)
{
	*a = *c + 1;
	*b = *c + 1;
}
void __declspec(noinline) restricted(int* __restrict a, int* __restrict b, int* __restrict c)
{
	*a = *c + 1;
	*b = *c + 1;
}

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

	// Pipelining examples
	timer.Reset();
	pipeline_data_good();
	__int64 time_data0 = timer();

	timer.Reset();
	pipeline_data_bad();
	__int64 time_data1 = timer();
	
	printf("Pipeline data good:   %lld ms\n", time_data0);
	printf("Pipeline data bad:    %lld ms\n", time_data1);

	// Restrict example
	int a = 3, b = 5, c = 7;
    printf("Expected: 3 5 7\nActual:   %d %d %d\n", a, b, c);
    normal(&a, &b, &c);
    printf("Expected: 8 8 7\nActual:   %d %d %d\n", a, b, c);
    c = 5;
    restricted(&a, &b, &c);
    printf("Expected: 6 6 5\nActual:   %d %d %d\n\n", a, b, c);
	int p = 7;
	printf("Expected: 7\nActual:   %d \n", p);
	normal(&p, &p, &p);
	printf("Expected: 9\nActual:   %d \n", p);
	restricted(&p, &p, &p);
	printf("Expected: 11\nActual:   %d \n", p);

	return 0;
}
