#include "node_t.h"
#include "sym_t.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/* Counts current local variables. Don't forget to reset it once we start a new method! */
unsigned int llvm_tmp_var_count = 0;

unsigned int llvm_return_label_count = 0;
unsigned int llvm_label_count = 0;

/* llvm_type_t shall be "i32", "i16", etc, as the LLVM IR requires */
typedef const char* llvm_type_t;

/* Gives us a valid local variable name that we can use, such as %1, %2 or %3 */
char* get_local_var_name() {
    char* buf = (char*)malloc(16);
    sprintf(buf, "%%%u", ++llvm_tmp_var_count);
    return buf;
}

void reset_local_vars() { 
  llvm_tmp_var_count = 0;
}

void increase_return_label_count() {
    ++llvm_return_label_count;
}

char* get_current_return_label_name() {
    char* buf = (char*)malloc(64);
    sprintf(buf, ".return%u", llvm_return_label_count);
    return buf;
}

char* get_label_name() {
    char* buf = (char*)malloc(64);
    sprintf(buf, ".label%u", ++llvm_label_count);
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
    ijavatype_t type; /* TYPE_INTARRAY, TYPE_INT... */
    int value; /* To specify if it's a raw value instead of a pointer */
} llvm_var_t;

llvm_var_t* llvm_var_create() {
    llvm_var_t* ret = (llvm_var_t*)malloc( sizeof (llvm_var_t));
    ret->value = 0;
    ret->type = TYPE_UNKNOWN;
    ret->repr = NULL;

    return ret;
}

/* Frees an llvm_var_t */
void llvm_var_free(llvm_var_t* self) {
    if ( self->repr != NULL ) free(self->repr);
    free(self);
}

/* Prints an LLVM binary op to stdout. Note that we always store the result even if we never use it.
    Inefficient? I call it inefficient to have Mooshak's tests coming out less than one week away from the submission date!! */
void llvm_bin_op(const char* op, llvm_type_t type, char* lhs, char* arg1, char* arg2) {
    printf("%s = %s %s %s, %s\n", lhs, op, type, arg1, arg2);
}

void llvm_declare_global(const char* type, const char* name) {
    printf("@%s = global %s 0, align 4\n", name, type);
}

void llvm_declare_global_array(const char* type, const char* name) {
    /* FIXME */
}



/* Prints an LLVM unary op to stdout (might not correspond to an ijava unary op */
void llvm_unary_op(const char* op, llvm_type_t type, char* val) {
    printf("%s %s %s\n", op, type, val);
}

