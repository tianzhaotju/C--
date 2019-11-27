%{
#include<unistd.h>
#include<stdio.h>   
#include "gramtree.h"
int yylex();
//void yyerror(const char*);
%}

%union {
struct ast* a;
double d;
}

%token <a> T_IntConstant T_FloatConstant T_ScientificConstant T_OctalConstant T_HexaConstant T_BinaryConstant 
%token <a> T_Identifier T_Semi T_Assignop T_Relop T_Plus T_Minus T_Star T_Div T_Type T_Lp
%token <a> T_Rp T_Lc T_Rc T_Return T_If T_Else T_While T_For T_Void T_Break T_Continue
%token <a> T_Main

%type  <a> Program ExtDefList ExtDef FunDec CompSt StmtList Exp_Stmt Stmt DefList Def Dec Exp INT SCENTIFIC_NUMBER OCTAL HEXA BINARY FLOAT ID SEMI ASSIGNOP RELOP PLUS MINUS STAR DIV TYPE LP RP LC RC RETURN IF ELSE WHILE FOR VOID BREAK CONTINUE

%right T_Assignop
%left T_Relop 
%left T_Plus T_Minus
%left T_Star T_Div
%left T_Lp T_Rp
%left UMINUS
%nonassoc IFX 
%nonassoc T_Else


%%
Program      :       ExtDefList                                                     { $$=newast("Program",1,$1);printf("Parsing success, print abstract syntax tree:\n");eval($$,0);printf("The abstract syntax tree is printed!  AOLIGEI!\n\n"); }
             ;

ExtDefList   :       ExtDef ExtDefList                                              { $$=newast("ExtDefList",2,$1,$2); }
             |       %empty                                                         { $$=newast("ExtDefList",0,-1); }
             ;

ExtDef       :       TYPE ID SEMI                                                   { $$=newast("ExtDef",3,$1,$2,$3); }
             |       TYPE SEMI                                                      { $$=newast("ExtDef",2,$1,$2);    }
             |       TYPE FunDec CompSt                                             { $$=newast("ExtDef",3,$1,$2,$3); }
             |       VOID FunDec CompSt                                             { $$=newast("ExtDef",3,$1,$2,$3); }             
             |       FLOAT MAIN LP RP                                               { yyerror("error at main function"); }
             |       TYPE MAIN LP TYPE ID RP                                        { yyerror("error at main function"); }
             |       VOID MAIN LP RP                                                { yyerror("error at main function"); }
             |       VOID MAIN LP TYPE ID RP                                        { yyerror("error at main function"); }
             ;

FunDec       :       ID LP TYPE ID RP                                               { $$=newast("FunDec",4,$1,$2,$3,$4); }
             |       ID LP RP                                                       { $$=newast("FunDec",3,$1,$2,$3); }
             ;

CompSt       :       LC DefList StmtList RC                                         { $$=newast("Compst",4,$1,$2,$3,$4); }
             ;

StmtList     :       Stmt StmtList                                                  { $$=newast("StmtList",2,$1,$2); }
             |       %empty                                                         { $$=newast("StmtList",0,-1); }
             ;

Exp_Stmt     :       SEMI                                                           { $$=newast("Exp_Stmt",1,$1); }
             |       Exp SEMI                                                       { $$=newast("Exp_Stmt",2,$1,$2); }
             ;

Stmt         :       Exp SEMI                                                       { $$=newast("Stmt",2,$1,$2); }
             |       CompSt                                                         { $$=newast("Stmt",1,$1); }
             |       RETURN Exp SEMI                                                { $$=newast("Stmt",3,$1,$2,$3); }
             |       IF LP Exp RP Stmt %prec IFX                                    { $$=newast("Stmt",5,$1,$2,$3,$4,$5); }
             |       IF LP Exp RP Stmt ELSE Stmt                                    { $$=newast("Stmt",7,$1,$2,$3,$4,$5,$6,$7); }
             |       WHILE LP Exp RP Stmt                                           { $$=newast("Stmt",5,$1,$2,$3,$4,$5); }
             |       FOR LP Exp_Stmt Exp_Stmt RP Stmt                               { $$=newast("Stmt",6,$1,$2,$3,$4,$5,$6); }
             |       FOR LP Exp_Stmt Exp_Stmt Exp RP Stmt                           { $$=newast("Stmt",7,$1,$2,$3,$4,$5,$6,$7); }
             |       CONTINUE SEMI                                                  { $$=newast("Stmt",2,$1,$2); }
             |       BREAK SEMI                                                     { $$=newast("Stmt",2,$1,$2); }
             |       RETURN SEMI                                                    { $$=newast("Stmt",2,$1,$2); }
             ;

