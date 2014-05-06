#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

#include "sym_t.h"

/*#define DEBUG*/
#undef DEBUG
#ifdef DEBUG
#define DEBUG_PRINT(...) do{ fprintf( stderr, __VA_ARGS__ ); } while( 0 )
#else
#define DEBUG_PRINT(...) do{ } while ( 0 )
#endif

char* sym_type_names[] = {
    "int",
    "boolean",
    "int[]",
    "boolean[]",
    "String[]",
    "void",
    "Id",
    "IntLit",
    "BoolLit",
    "String",
    "Unknown" /* Used internally */
};

sym_t* create_node(ijava_table_type_t nodeType, char* name)
{
	sym_t* node;

	assert(name);

	node = (sym_t*) malloc(sizeof(sym_t));
	
	memset(node,0,sizeof(sym_t));

	node->type = TYPE_UNKNOWN;
	node->is_parameter = 0;
	node->id = name;
	node->next = NULL;
	node->table_method = NULL;
	node->node_type = nodeType;
	node->method_start = NULL;

	return node;
}

/*Creates a new symbol table*/
sym_t* create_table(char* table_name, ijava_table_type_t type)
{
	sym_t* table;

	assert(table_name);
	assert(type == CLASS_TABLE || type == METHOD_TABLE);

	table = create_node(type, table_name);

	return table;
}

/*Creates a new table element containing the declaration of a variable*/
sym_t* create_variable(char* var_name, ijavatype_t var_type)
{
	sym_t* var;

	var = create_node(VARIABLE, var_name);

	var->type = var_type;

	return var;
}

/*Creates a new table element containing the declaration of a method, to include in the class' symbol table*/
sym_t* create_method(char* method_name, node_t* methoddecl)
{
	sym_t* method;

	assert(method_name);
	assert(methoddecl);
	assert(methoddecl->nodetype == NODE_METHODDECL);

	method = create_node(METHOD, method_name);

	/* methoddecl->n4 should have the methodbody */
	method->method_start = methoddecl->n4;

	return method;
}

/*Adds a previously created element to the specified symbol table*/
void add_element_to_table(sym_t* table, sym_t* element)
{
	sym_t* current;

	assert(table);
	assert(element);

	current = table;

	while (current->next != NULL)
		current = current->next;

	current->next = element;
}

