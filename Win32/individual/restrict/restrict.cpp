// Headers
#include <cstdio>
#include <cstdint>
	
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
	// Correct usage
	int a = 3, b = 5, c = 7;
    printf("Expected: 3 5 7\nActual:   %d %d %d\n", a, b, c);
    normal(&a, &b, &c);
    printf("Expected: 8 8 7\nActual:   %d %d %d\n", a, b, c);
    c = 5;
    restricted(&a, &b, &c);
    printf("Expected: 6 6 5\nActual:   %d %d %d\n\n", a, b, c);

	// Incorrect usage
	int p = 7;
	printf("Expected: 7\nActual:   %d \n", p);
	normal(&p, &p, &p);
	printf("Expected: 9\nActual:   %d \n", p);
	restricted(&p, &p, &p);
	printf("Expected: 11\nActual:   %d \n", p);

	return 0;
}
