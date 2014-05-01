#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <stdio.h>

#include "sym_table.h"

/*This function will go through the AST and create the necessary tables. This method returns the class table, with all the attributes
and methods of the class. We do not need to return the other symbol tables because the class' symbol table stores a pointer for each
method defined in there. So, if later we need to access a method's symbol table we just search it in the class' symbol table*/
symtab_t* analyse_ast(node_t* currentNode)
{
	printf("AQUI %d\n", currentNode->nodetype);

	/*If currentNode->nodetype == 1 then we have Variable Declarations
	  If currentNode->nodetype == 2 then we have Method Declarations*/

	if (currentNode->next != NULL)
		analyse_ast(currentNode->next);

	return NULL;
}