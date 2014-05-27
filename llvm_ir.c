#include "node_t.h"
#include "sym_t.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>

/* Counts current local variables. Don't forget to reset it once we start a new method! */
unsigned int llvm_tmp_var_count = 0;

/* llvm_type_t shall be "i32", "i16", etc, as the LLVM IR requires */
typedef char* llvm_type_t;

/* Gives us a valid local variable name that we can use, such as %1, %2 or %3 */
char* get_local_var_name() {
    char* buf = (char*)malloc(16);
    sprintf(buf, "%%%u", ++llvm_tmp_var_count);
    return buf;
}

/* This structure is passed around when we're outputting code. It represents a given type and "id"/representation of a node.
    llvm_var_t->repr stores the "representation", its name.
    llvm_var_t->type is the type of this node.

    Representation is useful because of situations where we need temporary and intermediate variables.
    For instance, assuming we have currently used 32 local variables (that is llvm_tmp_var_count = 32), the operation
    a + b + c
    will be turned into (this pseudo-LLVM IR) [note that we have left-associativity]
    %33 = a + b
    %34 = %33 +c

    NOTE: These pointers must be free()-able. strdup() all you want to make sure they're sittin' on the heap!
*/

typedef struct _llvm_var_t {
    char* repr; /* Representation: %1,@1, etc... */
    llvm_type_t type; /* i32, i16, etc */
} llvm_var_t;

llvm_var_t* llvm_var_create() {
    return (llvm_var_t*) malloc( sizeof (llvm_var_t));
}

/* Frees an llvm_var_t */
void llvm_var_free(llvm_var_t* self) {
    if ( self->repr != NULL ) free(self->repr);
    if ( self->type != NULL ) free(self->type);
    free(self);
}

/* Prints an LLVM binary op to stdout. Note that we always store the result even if we never use it.
    Inefficient? I call it inefficient to have Mooshak's tests coming out less than one week away from the submission date!! */
void llvm_bin_op(const char* op, llvm_type_t type, char* lhs, char* arg1, char* arg2) {
    printf("%s = %s %s %s, %s\n", lhs, op, type, arg1, arg2);
}

/* Prints an LLVM unary op to stdout (might not correspond to an ijava unary op */
void llvm_unary_op(const char* op, llvm_type_t type, char* val) {
    printf("%s %s %s\n", op, type, val);
}

/* Used to convert TYPE_INT, TYPE_BOOL, TYPE_INTLIT, etc to their llvm_type_t types */
const char* llvm_types_from_ijavatypes[]  = {
    "i32" /* TYPE_INT */,
    "i1" /* TYPE_BOOL */ /* FIXME */,
    "i32*" /* TYPE_INTARRAY */ /* FIXME*/,
    "i1*" /* TYPE_BOOLARRAY */  /* FIXME */,
    "i8**" /* TYPE_STRINGARRAY */ /* FIXME */,
    "NOT_EXPECTED_VOID" /*TYPE_VOID*/ /*FIXME */,
    "NOT_EXPECTED_ID" /* TYPE_STRINGARRAY */ /* FIXME */,
    "i32" /* TYPE_INTLIT */,
    "i1" /* TYPE_BOOLLIT */ /* FIXME */,
    "i8*" /* TYPE_STRING */ /* FIXME */,
    "NOT_EXPECTED_METHOD" /* TYPE_METHOD */ /* FIXME */,
    "NOT_EXPECTED_UNKNOWN" /* TYPE_UNKNOWN */ /* FIXME */
};

const char* llvm_type_from_ijavatype(ijavatype_t type) {
    return llvm_types_from_ijavatypes[type];
}

llvm_var_t* llvm_node_to_instr_binop(node_t* node, sym_t* class_table, sym_t* curr_method_table);
llvm_var_t* llvm_node_to_instr_node_type(node_t* node, sym_t* class_table, sym_t* curr_method_table);
llvm_var_t* llvm_node_to_instr_unop(node_t* node, sym_t* class_table, sym_t* curr_method_table);

/* This is generic and it just binds the several cases we have: binops, types (which end recursion), and others */
/* This function works just like get_tree_type() in semantic analysis. It (indirecty) recurses down a statement,
   except instead of just parsing the code, it outputs LLVM IR */
llvm_var_t* llvm_node_to_instr(node_t* node, sym_t* class_table, sym_t* curr_method_table) {
    assert(node);
    if ( is_binary_oper(node->nodetype) ) 
        return llvm_node_to_instr_binop(node, class_table, curr_method_table);
    else if ( is_unary_oper(node->nodetype) )
        return llvm_node_to_instr_unop(node, class_table, curr_method_table);
    else if ( node->nodetype == NODE_TYPE )
        return llvm_node_to_instr_node_type(node, class_table, curr_method_table);
    /* FIXME: MORE TO COME: prints, ifelses, etc.. */
    return NULL;
}


/* Used to convert the operations represented by nodes into LLVM IR operations. for instance,
   we map NODE_ADD to "add" */
