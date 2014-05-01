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
        abraham = 10;
        //abraham = (new int[5])[2];
    }
}

The program will have one Variable Declaration and one Method Declaration, so 2 declarations

*/

int main(void)
{

	node_t* ast_root;
	node_t* declarations;

	node_t* var_declarations;
	node_t* var_decl_temp;
	node_t* var_decl_temp2;
	
	node_t* parameter_decl;
	node_t* parameter_decl_temp;

	node_t* method_decl_temp;
	node_t* method_declarations;

	node_t* method_body_list;
	node_t* statement_temp;

	node_t* destiny;
	node_t* source;

	char var_name[15] = {'o', 'u', 't', 's', 'i', 'd', 'e', 'I', 'n', 't', 'e', 'g', 'e', 'r', '\0'};
	char param_name[6] = {'a', 'r', 'g', 's', '\0'};
	char var_name2[3] = {'j', '\0'};
	char var_name3[9] = {'a', 'b', 'r', 'a', 'h', 'a', 'm', '\0'};
	int var_value = 2;

	ast_root = NULL;/*This will be the root of our Sintax-Free Tree*/
	declarations = NULL;/*This will have our variable declaration and our method declaration*/


/*
----------------------------Variable Declarations----------------------------------------------------
*/

	/*Create the variable declaration and append it to the list of declarations*/

	var_decl_temp = node_create_terminal(TYPE_UNKNOWN, var_name);/*Create the terminal node for the "static int outsideInteger;" declaration*/
	declarations = node_create_vardecl(TYPE_INT, var_decl_temp);
	/*If we had more variable declarations then we would create them and append them to "var_declarations"*/


/*
------------------------------Method Declarations----------------------------------------------------
*/

	/*Method will have TYPE; ID; PARAMETERS; BODY*/

	method_decl_temp = node_create(NODE_METHODDECL);/*Create the list of declarations for the parameters of the method*/

	parameter_decl_temp = node_create_terminal(TYPE_UNKNOWN, param_name);/*This node will be one declaration of one parameter*/
	parameter_decl = node_create_vardecl(TYPE_STRINGARRAY, parameter_decl_temp);/*List of parameters declarations*/

	method_decl_temp->n1 = parameter_decl;/*Points to the parameters declarations*/

	/*Create the list of variable declarations*/
	var_decl_temp = node_create_terminal(TYPE_UNKNOWN, var_name2);/*Create the terminal node for the "int j" declaration*/
	var_declarations = node_create_vardecl(TYPE_INT, var_decl_temp);/*Store it in a list of declarations*/

	var_decl_temp = node_create_terminal(TYPE_UNKNOWN, var_name3);/*Create the terminal node for the "int abraham" declaration*/
	var_decl_temp2 = node_create_vardecl(TYPE_INT, var_decl_temp);/*Store it in a list of declarations*/

	var_declarations = node_append(var_decl_temp, var_decl_temp2);/*Join the two declarations*/

	
	/*Create the list of statements. In this case it will only be "abraham = (new int[5])[2];"*/

	statement_temp = node_create(NODE_STATEMENT_STORE);

	destiny = node_create_terminal(TYPE_INT, var_name3);/*abraham*/
	source = node_create_terminal_int(TYPE_INT, var_value);/*2*/

	statement_temp->n1 = destiny;/*Points to the destiny, where we store the stuff*/
	statement_temp->n2 = source;/*Points to the source*/
	
	method_body_list = statement_temp;

	method_decl_temp->n2 = method_body_list;/*Points to a list of variable declarations and statements*/


	/*Append the declaration of this method to the list of declarations of methods*/
	method_declarations = method_decl_temp;/*Since we only have one method we can do just this*/


/*
------------------------------Join Declarations------------------------------------------------------
*/


	/*Append to "declarations" the declaration of the method*/

	declarations = node_append(declarations,method_declarations);

	ast_root = node_create_program(declarations);

	/*Print the final result*/
	print_ast(ast_root);

	/*Note: During these tests I will not concern myself with free-ing the AST, I will let it to be done later*/


	return 0;
}
