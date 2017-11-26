#define NDEBUG
#define USE_THREADS
#include <assert.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

#ifndef MAX_THREADS
	#define MAX_THREADS 20
#endif

void* func(void* arg)
{
	int i;
	int val = *((int*)arg);
	int th_id = val;
	printf("start %d\n", th_id);
	for(i=0;i<212345678;++i)
	{
		val *= th_id;
		//printf("%d\r",val);
	}

	printf("end %d, %d\n", th_id, val);
}

int main(int argc, char *argv[])
{
	int i = 0;
	pthread_t threads[MAX_THREADS];
	int arg[MAX_THREADS];
	for(i = 0; i < MAX_THREADS; ++i)
	{
		arg[i] = i;
#ifdef USE_THREADS
		pthread_create(&threads[i], NULL, func, &arg[i]);
#else
		func(&arg[i]);
#endif
	}
	printf("main start\n");
	int ret = 0;
	int a = 0;
	int b = 0;
	int c = 0;
	assert(c==1);

	for(i = 0; i < 1234; ++i)
		a = i*c;

	for(i = 0; i < MAX_THREADS; ++i)
	{
#ifdef USE_THREADS
		pthread_join(threads[i], NULL);
#else

#endif
	}
	printf("main end\n");

	return EXIT_SUCCESS;
}
