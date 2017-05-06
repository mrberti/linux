#include <stdio.h>
#include <time.h>
#include <assert.h>
#include <math.h>

#define NSEC_PER_SEC 1000000000
#define TS 10// time step in ms

double do_something(int x)
{
	int i = 0;
	double ret = 0.0;
	for(i = 0; i < 123456789; ++i)
	{
		ret = sqrt(i);		
		if (i >= x)
			break;
	}
	return ret;
}

int calculate_next_time_step(struct timespec *t, long ms)
{
	if( ms <= 0 )
	{
		assert( ms > 0 );
		printf("<ms> must be greater 0\n");
		return -1;
	}

	t->tv_nsec += ms * 1000000;

	normalize_timespec(t);

	return 0;
}

int normalize_timespec(struct timespec *t)
{
	while( t->tv_nsec > NSEC_PER_SEC )
	{
		t->tv_nsec -= NSEC_PER_SEC;
		t->tv_sec++;
	}
	return 0;
}

double timespec_to_double(struct timespec *t)
{
	double secs = 0.0;
	normalize_timespec(t);
	secs = (double)t->tv_sec;
	secs += (double)t->tv_nsec/(double)NSEC_PER_SEC;
	return secs;
}

int main()
{
	int ret = 0;

	struct timespec t, t2, t_start, t_end;
	clock_t start, end;
	t.tv_sec = 0;
	t.tv_nsec = 0;
	t2 = t;
	int s = 0;
	int i = 0;
	int overflows = 0;
	double secs_end, secs_start, diff, diff_real;

	clock_gettime(CLOCK_MONOTONIC,&t);
	
	for(i = 0; i < 10; ++i)
	{
		// calculate next time step
		calculate_next_time_step(&t, TS);
		// Get start time stamps
		clock_gettime(CLOCK_MONOTONIC, &t_start);
		secs_start = timespec_to_double(&t_start);
		
		/* 
		   CONTROL CYCLE START
		   */

		if(overflows <= 0)
			s += TS*100;
		do_something(s);

		/*
		   CONTROL CYCLE END
		   */

		// Get duration of control cycle
		clock_gettime(CLOCK_MONOTONIC, &t_end);

		secs_end = timespec_to_double(&t_end);
		diff_real = secs_end - secs_start;

		// sleep
		ret = clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &t, &t2);
		
		// get end time of total loop
		clock_gettime(CLOCK_MONOTONIC, &t_end);
		secs_end = timespec_to_double(&t_end);
		diff = secs_end - secs_start;
		//printf("next step started @ %d.%d (%f)\n", t_end.tv_sec, t_end.tv_nsec, secs_end);
		printf("i = %d, S = %d, DIFF_REAL = %f, DIFF = %f, F=%f, HEAD = %f\n",i,s, diff_real, diff, (diff*100000)/TS, diff - diff_real);
		if((diff*100000)/TS > 105)
		{
			overflows++;
		}
		
	}
	printf("overflows = %d, ret = %d, s = %d, n = %d\n",overflows, ret,t2.tv_sec, t2.tv_nsec);

	return ret;
}