/* Used to convert TYPE_INT, TYPE_BOOL, TYPE_INTLIT, etc to their llvm_type_t types */
const char* llvm_types_from_ijavatypes[]  = {
    "i32" /* TYPE_INT */,
    "i1" /* TYPE_BOOL */ /* FIXME */,
    "IntArray" /* TYPE_INTARRAY */ /* FIXME*/,
    "BoolArray" /* TYPE_BOOLARRAY */  /* FIXME */,
    "i8*" /* TYPE_STRINGARRAY */ /* FIXME */,
    "void" /*TYPE_VOID*/ /*FIXME */,
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

void llvm_declare_local_onetype(ijavatype_t ijava_type, const char* name) {
    const char* type = llvm_type_from_ijavatype(ijava_type);
    if ( *name == '%' ) name++; /* Skip over '%' which might be extra */
    printf("%%%s = alloca %s, align 4\n", name, type);
    printf("store %s 0, %s* %%%s\n", type, type, name);
}

void llvm_declare_local_array(ijavatype_t ijava_type, const char* name) {
    if ( ijava_type == TYPE_INTARRAY ) {

    } else if ( ijava_type == TYPE_BOOLARRAY ) {

    }
}

void llvm_declare_local(ijavatype_t type, char* id) {
  if ( type == TYPE_INTARRAY || type == TYPE_BOOLARRAY )
    llvm_declare_local_array(type, id);
  else
    llvm_declare_local_onetype(type, id);
}

void llvm_label(char* label) {
  printf("%s:\n", label);
}

void llvm_store_names_types(char* dest, char* src, ijavatype_t ijavatype) {
  assert(src); assert(dest);
  const char* type = llvm_type_from_ijavatype(ijavatype);
  printf("store %s %s, %s* %s\n", type, src, type, dest);  
}

void llvm_store(llvm_var_t* dest, llvm_var_t* src) {
  assert(src); assert(dest); assert(src->type == dest->type);
  llvm_store_names_types(dest->repr, src->repr, src->type);
}


void llvm_define_function(sym_t* function_table) {
  assert(function_table);
  printf("define %s @%s(", llvm_type_from_ijavatype(function_table->next->type), function_table->id);

  sym_t* current;
  /* Start at next->next to skip return value */
  for ( current = function_table->next->next; current != NULL; current = current->next ) {
    if ( current->is_parameter )
      printf("%s %%.%s", llvm_type_from_ijavatype(current->type), current->id);

    /* Print comma if there is one more parameter */
    if ( current->next && current->next->is_parameter ) printf(", ");
  }

  printf(") {\n");
}

void llvm_declare_locals(sym_t* function_table) {
  sym_t* current;
  /* Start at next->next to skip return value */
  for ( current = function_table->next->next; current != NULL; current = current->next )
    if ( !current->is_parameter )
      llvm_declare_local(current->type, current->id);
    else {
      char* buf_in = (char*)malloc(strlen(current->id)+2);
      char* buf_out = (char*)malloc(strlen(current->id)+2);
      sprintf(buf_in,"%%.%s", current->id);
      sprintf(buf_out,"%%%s", current->id);
      llvm_declare_local(current->type, current->id);
      llvm_store_names_types(buf_out, buf_in, current->type);
      free(buf_in);
      free(buf_out);
    }
}

void llvm_goto_nonewlabel(char* label) {
  printf("br label %%%s\n", label);
}

void llvm_goto(char* label) {
  llvm_goto_nonewlabel(label);

  char* newlabel = get_label_name();
  llvm_label(newlabel);
  free(newlabel);
}


void llvm_load(char* loaded, llvm_var_t* src) {
  assert(loaded); assert(src); 
  const char* type = llvm_type_from_ijavatype(src->type);
  printf("%s = load %s* %s\n", loaded, type, src->repr);
}

void llvm_function_prologue(ijavatype_t ret) {
  llvm_declare_local(ret, "return");
  increase_return_label_count();
}

/* We need to do some hacky stuff. First we need to have at least one reference to the return label, so
   we add a goto. Then, we need to return the value stored at return. Since return is on the stack,
   we must load it onto another variable (we chose .return) and this is what we return
 */
void llvm_function_epilogue(ijavatype_t ret) {
  char* label = get_current_return_label_name();
  llvm_var_t* return_val = llvm_var_create(); return_val->repr=strdup("%return"); return_val->type = ret;
  llvm_goto_nonewlabel(label);
  llvm_label(label);
  llvm_load("%.return", return_val);
  printf("ret %s %%.return\n", llvm_type_from_ijavatype(ret));  
  free(label);
  printf("}\n");
  llvm_var_free(return_val);
}


llvm_var_t* llvm_get_value_from_ptr_or_value(llvm_var_t* var) {
  assert(var);
  llvm_var_t* var_loaded = llvm_var_create();

  if ( var->value ) {
     var_loaded->type = var->type; var_loaded->value = 1;
     var_loaded->repr = strdup(var->repr);
  }
  else {
    var_loaded->type = var->type; var_loaded->value = 1;
    var_loaded->repr = get_local_var_name();
    llvm_load(var_loaded->repr, var);
  }

    return var_loaded;  
}


void llvm_return(ijavatype_t ret, llvm_var_t* var) {
  assert(ret == var->type);
  char* label = get_current_return_label_name();

  if ( ret == TYPE_VOID ) {
    /* Do nothing */
  } else {
    llvm_store_names_types("%return", var->repr, ret); 
  }

  llvm_goto(label);  
  free(label);
}

void llvm_icmp(const char* comparison, char* dest, char* op1, char* op2) {
  /* FIXME: Slightly hardcoded */
  printf("%s = icmp %s i32 %s, %s\n", dest, comparison, op1, op2);
}

void llvm_br(char* condvar, char* labelthen, char* labelelse) {
  printf("br i1 %s, label %%%s, label %%%s\n", condvar, labelthen, labelelse);
}

void llvm_recurse_down(node_t* iter, sym_t* class_table, sym_t* table_method);

llvm_var_t* llvm_node_to_instr_binop(node_t* node, sym_t* class_table, sym_t* curr_method_table);
llvm_var_t* llvm_node_to_instr_node_type(node_t* node, sym_t* class_table, sym_t* curr_method_table);
llvm_var_t* llvm_node_to_instr_unop(node_t* node, sym_t* class_table, sym_t* curr_method_table);
llvm_var_t* llvm_node_to_instr_return(node_t* node, sym_t* class_table, sym_t* curr_method_table);
llvm_var_t* llvm_node_to_instr_store(node_t* node, sym_t* class_table, sym_t* curr_method_table);

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
    else if ( node->nodetype == NODE_STATEMENT_RETURN )
        return llvm_node_to_instr_return(node, class_table, curr_method_table);
    else if ( node->nodetype == NODE_STATEMENT_STORE )
        return llvm_node_to_instr_store(node, class_table, curr_method_table);      
    /* FIXME: MORE TO COME: prints, ifelses, etc.. */
    return NULL;
}


