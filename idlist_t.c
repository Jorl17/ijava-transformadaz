#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "idlist_t.h"

/*FIXME: ADD Documentation*/

/*Function responsible for adding a new element to the list, taking into account the new node will be the top of the list*/
idlist_t* insert_list(idlist_t   *list, char *node_name)
{
	idlist_t *node;

	node = (idlist_t *)malloc(sizeof(idlist_t));

	if (node != NULL)
	{
		node->name = (char *)malloc((strlen(node_name)+1)*sizeof(char));

		if (node->name != NULL)
			strcpy(node->name, node_name);

		if (list != NULL)
		{
			node->next = list;
			list = node;
		}

		else/*The list is empty*/
		{
			list = node;
			list->next = NULL;
		}
	}

	return list;
}

void printStuff(idlist_t  *list)
{
	while (list != NULL)
	{
		printf("%s\n", list->name);
		list = list->next;
	}
}

/*Function to free-up the list, cleaning all the memmory we allocate during the execution*/
void freeStuff(idlist_t  *list)
{
	idlist_t  *current;

	while (list != NULL)
	{
		current = list;
		list = list->next;
		free(current->name);
		free(current);
	}	
}