/*Prints an element in a symbol table*/
void print_element(sym_t* element)
{
	ijavatype_t type;

	assert(element);

	/*Print the element name*/
	printf("%s", element->id);

	type = element->type;

	if (element->node_type == VARIABLE)
	{
		/*
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
		*/

		printf("\t%s", sym_type_names[type]);

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

	assert(table);
	assert(table->node_type == CLASS_TABLE || table->node_type == METHOD_TABLE);

	if (table->node_type == CLASS_TABLE)
		printf("===== Class %s Symbol Table =====\n", table->id);
	else if (table->node_type == METHOD_TABLE)
		printf("===== Method %s Symbol Table =====\n", table->id);

	/*Jump the first element, which will tell us that the it is a table for a class/method*/
	current = table->next;

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
		
		DEBUG_PRINT("PARAM_DECL %s %d\n", current->n2->id, current->n1->type);
		

		/*Check if variable is already defined*/
		errorIfDuplicates(root, current->n2->id);

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
	ijavatype_t var_type;

	assert(var_decl->nodetype == NODE_METHODBODY);

	/*Get the list of variable declarations. Each element of this list corresponds to a list of declarations per line*/
	current = var_decl->n1;

	while (current != NULL)/*Go through all the declarations of variables in each line*/
	{
		assert(current->nodetype == NODE_VARDECL);

		current_var = current->n2;
		var_type = current->n1->type;

		/*We can have more than one declaration of variables in one line, so let's check it*/
		
		while (current_var != NULL)
		{			
			DEBUG_PRINT("VARIABLE %s OF TYPE %d\n", current_var->id, var_type);			

			/*Check if variable is already defined*/
			errorIfDuplicates(root, current_var->id);

			temp = create_variable(current_var->id, var_type);

			add_element_to_table(root,temp);

			current_var = current_var->next;
		}

		current = current->next;
	}
}

/*Looks up a given method's symbol table in the class' symbol table
FIXME: If this function returns NULL then we probably will have a semantic's error*/
ijavatype_t lookup_symbol_type_from_table(sym_t* table, char* symbol)
{
	sym_t* current;
	sym_t* return_var;

	assert(table);
	assert(symbol);

	current = table->next;
	return_var = NULL;

	while (current != NULL)
	{
		if (strcmp(symbol, current->id) == 0)
		{
			return current->type; /* FIXME: We need a type for functions!! */
		}

		current = current->next;
	}

	if ( !return_var ) return TYPE_UNKNOWN;
	return return_var->type;
}
ijavatype_t lookup_symbol_type(sym_t* class_table, sym_t* method_table, char* name) {
	ijavatype_t type = method_table ? lookup_symbol_type_from_table(method_table, name) : TYPE_UNKNOWN;
	if ( type == TYPE_UNKNOWN ) {
		type = lookup_symbol_type_from_table(class_table, name);
			if ( type != TYPE_UNKNOWN )
				return type;
			else {
				/* FIXME: Move this to its own function */
				printf("Cannot find symbol %s\n", name);
				exit(0);
			}
	}
	return type;
}

sym_t* lookup_method(sym_t* class_table, char* method_name)
{
	sym_t* current;
	sym_t* return_var;

	assert(class_table);
	assert(method_name);

	current = class_table->next;
	return_var = NULL;

	while (current != NULL)
	{
		if (strcmp(method_name, current->id) == 0)
		{
			if (current->node_type == METHOD)
			{
				return_var = current->table_method;
				break;
			}
		}

		current = current->next;
	}

	return return_var;
}

/*Returns the return type of a method, specified by its symbol table (in "table")*/
ijavatype_t get_return_type(sym_t* table)
{
	assert(table->node_type == METHOD_TABLE);

	assert(table->next);

	return table->next->type;
}

/*Get a method's return type*/
ijavatype_t lookup_return_type(sym_t* class_table, char* method_name)
{
	ijavatype_t type;
	sym_t* method_table;

	assert(class_table->node_type == CLASS_TABLE);

	method_table = lookup_method(class_table, method_name);

	if (method_table == NULL)
	{
		/* FIXME!! */
		printf("Cannot find symbol %s\n", method_name);
		exit(0);
	}

	type = get_return_type(method_table);

	return type;
}

/*Function responsible for creating a symbol table for a method*/
sym_t* create_method_table(node_t* methodNode)
{

	sym_t* root;
	sym_t* temp;
	char* return_string;/*Will contain the following string: "return"*/
	char string[] = "return";

	assert(methodNode->nodetype == NODE_METHODDECL);

	/*Create method's symbol table*/
	root = create_table(methodNode->n2->id, METHOD_TABLE);

	/*Add the method's return type...*/
	return_string = (char *)malloc( (strlen(string) + 1)*sizeof(char));
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
	sym_t* main_table;

	if ( !root ) return NULL;
	main_table = create_table(root->n1->id,CLASS_TABLE);

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
				DEBUG_PRINT("Declarei variavel com o nome |%s| e tipo %d\n", current_var->id, currentNode->n1->type);

				/*Check if variable is already defined*/
				errorIfDuplicates(main_table, current_var->id);

				current = create_variable(current_var->id, currentNode->n1->type);

				add_element_to_table(main_table,current);

				current_var = current_var->next;
			}
		}

		else if (currentNode->nodetype == NODE_METHODDECL)
		{
			DEBUG_PRINT("Declarei metodo com o nome %s e tipo de retorno %d\n", currentNode->n2->id, currentNode->n1->type);

			/*Check duplicate method*/
			errorIfDuplicates(main_table, currentNode->n2->id);

			/*Create a new entry in the class' symbol table with the method*/
			current = create_method(currentNode->n2->id, currentNode);

			/*Create the method's symbol table*/
			method_symbol_table = create_method_table(currentNode);

			/*Link the entry in the class' symbol table with the symbol table of the method*/
			current->table_method = method_symbol_table;

			add_element_to_table(main_table, current);
		}

		currentNode = currentNode->next;
	}

	return main_table;
}