/* Used to convert the operations represented by nodes into LLVM IR operations. for instance,
   we map NODE_ADD to "add" */
const char* llvm_node_to_nodetype [] = {
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
              "ne",
              "slt",
              "sgt",
              "sle",
              "sge",
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

    return llvm_node_to_nodetype [node->nodetype];
}


llvm_var_t* llvm_node_to_instr_binop_relational(node_t* node, sym_t* class_table, sym_t* curr_method_table) {
  /* Declare result, which will hold the answer */
  llvm_var_t* result = llvm_var_create(); result->type = TYPE_BOOL; result->repr=get_local_var_name(); result->value=0; 
  llvm_var_t* a, *b;
  char* loaded;
  llvm_declare_local(TYPE_BOOL, result->repr);

  if ( node->nodetype == NODE_OPER_AND ) {
    /* Implement short circuiting */
    /* a && b becomes
      result = a;
      if ( result ) result = b;
    */  
    char* labelthen = get_label_name();
    char* labelendifelse = get_label_name();

    a = llvm_node_to_instr(node->n1, class_table, curr_method_table);   /* get "%a" */
    llvm_var_t* a_loaded = llvm_get_value_from_ptr_or_value(a);
    llvm_store(result, a_loaded);                                       /* result = a */
    llvm_var_free(a_loaded);

    llvm_var_t* result_loaded = llvm_get_value_from_ptr_or_value(result);
    llvm_br(result_loaded->repr, labelthen, labelendifelse);                   /* if ( result ) goto labelthen; else goto labelendifelse; */
    llvm_label(labelthen);                                              /* labelthen: */
    b = llvm_node_to_instr(node->n2, class_table, curr_method_table); /* get "%b" */
      
    llvm_var_free(result_loaded);
    llvm_var_t* b_loaded = llvm_get_value_from_ptr_or_value(b);
    llvm_store(result, b_loaded);                                       /* result = a */                                          /* result = b */
    llvm_goto_nonewlabel(labelendifelse);                                        /* goto labelendifelse; */
    llvm_label(labelendifelse);                                         /* labelendifelse: */
    /*llvm_var_free(loaded_b);*/
  } else if  ( node->nodetype == NODE_OPER_OR ) {
    /* Implement short circuiting */
    /* a || b becomes
      result = a;
      if ( !result ) result = b;
    */  
    char* labelthen = get_label_name();
    char* labelendifelse = get_label_name();

    a = llvm_node_to_instr(node->n1, class_table, curr_method_table); /* get "%a" */
    llvm_var_t* a_loaded = llvm_get_value_from_ptr_or_value(a);
    llvm_store(result, a_loaded); /* tmp = a */
    llvm_var_free(a_loaded);

    llvm_var_t* result_loaded = llvm_get_value_from_ptr_or_value(result);
    llvm_var_t* notresult = llvm_var_create(); notresult->type = TYPE_BOOL; notresult->repr=get_local_var_name(); notresult->value = 1;
    
    llvm_bin_op("xor", "i1", notresult->repr, result_loaded->repr, "true");    /* notresult = result xor true //// same as notresult = !result */
    llvm_var_free(result_loaded);
    llvm_br(notresult->repr, labelthen, labelendifelse);                /* if ( notresult ) goto labelthen; else goto labelendifelse; */
    llvm_label(labelthen);                                              /* labelthen: */
      b = llvm_node_to_instr(node->n2, class_table, curr_method_table); /* get "%b" */
      llvm_var_t* b_loaded = llvm_get_value_from_ptr_or_value(b);
      llvm_store(result, b_loaded);                                            /* tmp = b */
      llvm_var_free(b_loaded);
    llvm_goto_nonewlabel(labelendifelse);                                        /* goto labelendifelse; */
    llvm_label(labelendifelse);                                         /* labelendifelse: */


  } else {
    a = llvm_node_to_instr(node->n1, class_table, curr_method_table);        /* Evaluate first operand */
    b = llvm_node_to_instr(node->n2, class_table, curr_method_table);        /* Evaluate second operand */

    llvm_var_t* a_loaded = llvm_get_value_from_ptr_or_value(a);
    llvm_var_t* b_loaded = llvm_get_value_from_ptr_or_value(b);

    char* tmp = get_local_var_name();
    llvm_icmp(llvm_get_op_from_node(node), tmp, a_loaded->repr, b_loaded->repr);  /* Store comparison in result */
    llvm_store_names_types(result->repr, tmp, TYPE_BOOL);

    llvm_var_free(a_loaded);
    llvm_var_free(b_loaded);
  }

  llvm_var_free(a);
  llvm_var_free(b);
  return result;
}

