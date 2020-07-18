// Headers
#include <stdio.h>
#include <sys/time.h>

// ASM functions
#ifdef __cplusplus
	extern "C" {
#endif
	void pipeline_bad(void);
	void pipeline_good(void);
#ifdef __cplusplus
	}
#endif

// Boilerplate code
int main(int argc, char* argv[])
{
	// Timer initialization
    struct timeval t1, t2, t3, t4;
	
	// Pipelining examples
    gettimeofday(&t1, NULL);
	pipeline_bad();
    gettimeofday(&t2, NULL);

    gettimeofday(&t3, NULL);
	pipeline_good();
    gettimeofday(&t4, NULL);
    
    // Results
    unsigned long long time0 = ((t2.tv_sec - t1.tv_sec) * 1000) + ((t2.tv_usec - t1.tv_usec) / 1000);
    unsigned long long time1 = ((t4.tv_sec - t3.tv_sec) * 1000) + ((t4.tv_usec - t3.tv_usec) / 1000);
	printf("Bad pipelining execution time:    %lld ms\n", time0);
	printf("Good pipelining execution time:   %lld ms\n", time1);
	return 0;
}

