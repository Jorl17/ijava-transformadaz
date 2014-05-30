%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "node_t.h"
#include "sym_t.h"
#include "llvm_ir.h"

extern int prev_col, prev_line;
extern char* yytext;

int had_error = 0;

node_t* ast_root;
int show_ast = 0;
int show_tables = 0;
sym_t* class_table;/*Class' symbol table*/

/*
Simbolos:
[] -> Opcional
{} -> 0 ou mais repeticoes
*/
%}

%union
{
    char* token;    
    struct _node_t* node;
    int type; /* ijavatype_t */
}

%nonassoc THEN
%nonassoc ELSE

%nonassoc REDUCEEXPRESSON1

%token <token> CLASS
%token <token> ID
%token <token> OBRACE
%token <token> CBRACE
%token <token> <token> STATIC
%token <token> <token> PUBLIC
%token <token> <token> VOID
%token <token> OCURV
%token <token> CCURV
%token <token> COMMA
%token <token> STRING
%token <token> SEMIC
%token <token> INT
%token <token> BOOL
%token <token> BOOLLIT
%token <token> PRINT
%token <token> INTLIT
%token <token> DOTLENGTH
%token <token> NOT
%token <token> PARSEINT
%token <token> NEW
%token <token> ASSIGN
%token <token> CSQUARE
%token <token> IF
%token <token> ELSE
%token <token> OP1
%token <token> LE GE EQ NEQ LEQ GEQ
%token <token> PLUS MINUS
%token <token> MULT DIV MOD
%token <token> OSQUARE
%token <token> RETURN
%token <token> RESERVED
%token <token> WHILE

/* FIXME: Probably IDs will need their one type, probably idlist_t */
%type <node> Start Program Declarations FieldDecl MethodDecl Statements FormalParams RealParams VarDecl Statement Expr exprIndexable Terminal Args RealArguments IDs VarDecls
%type <type> Type MethodType

%left OR
%left AND
%left EQ NEQ
%left LE GE LEQ GEQ
%left PLUS MINUS
%left MULT DIV MOD
%right ASSIGN
%left OBRACE
%right UNARY_HIGHEST_VAL
%left OSQUARE DOTLENGTH



%% 

/*Start -> Program*/
Start:	Program                                                                   {ast_root = $$;}
	;

/*Program -> CLASS ID OBRACE { FieldDecl | MethodDecl } CBRACE*/
Program:		CLASS ID OBRACE Declarations CBRACE                               {$$=node_create_program($2,$4);}
    |           CLASS ID OBRACE CBRACE                                            {$$=node_create_program($2,NULL);}
	;


Declarations:	Declarations FieldDecl                                            {$$=node_append($1,$2);}
	|			Declarations MethodDecl                                           {$$=node_append($1,$2);}
    |           FieldDecl                                                         {$$=$1;}
    |           MethodDecl                                                        {$$=$1;}
    ;

/*FieldDecl -> STATIC VarDecl*/
FieldDecl:		STATIC VarDecl                                                   {$$=$2;}
	;

VarDecls: VarDecl                                                                 {$$=$1;}
    |     VarDecls VarDecl                                                        {$$=node_append($1,$2);}

/*MethodDecl -> PUBLIC STATIC ( Type | VOID ) ID OCURV [ FormalParams ] CCURV OBRACE { VarDecl } { Statement } CBRACE*/
MethodDecl:		PUBLIC STATIC MethodType ID OCURV FormalParams CCURV OBRACE VarDecls Statements CBRACE    {$$=node_create_methoddecl($3,$4,node_create_methodparams($6),node_create_methodbody($9,$10));}
    |           PUBLIC STATIC MethodType ID OCURV FormalParams CCURV OBRACE VarDecls CBRACE               {$$=node_create_methoddecl($3,$4,node_create_methodparams($6),node_create_methodbody($9,NULL));}
    |           PUBLIC STATIC MethodType ID OCURV FormalParams CCURV OBRACE Statements CBRACE             {$$=node_create_methoddecl($3,$4,node_create_methodparams($6),node_create_methodbody(NULL,$9));}
    |           PUBLIC STATIC MethodType ID OCURV FormalParams CCURV OBRACE CBRACE                        {$$=node_create_methoddecl($3,$4,node_create_methodparams($6),node_create_methodbody(NULL,NULL));}
	;

