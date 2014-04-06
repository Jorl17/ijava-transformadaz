%{
#include <stdio.h>
#include <stdlib.h>

/*

---------------------------------------------------README MAXI-------------------------------------------------------------------

NAO TENHO A CERTEZA SE O YACC PERMITE CRIAR UMA REGRA DA GRAMATICA QUE SEJA TIPO A->LAMBDA (USADA PARA OS CASOS EM QUE TEMOS CENAS
QUE OCORREM 0 OU MAIS VEZES). MAS TENHO IDEIA DE TER OUVIDO O PROF DIZER QUE NAO PERMITIA ISSO. ANDEI A PROCURA NA NET E TAMBEM NAO
ENCONTREI NADA, POR ISSO PARA NAO PERDER MUITO TEMPO DESENVOLVI TUDO ASSUMINDO QUE NAO E POSSIVEL FAZER ESTE TIPO DE REGRAS.
SE POR ACASO DESCOBRIRMOS QUE E POSSIVEL IT WILL BE A RELIEVE, CASO CONTRARIO DIRIA QUE FICAMOS COM UMA GRAMATICA FEIA COMO TUDO
---------------------------------------------------README MAXI-------------------------------------------------------------------

Simbolos:
[] -> Opcional
{} -> 0 ou mais repeticoes

ToDo:
- Read readme file
- Prioratize operators
*/
%}

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
Program:		CLASS ID OBRACE CBRACE					{/*Zero repetitions*/}
	|			CLASS ID OBRACE Declarations CBRACE		{/*One or more repetitions*/}
	;

Declarations:	Declarations FieldDecl					{/*More than one repetition*/}
	|			Declarations MethodDecl					{/*More than one repetition*/}
	|			FieldDecl								{/*One repetition*/}
	|			MethodDecl								{/*One repetition*/}
	;

/*FieldDecl -> STATIC VarDecl*/
FieldDecl:		STATIC VarDecl
	;

/*MethodDecl -> PUBLIC STATIC ( Type | VOID ) ID OCURV [ FormalParams ] CCURV OBRACE { VarDecl } { Statement } CBRACE*/
MethodDecl:		PUBLIC STATIC MethodType ID OCURV CCURV OBRACE CBRACE										{/*Zero repetitions of VarDecl and Statement*/}
	|			PUBLIC STATIC MethodType ID OCURV CCURV OBRACE Go_Statement CBRACE  						{/*Zero repetitions of VarDecl and 1 or more repetitions of Statement*/}
	|			PUBLIC STATIC MethodType ID OCURV CCURV OBRACE Go_VarDecl CBRACE    						{/*Zero repetitions of Statement and 1 or more repetitions of VarDecl*/}
	|			PUBLIC STATIC MethodType ID OCURV CCURV OBRACE Go_Statement Go_VarDecl CBRACE   			{/*1 or more repetitions of VarDecl and Statement*/}
	|			PUBLIC STATIC MethodType ID OCURV FormalParams CCURV OBRACE CBRACE							{/*Same thing but now with FormalParams*/}
	|			PUBLIC STATIC MethodType ID OCURV FormalParams CCURV OBRACE Go_Statement CBRACE  			{/*Zero repetitions of VarDecl and 1 or more repetitions of Statement*/}
	|			PUBLIC STATIC MethodType ID OCURV FormalParams CCURV OBRACE Go_VarDecl CBRACE    			{/*Zero repetitions of Statement and 1 or more repetitions of VarDecl*/}
	|			PUBLIC STATIC MethodType ID OCURV FormalParams CCURV OBRACE Go_VarDecl Go_Statement CBRACE  {/*1 or more repetitions of VarDecl and Statement*/}
	;

MethodType:		Type
	|			VOID
	;

Go_Statement:	Go_Statement Statement  						{/*More than one repetition*/}
	|			Statement 										{/*One Repetition*/}
	;

Go_VarDecl:		Go_VarDecl VarDecl 								{/*More than one repetition*/}
	|			VarDecl 										{/*One repetition*/}
	;

/*FormalParams -> Type ID { COMMA Type ID }
FormalParams -> STRING OSQUARE CSQUARE ID*/
FormalParams:	Type ID 										{/*Zero repetitions*/}
	|			Type ID Go_Comma_Type							{/*One or more repetitions*/}
	|			STRING OSQUARE CSQUARE ID
	;

