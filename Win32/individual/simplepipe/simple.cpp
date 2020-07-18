// Headers
#include <cstdio>
#include <cstdint>
#include "HR_Timer.h"

// MASM functions
#ifdef __cplusplus
	extern "C" {
#endif
	void __cdecl pipeline_bad(void);
	void __cdecl pipeline_good(void);
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
	pipeline_bad();
	__int64 time_data0 = timer();
	
	timer.Reset();
	pipeline_good();
	__int64 time_data1 = timer();
	
	printf("Pipeline simple bad:  %lld ms\n", time_data0);
	printf("Pipeline simple good: %lld ms\n", time_data1);

	return 0;
}
