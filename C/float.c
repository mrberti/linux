#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main()
{
	int_least8_t i8;
	i8 = 123;
	long double f = 1.123, g = 1.123;
	short x = 1234, y = 3210;

	printf("%d, %lld\n", INT_LEAST8_MAX, INT_LEAST64_MAX);
	printf("size of f %d\n", sizeof(f));

	float a,b,c;
	_Bool bo;
	a = 2.123;
	b = 1.123;
	c = a*b*f;
	f = f * g;
	x = x + y;
	return c;
}
