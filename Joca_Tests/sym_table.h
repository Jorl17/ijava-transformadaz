#include "node_t.h"

typedef struct _symtab_t symtab_t;

typedef enum {
	CLASS_TABLE,
	METHOD_TABLE
} ijava_table_type_t;

symtab_t* analyse_ast(node_t* currentNode);


struct _symtab_t{

	/*This will be the name of our symbol table*/
	char* name;

	/*This value tells us if this is a table for a method or for a class*/
	ijava_table_type_t type;
};
