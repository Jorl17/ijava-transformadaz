#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <stdio.h>

#include "sym_table.h"

/*Creates a new symbol table*/
symtab_t* create_table(char* table_name, int class)
{
	symtab_t* table;

	table = (symtab_t*) malloc(sizeof(symtab_t));
	memset(table,0,sizeof(symtab_t));
	table->name = table_name;

	if (class == 1)
		table->node_type = CLASS_TABLE;
	else
		table->node_type = METHOD_TABLE;

	return table;
}

/*Creates a new table element containing the declaration of a variable*/
symtab_t* create_variable(char* var_name, int var_type)
{
	symtab_t* var;

	var = (symtab_t*)malloc(sizeof(symtab_t));
	memset(var,0,sizeof(symtab_t));

	var->id = var_name;
	var->type = var_type;
	var->node_type = VARIABLE;

	return var;
}

/*Creates a new table element containing the declaration of a method*/
symtab_t* create_method(char* method_name)
{
	symtab_t* method;

	method = (symtab_t*)malloc(sizeof(symtab_t));
	memset(method,0,sizeof(symtab_t));

	method->id = method_name;
	method->node_type = METHOD;

	return method;
}

/*Adds a previously created element to the specified symbol table*/
void add_element_to_table(symtab_t* table, symtab_t* element)
{
	symtab_t* current;

	current = table;

	while (current->next != NULL)
		current = current->next;

	current->next = element;
}

void print_element(symtab_t* element)
{
	int type;

	printf("%s", element->id);/*Print the element name*/

	type = element->type;

	if (element->node_type == VARIABLE)
	{
		if (type == TYPE_INT)
			printf("\tint");
		else if (type == TYPE_BOOL)
			printf("\tbool");
		else if (type == TYPE_INTARRAY)
			printf("\tint[]");
		else if (type == TYPE_BOOLARRAY)
			printf("\tbool[]");
		else if (type == TYPE_STRINGARRAY)
			printf("\tString[]");
		else if (type == TYPE_VOID)
			printf("\tvoid");

		if (element->is_parameter == 1)
			printf("\tparam");
		printf("\n");
	}

	else if (element->node_type == METHOD)
		printf("\tmethod\n");
}

/*Prints the table*/
void printTable(symtab_t* table)
{
	symtab_t* current;

	if (table->node_type == CLASS_TABLE)
		printf("===== Class %s Symbol Table =====\n", table->name);
	else if (table->node_type == METHOD_TABLE)
		printf("===== Method %s Symbol Table =====\n", table->name);


	current = table->next;/*Jump the first element, which will tell us that the it is a table for a class/method*/

	while (current != NULL)
	{
		print_element(current);
		current = current->next;
	}
}

/*This function will go through the AST and create the necessary tables. This method returns the class table, with all the attributes
and methods of the class. We do not need to return the other symbol tables because the class' symbol table stores a pointer for each
method defined in there. So, if later we need to access a method's symbol table we just search it in the class' symbol table*/
symtab_t* analyse_ast(node_t* root)
{
	node_t* currentNode;
	node_t* current_var;
	symtab_t* current;
	symtab_t* method_symbol_table;
	symtab_t* table;

	table = create_table(root->node_name,1);

	currentNode = root->n1;

	while (currentNode != NULL)
	{
		if (currentNode->nodetype == NODE_VARDECL)
		{
			current_var = currentNode->n2;

			while (current_var != NULL)
			{
				/*printf("Declarei variavel com o nome %s e tipo %d\n", current_var->id, currentNode->type);*/

				current = create_variable(current_var->id, currentNode->type);

				add_element_to_table(table,current);

				current_var = current_var->next;
			}
		}

		else if (currentNode->nodetype == NODE_METHODDECL)
		{
			printf("Declarei metodo com o nome %s e tipo de retorno %d\n", currentNode->node_name, currentNode->return_type);

			/*Create a new entry in the class' symbol table with the method*/
			current = create_method(currentNode->node_name);

#if 0
			/*Create the method's symbol table*/
			method_symbol_table = 

			/*Link the entry in the class' symbol table with the symbol table of the method*/
			current->table_method = method_symbol_table;
#endif

			add_element_to_table(table, current);
		}

		currentNode = currentNode->next;
	}

	return table;
}