DefList      :       Def DefList                                                    { $$=newast("DefList",2,$1,$2); }
             |       %empty                                                         { $$=newast("DefList",0,-1); }
             ;

Def          :       TYPE Dec SEMI                                                  { $$=newast("Def",3,$1,$2,$3); }
             ;

Dec          :       ID                                                             { $$=newast("DecList",1,$1); }
             |       ID ASSIGNOP Exp                                                { $$=newast("Dec",3,$1,$2,$3); }
             ;

Exp          :       Exp ASSIGNOP Exp                                               { $$=newast("Exp",3,$1,$2,$3); }
             |       Exp RELOP Exp                                                  { $$=newast("Exp",3,$1,$2,$3); }
             |       Exp PLUS Exp                                                   { $$=newast("Exp",3,$1,$2,$3); }
             |       Exp MINUS Exp                                                  { $$=newast("Exp",3,$1,$2,$3); }
             |       Exp STAR Exp                                                   { $$=newast("Exp",3,$1,$2,$3); }
             |       Exp DIV Exp                                                    { $$=newast("Exp",3,$1,$2,$3); }
             |       LP Exp RP                                                      { $$=newast("Exp",3,$1,$2,$3); }
             |       MINUS Exp %prec UMINUS                                         { $$=newast("Exp",2,$1,$2); }
             |       ID LP Exp RP                                                   { $$=newast("Exp",4,$1,$2,$3,$4);}
             |       ID LP RP                                                       { $$=newast("Exp",3,$1,$2,$3); }
             |       ID                                                             { $$=newast("Exp",1,$1); }
             |       INT                                                            { $$=newast("Exp",1,$1); }
             |       FLOAT                                                          { $$=newast("Exp",1,$1); }
             |       SCENTIFIC_NUMBER                                               { $$=newast("Exp",1,$1); }
             |       OCTAL                                                          { $$=newast("Exp",1,$1); }
             |       HEXA                                                           { $$=newast("Exp",1,$1); }
             |       BINARY                                                         { $$=newast("Exp",1,$1); }
             ;

INT          :       T_IntConstant                                                  {  }
             ;

SCENTIFIC_NUMBER:    T_ScientificConstant                                           {  }
             ;

OCTAL        :       T_OctalConstant                                                {  }
             ;

HEXA         :       T_HexaConstant                                                 {  }
             ;

BINARY       :       T_BinaryConstant                                               {  }
             ;

FLOAT        :       T_FloatConstant                                                {  }
             ;

ID           :       T_Identifier                                                   {  }
             ;

SEMI         :       T_Semi                                                         {  }
             ;

ASSIGNOP     :       T_Assignop                                                     {  }
             ;

RELOP        :       T_Relop                                                        {  }
             ;

PLUS         :       T_Plus                                                         {  }
             ;

MINUS        :       T_Minus                                                        {  }
             ;

STAR         :       T_Star                                                         {  }
             ;

DIV          :       T_Div                                                          {  }
             ;

TYPE         :       T_Type                                                         {  }
             ;

LP           :       T_Lp                                                           {  }
             ;

RP           :       T_Rp                                                           {  }
             ;

LC           :       T_Lc                                                           {  }
             ;

RC           :       T_Rc                                                           {  }
             ;

RETURN       :       T_Return                                                       {  }
             ;

IF           :       T_If                                                           {  }
             ;

ELSE         :       T_Else                                                         {  }
             ;

WHILE        :       T_While                                                        {  }
             ;

FOR          :       T_For                                                          {  }
             ;

VOID         :       T_Void                                                         {  }
             ;

BREAK        :       T_Break                                                        {  }
             ;

CONTINUE     :       T_Continue                                                     {  }
             ;

MAIN        :       T_Main                                                          {  }
            ;

%%

int main()
{
    printf(">>>\n");
    return yyparse(); //启动文法分析，调用词法分析
}
