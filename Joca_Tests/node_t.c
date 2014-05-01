#include "node_t.h"
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <stdio.h>

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
    "BoolArray",
    "Unknown" /* Used internally */
};

char* node_get_name(node_t* self) {
    if ( self->nodetype == NODE_TYPE )
        return node_type_names[self->type];
    else
        return node_names[self->nodetype];
}

node_t* node_create(nodetype_t nodetype) {
    node_t* self = (node_t*) malloc(sizeof(node_t));
    memset(self,0,sizeof (node_t) );
    self->nodetype = nodetype;
    self->next = NULL;
    self->n1 = self->n2 = self->n3 = NULL;
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
    DEBUG_PRINT("[node_create_terminal] type='%d' ('%s'), token='%s'\n", type, node_type_names[type], token);
    node_t* self = node_create(NODE_TYPE);
    self->type = type;

    /* token is supposed to be given to us from a valid malloc() or strdup()
       so we can take care of it */

    if ( type == TYPE_VOID )
        assert ( token == NULL );
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

/* FIXME: We will probably change this to use Joca's string functions... but for now this will probably suffice */
node_t* node_create_vardecl(ijavatype_t type, node_t* vars) {
    DEBUG_PRINT("[node_create_vardecl] type='%d' ('%s'), vars='%p'\n", type, node_type_names[type], vars);
    assert(vars != NULL);
    node_t* self = node_create(NODE_VARDECL);

    /* n1 points to a node such as IntArray, Int, Bool, etc */
    self->n1 = node_create_terminal(type,NULL);

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

node_t* node_create_program(node_t* declarations) {
    node_t* self = node_create(NODE_PROGRAM);
    self->n1 = declarations;
    if ( self->n1 != NULL)
        assert(self->n1->nodetype == NODE_VARDECL || self->n1->nodetype == NODE_METHODDECL || self->n1->nodetype == NODE_NULL );
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
        printf("\t");    
}

/* We need the depth because some of our nodes are in fact "double" nodes, which contain more info */
void print_node(node_t* node) {
    if ( node->nodetype != NODE_TYPE || node->type != TYPE_ID ) {

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

    if ( node->next ) print_sub_tree(node->next, depth);
}


void print_ast(node_t* ast) {
    assert ( ast->type == NODE_PROGRAM );
    print_sub_tree(ast, 0);
}
