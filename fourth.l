cfg.l
%{
#include "y.tab.h"
%}
%%
"a" {return ZERO;}
"b" {return ONE;}
[\n] {return NL;}
. ;
%%