#define ALLOW_BIN_OPER(___op,___t1,___t2) do { if ( oper == (___op) && lhstype == (___t1) && rhstype == (___t2)) return 1; } while(0)
#define ALLOW_BIN_OPER_SAMETYPE(___op,___type1) ALLOW_BIN_OPER((___op),(___type1),(___type1))

#define ALLOW_BIN_OPER_SAMETYPE_INT(___op) ALLOW_BIN_OPER_SAMETYPE(___op, TYPE_INT)
#define ALLOW_BIN_OPER_SAMETYPE_INTARRAY(___op) ALLOW_BIN_OPER_SAMETYPE(___op, TYPE_INTARRAY)
#define ALLOW_BIN_OPER_SAMETYPE_BOOL(___op) ALLOW_BIN_OPER_SAMETYPE(___op, TYPE_BOOL)
#define ALLOW_BIN_OPER_SAMETYPE_BOOLARRAY(___op) ALLOW_BIN_OPER_SAMETYPE(___op, TYPE_BOOLARRAY)
#define ALLOW_BIN_OPER_SAMETYPE_INT_AND_BOOL(___op) do { ALLOW_BIN_OPER_SAMETYPE_INT(___op); ALLOW_BIN_OPER_SAMETYPE_BOOL(___op); } while(0)
#define ALLOW_BIN_OPER_SAMETYPE_ALL(___op) do { ALLOW_BIN_OPER_SAMETYPE_INT_AND_BOOL(___op); ALLOW_BIN_OPER_SAMETYPE_INTARRAY(___op); ALLOW_BIN_OPER_SAMETYPE_BOOLARRAY(___op); } while(0)

int is_binary_operator_allowed(nodetype_t oper, ijavatype_t lhstype, ijavatype_t rhstype) {
    ALLOW_BIN_OPER_SAMETYPE_BOOL(NODE_OPER_AND);
    ALLOW_BIN_OPER_SAMETYPE_BOOL(NODE_OPER_OR);

    ALLOW_BIN_OPER_SAMETYPE_ALL(NODE_OPER_EQ);	
    ALLOW_BIN_OPER_SAMETYPE_ALL(NODE_OPER_NEQ);
    
    ALLOW_BIN_OPER_SAMETYPE_INT(NODE_OPER_LT);
    ALLOW_BIN_OPER_SAMETYPE_INT(NODE_OPER_GT);
    ALLOW_BIN_OPER_SAMETYPE_INT(NODE_OPER_GEQ);
    ALLOW_BIN_OPER_SAMETYPE_INT(NODE_OPER_LEQ);
    ALLOW_BIN_OPER_SAMETYPE_INT(NODE_OPER_ADD);
    ALLOW_BIN_OPER_SAMETYPE_INT(NODE_OPER_SUB);
    ALLOW_BIN_OPER_SAMETYPE_INT(NODE_OPER_MUL);
    ALLOW_BIN_OPER_SAMETYPE_INT(NODE_OPER_DIV);
    ALLOW_BIN_OPER_SAMETYPE_INT(NODE_OPER_MOD);
   	 
   	ALLOW_BIN_OPER(NODE_OPER_LOADARRAY, TYPE_INTARRAY, TYPE_INT);
    ALLOW_BIN_OPER(NODE_OPER_LOADARRAY, TYPE_BOOLARRAY, TYPE_INT);
    ALLOW_BIN_OPER(NODE_OPER_LOADARRAY, TYPE_STRINGARRAY, TYPE_INT);


    ALLOW_BIN_OPER(NODE_OPER_PARSEARGS, TYPE_STRINGARRAY, TYPE_INT);
             

	return 0;
}

#define ALLOW_UNARY_OPER(___op,___t1) do { if ( oper == (___op) && type == (___t1)) return 1; } while(0)
#define ALLOW_UNARY_OPER_INT(___op) ALLOW_UNARY_OPER(___op, TYPE_INT)
#define ALLOW_UNARY_OPER_BOOL(___op) ALLOW_UNARY_OPER(___op, TYPE_BOOL)
#define ALLOW_UNARY_OPER_INTARRAY(___op) ALLOW_UNARY_OPER(___op, TYPE_INTARRAY)
#define ALLOW_UNARY_OPER_BOOLARRAY(___op) ALLOW_UNARY_OPER(___op, TYPE_BOOLARRAY)
#define ALLOW_UNARY_OPER_ARRAY(___op) do { ALLOW_UNARY_OPER_INTARRAY(___op); ALLOW_UNARY_OPER_BOOLARRAY(___op); ALLOW_UNARY_OPER(___op, TYPE_STRINGARRAY); } while(0)