const char* llvm_node_to_nodetype[] = {
             "null_should_not_happen",
             "null_should_not_happen",
             "null_should_not_happen",
             "null_should_not_happen",
             "null_should_not_happen",
             "null_should_not_happen",
             "null_should_not_happen",
             "null_should_not_happen", /* NODE_STATEMENT_IFELSE, */
             "null_should_not_happen", /* NODE_STATEMENT_PRINT, */
             "null_should_not_happen", /*NODE_STATEMENT_RETURN, */
             "null_should_not_happen", /*NODE_STATEMENT_STORE, */
             "null_should_not_happen", /*NODE_STATEMENT_STOREARRAY, */
             "null_should_not_happen", /*NODE_STATEMENT_WHILE, */
              "or",
              "and",
              "eq",
              "neq",
              "NODE_OPER_LT",
              "NODE_OPER_GT",
              "NODE_OPER_LEQ",
              "NODE_OPER_GEQ",
              "add",
              "sub",
              "mul",
              "udiv",
              "urem",
              "xor",
              "NODE_OPER_MINUS",
              "NODE_OPER_PLUS",
              "NODE_OPER_LENGTH",
              "NODE_OPER_LOADARRAY",
              "NODE_OPER_CALL",
              "NODE_OPER_NEWINT",
              "NODE_OPER_NEWBOOL",
              "NODE_OPER_PARSEARGS",
              "NODE_NULL", /* Very useful: the NULL node */              
              "NODE_TYPE", /* Means it might be of type INTLIT, BOOLLIT, VOID, ID... It is defined by the 'type' property of the node */
              "NODE_LAST_NODE_TYPE" /* Used internally to signify the end of a table of node types */
};

const char* llvm_get_op_from_node(node_t* node) {
    assert(node);

    return llvm_node_to_nodetype [node->nodetype ];
}


/* Currently only does arithmetic */
llvm_var_t* llvm_node_to_instr_binop(node_t* node, sym_t* class_table, sym_t* curr_method_table) {
    assert(node);
    assert(node->n1);
    assert(node->n2);
    llvm_var_t* ret = llvm_var_create();

    /* Recurse down and find the variables that will be our operands */
    llvm_var_t* op1 = llvm_node_to_instr(node->n1, class_table, curr_method_table);
    llvm_var_t* op2 = llvm_node_to_instr(node->n2, class_table, curr_method_table);

    /* Get a nice juicy name for ourselves */
    ret->repr = get_local_var_name();

    /* Get the type from the previously calculated "tree_type". Avoids having a fixed table where we map operations to their output sizes */
    ret->type = strdup(llvm_type_from_ijavatype(node->tree_type));

    /* Output the binary op code */
    llvm_bin_op(llvm_get_op_from_node(node), ret->type, ret->repr, op1->repr, op2->repr);
    llvm_var_free(op1);
    llvm_var_free(op2);

    return ret;
}

/* Currently only does arithmetic */
llvm_var_t* llvm_node_to_instr_unop(node_t* node, sym_t* class_table, sym_t* curr_method_table) {
    assert(node);
    assert(node->n1);
    llvm_var_t* ret = (llvm_var_t*)malloc ( sizeof(llvm_var_t) );   
    const char* op;
    llvm_var_t* op1 = llvm_var_create();

    if      ( node->nodetype == NODE_OPER_PLUS )  { op = "add"; op1->repr = (llvm_type_t)"0"; op1->type = (llvm_type_t)"i32"; }
    else if ( node->nodetype == NODE_OPER_MINUS ) { op = "sub"; op1->repr = (llvm_type_t)"0"; op1->type = (llvm_type_t)"i32"; }
    else if ( node->nodetype == NODE_OPER_NOT )   { op = "xor"; op1->repr = (llvm_type_t)"true"; op1->type = (llvm_type_t)"i1";  }

    /* Recurse down and find the variables that will be our operands */
    llvm_var_t* op2 = llvm_node_to_instr(node->n1, class_table, curr_method_table);

    /* Get a nice juicy name for ourselves */
    ret->repr = get_local_var_name();

    /* Get the type from the previously calculated "tree_type". Avoids having a fixed table where we map operations to their output sizes */
    ret->type = strdup(llvm_type_from_ijavatype(node->tree_type));

    /* Output the binary op code */
    llvm_bin_op(llvm_get_op_from_node(node), ret->type, ret->repr, op1->repr, op2->repr);
    llvm_var_free(op1);
    llvm_var_free(op2);

    return ret;
}

void llvm_lookup_symbol_from_table(llvm_var_t* ret, char* id, sym_t* class_table, sym_t* curr_method_table) {

  assert(ret);
  assert(id);
  asert(class_table);
  assert(curr_method_table);

  int local;

  sym_t* result = lookup_symbol(class_table, curr_method_table, id, &local);

  ret->type = strdup(llvm_type_from_ijavatype(result->type));

  ret->id = (char *)malloc((2 + strlen(id))*sizeof(char));

  assert((local == 0 || local == 1));/*SHOULD NOT BE NEEDED BUT LET'S KEEP IT SAFE*/

  sprintf(ret->id, "%s%s", local==1 ? "%" : "@", id);
}

llvm_var_t* llvm_node_to_instr_node_type(node_t* node, sym_t* class_table, sym_t* curr_method_table) {
    assert(node->nodetype == NODE_TYPE);
    assert(node->type == TYPE_INTLIT || node->type == TYPE_BOOLLIT || node->type == TYPE_ID);
    llvm_var_t* ret = (llvm_var_t*)malloc ( sizeof(llvm_var_t) );   

    if ( node->type == TYPE_ID ) {
        /*FIXME: Look it up from the table
            FIXME: Joca, do your awesome thing man
        ret->repr = strdup(node->id);*/

        llvm_lookup_symbol_from_table(ret, node->id, class_table, curr_method_table);
    } else {
        /** FIXME: Must convert intlits by pipelining them */
        ret->repr = strdup(node->id);
        ret->type = strdup(llvm_type_from_ijavatype(node->type));
    }

    return ret;
}
