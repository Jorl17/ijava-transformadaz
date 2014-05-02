#include "idlist_t.h"

typedef enum {
              NODE_PROGRAM,
              NODE_VARDECL,
              NODE_METHODDECL, 
              NODE_METHODPARAMS,
              NODE_METHODBODY,
              NODE_METHODVARDECL,
              NODE_PARAMDECLARATION,
              NODE_STATEMENT_COMPOUNDSTATEMENT,
              NODE_STATEMENT_IFELSE,
              NODE_STATEMENT_PRINT,
              NODE_STATEMENT_RETURN,
              NODE_STATEMENT_STORE,
              NODE_STATEMENT_STOREARRAY,
              NODE_STATEMENT_WHILE,
              NODE_OPER_OR,
              NODE_OPER_AND,
              NODE_OPER_EQ,
              NODE_OPER_NEQ,
              NODE_OPER_LT,
              NODE_OPER_GT,
              NODE_OPER_LEQ,
              NODE_OPER_GEQ,
              NODE_OPER_ADD,
              NODE_OPER_SUB,
              NODE_OPER_MUL,
              NODE_OPER_DIV,
              NODE_OPER_MOD,
              NODE_OPER_NOT,
              NODE_OPER_MINUS,
              NODE_OPER_PLUS,
              NODE_OPER_LENGTH,
              NODE_OPER_LOADARRAY,
              NODE_OPER_CALL,
              NODE_OPER_NEWINT,
              NODE_OPER_NEWBOOL,
              NODE_OPER_PARSEARGS,
              NODE_TYPE, /* Means it might be of type INTLIT, BOOLLIT, VOID, ID... It is defined by the 'type' property of the node */
              NODE_NULL /* Very useful: the NULL node */
              } nodetype_t;

typedef enum {
    TYPE_INT,
    TYPE_BOOL,
    TYPE_INTARRAY,
    TYPE_BOOLARRAY,
    TYPE_STRINGARRAY,
    TYPE_VOID,
    TYPE_ID, /* FIXME: Needs to go? */
    TYPE_INTLIT,
    TYPE_BOOLLIT,
    TYPE_UNKNOWN /* Used internally */
} ijavatype_t;

typedef struct _node_t node_t;

typedef int ijavavalue_t;

#define IJAVA_TRUE 1
#define IJAVA_FALSE 0

char* node_get_name(node_t* self);
node_t* node_create(nodetype_t nodetype);
void node_delete(node_t* self);
node_t* node_create_terminal(ijavatype_t type, char* token);
node_t* node_create_terminal_int(ijavatype_t type, int token_value);
node_t* node_create_vardecl(ijavatype_t type, node_t* vars);
node_t* node_fuse_vardecls_into_main_vardecl_node(node_t* vardeclares);
node_t* node_create_null(void);
node_t* node_create_program(node_t* declarations);
node_t* node_append(node_t* meant_to_be_first, node_t* meant_to_be_last);
node_t* node_move_next_to_n1(node_t* self);
void print_ast(node_t* ast);
struct _node_t {

    /* Type of this node (Program, VarDecl, etc..) */
    nodetype_t nodetype;

    /* Fixed children used in Statements / Operators. The only ones that use
       all three of them are IfElse and  StoreArray */
    node_t* n1;
    node_t* n2;
    node_t* n3;

    /* Used with VarDecl. In which case it points to linked list of strings which
       contain the ids to be declared */
    idlist_t* ids;

    /* Pointer to the next node, in case this node is part of a linked-list */
    node_t* next;

    /* Type of the node, might be TYPE_INT, TYPE_BOOL, etc. In some cases,
       such as MethodDeclaration, it might be TYPE_VOID. */
    ijavatype_t type;

    /* The id, used with some nodes, such as MethodDecl and ParamDecl.
       FIXME: We might need to create a special id node for this later on... */     
    char* id;
     
    /*The value of the node, that is, if the node is an INT this field will contain
      the value of the int variable*/
    ijavavalue_t value;

    /*In case this struct represents a method or a class, then this field stores the method name or the class name*/
    char* node_name;

    /* FIXME: More things to come */
};
