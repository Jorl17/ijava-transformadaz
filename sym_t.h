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

sym_t* analyse_ast(node_t* root);

#endif