Go_Comma_Type:	Go_Comma_Type COMMA Type ID 					{/*More than one repetition*/}
	|			COMMA Type ID 									{/*One repetition*/}
	;

/*VarDecl -> Type ID { COMMA ID } SEMIC*/
VarDecl:		Type ID SEMIC 									{/*Zero repetitions*/}
	|			Type ID Go_Comma_ID SEMIC						{/*One or more repetitions*/}
	;

Go_Comma_ID:	Go_Comma_ID COMMA ID 							{/*More than one repetition*/}
	|			COMMA ID 										{/*One repetition*/}
	;

/*Type -> ( INT | BOOL ) [ OSQUARE CSQUARE ]*/
Type:			Type_Type										{/*No OSQUARE CSQUARE*/}
	|			Type_Type OSQUARE CSQUARE						{/*With OSQUARE CSQUARE*/}
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
Statement:		OBRACE CBRACE 									{/*With no repetitions of Statement*/}
	|			OBRACE Go_Statement_Statement CBRACE 			{/*With one or more repetitions of Stamente - FIXME: IS THIS REALLY NEEDED???*/}
	|			IF OCURV Expr CCURV Statement 					{/*With no "ELSE Statement"*/}
	|			IF OCURV Expr CCURV Statement ELSE Statement 	{/*With "ELSE Statement"*/}
	|			WHILE OCURV Expr CCURV Statement
	|			PRINT OCURV Expr CCURV SEMIC
	|			ID ASSIGN Expr SEMIC   							{/*With no "OSQUARE Expr CSQUARE"*/}
	|			ID OSQUARE Expr CSQUARE ASSIGN Expr SEMIC 		{/*With "OSQUARE Expr CSQUARE"*/}
	|			RETURN SEMIC									{/*With no "Expr"*/}
	|			RETURN Expr SEMIC
	;

Go_Statement_Statement:		Go_Statement_Statement Statement 	{/*More than one repetition*/}
	|						Statement 							{/*One repetition*/}
	;

/*Expr -> Expr ( OP1 | OP2 | OP3 | OP4 ) Expr
Expr -> Expr OSQUARE Expr CSQUARE
Expr -> ID | INTLIT | BOOLLIT
Expr -> NEW ( INT | BOOL ) OSQUARE Expr CSQUARE
Expr -> OCURV Expr CCURV
Expr -> Expr DOTLENGTH | ( OP3 | NOT ) Expr
Expr -> PARSEINT OCURV ID OSQUARE Expr CSQUARE CCURV
Expr _> ID OCURV [ Args ] CCURV*/
Expr:			Expr Expressions Expr 							{/*FIXME-> CONFLICT*/}
	|			Expr OSQUARE Expr CSQUARE
	|			ID
	|			INTLIT
	|			BOOLLIT
	|			NEW Type_Type OSQUARE Expr2 CSQUARE				{/*Remember that Type_Type: INT | BOOL; FIXME -> PROBLEM HERE: How to detect "NEW INT [2]" is correct, and "NEW INT [2][7]" is not=*/}
	|			OCURV Expr CCURV
	|			Expr DOTLENGTH Expr
	| 			Expr_OP3_NOT Expr
	|			PARSEINT OCURV ID OSQUARE Expr CSQUARE CCURV
	|			ID OCURV CCURV 									{/*With no "Args"*/}
	|			ID OCURV Args CCURV								{/*With "Args"*/}
	;

Expr2:			ID 												{/*With this are we solving the "NEW INT [2][7]" problem?*/}
	;

Expressions: 	OP1
	|			OP2
	|			OP3
	|			OP4
	;

Expr_OP3_NOT:	OP3
	|			NOT
	;

/*Args → Expr { COMMA Expr }*/
Args:			Expr											{/*Zero repetitions*/}
	|			Expr Go_Comma_Expression						{/*One or more repetitions*/}
	;

Go_Comma_Expression:	Go_Comma_Expression COMMA Expr 			{/*More than one repetition*/}
	|					COMMA Expr								{/*One repetition*/}
	;

%%
int main()
{
	yyparse();
}

int yyerror(char* s)
{
	printf("%s\n", s);
}
