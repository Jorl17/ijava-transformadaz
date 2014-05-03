#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

#include "sym_t.h"

#define DEBUG 0

/*Creates a new symbol table*/
sym_t* create_table(char* table_name, int class)
{
	sym_t* table;

	table = (sym_t*) malloc(sizeof(sym_t));
	memset(table,0,sizeof(sym_t));

	table->id = table_name;

	if (class == 1)
		table->node_type = CLASS_TABLE;
	else
		table->node_type = METHOD_TABLE;

	return table;
}

/*Creates a new table element containing the declaration of a variable*/
sym_t* create_variable(char* var_name, int var_type)
{
	sym_t* var;

	var = (sym_t*)malloc(sizeof(sym_t));
	memset(var,0,sizeof(sym_t));

	var->id = var_name;
	var->type = var_type;
	var->node_type = VARIABLE;

	return var;
}

/*Creates a new table element containing the declaration of a method, to include in the class' symbol table*/
sym_t* create_method(char* method_name)
{
	sym_t* method;

	method = (sym_t*)malloc(sizeof(sym_t));
	memset(method,0,sizeof(sym_t));

	method->id = method_name;
	method->node_type = METHOD;

	return method;
}

/*Adds a previously created element to the specified symbol table*/
void add_element_to_table(sym_t* table, sym_t* element)
{
	sym_t* current;

	current = table;

	while (current->next != NULL)
		current = current->next;

	current->next = element;
}

/*Prints an element in a symbol table*/
void print_element(sym_t* element)
{
	int type;

	printf("%s", element->id);/*Print the element name*/

	type = element->type;

	if (element->node_type == VARIABLE)
	{
		if (type == TYPE_INT)
			printf("\tint");
		else if (type == TYPE_BOOL)
			printf("\tboolean");
		else if (type == TYPE_INTARRAY)
			printf("\tint[]");
		else if (type == TYPE_BOOLARRAY)
			printf("\tboolean[]");
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
void printTable(sym_t* table)
{
	sym_t* current;

	if (table->node_type == CLASS_TABLE)
		printf("===== Class %s Symbol Table =====\n", table->id);
	else if (table->node_type == METHOD_TABLE)
		printf("===== Method %s Symbol Table =====\n", table->id);


	current = table->next;/*Jump the first element, which will tell us that the it is a table for a class/method*/

	while (current != NULL)
	{
		print_element(current);
		current = current->next;
	}
}

/*Adds all the declarations of parameters to a given method's symbol table*/
void add_parameters_declarations(sym_t* root, node_t* var_decl)
{
	node_t* current;
	sym_t* temp;

	/*Remember that var_decl = methodNode->n3. Since the list of declarations is in methodNode->n3->n1 we need to make
	current = var_decl->n1 and then iterate through the list*/
	current = var_decl->n1;

	while (current != NULL)
	{
		#if DEBUG
		printf("PARAM_DECL %s %d\n", current->n2->id, current->n1->type);
		#endif

		temp = create_variable(current->n2->id, current->n1->type);
		temp->is_parameter = 1;

		add_element_to_table(root,temp);

		current = current->next;
	}
}

/*Adds all the declarations of variables to a given method's symbol table*/
void add_variables_declarations(sym_t* root, node_t* var_decl)
{
	node_t* current;
	node_t* current_var;
	sym_t* temp;
	int var_type;

	/*Get the list of variable declarations. Each element of this list corresponds to a list of declarations per line*/
	current = var_decl->n1;

	while (current != NULL)/*Go through all the declarations of variables in each line*/
	{
		current_var = current->n2;
		var_type = current->n1->type;

		/*We can have more than one declaration of variables in one line, so let's check it*/
		
		while (current_var != NULL)
		{
			#if DEBUG
			printf("VARIABLE %s OF TYPE %d\n", current_var->id, var_type);
			#endif

			temp = create_variable(current_var->id, var_type);

			add_element_to_table(root,temp);

			current_var = current_var->next;
		}

		current = current->next;
	}
}

/*Function responsible for creating a symbol table for a method*/
sym_t* create_method_table(node_t* methodNode)
{

	sym_t* root;
	sym_t* temp;
	char* return_string;/*Will contain the following string: "return"*/
	char string[8] = {'r', 'e', 't', 'u', 'r', 'n', '\0'};
	int return_string_len;

	return_string_len = 8;

	/*Create method's symbol table*/
	root = create_table(methodNode->n2->id, 0);

	/*Add the method's return type...*/
	return_string = (char *)malloc(return_string_len*sizeof(char));
	strcpy(return_string,string);
	temp = create_variable(return_string,methodNode->n1->type);

	/*...and add it to the method's table*/
	add_element_to_table(root,temp);

	/*Add Method's Arguments to the table
	We can reach the list of arguments of the method with: methodNode->n3*/
	add_parameters_declarations(root,methodNode->n3);

	/*Add Method's Variable Declarations to the table*/
	add_variables_declarations(root,methodNode->n4);

	return root;
}

/*This function will go through the AST and create the necessary tables. This method returns the class table, with all the attributes
and methods of the class. We do not need to return the other symbol tables because the class' symbol table stores a pointer for each
method defined in there. So, if later we need to access a method's symbol table we just search it in the class' symbol table*/
sym_t* analyse_ast(node_t* root)
{
	node_t* currentNode;
	node_t* current_var;
	sym_t* current;
	sym_t* method_symbol_table;
	sym_t* table;

	table = create_table(root->n1->id,1);

	currentNode = root->n2;

	while (currentNode != NULL)
	{
		if (currentNode->nodetype == NODE_VARDECL)
		{
			/*Create the variable. Note that this node can bellong to a linked list of declarations, so we need to declare all the
			variables in that list*/
			current_var = currentNode->n2;

			while (current_var != NULL)
			{
				#if DEBUG
				printf("Declarei variavel com o nome %s e tipo %d\n", current_var->id, currentNode->n1->type);
				#endif

				current = create_variable(current_var->id, currentNode->n1->type);

				add_element_to_table(table,current);

				current_var = current_var->next;
			}
		}

		else if (currentNode->nodetype == NODE_METHODDECL)
		{
			#if DEBUG
			printf("Declarei metodo com o nome %s e tipo de retorno %d\n", currentNode->n2->id, currentNode->n1->type);
			#endif

			/*Create a new entry in the class' symbol table with the method*/
			current = create_method(currentNode->n2->id);

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
