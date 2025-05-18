/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    IF = 258,                      /* IF  */
    THEN = 259,                    /* THEN  */
    ELSE = 260,                    /* ELSE  */
    LOOP = 261,                    /* LOOP  */
    START = 262,                   /* START  */
    END = 263,                     /* END  */
    SUM = 264,                     /* SUM  */
    SUBSTRACTION = 265,            /* SUBSTRACTION  */
    MULTIPLICATION = 266,          /* MULTIPLICATION  */
    DIVIDE = 267,                  /* DIVIDE  */
    ROOT = 268,                    /* ROOT  */
    MOD = 269,                     /* MOD  */
    EXPONENT = 270,                /* EXPONENT  */
    LESS = 271,                    /* LESS  */
    MORE = 272,                    /* MORE  */
    LESS_EQUAL = 273,              /* LESS_EQUAL  */
    MORE_EQUAL = 274,              /* MORE_EQUAL  */
    EQUALS = 275,                  /* EQUALS  */
    DIFFERENT = 276,               /* DIFFERENT  */
    NOT = 277,                     /* NOT  */
    ASSIGN = 278,                  /* ASSIGN  */
    COMMA = 279,                   /* COMMA  */
    PRINT = 280,                   /* PRINT  */
    INPUT = 281,                   /* INPUT  */
    AND = 282,                     /* AND  */
    OR = 283,                      /* OR  */
    ABS = 284,                     /* ABS  */
    LOG = 285,                     /* LOG  */
    SIN = 286,                     /* SIN  */
    COS = 287,                     /* COS  */
    TAN = 288,                     /* TAN  */
    COT = 289,                     /* COT  */
    FUNCTION = 290,                /* FUNCTION  */
    ENDFUNCTION = 291,             /* ENDFUNCTION  */
    RETURN = 292,                  /* RETURN  */
    LPAREN = 293,                  /* LPAREN  */
    RPAREN = 294,                  /* RPAREN  */
    NEWLINE = 295,                 /* NEWLINE  */
    NUMBER = 296,                  /* NUMBER  */
    BOOL = 297,                    /* BOOL  */
    IDENTIFIER = 298,              /* IDENTIFIER  */
    STRING = 299,                  /* STRING  */
    BODY = 300                     /* BODY  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 71 "parser.y"

  int ival;
  char* sval;

#line 114 "parser.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
