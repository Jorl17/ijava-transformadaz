%{
    #include "y.tab.h"
    int in_comment = 0, comment_start_line = 0, comment_start_col = 0;
    int line=1, col=1;

    #define INCREASE_COL do {col += yyleng; } while (0)
    #define PRINT_TOKEN(x)  {INCREASE_COL; /*printf("%s\n", #x);*/  }
    #define PRINT_TOKEN_ARG(x)  {INCREASE_COL; /*printf("%s(%s)\n",#x,yytext);*/ }
    #define IGNORE {col+=yyleng;}
    #define IGNORE_NEWLINE {line++; col=1;}
    #define PRINT_LINE_COL do { printf("Line %d, col %d", line, col); } while(0)
    #define PRINT_LINE_COL_COMMENT  do { printf("Line %d, col %d", comment_start_line, comment_start_col); } while(0)
    #define ERROR_UNTERMINATED_COMMENT do { PRINT_LINE_COL_COMMENT; printf(": unterminated comment\n"); } while(0)
    #define ERROR_ILLEGAL_CHARACTER(x) do { INCREASE_COL; PRINT_LINE_COL; printf(": illegal character ('%c')\n", x); } while(0)
    #define START_MULTILINE_COMMENT { in_comment = 1; INCREASE_COL; comment_start_line = line; comment_start_col = col-2; BEGIN MULTI_LINE_COMMENT_S; }
    #define END_MULTILINE_COMMENT { in_comment = 0; INCREASE_COL; BEGIN 0; }
%}
%X MULTI_LINE_COMMENT_S
letra [a-z]|[A-Z]|"_"|"$"
numero [0-9]
ID {letra}({letra}|{numero})*
INTLIT {numero}+|0x[0-9a-fA-F]+
OPEN_COMMENT "/*"
CLOSE_COMMENT "*/"
SINGLE_LINE_COMMENT "//"
BOOLLIT "true"|"false"
INT "int"
BOOL "boolean"
NEW "new"
IF "if"
ELSE "else"
WHILE "while"
PRINT "System.out.println"
PARSEINT "Integer.parseInt"
CLASS "class"
PUBLIC "public"
STATIC "static"
VOID "void"
STRING "String"
DOTLENGTH ".length"
RETURN "return"
OCURV "("
CCURV ")"
OBRACE "{"
CBRACE "}"
OSQUARE "["
CSQUARE "]"
OP1 "&&"|"||"
OP2 "<"|">"|"=="|"!="|"<="|">="
OP3 "+"|"-"
OP4 "*"|"/"|"%"
NOT "!"
ASSIGN "="
SEMIC ";"
COMMA ","
RESERVED "abstract"|"continue"|"for"|"switch"|"assert"|"default"|"goto"|"package"|"synchronized"|"do"|"private"|"this"|"break"|"double"|"implements"|"protected"|"throw"|"byte"|"import"|"throws"|"case"|"enum"|"instanceof"|"transient"|"catch"|"extends"|"short"|"try"|"char"|"final"|"interface"|"finally"|"long"|"strictfp"|"volatile"|"const"|"float"|"native"|"super"|"null"
WHITESPACE " "|"\t"
NEWLINE "\n"
%%
{OPEN_COMMENT}                          START_MULTILINE_COMMENT
<MULTI_LINE_COMMENT_S>{CLOSE_COMMENT}   END_MULTILINE_COMMENT
<MULTI_LINE_COMMENT_S>.                 IGNORE
<MULTI_LINE_COMMENT_S>\n                IGNORE_NEWLINE
{SINGLE_LINE_COMMENT}.*                 IGNORE
{WHITESPACE}                            IGNORE
{NEWLINE}                               IGNORE_NEWLINE
{RESERVED}                              {PRINT_TOKEN_ARG(RESERVED); return RESERVED;}
{BOOLLIT}                               {PRINT_TOKEN_ARG(BOOLLIT); return BOOLLIT;}
{INTLIT}                                {PRINT_TOKEN_ARG(INTLIT); return INTLIT;}
{INT}                                   {PRINT_TOKEN(INT); return INT;}
{BOOL}                                  {PRINT_TOKEN(BOOL); return BOOL;}
{NEW}                                   {PRINT_TOKEN(NEW); return NEW;}
{IF}                                    {PRINT_TOKEN(IF); return IF;}
{ELSE}                                  {PRINT_TOKEN(ELSE); return ELSE;}
{WHILE}                                 {PRINT_TOKEN(WHILE); return WHILE;}
{PRINT}                                 {PRINT_TOKEN(PRINT); return PRINT;}
{PARSEINT}                              {PRINT_TOKEN(PARSEINT); return PARSEINT;}
{CLASS}                                 {PRINT_TOKEN(CLASS); return CLASS;}
{PUBLIC}                                {PRINT_TOKEN(PUBLIC); return PUBLIC;}
{STATIC}                                {PRINT_TOKEN(STATIC); return STATIC;}
{VOID}                                  {PRINT_TOKEN(VOID); return VOID;}
{STRING}                                {PRINT_TOKEN(STRING); return STRING;}
{DOTLENGTH}                             {PRINT_TOKEN(DOTLENGTH); return DOTLENGTH;}
{RETURN}                                {PRINT_TOKEN(RETURN); return RETURN;}
{OCURV}                                 {PRINT_TOKEN(OCURV); return OCURV;}
{CCURV}                                 {PRINT_TOKEN(CCURV); return CCURV;}
{OBRACE}                                {PRINT_TOKEN(OBRACE); return OBRACE;}
{CBRACE}                                {PRINT_TOKEN(CBRACE); return CBRACE;}
{OSQUARE}                               {PRINT_TOKEN(OSQUARE); return OSQUARE;}
{CSQUARE}                               {PRINT_TOKEN(CSQUARE); return CSQUARE;}
{OP1}                                   {PRINT_TOKEN_ARG(OP1); return OP1;}
{OP2}                                   {PRINT_TOKEN_ARG(OP2); return OP2;}
{OP3}                                   {PRINT_TOKEN_ARG(OP3); return OP3;}
{OP4}                                   {PRINT_TOKEN_ARG(OP4); return OP4;}
{NOT}                                   {PRINT_TOKEN(NOT); return NOT;}
{ASSIGN}                                {PRINT_TOKEN(ASSIGN); return ASSIGN;}
{SEMIC}                                 {PRINT_TOKEN(SEMIC); return SEMIC;}
{COMMA}                                 {PRINT_TOKEN(COMMA); return COMMA;}
{ID}                                    {PRINT_TOKEN_ARG(ID); return ID;}
.                                       {ERROR_ILLEGAL_CHARACTER(yytext[0]);}
%%

int yywrap() {
    if ( in_comment ) {
        ERROR_UNTERMINATED_COMMENT;
    }
    return 1;
}