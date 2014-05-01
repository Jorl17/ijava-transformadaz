#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "idlist_t.h"

/*These are functions for managing a list of strings (char *), used in one node of the Sintax-Free Tree, where the insertions are made on
the top of the list. That is, if we insert the elements c, b and a then, after those insertions the list would be: a->b->c*/

/*Function responsible for adding a new element to the list, taking into account the new node will be the top of the list*/
idlist_t* insert_list(idlist_t   *list, char *node_name)
{
	idlist_t *node;

	node = (idlist_t *)malloc(sizeof(idlist_t));/*Create a new node*/

	if (node != NULL)
	{
		node->name = (char *)malloc((strlen(node_name)+1)*sizeof(char));/*Allocate space for the node's content (the string)*/

		if (node->name != NULL)
			strcpy(node->name, node_name);/*Copy the desired name for the correspondent field*/

		if (list != NULL)/*Insert the node on the top of the list, making it point to the previous first element of the list*/
		{
			node->next = list;
			list = node;
		}

		else/*The list is empty, the node will be the list*/
		{
			list = node;
			list->next = NULL;
		}
	}

	return list;/*Return the current list, containing the inserted node*/
}

/*Function responsible for printing the list*/
void printStuff(idlist_t  *list)
{
	/*Go through the list and print every element*/
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

	/*Go through the list and for every element free it's content and then free the node*/
	while (list != NULL)
	{
		current = list;
		list = list->next;
		free(current->name);
		free(current);
	}	
}
