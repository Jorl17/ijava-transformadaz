%{
#include <stdio.h>
#include <stdlib.h>
#include "node_t.h"

extern int prev_col, prev_line;
extern char* yytext;

int had_error = 0;

node_t* ast_root;

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
%token <token> OP2
%token <token> OP3
%token <token> OP4
%token <token> OSQUARE
%token <token> RETURN
%token <token> RESERVED
%token <token> WHILE

/* FIXME: Probably IDs will need their one type, probably idlist_t */
%type <node> Start Program Declarations FieldDecl MethodDecl Statements FormalParams RealParams VarDecl Statement Statement_Repeat OC_Square Expr exprIndexable Terminal Args Comma_Expression IDs VarDecls
%type <type> Type MethodType

%left OR
%left AND
%left OP2
%left OP3
%left OP4
%right ASSIGN
%left OSQUARE
%left OBRACE
%left NOT
%left DOTLENGTH
%right UNARY_HIGHEST_VAL



%% 

/*Start -> Program*/
Start:	Program                                                                   {ast_root = $$;}
	;

/*Program -> CLASS ID OBRACE { FieldDecl | MethodDecl } CBRACE*/
Program:		CLASS ID OBRACE Declarations CBRACE                               {$$=node_create_program($4);}
    |           CLASS ID OBRACE CBRACE                                            {$$=node_create_program(node_create_null());}
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

Statements:	Statement                                                             {$$=node_create_null(); /*FIXME: $$=$1 */}
    |       Statement Statements                                                  {$$=node_append(node_create_null() /*FIXME: $1 */,$2);}
    ;

/*FormalParams -> Type ID { COMMA Type ID }
FormalParams -> STRING OSQUARE CSQUARE ID*/
FormalParams:	RealParams                                                        {$$=$1;}
	|			STRING OSQUARE CSQUARE ID                                         {$$=node_create_paramdeclaration(TYPE_STRINGARRAY,$4);}
	|			                                                                  {$$=node_create_null();}
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
Statement:		OBRACE Statement_Repeat CBRACE                                   {}
	|			IF OCURV Expr CCURV Statement %prec THEN                         {}
	|			IF OCURV Expr CCURV Statement ELSE Statement                     {}
	|			WHILE OCURV Expr CCURV Statement                                 {}
	|			PRINT OCURV Expr CCURV SEMIC                                     {}
	|			ID OC_Square ASSIGN Expr SEMIC                                   {}
	|			RETURN SEMIC                                                     {}
	|			RETURN Expr SEMIC                                                {}
	;

Statement_Repeat:	Statement_Repeat Statement                                   {}
	|                                                                            {}			
    ;

OC_Square:		OSQUARE Expr CSQUARE                                             {}
	|                                                                            {}			
    ;

Expr: Expr AND Expr                                                              {}
    | Expr OR Expr                                                               {}
    | Expr OP2 Expr                                                              {}
    | Expr OP3 Expr                                                              {}
    | Expr OP4 Expr                                                              {}
    | NOT Expr %prec UNARY_HIGHEST_VAL                                           {}
    | OP3 Expr %prec UNARY_HIGHEST_VAL                                           {}
    | NEW INT OSQUARE Expr CSQUARE                                               {}
    | NEW BOOL OSQUARE Expr CSQUARE                                              {}
    | exprIndexable                                                              {}
    ;

exprIndexable: exprIndexable OSQUARE Expr CSQUARE                                {}
	| Terminal                                                                   {}
	| OCURV Expr CCURV                                                           {}
	| Expr DOTLENGTH                                                             {}
	| PARSEINT OCURV ID OSQUARE Expr CSQUARE CCURV                               {}
	;

Terminal:		ID                                                               {$$=node_create_terminal(TYPE_ID, $1);}
	|			INTLIT                                                           {$$=node_create_terminal(TYPE_INTLIT, $1);}
	|			BOOLLIT                                                          {$$=node_create_terminal(TYPE_BOOLLIT, $1);}
	|			ID OCURV Args CCURV                                              {}
	;

/*Args -> Expr { COMMA Expr }*/
Args:			Expr Comma_Expression                                            {}
	|			                                                                 {}
    ;

Comma_Expression:	COMMA Expr Comma_Expression                                  {}
	|                                                                            {}
    ;
%%

int main()
{
	yyparse();

    if (!had_error)
        print_ast(ast_root);
	return 0;
}

int yyerror(char* s)
{
    had_error = 1;
	printf("Line %d, col %d: %s: %s\n", prev_line, prev_col, s, yytext);
}
