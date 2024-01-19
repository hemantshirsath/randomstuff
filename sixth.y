%{
    #include<stdio.>
    int flag=0;
%}
%{
    int yylex();
    void yyerror();
%}
%token ZERO ONE TWO NL
%start q0

%%
q0: ZERO q0{$$=$2;}
  | ONE q1{$$=$2;}
  |TWO q2 {$$=$2;}
  |NL{printf("Number is divisible by 3"); return (0);}
  :

q1: ZERO q1 {$$=$2;}
  | ONE q2 {$$=$2;}
  | TWO q0 {$$=$2;}
  | NL {printf("Number is not divisible by 3"); return(0); }
  :

q2: ZERO q2 {$$=$2;}
  | ONE q0 {$$=$2;}
  | TWO q1 {$$=$2;}
  | NL {printf("Number is not divisible by 3 "); return(0);}
%%
void  main(){
printf("Enter decimal number to check");
yyparse();

}