int is_unary_operator_allowed(nodetype_t oper, ijavatype_t type) {

	ALLOW_UNARY_OPER_BOOL(NODE_OPER_NOT);
	ALLOW_UNARY_OPER_INT(NODE_OPER_MINUS);
	ALLOW_UNARY_OPER_INT(NODE_OPER_PLUS);
	ALLOW_UNARY_OPER_ARRAY(NODE_OPER_LENGTH);
	ALLOW_UNARY_OPER_INT(NODE_OPER_NEWINT);
	ALLOW_UNARY_OPER_INT(NODE_OPER_NEWBOOL);

	return 0;
}

int is_unary_oper(nodetype_t oper) {
		return is_nodetype_in_table(oper, unary_operators);
}

int is_binary_oper(nodetype_t oper) {
	return is_nodetype_in_table(oper, binary_operators);
}

int node_is_oper(node_t* self) {
	nodetype_t type = self->nodetype;
	return is_unary_oper(type)
		|| is_binary_oper(type) 
		|| type == NODE_OPER_CALL
	;
}

int node_is_statement(node_t* self) {
		return is_nodetype_in_table(self->nodetype, statements);
}

ijavatype_t node_get_oper_type(node_t* node, sym_t* class_table, sym_t* curr_method_table);

void check_intlit(char* literal) {
	/* FIXME: Joca, do this thing and error out if needed */
}

ijavatype_t get_tree_type(node_t* self, sym_t* class_table, sym_t* curr_method_table) {
	assert(self);

	/* FIXME: Do this! Do we need to explicitly deal with, for instance, NODE_NULL? */	
	/* Base cases */
	if ( self->nodetype == NODE_TYPE ) {
		/* We shouldn't ever recurse to other NODE_TYPEs */
		assert(self->type == TYPE_ID || self->type == TYPE_INTLIT || self->type == TYPE_BOOLLIT); 
		if ( self->type == TYPE_ID )
			return lookup_symbol_type(class_table, curr_method_table, self->id); /* FIXME FIXME: In here we should lookup the type's type using semantic stuff */
		else {
			if ( self->type == TYPE_INTLIT ) {
				check_intlit(self->id);
				return TYPE_INT;
			} else
				return TYPE_BOOL;
		}
	}

	else if ( node_is_oper(self) ) {
		return node_get_oper_type(self, class_table, curr_method_table);
	}

	else {
		fprintf(stderr,"This was not meant to happen! Triggering assert: %s\n", node_get_name(self));
		assert(0);
	}
}

int node_is_statement_allowed(node_t* node) {
	nodetype_t type = node->nodetype;
	assert(node_is_statement(node));
}

void unary_operator_error_out(node_t* oper, ijavatype_t type) {
	printf("Operator %s cannot be applied to type %s\n", node_get_oper_written_form(oper), sym_type_names[type]);

	/* Exit the application */
	exit(0);
}

void binary_operator_error_out(node_t* oper, ijavatype_t type1, ijavatype_t type2) {	
	char* type1_str = sym_type_names[type1];
	char* type2_str = sym_type_names[type2];
	printf("Operator %s cannot be applied to types %s, %s\n", node_get_oper_written_form(oper), type1_str, type2_str);

	/* Print them alphabetically ordered */ 
	/*
	if ( strcmp(type1_str, type2_str) < 0)
		printf("%s, %s\n", type1_str, type2_str);
	else
		printf("%s, %s\n", type2_str, type1_str);
	*/

	/* Exit the application */
	exit(0);
}

