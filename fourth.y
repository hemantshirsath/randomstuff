cfg.y
%{
#include<stdio.h>
int flag=0;
%}
%{
int yylex();
void yyerror();
%}
%token ONE ZERO NL
%%
str1: str2 n1{};
str2: ZERO str2 ONE{}
    | ZERO ONE{};
n1: NL {return(0);};
%%
void main()
{
printf("Enter string ");
yyparse();
if(flag==0)
printf("Given String is valid");
}
void yyerror()
{
printf("Given string is not valid");
flag=1;
}

lex cfg.l
yacc -d cfg.y
cc lex.yy.c y.tab.c -ll -ly
./a.out
