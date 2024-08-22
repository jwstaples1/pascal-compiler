#ifndef REG_H_
#define REG_H_

#define NUM_INTEGER_REGISTERS 10 /**< the number of x86 integer registers that may be allocated */
#define NUM_CALLEE_SAVED 5  /**< the number of x86 integer registers that are callee saved */
#define NUM_CALLER_SAVED 5  /**< the number of x86 integer registers that are caller saved */      
#define EBX 0
#define ECX 1
#define R8D 2
#define R9D 3
#define R10D 4
#define R11D 5
#define R12D 6
#define R13D 7
#define R14D 8
#define R15D 9

/*The following registers are reserved for special purposes: I/O and division*/
#define EAX  10
#define EDX  11
#define ESI  12
#define EDI  13

EXTERN(void, initRegisters, (void));
EXTERN(void, cleanupRegisters, (void));
EXTERN(int, allocateIntegerRegister, (void));
EXTERN(void, freeIntegerRegister, (int reg));
EXTERN(char*, getIntegerRegisterName, (int reg));
EXTERN(void, reserveIntegerRegister, (int reg));
EXTERN(char*, get64bitIntegerRegisterName, (int reg));
EXTERN(bool, isAllocatedIntegerRegister, (int reg));

#endif /*REG_H_*/
