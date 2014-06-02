#ifndef NODE_T_H
#define NODE_T_H 1

typedef enum {
              NODE_PROGRAM,
              NODE_VARDECL,
              NODE_METHODDECL, 
              NODE_METHODPARAMS,
              NODE_METHODBODY,
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
              NODE_NULL, /* Very useful: the NULL node */              
              NODE_TYPE, /* Means it might be of type INTLIT, BOOLLIT, VOID, ID... It is defined by the 'type' property of the node */
              NODE_LAST_NODE_TYPE /* Used internally to signify the end of a table of node types */
} nodetype_t;

extern nodetype_t statements[];
extern nodetype_t binary_operators[];
extern nodetype_t unary_operators[];

typedef enum {
    TYPE_INT,
    TYPE_BOOL,
    TYPE_INTARRAY,
    TYPE_BOOLARRAY,
    TYPE_STRINGARRAY,
    TYPE_VOID,
    TYPE_ID,
    TYPE_INTLIT,
    TYPE_BOOLLIT,
    TYPE_STRING,
    TYPE_METHOD,
    TYPE_UNKNOWN /* Used internally */
} ijavatype_t;

typedef struct _node_t node_t;

typedef int ijavavalue_t;

#define IJAVA_TRUE 1
#define IJAVA_FALSE 0

#define OP_DECLAR(___op)
#define BINARY_OP_DECLR(___op) node_t* node_create_oper_##___op(node_t* lhs, node_t* rhs)
#define UNARY_OP_DECLR(___op) node_t* node_create_oper_##___op(node_t* unary)

char* node_get_name(node_t* self);
char* node_get_oper_written_form(node_t* self);
node_t* node_create_program(char* token, node_t* declarations);
void node_delete(node_t* self);
node_t* node_create_terminal(ijavatype_t type, char* token);
node_t* node_create_terminal_int(ijavatype_t type, int token_value);
node_t* node_create_type(ijavatype_t type);
node_t* node_create_vardecl(ijavatype_t type, node_t* vars);
node_t* node_create_paramdeclaration(ijavatype_t type, char* token);
node_t* node_create_methodparams(node_t* params);
node_t* node_create_methodbody(node_t* vardecls,node_t* statements);
node_t* node_create_methoddecl(ijavatype_t type, char* token, node_t* method_params, node_t* method_body);
node_t* node_statement_append_statement(node_t* first_statement, node_t* second_statement);
node_t* node_fuse_vardecls_into_main_vardecl_node(node_t* vardeclares);
node_t* node_create_null(void);
node_t* node_append(node_t* meant_to_be_first, node_t* meant_to_be_last);
node_t* node_move_next_to_n1(node_t* self);
BINARY_OP_DECLR(or);
BINARY_OP_DECLR(and);
BINARY_OP_DECLR(eq);
BINARY_OP_DECLR(neq);
BINARY_OP_DECLR(lt);
BINARY_OP_DECLR(gt);
BINARY_OP_DECLR(leq);
BINARY_OP_DECLR(geq);
BINARY_OP_DECLR(add);
BINARY_OP_DECLR(sub);
BINARY_OP_DECLR(mul);
BINARY_OP_DECLR(div);
BINARY_OP_DECLR(mod);

BINARY_OP_DECLR(loadarray);
BINARY_OP_DECLR(parseargs);

UNARY_OP_DECLR(not);
UNARY_OP_DECLR(plus);
UNARY_OP_DECLR(minus);
UNARY_OP_DECLR(dotlength);
UNARY_OP_DECLR(newint);
UNARY_OP_DECLR(newbool);

node_t* node_create_oper_call(char* token, node_t* args);

node_t* node_create_statement_storearray(char* token, node_t* index, node_t* rval );
node_t* node_create_statement_store(char* token, node_t* rval);
node_t* node_create_statement_return(node_t* expr);
node_t* node_create_statement_print(node_t* expr);
node_t* node_create_statement_while(node_t* expr, node_t* statement);
node_t* node_create_statement_ifelse(node_t* cond, node_t* ifstatement, node_t* elsestatement);
node_t* node_create_statement_potential_compoundstatement(node_t* statements);

int is_nodetype_in_table(nodetype_t nodetype, nodetype_t* table);

void print_ast(node_t* ast);
struct _node_t {

    /* Type of this node (Program, VarDecl, etc..) */
    nodetype_t nodetype;

    /* Fixed children used in Statements / Operators. */
    node_t* n1;
    node_t* n2;
    node_t* n3;
    node_t* n4;

    /* Pointer to the next node, in case this node is part of a linked-list */
    node_t* next;

    /* Type of the node, might be TYPE_INT, TYPE_BOOL, etc. In some cases,
       such as MethodDeclaration, it might be TYPE_VOID. */
    ijavatype_t type;

    /* The id, used with some nodes, such as MethodDecl and ParamDecl. */
    char* id;
     

    /* This is the type of the tree starting at this node. Or so to say, it is
       its "role". For instance, for the "+" node in 3+5 it is TYPE_INT.
       Filled during semantic analysis */
    ijavatype_t tree_type;
};

#endif
