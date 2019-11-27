/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    T_IntConstant = 258,
    T_FloatConstant = 259,
    T_ScientificConstant = 260,
    T_OctalConstant = 261,
    T_HexaConstant = 262,
    T_BinaryConstant = 263,
    T_Identifier = 264,
    T_Semi = 265,
    T_Assignop = 266,
    T_Relop = 267,
    T_Plus = 268,
    T_Minus = 269,
    T_Star = 270,
    T_Div = 271,
    T_Type = 272,
    T_Lp = 273,
    T_Rp = 274,
    T_Lc = 275,
    T_Rc = 276,
    T_Return = 277,
    T_If = 278,
    T_Else = 279,
    T_While = 280,
    T_For = 281,
    T_Void = 282,
    T_Break = 283,
    T_Continue = 284,
    T_Main = 285,
    UMINUS = 286,
    IFX = 287
  };
#endif
/* Tokens.  */
#define T_IntConstant 258
#define T_FloatConstant 259
#define T_ScientificConstant 260
#define T_OctalConstant 261
#define T_HexaConstant 262
#define T_BinaryConstant 263
#define T_Identifier 264
#define T_Semi 265
#define T_Assignop 266
#define T_Relop 267
#define T_Plus 268
#define T_Minus 269
#define T_Star 270
#define T_Div 271
#define T_Type 272
#define T_Lp 273
#define T_Rp 274
#define T_Lc 275
#define T_Rc 276
#define T_Return 277
#define T_If 278
#define T_Else 279
#define T_While 280
#define T_For 281
#define T_Void 282
#define T_Break 283
#define T_Continue 284
#define T_Main 285
#define UMINUS 286
#define IFX 287

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 9 "CMM.y" /* yacc.c:1909  */

struct ast* a;
double d;

#line 123 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
