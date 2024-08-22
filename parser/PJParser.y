/*******************************************************/
/*                     PascalJunior Parser             */
/*                                                     */
/*******************************************************/

/*********************DEFINITIONS***********************/
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <util/general.h>
#include <util/symtab.h>
#include <util/dlink.h>
#include <util/string_utils.h>
#include <util/symtab_stack.h>
#include <codegen/codegen.h>
#include <codegen/codegen.h>
#include <codegen/reg.h>
#include <codegen/symfields.h>
#include <codegen/types.h>
#include "PJParserHeader.h"
  
#define SYMTABLE_SIZE 100

/*********************EXTERNAL DECLARATIONS***********************/

EXTERN(void,yyerror,(char*));
EXTERN(int,yylex,(void));

SymTable globalSymtab;
SymtabStack scopeStack;

static DList instList;
static DList dataList;
char *fileName;

int globalOffset = 0;
int localOffset = 0;
extern int yylineno;
extern char *yytext;
extern FILE *yyin;
%}

%defines

%start Program

%token T_AND
%token T_ELSE
%token T_FLOAT
%token T_FOR
%token T_IF 		
%token T_LONGINT
%token T_BOOLEAN
%token T_PROGRAM	 
%token T_FUNCTION
%token T_NOT 		
%token T_OR 		
%token T_READ
%token T_WHILE
%token T_WRITE
%token T_WRITELN
%token T_BEGIN
%token T_END
%token T_VAR
%token T_DO
%token T_ARRAY
%token T_EXIT
%token T_THEN
%token T_LE
%token T_LT
%token T_GE
%token T_GT
%token T_EQ
%token T_NE
%token T_ASSIGN
%token T_COMMA
%token T_SEMICOLON
%token T_COLON
%token T_LBRACKET
%token T_RBRACKET
%token T_LPAREN
%token T_RPAREN
%token T_PLUS
%token T_TIMES
%token T_IDENTIFIER
%token T_DIV
%token T_STRING	
%token T_INTNUM
%token T_FLOATNUM
%token T_MINUS
%token T_DOT
%token T_DOTDOT
%token T_OF
%token T_TRUE
%token T_FALSE


%left T_LT T_LE T_GT T_GE T_NE T_EQ
%left T_PLUS T_MINUS T_OR
%left T_TIMES T_DIV T_AND
%left T_NOT

%union {
	int     regIndex;
	int	typeId;  
	DList	idList;
	char	*name;
 	int     symIndex; 
	int 	offset;
	ArrayBounds bounds;
        int     value;
}

%type <idList> IdentifierList DeclList Decls
%type <regIndex> Expr AddExpr MulExpr Factor Variable Constant
%type <name> T_STRING T_INTNUM  ProgramHead T_IDENTIFIER OutputFormat
%type <typeId> Type StandardType ArrayType WriteToken
%type <bounds> Dim
%type <value> IntConst
%type <symIndex> TestAndThen Test WhileExpr WhileToken

%%
/***********************PRODUCTIONS****************************/

Program : ProgramHeadAndProcedures CompoundStatement T_DOT
		{
			emitProcedureExit(instList);
			emitDataPrologue(dataList);
			emitInstructions(instList);
		}
		;

ProgramHeadAndProcedures : ProgramHead Procedures 
		{
			emitProcedurePrologue(instList,$1);
		}
;

ProgramHead : T_PROGRAM T_IDENTIFIER T_SEMICOLON Decls 
		{
			$$ = "main";
			// Decls defined here are global
		}
	    ;

       
Decls : T_VAR DeclList
		|
	  	;
	  
DeclList : IdentifierList T_COLON Type T_SEMICOLON
		{   
			
			dlinkApply1($1,(DLinkApply1Func)addIdToSymtab, (Generic)$3);
			dlinkFreeNodes($1);
		}
		 | DeclList IdentifierList T_COLON Type T_SEMICOLON
		{
			dlinkApply1($2,(DLinkApply1Func)addIdToSymtab, (Generic)$4);
			dlinkFreeNodes($2);
		}
		 ;
		 
IdentifierList : T_IDENTIFIER
		{
			int symTabIndex = SymIndex(fetchCurrentScope(),$1);
				
			$$ = dlinkListAlloc(NULL);
			dlinkAppend($$,dlinkNodeAlloc((Generic)symTabIndex));
		}
	       | IdentifierList T_COMMA T_IDENTIFIER
		{
			int symTabIndex = SymIndex(fetchCurrentScope(),$3);
			dlinkAppend($1,dlinkNodeAlloc((Generic)symTabIndex));
			$$ = $1;
		}
	
Type : StandardType
		{
			$$ = $1;
		}
	 | ArrayType
	 	{
			$$ = $1;
	 	}
	 ;

