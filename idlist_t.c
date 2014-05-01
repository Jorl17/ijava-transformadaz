#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "idlist_t.h"

/*FIXME: ADD Documentation*/

idlist_t * insere(idlist_t   *list, char *nome)
{
	idlist_t   *novo;

	novo = (idlist_t   *)malloc(sizeof(idlist_t  ));

	if (novo != NULL)
	{
		novo->name = (char *)malloc((strlen(nome)+1)*sizeof(char));

		if (novo->name != NULL)
			strcpy(novo->name, nome);

		if (list != NULL)
		{
			novo->next = list;
			list = novo;
		}

		else/*list == NULL*/
		{
			list = novo;
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
