#include "node_t.h"
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <stdio.h>

#define BINARY_OP_IMPL(___op, ___nodetype) node_t* node_create_oper_##___op (node_t* lhs, node_t* rhs) { return node_create_binary_oper(___nodetype, lhs, rhs); }
#define UNARY_OP_IMPL(___op, ___nodetype) node_t* node_create_oper_##___op (node_t* expr) { return node_create_unary_oper(___nodetype, expr); }

#if 0
#define DEBUG
#else
#define NDEBUG
#endif

#ifdef DEBUG
#define DEBUG_PRINT(...) do{ fprintf( stderr, __VA_ARGS__ ); } while( 0 )
#else
#define DEBUG_PRINT(...) do{ } while ( 0 )
#endif

char* node_names[] = {
    "Program",
    "VarDecl",
    "MethodDecl",
    "MethodParams",
    "MethodBody",
    "ParamDeclaration",
    "CompoundStat",
    "IfElse",
    "Print",
    "Return",
    "Store",
    "StoreArray",
    "While",
    "Or",
    "And",
    "Eq",
    "Neq",
    "Lt",
    "Gt",
    "Leq",
    "Geq",
    "Add",
    "Sub",
    "Mul",
    "Div",
    "Mod",
    "Not",
    "Minus",
    "Plus",
    "Length",
    "LoadArray",
    "Call",
    "NewInt",
    "NewBool",
    "ParseArgs",
    "Null"
};

char* node_type_names[] = {
    "Int",
    "Bool",
    "IntArray",
    "BoolArray",
    "StringArray",
    "Void",
    "Id",
    "IntLit",
    "BoolLit",
    "BoolArray",
    "Unknown" /* Used internally */
};

char* node_get_name(node_t* self) {
    assert(self);
/*    DEBUG_PRINT("[node_get_name] self=%p, self->nodetype='%d' ('%s')\n", self, self->nodetype, node_names[self->nodetype]);*/
    if ( self->nodetype == NODE_TYPE )
        return node_type_names[self->type];
    else
        return node_names[self->nodetype];
}

node_t* node_create(nodetype_t nodetype) {
    node_t* self = (node_t*) malloc(sizeof(node_t));
    memset(self,0,sizeof (node_t) );
    self->nodetype = nodetype;
    self->type = TYPE_UNKNOWN;
    self->next = NULL;
    self->n1 = self->n2 = self->n3 = self->n4 = NULL;
    return self;
}

node_t* node_create_null(void) {
    return node_create(NODE_NULL);
}

node_t* node_append(node_t* meant_to_be_first, node_t* meant_to_be_last) {
    DEBUG_PRINT("[node_append] meant_to_be_first='%p', meant_to_be_last ='%p'\n", meant_to_be_first, meant_to_be_last);
    node_t* iter = meant_to_be_first;
    while ( iter->next != NULL ) iter = iter->next;
    iter->next = meant_to_be_last;
    return meant_to_be_first;
}


node_t* node_create_terminal(ijavatype_t type, char* token) {
    DEBUG_PRINT("[node_create_terminal] type='%d' ('%s'), token='%s'\n", type, node_type_names[type], token);
    node_t* self = node_create(NODE_TYPE);
    self->type = type;

    /* token is supposed to be given to us from a valid malloc() or strdup()
       so we can take care of it */

    if ( type == TYPE_VOID )
        assert ( token == NULL );
    else {
        /* token might be null in case we just want to create a node which says "Int", "Bool", "IntArray", "BoolArray", etc.. */
        self->id = token;
    }

    DEBUG_PRINT("[node_create_terminal]-->self = %p\n", self);
    return self;
}

node_t* node_create_terminal_int(ijavatype_t type, int token_value) {
    DEBUG_PRINT("[node_create_terminal] type='%d' ('%s'), token='%d'\n", type, node_type_names[type], token_value);
    node_t* self = node_create(NODE_TYPE);
    self->type = type;

    /* token is supposed to be given to us from a valid malloc() or strdup()
       so we can take care of it */

    if ( type == TYPE_VOID )
        /*assert ( token_value == NULL ); -- FIXME: Can not make this assertion because we can support -1 values, right?*/
        ;
    else {
        /* token might be null in case we just want to create a node which says "Int", "Bool", "IntArray", "BoolArray", etc.. */
        self->value = token_value;
    }

    DEBUG_PRINT("[node_create_terminal]-->self = %p\n", self);
    return self;
}

/* FIXME: We're not using this atm, and I hope we never have to */
node_t* node_fuse_vardecls_into_main_vardecl_node(node_t* vardeclares) {
    assert(vardeclares);
    
    node_t* final = node_create(NODE_VARDECL);
    node_t* iter = vardeclares;
    node_t* target_iter = final;
    node_t* tmp;

    while ( iter != NULL ) {
        assert(iter->n1); /* has type */
        assert(iter->n2); /* has id */    
        target_iter->next = node_append(iter->n1, iter->n2);
        tmp =  iter;
        iter = iter->next;
        node_delete(tmp);
    }
    return final;
}

