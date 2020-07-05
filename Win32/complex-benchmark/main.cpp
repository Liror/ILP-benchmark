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
	void __cdecl pipeline_data_middle_small(void);
	void __cdecl pipeline_data_good_small(void);
	void __cdecl pipeline_data_bad_anomaly(void);
	void __cdecl pipeline_data_good_anomaly(void);
	void __cdecl pipeline_data_bad_large(void);
	void __cdecl pipeline_data_good_large(void);
	void __cdecl pipeline_bad(void);
	void __cdecl pipeline_good(void);
	void __cdecl pipeline_instruction_bad(void);
	void __cdecl pipeline_instruction_good(void);
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
	// Branch prediction
	HR_Timer timer = HR_Timer();
	timer.Reset();
	for(uint32_t i=1; i!=0; ++i)
		__asm { NOP }
	__int64 t1 = timer();

	timer.Reset();
	loop_example_bad();
	__int64 t2 = timer();

	timer.Reset();
	loop_example_good();
	__int64 t3 = timer();
	printf("Simple loop execution time: %lld ms\n", t1);
	printf("Bad loop execution time:    %lld ms\n", t2);
	printf("Good loop execution time:   %lld ms\n", t3);

	// Restrict example
	int b1, b2;
	int c = 7;
	normal(&c, &b1, &c); // when used like restricted should be used, compiler automatically optimizes additional load away
	restricted(&c, &b1, &c); // incorrect use as variables should not be overlapping
	printf("Expected: 9 10 9\nActual:   %d %d %d\n", b1, b2, c);

	// Pipelining examples
	__int64 time_data[9] = { 0 };
	
	timer.Reset();
	pipeline_data_bad_small();
	time_data[0] = timer();
	
	timer.Reset();
	pipeline_data_middle_small();
	time_data[8] = timer();
	
	timer.Reset();
	pipeline_data_good_small();
	time_data[1] = timer();

	timer.Reset();
	pipeline_data_bad_anomaly();
	time_data[2] = timer();
	
	timer.Reset();
	pipeline_data_good_anomaly();
	time_data[3] = timer();

	timer.Reset();
	pipeline_data_bad_large();
	time_data[4] = timer();
	
	timer.Reset();
	pipeline_data_good_large();
	time_data[5] = timer();

	timer.Reset();
	pipeline_bad();
	time_data[6] = timer();
	
	timer.Reset();
	pipeline_good();
	time_data[7] = timer();

	timer.Reset();
	pipeline_instruction_bad();
	__int64 time_i_b = timer();

	timer.Reset();
	pipeline_instruction_good();
	__int64 time_i_g = timer();
	
	printf("Pipeline data good small:   %lld ms\n", time_data[1]);
	printf("Pipeline data middle small: %lld ms\n", time_data[8]);
	printf("Pipeline data bad small:    %lld ms\n", time_data[0]);
	printf("Pipeline data good anomaly: %lld ms\n", time_data[3]);
	printf("Pipeline data bad anomaly:  %lld ms\n", time_data[2]);
	printf("Pipeline data good large:   %lld ms\n", time_data[5]);
	printf("Pipeline data bad large:    %lld ms\n", time_data[4]);
	printf("Pipeline simple good:       %lld ms\n", time_data[7]);
	printf("Pipeline simple bad:        %lld ms\n", time_data[6]);
	printf("Pipeline instruction good:  %lld ms\n", time_i_g);
	printf("Pipeline instruction bad:   %lld ms\n", time_i_b);

	return 0;
}
