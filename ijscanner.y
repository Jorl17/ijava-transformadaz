%{
#include <stdio.h>
#include <stdlib.h>

/*
Simbolos:
[] -> Opcional
{} -> 0 ou mais repeticoes
*/
%}

%nonassoc THEN
%nonassoc ELSE

%token CLASS
%token ID
%token OBRACE
%token CBRACE
%token STATIC
%token PUBLIC
%token VOID
%token OCURV
%token CCURV
%token COMMA
%token STRING
%token SEMIC
%token INT
%token BOOL
%token BOOLLIT
%token PRINT
%token INTLIT
%token DOTLENGTH
%token NOT
%token PARSEINT
%token NEW
%token ASSIGN
%token CSQUARE
%token IF
%token ELSE
%token OP1
%token OP2
%token OP3
%token OP4
%token OSQUARE
%token RETURN
%token RESERVED
%token WHILE

%% 

/*Start -> Program*/
Start:	Program
	;

/*Program -> CLASS ID OBRACE { FieldDecl | MethodDecl } CBRACE*/
Program:		CLASS ID OBRACE Declarations CBRACE
	;

Declarations:	Declarations FieldDecl
	|			Declarations MethodDecl
	|			;

/*FieldDecl -> STATIC VarDecl*/
FieldDecl:		STATIC VarDecl
	;

/*MethodDecl -> PUBLIC STATIC ( Type | VOID ) ID OCURV [ FormalParams ] CCURV OBRACE { VarDecl } { Statement } CBRACE*/
MethodDecl:		PUBLIC STATIC MethodType ID OCURV FormalParams CCURV OBRACE Go_VarDecl Go_Statement CBRACE
	;

MethodType:		Type
	|			VOID
	;

Go_Statement:	Go_Statement Statement  						/*One or more repetitions*/
	|			;		 										/*Zero Repetitions*/

Go_VarDecl:		Go_VarDecl VarDecl 								/*One or more repetitions*/
	|			; 												/*Zero repetitions*/

/*FormalParams -> Type ID { COMMA Type ID }
FormalParams -> STRING OSQUARE CSQUARE ID*/
FormalParams:	Type ID Go_Comma_Type							/*Zero or more repetitions*/
	|			STRING OSQUARE CSQUARE ID
	|			;												/*Nothing*/

Go_Comma_Type:	Go_Comma_Type COMMA Type ID 					/*More than one repetition*/
	|			; 												/*Zero repetitions*/

/*VarDecl -> Type ID { COMMA ID } SEMIC*/
VarDecl:		Type ID Go_Comma_ID SEMIC						/*Zero or more repetitions*/
	;

Go_Comma_ID:	Go_Comma_ID COMMA ID 							/*One or more repetitions*/
	|			;		 										/*Zero repetitions*/

/*Type -> ( INT | BOOL ) [ OSQUARE CSQUARE ]*/
Type:			Type_Type										/*No OSQUARE CSQUARE*/
	|			Type_Type OSQUARE CSQUARE						/*With OSQUARE CSQUARE*/
	;


Type_Type:		INT
	|			BOOL
	;	

/*Statement → OBRACE { Statement } CBRACE
Statement → IF OCURV Expr CCURV Statement [ ELSE Statement ]
Statement → WHILE OCURV Expr CCURV Statement
Statement → PRINT OCURV Expr CCURV SEMIC
Statement → ID [ OSQUARE Expr CSQUARE ] ASSIGN Expr SEMIC
Statement → RETURN [ Expr ] SEMIC*/
Statement:		OBRACE Statement_Repeat CBRACE 					/*With zero or more repetitions of Statement*/
	|			IF OCURV Expr CCURV Statement %prec THEN		/*With no "ELSE Statement". The "%prec" is to solve the if-else conflict*/
	|			IF OCURV Expr CCURV Statement ELSE Statement 	/*With "ELSE Statement"*/
	|			WHILE OCURV Expr CCURV Statement
	|			PRINT OCURV Expr CCURV SEMIC
	|			ID OC_Square ASSIGN Expr SEMIC
	|			RETURN SEMIC									/*With no "Expr"*/
	|			RETURN Expr SEMIC
	;

Statement_Repeat:	Statement_Repeat Statement
	|			;

OC_Square:		OSQUARE Expr CSQUARE
	|			;

/*Expr -> Expr ( OP1 | OP2 | OP3 | OP4 ) Expr
Expr -> Expr OSQUARE Expr CSQUARE
Expr -> ID | INTLIT | BOOLLIT
Expr -> NEW ( INT | BOOL ) OSQUARE Expr CSQUARE
Expr -> OCURV Expr CCURV
Expr -> Expr DOTLENGTH | ( OP3 | NOT ) Expr pode desdobrar-se nisto: "Expr -> Expr DOTLENGTH" e "Expr -> (OP3 | NOT) Expr" ??
Expr -> PARSEINT OCURV ID OSQUARE Expr CSQUARE CCURV
Expr -> ID OCURV [ Args ] CCURV*/
Expr:			Expr Operators Expr 							/*FIXME-> CONFLICT*/
	|			Expr OSQUARE Expr CSQUARE 						/*FIXME-> CONFLICT*/
	|			NEW Type_Type OSQUARE Expr CSQUARE				/*Remember that Type_Type: INT | BOOL;*/
	|			OCURV Expr CCURV
	|			Expr DOTLENGTH
	| 			OP3_NOT Expr
	|			PARSEINT OCURV ID OSQUARE Expr CSQUARE CCURV
	|			Terminal
	;

Terminal:		ID
	|			INTLIT
	|			BOOLLIT
	|			ID OCURV Args CCURV								/*Zero or more repetitions of "Args"*/
	;

Operators: 		OP1
	|			OP2
	|			OP3
	|			OP4
	;

OP3_NOT:		OP3
	|			NOT
	;

/*Args → Expr { COMMA Expr }*/
Args:			Expr Comma_Expression							/*Zero or more repetitions*/
	|			;

Comma_Expression:	COMMA Expr Comma_Expression 				/*Zero or more repetitions*/
	|					;										/*No repetitions*/

%%
int main()
{
	yyparse();
	return 0;
}

int yyerror(char* s)
{
	printf("%s\n", s);
}