node_t* node_create_type(ijavatype_t type) {
    return node_create_terminal(type,NULL);
}

/* FIXME: We will probably change this to use Joca's string functions... but for now this will probably suffice */
node_t* node_create_vardecl(ijavatype_t type, node_t* vars) {
    DEBUG_PRINT("[node_create_vardecl] type='%d' ('%s'), vars='%p'\n", type, node_type_names[type], vars);
    assert(vars != NULL);
    node_t* self = node_create(NODE_VARDECL);

    /* n1 points to a node such as IntArray, Int, Bool, etc */
    self->n1 = node_create_type(type);

    /* n2 points to the first node belonging to this vardecl */
    self->n2 = vars;


    DEBUG_PRINT("[node_create_vardecl]-->%s ", node_type_names[type]);
    node_t* iter = vars;
    while ( iter != NULL ) {
        assert(iter->type == TYPE_UNKNOWN );
        iter->type = TYPE_ID;
        DEBUG_PRINT("%s, ", iter->id);
        iter = iter->next;        
    }
    DEBUG_PRINT("\n");

    DEBUG_PRINT("[node_create_vardecl]-->self = %p\n", self);
    return self;
}

node_t* node_create_paramdeclaration(ijavatype_t type, char* token) {
    assert(token != NULL);
    DEBUG_PRINT("[node_create_paramdeclaration] type='%d' ('%s'), token='%s'\n", type, node_type_names[type], token);
    node_t* self = node_create(NODE_PARAMDECLARATION);

    /* The type node */
    self->n1 = node_create_type(type);

    /* The node with the Id, and the token */
    self->n2 = node_create_terminal(TYPE_ID, token);

    return self;
}

node_t* node_create_methodparams(node_t* params) {    
    
    DEBUG_PRINT("[node_create_methodparams] params=%p\n", params);
    node_t* self = node_create(NODE_METHODPARAMS);

    /* The first child is the node whose path we must follow to get to other nodes. Might be NULL! */
    self->n1 = params;

    return self; 
}

node_t* node_create_methodbody(node_t* vardecls,node_t* statements) {
    node_t* self = node_create(NODE_METHODBODY);
    int currChild = 0;
    
    if ( vardecls != NULL ) self->n1 = vardecls;
    if ( statements != NULL ) self->n2 = statements;

    return self;
}

node_t* node_create_binary_oper(nodetype_t nodetype, node_t* lhs, node_t* rhs) {
    node_t* self = node_create(nodetype);

    self->n1 = lhs;
    self->n2 = rhs;

    return self;
}

BINARY_OP_IMPL(or, NODE_OPER_OR);
BINARY_OP_IMPL(and, NODE_OPER_AND);
BINARY_OP_IMPL(eq, NODE_OPER_EQ);
BINARY_OP_IMPL(neq, NODE_OPER_NEQ);
BINARY_OP_IMPL(lt, NODE_OPER_LT);
BINARY_OP_IMPL(gt, NODE_OPER_GT);
BINARY_OP_IMPL(leq, NODE_OPER_LEQ);
BINARY_OP_IMPL(geq, NODE_OPER_GEQ);
BINARY_OP_IMPL(add, NODE_OPER_ADD);
BINARY_OP_IMPL(sub, NODE_OPER_SUB);
BINARY_OP_IMPL(mul, NODE_OPER_MUL);
BINARY_OP_IMPL(div, NODE_OPER_DIV);
BINARY_OP_IMPL(mod, NODE_OPER_MOD);

BINARY_OP_IMPL(loadarray, NODE_OPER_LOADARRAY);
BINARY_OP_IMPL(parseargs, NODE_OPER_PARSEARGS);

node_t* node_create_unary_oper(nodetype_t nodetype, node_t* expr) {
    node_t* self = node_create(nodetype);

    self->n1 = expr;

    return self;
}

UNARY_OP_IMPL(not, NODE_OPER_NOT);
UNARY_OP_IMPL(plus, NODE_OPER_PLUS);
UNARY_OP_IMPL(minus, NODE_OPER_MINUS);
UNARY_OP_IMPL(dotlength, NODE_OPER_LENGTH);
UNARY_OP_IMPL(newint, NODE_OPER_NEWINT);
UNARY_OP_IMPL(newbool, NODE_OPER_NEWBOOL);

node_t* node_create_oper_call(char* token, node_t* args) {
    node_t* self = node_create(NODE_OPER_CALL);

    /* First node: ID */
    self->n1 = node_create_terminal(TYPE_ID, token);

    /* Second Node: Arguments, chained. Might be NULL! */
    self->n2 = args;

    return self;
}

node_t* node_statement_append_statement(node_t* first_statement, node_t* second_statement) {
    if ( first_statement == NULL )
        return second_statement;
    return node_append(first_statement, second_statement);
}

node_t* node_create_statement_return(node_t* expr) {
    node_t* self = node_create(NODE_STATEMENT_RETURN);

    /* expr might be NULL, in which case it is okay to still assign */
    self->n1 = expr;

    return self;
}

