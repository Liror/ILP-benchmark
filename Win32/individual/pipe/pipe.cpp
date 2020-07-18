// Headers
#include <cstdio>
#include <cstdint>
#include "HR_Timer.h"

// MASM functions
#ifdef __cplusplus
	extern "C" {
#endif
	void __cdecl pipeline_data_bad(void);
	void __cdecl pipeline_data_middle(void);
	void __cdecl pipeline_data_good(void);
#ifdef __cplusplus
	}
#endif

// Main control function
int main(int argc, char* argv[])
{
	// Timer initialization
	HR_Timer timer = HR_Timer();
	timer.Reset();

	// Pipelining examples
	timer.Reset();
	pipeline_data_bad();
	__int64 time_data0 = timer();
	
	timer.Reset();
	pipeline_data_middle();
	__int64 time_data1 = timer();

	timer.Reset();
	pipeline_data_good();
	__int64 time_data2 = timer();
	
	printf("Pipeline data bad:    %lld ms\n", time_data0);
	printf("Pipeline data middle: %lld ms\n", time_data1);
	printf("Pipeline data good:   %lld ms\n", time_data2);

	return 0;
}
