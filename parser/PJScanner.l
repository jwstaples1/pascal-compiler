WS	[ \t\n]

%{

/* This scanner approximates the Pascal specification.
 *
 */

#include <stdio.h>
#include <util/general.h>
#include <util/dlink.h>
#include <util/string_utils.h>
#include "PJParserHeader.h"
#include "PJParser.h"

extern char *fileName;
%}

%option yylineno

%%

LONGINT			{ return T_LONGINT;}
BOOLEAN			{ return T_BOOLEAN;}
WHILE			{ return T_WHILE; }
ELSE			{ return T_ELSE; }
FLOAT			{ return T_FLOAT; }
IF			{ return T_IF; }
READ			{ return T_READ; }
WRITE			{ return T_WRITE; }
WRITELN			{ return T_WRITELN; }
PROGRAM			{ return T_PROGRAM; }
FUNCTION		{ return T_FUNCTION; }
BEGIN			{ return T_BEGIN; }
END			{ return T_END;}
VAR			{ return T_VAR;}
DO			{ return T_DO;}
ARRAY			{ return T_ARRAY;}
THEN			{ return T_THEN;}
OF			{ return T_OF;}
EXIT		{ return T_EXIT;}
NOT			{ return T_NOT;}
OR		    	{ return T_OR;}
AND			{ return T_AND;}
TRUE		{ return T_TRUE;}
FALSE		{ return T_FALSE;}
\<=			{ return T_LE; }
\<			{ return T_LT; }
\>=			{ return T_GE; }
\>			{ return T_GT; }
\=			{ return T_EQ; }
\<>			{ return T_NE; }
\:=			{ return T_ASSIGN; }
\;			{ return T_SEMICOLON; }
\[			{ return T_LBRACKET; }
\]			{ return T_RBRACKET; }
\(			{ return T_LPAREN; }
\)			{ return T_RPAREN; }
\+			{ return T_PLUS; }
\-          		{ return T_MINUS; }
\*			{ return T_TIMES; }
DIV			{ return T_DIV;}
","			{ return T_COMMA;}
":"			{ return T_COLON;}
"."             	{ return T_DOT;}
".."			{ return T_DOTDOT;} 

\'[^\']*\'		{ 
				  yylval.name = substr(yytext, 1, yyleng-2);
				  return T_STRING; 
			}
\{[^\}]*\}		{ ; }
[a-zA-Z]([a-zA-Z]|[0-9])*	{ 
					yylval.name = ssave(yytext);
					return T_IDENTIFIER; 
				}
	
[0-9]+			{ 
				yylval.name = ssave(yytext);
				return T_INTNUM; 
			}

{WS}			{ ; }

[0-9]*(\.)[0-9]+((e|E)(\+|\-)?[0-9]*)?/[^.$]	{ 
							yylval.name = ssave(yytext);
							return T_FLOATNUM; 
						}

[0-9]+((e|E)(\+|\-)?[0-9]*)/[^.$]  { 
					yylval.name = ssave(yytext);
					return T_FLOATNUM; 
				   }


.			{ fprintf(stderr, "%s: line %d: lexical error '%s'.\n", fileName,yylineno,yytext); }
%%