MethodType:		Type                                                              {$$=$1;}
	|			VOID                                                              {$$=TYPE_VOID;}
	;

Statements:	Statement                                                             {$$=$1;}
    |       Statement Statements                                                  {$$=node_statement_append_statement($1,$2);}
    ;

/*FormalParams -> Type ID { COMMA Type ID }
FormalParams -> STRING OSQUARE CSQUARE ID*/
FormalParams:	RealParams                                                        {$$=$1;}
	|			STRING OSQUARE CSQUARE ID                                         {$$=node_create_paramdeclaration(TYPE_STRINGARRAY,$4);}
	|			                                                                  {$$=NULL;}
    ;                                                                             

RealParams:	  Type ID                                                             {$$=node_create_paramdeclaration($1,$2);}
    |         Type ID COMMA RealParams                                            {$$=node_append(node_create_paramdeclaration($1,$2),$4);}
    ;

/*VarDecl -> Type ID { COMMA ID } SEMIC*/
VarDecl:		Type IDs SEMIC                                                    {$$=node_create_vardecl($1, $2);};

IDs:  ID                                                                          {$$=node_create_terminal(TYPE_UNKNOWN, $1);}
    | IDs COMMA ID                                                                {$$=node_append($1, node_create_terminal(TYPE_UNKNOWN,$3));}
    ;

/*Type -> ( INT | BOOL ) [ OSQUARE CSQUARE ]*/
Type:			INT OSQUARE CSQUARE                                               {$$=TYPE_INTARRAY;}
    |           BOOL OSQUARE CSQUARE                                              {$$=TYPE_BOOLARRAY;}
    |           INT                                                               {$$=TYPE_INT;}
	|			BOOL                                                              {$$=TYPE_BOOL;}
	;

/*Statement → OBRACE { Statement } CBRACE
Statement → IF OCURV Expr CCURV Statement [ ELSE Statement ]
Statement → WHILE OCURV Expr CCURV Statement
Statement → PRINT OCURV Expr CCURV SEMIC
Statement → ID [ OSQUARE Expr CSQUARE ] ASSIGN Expr SEMIC
Statement → RETURN [ Expr ] SEMIC*/
Statement:		OBRACE CBRACE                                                    {$$=NULL;}
    |           OBRACE Statements CBRACE                                         {$$=node_create_statement_potential_compoundstatement($2);}
	|			IF OCURV Expr CCURV Statement %prec THEN                         {$$=node_create_statement_ifelse($3,$5,node_create_null());}
	|			IF OCURV Expr CCURV Statement ELSE Statement                     {$$=node_create_statement_ifelse($3, $5, $7);}
	|			WHILE OCURV Expr CCURV Statement                                 {$$=node_create_statement_while($3, $5);}
	|			PRINT OCURV Expr CCURV SEMIC                                     {$$=node_create_statement_print($3);}
    |           ID ASSIGN Expr SEMIC                                             {$$=node_create_statement_store($1, $3);}
	|			ID OSQUARE Expr CSQUARE ASSIGN Expr SEMIC                        {$$=node_create_statement_storearray($1, $3,$6);}
	|			RETURN SEMIC                                                     {$$=node_create_statement_return(NULL);}
	|			RETURN Expr SEMIC                                                {$$=node_create_statement_return($2);}
	;

Expr: NEW INT OSQUARE Expr CSQUARE                                               {$$=node_create_oper_newint($4);}
    | NEW BOOL OSQUARE Expr CSQUARE                                              {$$=node_create_oper_newbool($4);}
    | exprIndexable %prec REDUCEEXPRESSON1                                                             {$$=$1;}
    ;