/* Currently only does arithmetic */
llvm_var_t* llvm_node_to_instr_binop(node_t* node, sym_t* class_table, sym_t* curr_method_table) {
    assert(node);
    assert(node->n1);
    assert(node->n2);

    if ( is_binary_op_boolean(node->nodetype) ) 
      return llvm_node_to_instr_binop_relational(node, class_table, curr_method_table);
    else {
      llvm_var_t* ret = llvm_var_create();

      /* Recurse down and find the variables that will be our operands */
      llvm_var_t* op1 = llvm_node_to_instr(node->n1, class_table, curr_method_table);
      llvm_var_t* op2 = llvm_node_to_instr(node->n2, class_table, curr_method_table);

      llvm_var_t* op1_loaded = llvm_get_value_from_ptr_or_value(op1);
      llvm_var_t* op2_loaded = llvm_get_value_from_ptr_or_value(op2);

      /* Get a nice juicy name for ourselves */
      ret->repr = get_local_var_name();

      /* Get the type from the previously calculated "tree_type". Avoids having a fixed table where we map operations to their output sizes */
      ret->type = node->tree_type;

      /* FIXME: Added this in */
      ret->value = 1;

      /* Output the binary op code */
      llvm_bin_op(llvm_get_op_from_node(node), llvm_type_from_ijavatype(ret->type), ret->repr, op1_loaded->repr, op2_loaded->repr);
      llvm_var_free(op1);
      llvm_var_free(op2);
      llvm_var_free(op1_loaded);
      llvm_var_free(op2_loaded);

      return ret;
    }

    
}

/* Currently only does arithmetic */
llvm_var_t* llvm_node_to_instr_unop(node_t* node, sym_t* class_table, sym_t* curr_method_table) {
    assert(node);
    assert(node->n1);
    llvm_var_t* ret = llvm_var_create();   
    const char* op;
    llvm_var_t* op1 = llvm_var_create();

    if      ( node->nodetype == NODE_OPER_PLUS )  { op = "add"; op1->repr = strdup("0");    op1->type = TYPE_INT;  op1->value = 1;}
    else if ( node->nodetype == NODE_OPER_MINUS ) { op = "sub"; op1->repr = strdup("0");    op1->type = TYPE_INT;   op1->value = 1;}
    else if ( node->nodetype == NODE_OPER_NOT )   { op = "xor"; op1->repr = strdup("true"); op1->type = TYPE_BOOL;  op1->value = 1; }

    /* Recurse down and find the variables that will be our operands */
    llvm_var_t* op2 = llvm_node_to_instr(node->n1, class_table, curr_method_table);
    llvm_var_t* op2_loaded = llvm_get_value_from_ptr_or_value(op2);


    /* Get a nice juicy name for ourselves */
    ret->repr = get_local_var_name();

    ret->type = node->tree_type;

    ret->value = 1;

    /* Output the binary op code */
    llvm_bin_op(op, llvm_type_from_ijavatype(ret->type), ret->repr, op1->repr, op2_loaded->repr);
    llvm_var_free(op1);
    llvm_var_free(op2); 
    llvm_var_free(op2_loaded); 

    return ret;
}

