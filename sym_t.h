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
};

sym_t* create_table(char* table_name, int class);
sym_t* create_variable(char* var_name, int var_type);
sym_t* create_method(char* method_name);
void add_element_to_table(sym_t* table, sym_t* element);
void print_element(sym_t* element);
void printTable(sym_t* table);
void add_parameters_declarations(sym_t* root, node_t* var_decl);
void add_variables_declarations(sym_t* root, node_t* var_decl);
sym_t* create_method_table(node_t* methodNode);
sym_t* analyse_ast(node_t* root);
int checkSymbol(sym_t* table, char* id);

#endif
