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

	array.array = NULL;

	return 0;
}