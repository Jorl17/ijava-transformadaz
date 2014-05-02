#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include "sym_table.h"

/*This file aims to create a dummy Sintax-Free Tree, to help the development of the Semantic Analisys, more specifically the creation of
the symbol tables*/

/*Develop the dummy-tree for the following program:

class Test
{
    static int outsideInteger;
    static int b;

    public static void main(String []args)
    {
        int j, abraham;
        abraham = 2;
        //j = abraham + abraham; 
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

	node_t* statement_temp;
	node_t* statements_list;

	node_t* method_body_list;

	node_t* destiny;
	node_t* source;

	char var_name[15] = {'o', 'u', 't', 's', 'i', 'd', 'e', 'I', 'n', 't', 'e', 'g', 'e', 'r', '\0'};
	char param_name[6] = {'a', 'r', 'g', 's', '\0'};
	char var_name2[3] = {'j', '\0'};
	char var_name3[9] = {'a', 'b', 'r', 'a', 'h', 'a', 'm', '\0'};
	char var_name4[3] = {'b', '\0'};
	char main_method_name[6] = {'m', 'a', 'i', 'n', '\0'};
	char program_name[6] = {'T', 'e', 's', 't', '\0'};

	int var_value = 2;

	symtab_t* class_table;


/*
----------------------------Variable Declarations----------------------------------------------------
*/

	/*Create the variable declaration and append it to the list of declarations*/

	var_decl_temp = node_create_terminal(TYPE_UNKNOWN, var_name);/*Create the terminal node for the "static int outsideInteger;" declaration*/
	declarations = node_create_vardecl(TYPE_INT, var_decl_temp);

	printf("AQUI %d\n", declarations->type==TYPE_INT?1:-1);

	var_decl_temp = node_create_terminal(TYPE_UNKNOWN, var_name4);/*Create the terminal node for the "static int b;" declaration*/
	var_decl_temp2 = node_create_vardecl(TYPE_INT, var_decl_temp);

	printf("AQUI %d\n", var_decl_temp2->type==TYPE_INT?1:-1);

	declarations = node_append(declarations, var_decl_temp2);
	/*If we had more variable declarations then we would create them and append them to "var_declarations"*/


/*
------------------------------Method Declarations----------------------------------------------------
*/

	/*Method will have TYPE; ID; PARAMETERS; BODY*/

	method_decl_temp = node_create(NODE_METHODDECL);/*Create the list of declarations for the parameters of the method*/

	method_decl_temp->node_name = main_method_name;
	method_decl_temp->return_type = TYPE_VOID;

	parameter_decl_temp = node_create_terminal(TYPE_UNKNOWN, param_name);/*String[] args*/
	parameter_decl = node_create_vardecl(TYPE_STRINGARRAY, parameter_decl_temp);/*List of parameters declarations*/

	method_decl_temp->n1 = parameter_decl;/*Points to the parameters declarations*/

	/*Create the list of variable declarations*/
	var_decl_temp = node_create_terminal(TYPE_UNKNOWN, var_name2);/*int j*/
	var_declarations = node_create_vardecl(TYPE_INT, var_decl_temp);/*Store it in a list of declarations*/

	var_decl_temp = node_create_terminal(TYPE_UNKNOWN, var_name3);/*int abraham*/
	var_decl_temp2 = node_create_vardecl(TYPE_INT, var_decl_temp);/*Store it in a list of declarations*/

	var_declarations = node_append(var_declarations, var_decl_temp2);/*Join the two declarations*/

	node_t* temp;

	temp = var_declarations;
	printf("VAR DECLARATIONS:\n");

	while (temp != NULL)
	{
		printf("%s\n", temp->n2->id);
		temp = temp->next;
	}
	
	/*Create the list of statements. In this case it will only be "abraham = (new int[5])[2];"*/

	statement_temp = node_create(NODE_STATEMENT_STORE);

	destiny = node_create_terminal(TYPE_INT, var_name3);/*abraham*/
	destiny->type = TYPE_ID;

	source = node_create_terminal_int(TYPE_INTLIT, var_value);/*2*/
	source->type = TYPE_INTLIT;

	statement_temp->n1 = destiny;/*Points to the destiny, where we store the stuff*/
	statement_temp->n2 = source;/*Points to the source*/

	statements_list = statement_temp;

	printf("STATEMENTS_LIST:\n");

	temp = statements_list;

	while (temp != NULL)
	{
		printf("%s %d\n", temp->n1->id, temp->n2->value);
		temp = temp->next;
	}
	
	/*Method Body will have var_declarations + statement_list*/
	
	method_body_list = var_declarations;

	method_body_list = node_append(method_body_list, statements_list);

	method_decl_temp->n2 = method_body_list;/*Points to a list of variable declarations and statements*/


	/*Append the declaration of this method to the list of declarations of methods*/
	method_declarations = method_decl_temp;/*Since we only have one method we can do just this*/


/*
------------------------------Join Declarations------------------------------------------------------
*/


	/*Append to "declarations" the declaration of the method*/

	declarations = node_append(declarations,method_declarations);

	ast_root = node_create_program(declarations);

	ast_root->node_name = program_name;

	/*Print the final result*/
	printf("\nAST:\n");
	print_ast(ast_root);

	/*Note: During these tests I will not concern myself with free-ing the AST, I will let it to be done later*/


	/*Create the symbol tables*/
	class_table = analyse_ast(ast_root);

	printTable(class_table);

	return 0;
}
