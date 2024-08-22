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

#ifndef YY_YY_PJPARSER_H_INCLUDED
# define YY_YY_PJPARSER_H_INCLUDED
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
    T_AND = 258,                   /* T_AND  */
    T_ELSE = 259,                  /* T_ELSE  */
    T_FLOAT = 260,                 /* T_FLOAT  */
    T_FOR = 261,                   /* T_FOR  */
    T_IF = 262,                    /* T_IF  */
    T_LONGINT = 263,               /* T_LONGINT  */
    T_BOOLEAN = 264,               /* T_BOOLEAN  */
    T_PROGRAM = 265,               /* T_PROGRAM  */
    T_FUNCTION = 266,              /* T_FUNCTION  */
    T_NOT = 267,                   /* T_NOT  */
    T_OR = 268,                    /* T_OR  */
    T_READ = 269,                  /* T_READ  */
    T_WHILE = 270,                 /* T_WHILE  */
    T_WRITE = 271,                 /* T_WRITE  */
    T_WRITELN = 272,               /* T_WRITELN  */
    T_BEGIN = 273,                 /* T_BEGIN  */
    T_END = 274,                   /* T_END  */
    T_VAR = 275,                   /* T_VAR  */
    T_DO = 276,                    /* T_DO  */
    T_ARRAY = 277,                 /* T_ARRAY  */
    T_EXIT = 278,                  /* T_EXIT  */
    T_THEN = 279,                  /* T_THEN  */
    T_LE = 280,                    /* T_LE  */
    T_LT = 281,                    /* T_LT  */
    T_GE = 282,                    /* T_GE  */
    T_GT = 283,                    /* T_GT  */
    T_EQ = 284,                    /* T_EQ  */
    T_NE = 285,                    /* T_NE  */
    T_ASSIGN = 286,                /* T_ASSIGN  */
    T_COMMA = 287,                 /* T_COMMA  */
    T_SEMICOLON = 288,             /* T_SEMICOLON  */
    T_COLON = 289,                 /* T_COLON  */
    T_LBRACKET = 290,              /* T_LBRACKET  */
    T_RBRACKET = 291,              /* T_RBRACKET  */
    T_LPAREN = 292,                /* T_LPAREN  */
    T_RPAREN = 293,                /* T_RPAREN  */
    T_PLUS = 294,                  /* T_PLUS  */
    T_TIMES = 295,                 /* T_TIMES  */
    T_IDENTIFIER = 296,            /* T_IDENTIFIER  */
    T_DIV = 297,                   /* T_DIV  */
    T_STRING = 298,                /* T_STRING  */
    T_INTNUM = 299,                /* T_INTNUM  */
    T_FLOATNUM = 300,              /* T_FLOATNUM  */
    T_MINUS = 301,                 /* T_MINUS  */
    T_DOT = 302,                   /* T_DOT  */
    T_DOTDOT = 303,                /* T_DOTDOT  */
    T_OF = 304,                    /* T_OF  */
    T_TRUE = 305,                  /* T_TRUE  */
    T_FALSE = 306                  /* T_FALSE  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 102 "PJParser.y"

	int     regIndex;
	int	typeId;  
	DList	idList;
	char	*name;
 	int     symIndex; 
	int 	offset;
	ArrayBounds bounds;
        int     value;

#line 126 "PJParser.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_PJPARSER_H_INCLUDED  */
