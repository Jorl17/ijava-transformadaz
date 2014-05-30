#include <stdlib.h>
#include <stdio.h>

struct IntArray{
	int size;
	int* array;
};

struct IntArray array;

int main(void)
{
	array.size = 40;

	array.array = (int *) malloc(array.size*sizeof(int));

	return 0;
}