StandardType 	: T_LONGINT
		{
			$$ = INTEGER_TYPE;
		} 
		| T_BOOLEAN
		{
			$$ = INTEGER_TYPE;
		}
		| T_FLOAT
		{
			//$$ = FLOAT_TYPE ;
		}
		;
			
ArrayType : T_ARRAY T_LBRACKET Dim T_RBRACKET T_OF StandardType
		{
			$$ = newArrayType(1, $3.lowerBound, $3.upperBound, 0, 0, $6);	
		}
		| T_ARRAY T_LBRACKET Dim T_COMMA Dim T_RBRACKET T_OF StandardType
		{
			$$ = newArrayType(1, $3.lowerBound, $3.upperBound, $5.lowerBound, $5.upperBound, $8);
		}
	 ;


Dim : IntConst T_DOTDOT IntConst
		{
			$$.lowerBound = $1;
			$$.upperBound = $3;
		}
	;

IntConst : T_MINUS T_INTNUM
		{   
			$$ = -atoi($2); 
		}
        	| T_INTNUM
		{ 
			$$ = atoi($1); 
		}
           ;

Procedures : Procedures ProcedureDecl
	   | 
	   ;

ProcedureDecl : ProcedureHead ProcedureBody
		{
			emitPopCalleeSavedRegisters(instList);
			emitProcedureExit(instList);
			endScope(scopeStack);
		}
       ;

ProcedureHead : FunctionDecl Decls 
		{
			// we push all of the callee-saved registers
			// this also allocates the space for locals that we need
			emitPushCalleeSavedRegisters(instList);
		}
    	;

FunctionDecl : T_FUNCTION T_IDENTIFIER T_COLON StandardType T_SEMICOLON
		{
			emitProcedurePrologue(instList, $2);

			// we open a new scope and reset the local offset to 0
			beginScope(scopeStack);
			localOffset = 0;
		}
   	     ;
	      
ProcedureBody : CompoundStatement T_SEMICOLON
	      ;

Statement : Assignment
		| IfStatement
		| WhileStatement
		| IOStatement 
		| ExitStatement
	  	| CompoundStatement
		;

Assignment : Variable T_ASSIGN Expr
		{ 
			emitAssignment(instList,$1,$3);
		}
		;
 
IfStatement : T_IF TestAndThen T_ELSE Statement
		{
			emitEndBranchTarget(instList,$2);
		}
	    | T_IF TestAndThen
		{
			emitEndBranchTarget(instList,$2);
		}
  	    ;
				
TestAndThen	: Test T_THEN Statement
	    {
		   	$$ = emitThenBranch(instList,$1);
	    }
			;
				
Test : Expr 
		{
			$$ = emitIfTest(instList,$1);
		}
	 ;

WhileStatement : WhileToken WhileExpr T_DO Statement
		{
			emitWhileLoopBackBranch(instList,$1,$2);
		}
                ;
                
WhileExpr : Expr 
		{
			$$ = emitWhileLoopTest(instList,$1);
		}
		  ;
				
WhileToken	: T_WHILE
		{
			$$ = emitWhileLoopLandingPad(instList);
		}
			;


IOStatement : T_READ T_LPAREN Variable T_RPAREN
		{ 
			emitReadVariable(instList,dataList,  $3);
		}
            | WriteToken T_LPAREN Expr OutputFormat T_RPAREN
		{ 
			emitWriteExpression(instList, dataList, $1, $3, $4);
		}
            | WriteToken T_LPAREN T_STRING OutputFormat T_RPAREN      
		{ 
			emitWriteString(instList, dataList, $1, $3, $4);
		}
            ;

OutputFormat : T_COLON T_INTNUM
        	{
		   $$ = $2;
		} |
		{
		   $$ = NULL;
		}
		;

WriteToken : T_WRITE
		{$$ = IS_WRITE;}
	    | T_WRITELN
		{$$ = IS_WRITELN;}
		;
			 
ExitStatement : T_EXIT T_LPAREN Expr T_RPAREN 
		{
			emitReturnStatement(instList, $3);
		}
		;

CompoundStatement : T_BEGIN StatementList T_END
		;
                  
StatementList : StatementList T_SEMICOLON Statement
			  | Statement
              ;

 
Expr	: AddExpr
		{
			$$ = $1; 
		}
                | Expr T_EQ AddExpr
		{
			$$ = emitEqualExpression(instList,$1,$3);
		}
                | Expr T_NE AddExpr
		{
			$$ = emitNotEqualExpression(instList,$1,$3);
		}
                | Expr T_LE AddExpr
		{
			$$ = emitLessEqualExpression(instList,$1,$3);
		}
                | Expr T_LT AddExpr
		{
			$$ = emitLessThanExpression(instList,$1,$3);
		}
                | Expr T_GE AddExpr
		{
			$$ = emitGreaterEqualExpression(instList,$1,$3);
		}
                | Expr T_GT AddExpr
		{
			$$ = emitGreaterThanExpression(instList,$1,$3);
		}
                ;

