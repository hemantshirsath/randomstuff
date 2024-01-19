calculator.y
%{
#include<stdio.h>
int flag=0;
%}
%{
int yylex();
void yyerror();
%}
%token NUMBER
%left '+' '-'
%left '*' '/' '%'
%left '(' ')'
%%
ArithmeticExpression: E{
printf("Result %d",$$);
return 0;
};
E: E'+'E {$$=$1+$3;}
 | E'-'E {$$=$1+$3;}
 | E'*'E {$$=$1*$3;}
 | E'/'E {$$=$1/$3;}
 | E'%'E{$$=$1%$3;}
 | '('E')' {$$=$2;}
 | NUMBER {$$=$1;}
 ;
%%
void main()
{
printf("Enter arithmetic expression ");
yyparse();
if(flag==0)
printf("Entered arithmetic expression is valid");
}
void yyerror()
{
printf("Entered arithmetic expression is invalid");
flag=1;
}

lex calculator.l
yacc -d calculator.y
cc lex.yy.c y.tab.c -ll -ly
./a.out





