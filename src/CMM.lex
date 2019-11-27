%{
#include "stdio.h"
#include "stdlib.h"
# include "gramtree.h"
# include "y.tab.h"
%}

%option yylineno

FLOAT               ([-+]?[0-9]*\.?[0-9]+(L|l)?((F|f)?|(L|l)?))
INTEGER             ([0-9]+(((U|u)?(L|l)?)|((L|l)?(U|u)?)|((L|l)?(L|l)?)))
SCENTIFIC_NUMBER    ([+-]?[\d]+([\.][\d]+)?([Ee][+-]?[\d]+)?(((U|u)?(L|l)?)|((L|l)?(U|u)?)|((L|l)?(L|l)?)))
OCTAL               ([+-]?0[1-7]+(((U|u)?(L|l)?)|((L|l)?(U|u)?)|((L|l)?(L|l)?)))
HEXA                ([+-]?0[x|X][A-Fa-f0-9]+(((U|u)?(L|l)?)|((L|l)?(U|u)?)|((L|l)?(L|l)?)))
BINARY              ([+-]?0[b|B][0|1]+(((U|u)?(L|l)?)|((L|l)?(U|u)?)|((L|l)?(L|l)?)))
TYPE                ("int"|"float")

IDENTIFIER          ([_a-zA-Z][_a-zA-Z0-9]*)
SEMI                (";")
ASSIGNOP            ("=")
PLUS                ("+")
MINUS               ("-")
STAR                ("*")
DIV                 ("/")
LP                  ("(")
RP                  (")")
LC                  ("{")
RC                  ("}")
RELOP               ("<="|">="|"==")


SINGLE_ANNOTATION   ("//"[^\n]*)
MULTI_ANNOTATION    ("/*"*"*/")

%%
[\n]                { yylineno++;                           }
[ \t\r\a]+          { /* ignore all spaces */               }
{SINGLE_ANNOTATION} { /* skip for single line comment */    }
{MULTI_ANNOTATION}  { /* skip for single line commnet */    }

{INTEGER}           {  yylval.a=newast("INREGER",0,yylineno); return T_IntConstant;                }
{FLOAT}             {  yylval.a=newast("FLOAT",0,yylineno); return T_FloatConstant;                }
{SCENTIFIC_NUMBER}  {  yylval.a=newast("SCENTIFIC_NUMBER",0,yylineno); return T_ScientificConstant;}
{OCTAL}             {  yylval.a=newast("OCTAL",0,yylineno); return T_OctalConstant;                }
{HEXA}              {  yylval.a=newast("HEXA",0,yylineno); return T_HexaConstant;                  }
{BINARY}            {  yylval.a=newast("BINARY",0,yylineno); return T_BinaryConstant;              }
{TYPE}              {  yylval.a=newast("TYPE",0,yylineno); return T_Type;                          }

"void"              {  yylval.a=newast("void",0,yylineno); return T_Void;                          }
"while"             {  yylval.a=newast("while",0,yylineno); return T_While;                        }
"for"               {  yylval.a=newast("for",0,yylineno); return T_For;                            } 
"if"                {  yylval.a=newast("if",0,yylineno); return T_If;                              }
"else"              {  yylval.a=newast("else",0,yylineno); return T_Else;                          }
"return"            {  yylval.a=newast("return",0,yylineno); return T_Return;                      }
"break"             {  yylval.a=newast("break",0,yylineno); return T_Break;                        }
"continue"          {  yylval.a=newast("continue",0,yylineno); return T_Continue;                  }
"main"              {  yylval.a=newast("main",0,yylineno); return T_Main;                          }

{IDENTIFIER}        {  yylval.a=newast("IDENTIFIER",0,yylineno); return T_Identifier;              }
{SEMI}              {  yylval.a=newast("semi",0,yylineno); return T_Semi;                          }
{ASSIGNOP}          {  yylval.a=newast("ASSIGNOP",0,yylineno); return T_Assignop;                  }
{RELOP}             {  yylval.a=newast("RELOP",0,yylineno); return T_Relop;                        }
{PLUS}              {  yylval.a=newast("plus",0,yylineno); return T_Plus;                          }
{MINUS}             {  yylval.a=newast("minus",0,yylineno); return T_Minus;                        }
{STAR}              {  yylval.a=newast("star",0,yylineno); return T_Star;                          }
{DIV}               {  yylval.a=newast("div",0,yylineno); return T_Div;                            }
{LP}                {  yylval.a=newast("lp",0,yylineno); return T_Lp;                              }
{RP}                {  yylval.a=newast("rp",0,yylineno); return T_Rp;                              }
{LC}                {  yylval.a=newast("lc",0,yylineno); return T_Lc;                              }
{RC}                {  yylval.a=newast("rc",0,yylineno); return T_Rc;                              }

.                   {  printf("Error type A at line %d: Mystirious charachter '%s'\n",yylineno,yytext);}

%%

int yywrap(void) { 
    return 1;
}
