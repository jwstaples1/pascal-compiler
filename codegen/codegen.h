#ifndef CODEGEN_H_
#define CODEGEN_H_
                         
EXTERN(void, emitProcedurePrologue, (DList instList, char* name));
EXTERN(void, emitProcedureExit, (DList instList));
EXTERN(void, emitDataPrologue, (DList dataList));
EXTERN(void, emitInstructions,(DList list));
EXTERN(void, emitAssignment, (DList instList, int lhsRegIndex, int rhsRegIndex));
EXTERN(void, emitReadVariable, (DList instList, DList dataList, int addrIndex));
EXTERN(void, emitWriteExpression, (DList instList, DList dataList, int writeType, int regIndex, char *length));
EXTERN(void, emitWriteString,(DList instList,  DList dataList, int writeType, char *str, char *length));

EXTERN(int, emitOrExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitAndExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitNotExpression, (DList instList, int operand));
EXTERN(int, emitEqualExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitNotEqualExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitLessEqualExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitLessThanExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitGreaterEqualExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitGreaterThanExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitAddExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitSubtractExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitMultiplyExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitDivideExpression, (DList instList, int leftOperand, int rightOperand));

EXTERN(int, emitIfTest, (DList instList, int regIndex));
EXTERN(void, emitEndBranchTarget, (DList instList, int endLabelIndex));
EXTERN(int, emitThenBranch, (DList instList, int elseLabelIndex));
EXTERN(int, emitWhileLoopLandingPad, (DList instList));
EXTERN(int, emitWhileLoopTest, (DList instList, int regIndex));
EXTERN(void, emitWhileLoopBackBranch,(DList instList, int beginLabelIndex, int endLabelIndex));

EXTERN(int, emitComputeVariableAddress,(DList instList, char *variableName));
EXTERN(int, emitComputeArrayAddress, (DList instList, char *variableName, int subIndex));
EXTERN(int, emitCompute2DArrayAddress, (DList instList, char *variableName, int subIndex1, int subIndex2));

EXTERN(int, emitLoadVariable,(DList instList, int varIndex));
EXTERN(int, emitLoadIntegerConstant,(DList instList, char* intConst));

EXTERN(void, addIdToSymtab, (DNode node, Generic gtypeid));
EXTERN(SymTable, fetchCurrentScope, ());

EXTERN(int, emitCallFunction, (DList instList, char *functionName));

EXTERN(void, emitPushCalleeSavedRegisters, (DList instList));
EXTERN(void, emitPopCalleeSavedRegisters, (DList instList));
EXTERN(void, emitPushCallerSavedRegisters, (DList instList));
EXTERN(void, emitPopCallerSavedRegisters, (DList instList));

EXTERN(void, emitReturnStatement, (DList instList, int registerId));

EXTERN(void,yyerror,(char*));

#define IS_WRITE 0
#define IS_WRITELN 1
#endif /*CODEGEN_H_*/

