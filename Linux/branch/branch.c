// Headers
#include <stdio.h>
#include <sys/time.h>

// ASM functions
#ifdef __cplusplus
	extern "C" {
#endif
	void loop_example_always(void);
	void loop_example_sometimes(void);
#ifdef __cplusplus
	}
#endif

// Boilerplate code
int main(int argc, char* argv[])
{
	// Timer initialization
    struct timeval t1, t2, t3, t4, t5, t6;
    gettimeofday(&t1, NULL);
	for(unsigned int i=1; i!=0; ++i)
		asm volatile ("NOP");
    gettimeofday(&t2, NULL);
	
	// Branch prediction examples
    gettimeofday(&t3, NULL);
	loop_example_always();
    gettimeofday(&t4, NULL);

	gettimeofday(&t5, NULL);
	loop_example_sometimes();
    gettimeofday(&t6, NULL);
    
    // Results
    unsigned long long time0 = ((t4.tv_sec - t3.tv_sec) * 1000) + ((t4.tv_usec - t3.tv_usec) / 1000);
    unsigned long long time1 = ((t6.tv_sec - t5.tv_sec) * 1000) + ((t6.tv_usec - t5.tv_usec) / 1000);
	printf("Always jumping loop execution time:    %lld ms\n", time0);
	printf("Sometimes jumping loop execution time: %lld ms\n", time1);
	return 0;
}

