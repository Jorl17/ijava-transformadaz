%{
    #include "y.tab.h"
    int in_comment = 0, comment_start_line = 0, comment_start_col = 0;
    int line=1, col=1, prev_line=1, prev_col=1;

    #define INCREASE_COL do {prev_line = line; prev_col = col; col += yyleng; } while (0)
    #define PRINT_TOKEN(x)  {INCREASE_COL; /*printf("%s\n", #x);*/ return x;  }
    #define PRINT_TOKEN_ARG(x)  {INCREASE_COL; /*printf("%s(%s)\n",#x,yytext);*/  return x;}
    #define IGNORE {INCREASE_COL;}
    #define IGNORE_NEWLINE {prev_line = line++; prev_col = col; col=1;}
    #define PRINT_LINE_COL do { printf("Line %d, col %d", line, col); } while(0)
    #define PRINT_LINE_COL_COMMENT  do { printf("Line %d, col %d", comment_start_line, comment_start_col); } while(0)
    #define ERROR_UNTERMINATED_COMMENT do { PRINT_LINE_COL_COMMENT; printf(": unterminated comment\n"); } while(0)
    #define ERROR_ILLEGAL_CHARACTER(x) do { PRINT_LINE_COL; printf(": illegal character ('%c')\n", x); INCREASE_COL; } while(0)
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
OR "||"
AND "&&"
OP2 "<"|">"|"=="|"!="|"<="|">="
OP3 "+"|"-"
OP4 "*"|"/"|"%"
NOT "!"
ASSIGN "="
SEMIC ";"
COMMA ","
RESERVED "abstract"|"continue"|"for"|"switch"|"assert"|"default"|"goto"|"package"|"synchronized"|"do"|"private"|"this"|"break"|"double"|"implements"|"protected"|"throw"|"byte"|"import"|"throws"|"case"|"enum"|"instanceof"|"transient"|"catch"|"extends"|"short"|"try"|"char"|"final"|"interface"|"finally"|"long"|"strictfp"|"volatile"|"const"|"float"|"native"|"super"|"null"|"++"|"--"
WHITESPACE " "|"\t"
NEWLINE "\n"
%%
{OPEN_COMMENT}                          START_MULTILINE_COMMENT
<MULTI_LINE_COMMENT_S><<EOF>>           { IGNORE_NEWLINE; return yytext[0]; }
<MULTI_LINE_COMMENT_S>{CLOSE_COMMENT}   END_MULTILINE_COMMENT
<MULTI_LINE_COMMENT_S>.                 IGNORE
<MULTI_LINE_COMMENT_S>\n                IGNORE_NEWLINE
{SINGLE_LINE_COMMENT}.*                 IGNORE
<<EOF>>                                 { IGNORE_NEWLINE; return yytext[0]; }
{WHITESPACE}                            IGNORE
{NEWLINE}                               IGNORE_NEWLINE
{RESERVED}                              {PRINT_TOKEN_ARG(RESERVED); }
{BOOLLIT}                               {PRINT_TOKEN_ARG(BOOLLIT); }
{INTLIT}                                {PRINT_TOKEN_ARG(INTLIT); }
{INT}                                   {PRINT_TOKEN(INT); }
{BOOL}                                  {PRINT_TOKEN(BOOL); }
{NEW}                                   {PRINT_TOKEN(NEW); }
{IF}                                    {PRINT_TOKEN(IF); }
{ELSE}                                  {PRINT_TOKEN(ELSE); }
{WHILE}                                 {PRINT_TOKEN(WHILE); }
{PRINT}                                 {PRINT_TOKEN(PRINT); }
{PARSEINT}                              {PRINT_TOKEN(PARSEINT); }
{CLASS}                                 {PRINT_TOKEN(CLASS); }
{PUBLIC}                                {PRINT_TOKEN(PUBLIC); }
{STATIC}                                {PRINT_TOKEN(STATIC); }
{VOID}                                  {PRINT_TOKEN(VOID); }
{STRING}                                {PRINT_TOKEN(STRING); }
{DOTLENGTH}                             {PRINT_TOKEN(DOTLENGTH); }
{RETURN}                                {PRINT_TOKEN(RETURN); }
{OCURV}                                 {PRINT_TOKEN(OCURV); }
{CCURV}                                 {PRINT_TOKEN(CCURV); }
{OBRACE}                                {PRINT_TOKEN(OBRACE); }
{CBRACE}                                {PRINT_TOKEN(CBRACE); }
{OSQUARE}                               {PRINT_TOKEN(OSQUARE); }
{CSQUARE}                               {PRINT_TOKEN(CSQUARE); }
{OR}                                    {PRINT_TOKEN_ARG(OR); }
{AND}                                   {PRINT_TOKEN_ARG(AND); }
{OP2}                                   {PRINT_TOKEN_ARG(OP2); }
{OP3}                                   {PRINT_TOKEN_ARG(OP3); }
{OP4}                                   {PRINT_TOKEN_ARG(OP4); }
{NOT}                                   {PRINT_TOKEN(NOT); }
{ASSIGN}                                {PRINT_TOKEN(ASSIGN); }
{SEMIC}                                 {PRINT_TOKEN(SEMIC); }
{COMMA}                                 {PRINT_TOKEN(COMMA); }
{ID}                                    {PRINT_TOKEN_ARG(ID); }
.                                       {ERROR_ILLEGAL_CHARACTER(yytext[0]);}
%%

int yywrap() {
    if ( in_comment ) {
        ERROR_UNTERMINATED_COMMENT;
    }
    return 1;
}