exprIndexable: exprIndexable OSQUARE Expr CSQUARE                                {$$=node_create_oper_loadarray($1,$3);}
    | Expr AND Expr                                                              {$$=node_create_oper_and($1,$3);}
    | Expr OR Expr                                                               {$$=node_create_oper_or($1,$3);}
    | Expr LE Expr                                                               {$$=node_create_oper_lt($1,$3);}
    | Expr GE Expr                                                               {$$=node_create_oper_gt($1,$3);}
    | Expr EQ Expr                                                               {$$=node_create_oper_eq($1,$3);}
    | Expr NEQ Expr                                                              {$$=node_create_oper_neq($1,$3);}
    | Expr GEQ Expr                                                              {$$=node_create_oper_geq($1,$3);}
    | Expr LEQ Expr                                                              {$$=node_create_oper_leq($1,$3);}
    | Expr PLUS Expr                                                             {$$=node_create_oper_add($1,$3);}
    | Expr MINUS Expr                                                            {$$=node_create_oper_sub($1,$3);}
    | Expr MULT Expr                                                             {$$=node_create_oper_mul($1,$3);}
    | Expr DIV Expr                                                              {$$=node_create_oper_div($1,$3);}
    | Expr MOD Expr                                                              {$$=node_create_oper_mod($1,$3);}
    | NOT Expr %prec UNARY_HIGHEST_VAL                                           {$$=node_create_oper_not($2);}
    | PLUS Expr %prec UNARY_HIGHEST_VAL                                          {$$=node_create_oper_plus($2);}
    | MINUS Expr %prec UNARY_HIGHEST_VAL                                         {$$=node_create_oper_minus($2);}
	| Terminal                                                                   {$$=$1;}
	| OCURV Expr CCURV                                                           {$$=$2;}
	| Expr DOTLENGTH                                                             {$$=node_create_oper_dotlength($1);}
	| PARSEINT OCURV ID OSQUARE Expr CSQUARE CCURV                               {$$=node_create_oper_parseargs(node_create_terminal(TYPE_ID,$3),$5);}
	;

Terminal:		ID                                                               {$$=node_create_terminal(TYPE_ID, $1);}
	|			INTLIT                                                           {$$=node_create_terminal(TYPE_INTLIT, $1);}
	|			BOOLLIT                                                          {$$=node_create_terminal(TYPE_BOOLLIT, $1);}
	|			ID OCURV Args CCURV                                              {$$=node_create_oper_call($1,$3);}
    |           ID OCURV CCURV                                                   {$$=node_create_oper_call($1,NULL);}
	;

/*Args -> Expr { COMMA Expr }*/
Args:			RealArguments                                                    {$$=$1;}
    ;

RealArguments:	Expr                                                             {$$=$1;}
	|           Expr COMMA RealArguments                                         {$$=node_append($1,$3);}
    ;
%%

int main(int argc, char* argv[])
{
    int i;

	yyparse();

    for(i=0; i < argc; i++)
    {
        if(strcmp(argv[i], "-s") == 0)
            show_tables = 1;
        
        else if(strcmp(argv[i], "-t") == 0)
            show_ast = 1;
    }

    if (show_ast && !had_error)
        print_ast(ast_root);
    
    /*Create the symbol tables*/
    if ( !had_error && (!show_ast || show_tables))
        class_table = analyse_ast(ast_root);

    if ( !had_error) {
        check_ast_for_semantic_errors(ast_root, class_table);/*If error quits program*/
    }

    if (show_tables && !had_error)
    {
        /*Print the class symbol table*/
        if ( class_table )
            printTable(class_table);
        
        /*Print the other tables*/
        sym_t* temp_node;
        temp_node = class_table;

        while (temp_node != NULL)
        {
            if (temp_node->node_type == METHOD)
            {
                printf("\n");
                printTable(temp_node->table_method);
            }

            temp_node = temp_node->next;
        }
    }

    if ( !had_error )
        llvm_output_code(ast_root, class_table);        

    

	return 0;
}

int yyerror(char* s)
{
    had_error = 1;
	printf("Line %d, col %d: %s: %s\n", prev_line, prev_col, s, yytext);
}
