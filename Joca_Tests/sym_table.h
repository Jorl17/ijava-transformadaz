#include "node_t.h"

typedef struct _symtab_t symtab_t;

typedef enum {
	CLASS_TABLE,
	METHOD_TABLE,
	VARIABLE,
	METHOD
} ijava_table_type_t;

symtab_t* create_table(char* table_name, int class);
symtab_t* create_variable(char* var_name, int var_type);
symtab_t* create_method(char* method_name);
symtab_t* create_method_table(node_t* methodNode);
void add_element_to_table(symtab_t* table, symtab_t* element);
void print_element(symtab_t* element);
void printTable(symtab_t* table);
symtab_t* analyse_ast(node_t* root);

struct _symtab_t{

	/*This will be the name of our symbol table*/
	char* name;

	/*Tells us if the current element is the table of a class, the table of a method, a variable, or a method*/
	ijava_table_type_t node_type;

	/*Name of the element (main, x, etc)*/
	char* id;

	/*The type of the element - String[]; int[]; etc*/
	ijavatype_t type;

	/*In case the current table corresponds to a method, then this field tells us if the element is a parameter or not*/
	int is_parameter;

	/*Points to the next item on the table*/
	symtab_t* next;

	/*In case we have a method point to the method symbolic table*/
	symtab_t* table_method;
};