int is_binary_op_boolean(nodetype_t type) {
	return type == NODE_OPER_OR  ||
		   type == NODE_OPER_AND ||
		   type == NODE_OPER_EQ  ||
		   type == NODE_OPER_NEQ ||
		   type == NODE_OPER_LT  ||
		   type == NODE_OPER_GT  ||
		   type == NODE_OPER_LEQ ||
		   type == NODE_OPER_GEQ
   ;	
}

/* FIXME: This is unimplemented, we need to cover function calls */
ijavatype_t node_get_oper_type(node_t* node, sym_t* class_table, sym_t* curr_method_table) {
	nodetype_t type = node->nodetype;
	assert(node_is_oper(node));
	if (is_unary_oper(type)) {
		/* In the first child we have the subtree (might just be an Id) that gives us the type */
		ijavatype_t expr_type =  get_tree_type(node->n1, class_table, curr_method_table);
		if ( !is_unary_operator_allowed(type, expr_type ) ) {
			unary_operator_error_out(node,expr_type);
			/* !!! PROGRAM FLOW ENDS !!! */
		}

		/* FIXME: THis is so fugly */
		if ( type == NODE_OPER_NEWBOOL )
			return TYPE_BOOLARRAY;
		 else if ( type == NODE_OPER_NEWINT)
			return TYPE_INTARRAY;
		else if ( type == NODE_OPER_LENGTH) {
			return TYPE_INT;
		}

		return expr_type;
	} else if (is_binary_oper(type)) {
		/* In the first child we have the first subtree (might just be an Id) that gives us the type */
		ijavatype_t expr_type1 =  get_tree_type(node->n1, class_table, curr_method_table);
		/* In the second child we have the second subtree (might just be an Id) that gives us the type */
		ijavatype_t expr_type2 =  get_tree_type(node->n2, class_table, curr_method_table);
		if ( !is_binary_operator_allowed(type, expr_type1, expr_type2) ) {
			binary_operator_error_out(node,expr_type1, expr_type2);
			/* !!! PROGRAM FLOW ENDS !!! */
		}

		/* FIXME: This here is super fugly! Turn array accesses into indexes! */
		if ( type == NODE_OPER_LOADARRAY ) {
			assert(expr_type1 == TYPE_BOOLARRAY || expr_type1 == TYPE_INTARRAY || TYPE_STRINGARRAY);
			if ( expr_type1 == TYPE_INTARRAY )
				return TYPE_INT;
			else if ( expr_type1 == TYPE_BOOLARRAY )
				return TYPE_BOOL;
			else if ( expr_type1 == TYPE_STRINGARRAY )
				return TYPE_STRING;
		} else if ( is_binary_op_boolean(type) ) {
			return TYPE_BOOL;
		} /* FIXME: Same thing for ParseArgs */


		return expr_type2; /* Or expr_type2 */
	} else if (type == NODE_OPER_CALL) {
		/* FIXME: Check basically all of this */
		assert(node->n1);
		assert(node->n1->id);
		char* fnc_name = node->n1->id;
		node_t* args = node->n2;
		sym_t* method_table = lookup_method(class_table, fnc_name);
		if ( !method_table ) {
			/* FIXME! */
			printf("Cannot find symbol %s\n", fnc_name);			
			/* FIXME: What if we found it, but it's not a method? */
			exit(0);
		}

		assert(method_table->next);
		sym_t* iter = method_table->next;
		ijavatype_t return_type = iter->type;
		iter = iter->next;

		int argCount = 0;
		while (iter && iter->is_parameter) {
			if ( args ) {
				ijavatype_t this_arg_type = get_tree_type ( args, class_table, curr_method_table);
				if ( iter->type != this_arg_type ) {
					printf("Incompatible type of argument %d in call to method %s (got %s, required %s)\n",
							argCount, fnc_name, sym_type_names[this_arg_type], sym_type_names[iter->type]);
					exit(0);
				}
			} else {
					printf("Incompatible type of argument %d in call to method %s (got void, required %s)\n",
							argCount, fnc_name, sym_type_names[iter->type]);
					exit(0);
			}

			iter = iter->next; argCount++; args = args->next;
		}

		if ( args ) {
			ijavatype_t this_arg_type = get_tree_type ( args, class_table, curr_method_table);
			printf("Incompatible type of argument %d in call to method %s (got %s, required void)\n",
							argCount, fnc_name, sym_type_names[this_arg_type]);
					exit(0);
		}

		return return_type;

	} else {
		printf("SHOULD NEVER GET HERE! Forcing assert!\n");
		assert(0);
	}
}

