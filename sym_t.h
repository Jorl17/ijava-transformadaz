#ifndef SYM_T_H
#define SYM_T_H 1

#include "node_t.h"

typedef struct _sym_t sym_t;

typedef enum {
	CLASS_TABLE,
	METHOD_TABLE,
	VARIABLE,
	METHOD
} ijava_table_type_t;

struct _sym_t{

	/*Tells us if the current element is the table of a class, the table of a method, a variable, or a method*/
	ijava_table_type_t node_type;

	/*Name of the element (main, x, etc)*/
	char* id;

	/*The type of the element - String[]; int[]; etc*/
	ijavatype_t type;

	/*In case the current table corresponds to a method, then this field tells us if the element is a parameter or not*/
	int is_parameter;

	/*Points to the next item on the table*/
	sym_t* next;

	/*In case we have a method point to the method symbolic table*/
	sym_t* table_method;

	/* Pointer to the node which contains the first statements of this method,
	this is used later on for error checking, and might be used later on for code generation.
	It should thus point to a MethodBody node, or NULL */
	node_t* method_start;
};

sym_t* create_table(char* table_name, ijava_table_type_t class);
sym_t* create_variable(char* var_name, ijavatype_t var_type);
sym_t* create_method(char* method_name, node_t* methoddecl);
void add_element_to_table(sym_t* table, sym_t* element);
void print_element(sym_t* element);
void printTable(sym_t* table);
void add_parameters_declarations(sym_t* root, node_t* var_decl);
void add_variables_declarations(sym_t* root, node_t* var_decl);
sym_t* create_method_table(node_t* methodNode);
sym_t* analyse_ast(node_t* root);
int checkSymbol(sym_t* table, char* id);
void errorIfDuplicates(sym_t* table, char* id);
sym_t* lookup_method(sym_t* class_table, char* method_name);
ijavatype_t get_return_type(sym_t* table);
ijavatype_t lookup_return_type(sym_t* class_table, char* method_name);

int is_binary_oper(nodetype_t oper);
int is_unary_oper(nodetype_t oper);
int node_is_statement(node_t* self);
int is_binary_op_boolean(nodetype_t type);

void check_ast_for_semantic_errors(node_t* root, sym_t* class_table);

#endif
