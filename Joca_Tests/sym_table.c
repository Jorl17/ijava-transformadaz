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

/*Creates a new table element containing the declaration of a method, to include in the class' symbol table*/
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

/*Prints an element in a symbol table*/
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

/*Prints a symbol table*/
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

/*Adds all the declarations of parameters to a given method's symbol table*/
void add_parameters_declarations(symtab_t* root, node_t* var_decl)
{
	node_t* current;
	symtab_t* temp;

	current = var_decl->n1;

	while (current != NULL)
	{
		printf("PARAM_DECL %s %d\n", current->n2->id, current->n1->type);

		temp = create_variable(current->n2->id, current->n1->type);
		temp->is_parameter = 1;

		add_element_to_table(root,temp);

		current = current->next;
	}
}

/*Adds all the declarations of variables to a given method's symbol table*/
void add_variables_declarations(symtab_t* root, node_t* var_decl)
{
	node_t* current;
	symtab_t* temp;

	current = var_decl->n1;

	/*FIXME: THERE IS A PROBLEM IN THIS FUNCTION. FOR SOME REASON WE HAVE ONE MORE DECLARATION OF VARIABLES IN THE METHOD
	WILL TRY TO FIGURE IT OUT TOMOROW BUT FOR NOW THE BUG IS CORRECTED -- LETS HOPE THE BUG IS IN THE "CREATION" OF THE AST...*/

	while (current != NULL)
	{
		printf("VAR_DECL %s %d\n", current->n2->id, current->type);

		temp = create_variable(current->n2->id, current->type);

		add_element_to_table(root,temp);

		current = current->next;
	}
}

/*Function responsible for creating a symbol table for a method*/
symtab_t* create_method_table(node_t* methodNode)
{
	symtab_t* root;
	symtab_t* temp;
	char* return_string;/*Will contain the following string: "return"*/
	int return_string_len;

	/*Method will have TYPE; ID; PARAMETERS; BODY

	Let's consider that the node "method_decl_temp" has a given method M.
	Then, M->return_type will give us the type of return of the method
	Also, M->n1 will give us a list of declarations of the parameters/arguments of the method
	M->n2 will give us a list of the declarations of variables inside the method
	M->n3 will give us a list of the statements in the method*/

	return_string_len = 6;

	root = create_table(methodNode->node_name, 0);/*Create method's symbol table*/

	/*Add the method's return type...*/
	return_string = (char *)malloc(return_string_len*sizeof(char));
	strcpy(return_string,"return");
	temp = create_variable(return_string,methodNode->return_type);
	/*...and add it to the method's table*/
	add_element_to_table(root,temp);

	/*Add Method's Arguments to the table
	If we go to methodNode->n1 we reach the list of parameters declarations
	Then is just a matter of going through all of them and add them to the table*/
	add_parameters_declarations(root,methodNode->n1);

	/*FIXME: Add Method's Declarations to the table
	Same but with methodNode->n2*/
	add_variables_declarations(root,methodNode->n2);

	return root;
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
				printf("Declarei variavel com o nome %s e tipo %d\n", current_var->id, currentNode->type);

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

			/*Create the method's symbol table*/
			method_symbol_table = create_method_table(currentNode);

			/*Link the entry in the class' symbol table with the symbol table of the method*/
			current->table_method = method_symbol_table;

			add_element_to_table(table, current);
		}

		currentNode = currentNode->next;
	}

	return table;
}