void invalid_store_error_out(char* id, ijavatype_t got, ijavatype_t req) {
	printf("Incompatible type in assignment to %s (got %s, required %s)\n", id, sym_type_names[got], sym_type_names[req]);

	/* Exit the application */
	exit(0);
}

/* We expect a linked list of statements */
void recurse_down(node_t* node, sym_t* class_table, sym_t* curr_method_table) {
	DEBUG_PRINT("[recurse_down] node=%p, class_table=%p, method_table=%p\n", node, class_table, curr_method_table);
	node_t* iter = node;
	while ( iter != NULL ) {
		DEBUG_PRINT("[recurse_down]-->Looped: node_type = %s\n", node_get_name(iter));

		assert( node_is_statement(iter) );

		if ( iter->nodetype == NODE_STATEMENT_COMPOUNDSTATEMENT) {
			recurse_down(iter->n1, class_table, curr_method_table); /* FIXME: Is this right? */
		}

		else if ( iter->nodetype == NODE_STATEMENT_STORE ) {
			assert(iter->n1);
			assert(iter->n2);
			ijavatype_t type_lhs = get_tree_type(iter->n1, class_table, curr_method_table);
			ijavatype_t type_rhs = get_tree_type(iter->n2, class_table, curr_method_table);

			if ( type_lhs != type_rhs ) {
			/* The id should be stored in iter->n1, because stores will always be made on ids, and never
			on expressions */				
				assert(iter->n1->id);
				invalid_store_error_out(iter->n1->id, type_rhs, type_lhs);
				/* !!! PROGRAM FLOW ENDS !!! */
			}
		} else if ( iter->nodetype == NODE_STATEMENT_STOREARRAY ) {
			assert(iter->n1);
			assert(iter->n2);
			assert(iter->n3);
			ijavatype_t type_lhs = get_tree_type(iter->n1, class_table, curr_method_table);
			ijavatype_t type_index = get_tree_type(iter->n2, class_table, curr_method_table);
			ijavatype_t type_rhs = get_tree_type(iter->n3, class_table, curr_method_table);

			if ( type_index != TYPE_INT || (type_lhs != TYPE_INTARRAY && type_lhs != TYPE_BOOLARRAY && type_lhs != TYPE_STRINGARRAY) ) {	
				assert(iter->n1->id);
				char* type1_str = sym_type_names[type_lhs];
				char* type2_str = sym_type_names[type_index];
				printf("Operator [ cannot be applied to types %s, %s\n", type1_str, type2_str);
				exit(0);
				/* !!! PROGRAM FLOW ENDS !!! */
			} else {
				if ( type_lhs == TYPE_STRINGARRAY ) type_lhs = TYPE_STRING;
				else if ( type_lhs == TYPE_INTARRAY )  type_lhs = TYPE_INT;
				else if ( type_lhs == TYPE_BOOLARRAY )  type_lhs = TYPE_BOOL;
				else assert(0);
			}

			if ( type_lhs != type_rhs ) {
			/* The id should be stored in iter->n1, because stores will always be made on ids, and never
			on expressions */				
				assert(iter->n1->id);
				char* type1_str = sym_type_names[type_rhs];
				char* type2_str = sym_type_names[type_lhs];
				printf("Incompatible type in assignment to %s[] (got %s, required %s)\n", iter->n1->id, type1_str, type2_str);
				exit(0);
				/* !!! PROGRAM FLOW ENDS !!! */
			}
		} else if ( iter->nodetype == NODE_STATEMENT_RETURN ) {
			ijavatype_t expr_type = TYPE_VOID;
			if ( iter->n1 )
				expr_type = get_tree_type(iter->n1, class_table, curr_method_table);

			ijavatype_t expected_return_type = get_return_type(curr_method_table);

			if ( expr_type != expected_return_type ) {
				/* FIXME: MAYBE CHANGE THIS */
				char* type1_str = sym_type_names[expr_type];
				char* type2_str = sym_type_names[expected_return_type];
				printf("Incompatible type in return statement (got %s, required %s)\n", type1_str, type2_str);
				exit(0);
				/* !!! PROGRAM FLOW ENDS !!! */
			}
		}  else if ( iter->nodetype == NODE_STATEMENT_PRINT ) {
			ijavatype_t expr_type = TYPE_VOID;
			if ( iter->n1 )
				expr_type = get_tree_type(iter->n1, class_table, curr_method_table);

			if ( expr_type == TYPE_STRINGARRAY || expr_type == TYPE_INTARRAY || expr_type == TYPE_BOOLARRAY ) {
				/* FIXME: MAYBE CHANGE THIS */
				char* type1_str = sym_type_names[expr_type];
				printf("Incompatible type in print statement (got %s, required boolean or int)\n", type1_str);
				exit(0);
				/* !!! PROGRAM FLOW ENDS !!! */
			}
		} else if ( iter->nodetype == NODE_STATEMENT_IFELSE ) {
			ijavatype_t expr_type = TYPE_VOID;
			if ( iter->n1->nodetype == NODE_NULL ) {
				/* FIXME: Is it right? FIXME? */
				printf("Incompatible type in if statement (got void, required boolean)\n");
				exit(0);
				/* !!! PROGRAM FLOW ENDS !!! */
			}

			expr_type = get_tree_type(iter->n1, class_table, curr_method_table);
			if ( expr_type != TYPE_BOOL ) {
				char* type1_str = sym_type_names[expr_type];
				printf("Incompatible type in if statement (got %s, required boolean)\n", type1_str);
				exit(0);
				/* !!! PROGRAM FLOW ENDS !!! */				
			}

			if ( iter->n2->nodetype != NODE_NULL)
				recurse_down(iter->n2, class_table, curr_method_table);
			if ( iter->n3->nodetype != NODE_NULL)
				recurse_down(iter->n3, class_table, curr_method_table);

		} else if ( iter->nodetype == NODE_STATEMENT_WHILE ) {
			ijavatype_t expr_type = TYPE_VOID;
			if ( iter->n1->nodetype == NODE_NULL ) {
				/* FIXME: Is it right? FIXME? */
				printf("Incompatible type in while statement (got void, required boolean)\n");
				exit(0);
				/* !!! PROGRAM FLOW ENDS !!! */
			}

			expr_type = get_tree_type(iter->n1, class_table, curr_method_table);
			if ( expr_type != TYPE_BOOL ) {
				char* type1_str = sym_type_names[expr_type];
				printf("Incompatible type in while statement (got %s, required boolean)\n", type1_str);
				exit(0);
				/* !!! PROGRAM FLOW ENDS !!! */				
			}

			if ( iter->n2->nodetype != NODE_NULL)
				recurse_down(iter->n2, class_table, curr_method_table);			
		}

		iter = iter->next;
	}
}

