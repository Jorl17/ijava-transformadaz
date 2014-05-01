#include <stdio.h>
#include <stdlib.h>

#include "node_t.h"

/*This file aims to create a dummy Sintax-Free Tree, to help the development of the Semantic Analisys, more specifically the creation of
the symbol tables*/

/*Develop the dummy-tree for the following program:

class Test
{
    static int outsideInteger;

    public static void main(String []args)
    {
        int j, abraham;
        abraham = (new int[5])[2];
    }
}

The program will have one Variable Declaration and one Method Declaration, so 2 declarations

*/

int main(void)
{

	node_t* ast_root;
	node_t* declarations;
	node_t* var_declarations;
	node_t* method_declarations;
	node_t* terminal_outsideInteger;
	char name[14] = {'o', 'u', 't', 's', 'i', 'd', 'e', 'I', 'n', 't', 'e', 'g', 'e', 'r', '\0'};

	ast_root = NULL;/*This will be the root of our Sintax-Free Tree*/
	declarations = NULL;/*This will have our variable declaration and our method declaration*/


/*
----------------------------Variable Declarations----------------------------------------------------
*/

	/*Create the variable declaration and append it to the list of declarations*/

	terminal_outsideInteger = node_create_terminal(TYPE_UNKNOWN, name);/*Create the terminal node for the "static int outsideInteger;" declaration*/
	var_declarations = node_create_vardecl(TYPE_INT, terminal_outsideInteger);
	/*If we had more variable declarations then we would create them and apend them to "var_declarations"*/

	declarations = var_declarations;


/*
------------------------------Method Declarations----------------------------------------------------
*/


	/*declarations = node_apend(var_declarations, method_declarations);*/



	return 0;
}