node_t* node_create_statement_print(node_t* expr) {
    node_t* self = node_create(NODE_STATEMENT_PRINT);

    assert(expr);
    self->n1 = expr;

    return self; 
}

node_t* node_create_statement_storearray(char* token, node_t* index, node_t* rval ) {
    node_t* self = node_create(NODE_STATEMENT_STOREARRAY);

    /* First node: ID */
    self->n1 = node_create_terminal(TYPE_ID, token);

    /* Second node: Index */
    self->n2 = index;

    /* Third node: Rval */
    self->n3 = rval;

    return self;
}

node_t* node_create_statement_store(char* token, node_t* rval) {
    node_t* self = node_create(NODE_STATEMENT_STORE);

    /* First node: ID */
    self->n1 = node_create_terminal(TYPE_ID, token);

    /* Second node: Rval */
    self->n2 = rval;

    return self;
}

node_t* node_create_statement_while(node_t* expr, node_t* statement) {
    if ( !statement ) statement = node_create_null();
    node_t* self = node_create(NODE_STATEMENT_WHILE);

    /* First node: expr */
    self->n1 = expr;

    /* Second node: statement */    
    self->n2 = statement;

    return self;
}

node_t* node_create_statement_ifelse(node_t* cond, node_t* ifstatement, node_t* elsestatement) {
    assert(cond);
    if ( ifstatement == NULL ) ifstatement = node_create_null();
    if ( elsestatement == NULL ) elsestatement = node_create_null();
    node_t* self = node_create(NODE_STATEMENT_IFELSE);

    /* First node: cond */
    self->n1 = cond;

    /* Second node: ifexpr */
    self->n2 = ifstatement;

    /* Third node: elseexpr */
    self->n3 = elsestatement;

    return self;
}

int count_nodes_in_list(node_t* list) {
    int c = 0;
    while ( list != NULL ) { c++; list = list->next; } ;

    return c;
}

/* This potentially creates a CompundStatement (if there are 2 or more statements) */
node_t* node_create_statement_potential_compoundstatement(node_t* statements) {
    /* Statements might be NULL if, for instance, the user just inserts {}, in which case
       we wish to carry with it being NULL. Note also that NULL statements are filtered out
       of the list because of the way we built node_steatement_append_statement() (go check it out)
    */
    if ( statements == NULL ) return NULL;
    int num_statements = count_nodes_in_list(statements);

    if ( num_statements < 2) return statements;
    else {
        node_t* self = node_create(NODE_STATEMENT_COMPOUNDSTATEMENT);
        self->n1 = statements;
        return self;
    }
}

node_t* node_create_methoddecl(ijavatype_t type, char* token, node_t* method_params, node_t* method_body) {
    node_t* self = node_create(NODE_METHODDECL);

    /* First child is the type */
    self->n1 = node_create_type(type);

    /* Second child is the ID */
    self->n2 = node_create_terminal(TYPE_ID, token);

    /* Third child is MethodParams */
    self->n3 = method_params;

    /* Fourth child is MethodBody */
    self->n4 = method_body;

    return self;
}

node_t* node_create_program(char* token, node_t* declarations) {
    node_t* self = node_create(NODE_PROGRAM);

    self->n1 = node_create_terminal(TYPE_ID, token);

    self->n2 = declarations;
    /*if ( self->n1 != NULL)
        assert(self->n1->nodetype == NODE_VARDECL || self->n1->nodetype == NODE_METHODDECL || self->n1->nodetype == NODE_NULL );*/
    return self;
}

void node_delete(node_t* self) {
    /* FIXME: Needs change? */
    free(self);
}

node_t* node_move_next_to_n1(node_t* self) {
    self->n1 = self->next;
    self->next = NULL;
    return self;
}

void print_tabs(int n) {
    int i;
    for ( i = 0; i < n; i++)
        printf("  ");    
}

/* We need the depth because some of our nodes are in fact "double" nodes, which contain more info */
void print_node(node_t* node) {
    if ( node->nodetype != NODE_TYPE || (node->type != TYPE_ID && node->type != TYPE_INTLIT && node->type != TYPE_BOOLLIT) ) {

        printf("%s", node_get_name(node));
    } else {
        assert(node->id);
/*
        if ( node->type == TYPE_INTLIT || node->type == TYPE_ID || node->type == TYPE_BOOLLIT )
 
            printf("%s(%s)", node_get_name(node), node->id);            
        else*/
            printf("%s(%s)", node_get_name(node), node->id);
    }
}

void print_sub_tree(node_t* node, int depth) {
    assert(node);
    print_tabs(depth); print_node(node); printf("\n");

    if (node->n1)
        print_sub_tree(node->n1, depth+1);
    if (node->n2)
        print_sub_tree(node->n2, depth+1);
    if (node->n3)
        print_sub_tree(node->n3, depth+1);
    if (node->n4)
        print_sub_tree(node->n4, depth+1);

    if ( node->next ) print_sub_tree(node->next, depth);
}


void print_ast(node_t* ast) {
    assert ( ast->nodetype == NODE_PROGRAM );
    print_sub_tree(ast, 0);
}