void llvm_lookup_symbol_from_table(llvm_var_t* ret, char* id, sym_t* class_table, sym_t* curr_method_table) {

  assert(ret);
  assert(id);
  assert(class_table);
  assert(curr_method_table);

  int local;  

  sym_t* result = lookup_symbol(class_table, curr_method_table, id, &local);

  ret->type = result->type;

  ret->repr = (char *)malloc((2 + strlen(id))*sizeof(char));

  ret->value = 0;

  assert((local == 0 || local == 1));/*SHOULD NOT BE NEEDED BUT LET'S KEEP IT SAFE*/

  sprintf(ret->repr, "%s%s", local==1 ? "%" : "@", id);
}

llvm_var_t* llvm_node_to_instr_node_type(node_t* node, sym_t* class_table, sym_t* curr_method_table) {
    assert(node->nodetype == NODE_TYPE);
    assert(node->type == TYPE_INTLIT || node->type == TYPE_BOOLLIT || node->type == TYPE_ID);
    int value;
    llvm_var_t* ret = llvm_var_create();   

    if ( node->type == TYPE_ID ) {
        /*FIXME: Look it up from the table
            FIXME: Joca, do your awesome thing man
        ret->repr = strdup(node->id);*/

        llvm_lookup_symbol_from_table(ret, node->id, class_table, curr_method_table);
    } else if ( node->type == TYPE_BOOLLIT) {
       ret->type = TYPE_BOOL;
       ret->repr = get_local_var_name();
       printf("%s = add i1 0, %d\n", ret->repr, node->id[0] == 't' ? 1 : 0);
       ret->value = 1;
        
	} else {
        char* val;
        ret->type = TYPE_INT;
        ret->repr = get_local_var_name();

        value = check_intlit(node->id);        

        printf("%s = add i32 0, %d\n", ret->repr, value);
        ret->value = 1;
   }

   return ret;
 }


llvm_var_t* llvm_node_to_instr_return(node_t* node, sym_t* class_table, sym_t* curr_method_table) {
  assert(node);
  ijavatype_t ret = get_return_type(curr_method_table);
  

  if ( !ret == TYPE_VOID ) {
    llvm_return(ret, NULL);
  }  else {
    llvm_var_t* val = llvm_node_to_instr(node->n1, class_table, curr_method_table);  
    llvm_var_t* val_loaded = llvm_get_value_from_ptr_or_value(val);
    llvm_return(ret, val_loaded);
    llvm_var_free(val);
    llvm_var_free(val_loaded);
  }
  return NULL;
}

llvm_var_t* llvm_node_to_instr_store(node_t* node, sym_t* class_table, sym_t* curr_method_table) {
  assert(node);
  assert(node->n1);
  assert(node->n2);
  llvm_var_t* src = llvm_node_to_instr(node->n2, class_table, curr_method_table);
  llvm_var_t* dest = llvm_var_create(); llvm_lookup_symbol_from_table(dest, node->n1->id, class_table, curr_method_table);

  llvm_var_t* src_loaded = llvm_get_value_from_ptr_or_value(src);
  llvm_store(dest, src_loaded);
  llvm_var_free(src);
  llvm_var_free(src_loaded);
  llvm_var_free(dest);
  return NULL;
}

void llvm_recurse_down(node_t* iter, sym_t* class_table, sym_t* table_method) {  
  assert(iter);

  for ( ;iter != NULL ; iter = iter->next) {
    assert( node_is_statement(iter) );
    if ( iter->nodetype == NODE_STATEMENT_COMPOUNDSTATEMENT) {
        llvm_recurse_down(iter->n1, class_table, table_method);
    } else {
        llvm_node_to_instr(iter, class_table, table_method);
    }
  }

}

void llvm_output_code(node_t* root, sym_t* class_table) {
  if ( !root || !class_table ) return; /* FIXME: WIll this ever happen? */

  /* Find all the method entry points and recurse down on them */
  sym_t* iter;

  for (iter = class_table; iter != NULL; iter = iter->next) {
      if (iter->node_type == VARIABLE) {
        llvm_declare_global(llvm_type_from_ijavatype(iter->type), iter->id);
      }      
  }

  for (iter = class_table; iter != NULL; iter = iter->next) {
      if (iter->node_type == METHOD) {
        ijavatype_t return_val = get_return_type(iter->table_method);
        llvm_define_function(iter->table_method);
        llvm_function_prologue(return_val);
        llvm_declare_locals(iter->table_method);
        if ( iter->method_start->n2 )
          llvm_recurse_down(iter->method_start->n2, class_table, iter->table_method);
        llvm_function_epilogue(return_val);
      }      
  }
  
}
