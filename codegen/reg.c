/**
 * reg.c
 *
 * A set of routines to handle the allocation of registers in the Cminus Compiler
 *
 */

#include <stdlib.h>
#include <stdio.h>
#include <util/general.h>
#include <string.h>
#include "reg.h"

/**
 * The assembly language names of the X86-64 registers
 */
static char* integerRegisterNames[] = {"%ebx","%ecx", 
				       "%r8d", "%r9d", "%r10d", "%r11d", "%r12d", "%r13d", "%r14d", "%r15d",
				       "bogus"};
static char* integer64bitRegisterNames[] = {"%rbx","%rcx",
					    "%r8", "%r9", "%r10", "%r11", "%r12", "%r13", "%r14", "%r15",
				       "bogus"};
static bool *allocatedIntegerRegisters; /**< vector of bools indicated whether register is allocated or not */

int calleeSavedRegisters[NUM_CALLEE_SAVED] = {EBX, R12D, R13D, R14D, R15D};
int callerSavedRegisters[NUM_CALLER_SAVED] = {ECX, R8D, R9D, R10D, R11D};

/**
 * Initialize the allocated registers vector
 */
void initRegisters() {
	int i;

	allocatedIntegerRegisters = (bool*)malloc(NUM_INTEGER_REGISTERS*sizeof(bool));
	for (i = 0; i < NUM_INTEGER_REGISTERS; i++)
		allocatedIntegerRegisters[i] = false;
}

/**
 * Return the next free register, return -1 if none available (shouldn't happen in the simple examples)
 *
 * @param allocRegisters the vector indicating which registers are allocated.
 * @param numRegisters number of allocable registers 
 * @return see above
 */
static int getFreeRegister(bool *allocRegisters, int numRegisters) {
	int i;
	
	for (i = 0; i < numRegisters; i++) 
		if (!allocRegisters[i])
			return i;
 	
	return -1;
}

/**
 * Allocate a free  register. Set the allocated vector entry to true. Fail if none available
 *
 * @param allocRegisters the vector indicating which registers are allocated.
 * @param numRegisters number of allocable registers 
 * @return the register that has been allocated
 */
static int allocateRegister(bool *allocatedRegisters,int numRegisters) {	
	int reg = getFreeRegister(allocatedRegisters,numRegisters);
	
	if (reg != -1)
		allocatedRegisters[reg] = true;
	else {
		fprintf(stderr,"Register allocation error\n");
		exit(-1);
	}
	
	return reg;
}

/**
 * Allocate a free integer register.
 *
 * @return the register that has been allocated
 */
int allocateIntegerRegister() {
	return allocateRegister(allocatedIntegerRegisters,NUM_INTEGER_REGISTERS);
}

/**
 * Reserve a specific integer Register
 *
 * @param reg register id to reserve
 */
void reserveIntegerRegister(int reg) {
    allocatedIntegerRegisters[reg] = true;
}
 
/**
 * Free the space for the allocated vector.
 */
void cleanupRegisters() {
	free(allocatedIntegerRegisters);
}

/**
 * Free a register by setting is entry in the allocated vector to false.
 *
 * @param reg the register to free
 */
static void freeRegister(bool *allocatedRegisters, int reg, int size) {
	if (reg >= 0 && reg < size)
		allocatedRegisters[reg] = false;
	else
		fprintf(stderr,"Error trying to free invalid register #%d\n",reg);
}

/**
 * Free an integer register by setting is entry in the allocated vector to false.
 *
 * @param reg the register to free
 */
void freeIntegerRegister(int reg) {
	freeRegister(allocatedIntegerRegisters,reg,NUM_INTEGER_REGISTERS);
}

/**
 * Return the X86-64 assembler name for a register.
 *
 * @param reg a x86-64 register number
 * @return see above
 */
char* getIntegerRegisterName(int reg) {
	return integerRegisterNames[reg];
}

/**
 * Return the X86-64 assembler name for a register.
 *
 * @param reg a x86-64 register number
 * @return see above
 */
char* get64bitIntegerRegisterName(int reg) {
  return integer64bitRegisterNames[reg];
}

bool isAllocatedIntegerRegister(int reg) {
	return allocatedIntegerRegisters[reg];
}
