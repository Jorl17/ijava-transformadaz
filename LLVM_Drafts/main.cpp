#include <stdlib.h>
#include <stdio.h>

struct IntArray{
	int size;
	bool* array;
};

int main(void)
{
	struct IntArray array;
	
	array.size = 40;

	array.array = (bool *) malloc(array.size*sizeof(bool));

	return 0;
}