AddExpr		:  MulExpr            
		{
			$$ = $1; 
		}
		| AddExpr T_OR MulExpr 
		{
			$$ = emitOrExpression(instList,$1,$3);
		}
                |  AddExpr T_PLUS MulExpr
		{
			$$ = emitAddExpression(instList,$1,$3);
		}
                |  AddExpr T_MINUS MulExpr
		{
			$$ = emitSubtractExpression(instList,$1,$3);
		}
                ;

MulExpr		:  Factor
        	{$$ =$1;}
	    	| MulExpr T_TIMES Factor
		{
			$$ = emitMultiplyExpression(instList,$1,$3);
		}
                |  MulExpr T_DIV Factor
		{
			$$ = emitDivideExpression(instList,$1,$3);
		}	
		     | MulExpr T_AND Factor 
		{
			$$ = emitAndExpression(instList,$1,$3);
		}	
                ;
		

Factor          : Variable
		{ 
			$$ = emitLoadVariable(instList, $1);
		}
                | Constant
		{ 
			$$ = $1;
		}
		|  T_NOT Factor
		{
			$$ = emitNotExpression(instList,$2);
		}
		| T_IDENTIFIER T_LPAREN T_RPAREN
		{
		  $$ = emitCallFunction(instList, $1);
		}
		| T_LPAREN Expr T_RPAREN
		{
			$$ = $2;
		}
                ;  

 
Variable        : T_IDENTIFIER
		{
			$$ = emitComputeVariableAddress(instList, $1);
		}
        | T_IDENTIFIER T_LBRACKET Expr T_RBRACKET    
        {
        	$$ = emitComputeArrayAddress(instList, $1 ,$3);
        }
		| T_IDENTIFIER T_LBRACKET Expr T_COMMA Expr T_RBRACKET   
        {
            $$ = emitCompute2DArrayAddress(instList, $1, $3, $5);
        }
        ;			       		       

        		       
Constant        : T_FLOATNUM    
		| T_MINUS T_INTNUM
		{   
			char *negstr = nssave(2, "-", $2);
			$$ = emitLoadIntegerConstant(instList,negstr); 
		}
        	| T_INTNUM
		{ 
			$$ = emitLoadIntegerConstant(instList,$1); 
		}
		| T_TRUE
		{ 
			$$ = emitLoadIntegerConstant(instList,"1"); 
		}
		| T_FALSE
		{ 
			$$ = emitLoadIntegerConstant(instList,"0"); 
		}
                ;

%%


/********************C ROUTINES *********************************/
void yyerror(char *s)
{
  fprintf(stderr,"%s: line %d, found %s: %s\n",fileName,yylineno,yytext,s);
}

int yywrap() {
	return 1;
}


static void initialize(char* inputFileName) {
	yyin = fopen(inputFileName,"r");
        if (yyin == NULL) {
          fprintf(stderr,"Error: Could not open file %s\n",inputFileName);
          exit(-1);
        }

	char* dotChar = rindex(inputFileName,'.');
	int endIndex = strlen(inputFileName) - strlen(dotChar);
	char *outputFileName = nssave(2,substr(inputFileName,0,endIndex),".s");
	stdout = freopen(outputFileName,"w",stdout);
        if (stdout == NULL) {
          fprintf(stderr,"Error: Could not open file %s\n",outputFileName);
          exit(-1);
        }

	
	globalSymtab = SymInit(SYMTABLE_SIZE);
	SymInitField(globalSymtab,SYMTAB_OFFSET_FIELD,(Generic)-1,NULL);
	SymInitField(globalSymtab,SYMTAB_TYPE_INDEX_FIELD,(Generic)-1,NULL);
	initRegisters();

	// define a new SymtabStack for scoping
	scopeStack = symtabStackInit();
	
	instList = dlinkListAlloc(NULL);
	dataList = dlinkListAlloc(NULL);

}

static void finalize() {

    fclose(stdin);
    fclose(stdout);
    
    SymKillField(globalSymtab,SYMTAB_OFFSET_FIELD);
    SymKillField(globalSymtab,SYMTAB_TYPE_INDEX_FIELD);
    SymKill(globalSymtab);
 
    cleanupRegisters();
    
    dlinkFreeNodesAndAtoms(instList);
    dlinkFreeNodesAndAtoms(dataList);

}

int main(int argc, char** argv)

{	
	fileName = argv[1];
	initialize(fileName);
	
	yyparse();
    
	finalize();
  
	return 0;
}
/******************END OF C ROUTINES**********************/
