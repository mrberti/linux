#include <stdio.h>
#include <math.h>
#include <time.h>

/**
  Use gcc -lm
  **/

#define MAX_N 123456789
int main()
{
	clock_t start, end;
	start = clock();	
	int i = 0;
	double s = 0;
	
	for(i=0;i<MAX_N;i++)
	{
		s = sqrt(i);
	}
	end = clock();
	double exec_time = (double)(end-start)/CLOCKS_PER_SEC;
	printf("i = %d, s = %f\n", i, s);
	printf("%d calculations in %lf s\n", i, exec_time);
	printf("roughly %.0lf calculations per second\n", (double)i/(double)exec_time);
}