void check_ast_for_semantic_errors(node_t* root, sym_t* class_table) {
	DEBUG_PRINT("[check_ast_for_semantic_errors] root=%p, class_table=%p\n", root, class_table);
	if ( !root || !class_table ) return; /* FIXME: WIll this ever happen? */

	/* Find all the method entry points and recurse down on them */
	sym_t* iter = class_table;

    while (iter != NULL) {
        if (iter->node_type == METHOD) {
        	/* We have made sure that our AST has all the statements in n2 */
        	recurse_down(iter->method_start->n2, class_table, iter->table_method);
        }
        iter = iter->next;
    }
	
}

/*Checks if there is a symbol defined in table with the name stored in id. Note that this table can be the class' symbol table
or a method's table*/
void errorIfDuplicates(sym_t* table, char* id)
{
	if (checkSymbol(table, id) == 1)
	{
		printf("Symbol %s already defined\n", id);
		exit(0);
	}
}

int checkSymbol(sym_t* table, char* id)
{
	int return_value;
	sym_t* current;

	current = table;
	return_value = 0;

	assert(id);

	while (current != NULL)
	{
		if (current->node_type != CLASS_TABLE && strcmp(id, current->id) == 0)
		{
			return_value = 1;
			break;
		}

		current = current->next;
	}

	return return_value;
}
