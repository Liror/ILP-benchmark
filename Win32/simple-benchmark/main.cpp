// main.cpp:

// Headers
#include <cstdio>
#include <cstdint>
#include "HR_Timer.h"

// MASM functions
#ifdef __cplusplus
	extern "C" {
#endif
	void __cdecl pipeline_data_bad_small(void);
	void __cdecl pipeline_data_good_small(void);
	void __cdecl loop_example_bad(void);
	void __cdecl loop_example_good(void);
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
	loop_example_good();
	__int64 t0 = timer();

	timer.Reset();
	loop_example_bad();
	__int64 t1 = timer();
	
	printf("Good loop execution time:   %lld ms\n", t0);
	printf("Bad loop execution time:    %lld ms\n", t1);
	printf("Sometimes these two loops perform similarly well, in that case the branch predictor worked flawlessly.\nThis does not happen in the more thorough program benchmark...\n");

	// Pipelining examples
	timer.Reset();
	pipeline_data_good_small();
	__int64 time_data0 = timer();

	timer.Reset();
	pipeline_data_bad_small();
	__int64 time_data1 = timer();
	
	printf("Pipeline data good small:   %lld ms\n", time_data0);
	printf("Pipeline data bad small:    %lld ms\n", time_data1);

	// Restrict example
	int b1, b2;
	int c = 7;
	normal(&c, &b1, &c); // when used like restricted should be used, compiler automatically optimizes additional load away
	restricted(&c, &b1, &c); // incorrect use as variables should not be overlapping
	printf("Expected: 9 10 9\nActual:   %d %d %d\n", b1, b2, c);

	return 0;
}
