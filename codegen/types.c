/*
 * types.c
 *
 *  Created on: Jul 13, 2009
 *      Author: carr, wang
 */

#include <string.h>
#include <codegen/types.h>
#include <codegen/reg.h>
#include <util/symtab.h>
#include <codegen/symfields.h>

typedef struct array_type {
  int elementType;
  int dim[2][2];
  int dimension;
  int numElements;
} Array_Type_Info;

int typeid = COMPOSITE_TYPE;
Array_Type_Info arrayTypeTable[NUM_ARRAY_TYPES];


/**
 * Return true if a type is an array, false otherwise.
 *
 * @param typeId id for a type
 * @return see above
 */
bool isArrayType(int typeId) {
  return (bool)(typeId >= COMPOSITE_TYPE);
}

/**
 * Return true if a type is an array, false otherwise.
 *
 * @param dimension number of dimensions
 * @param low1 lower bound of 1st dimension
 * @param high1 lower bound of 1st dimension
 * @param low2 lower bound of 2nd dimension
 * @param high2 lower bound of 2nd dimension
 * @param elementType element typeid
 * @return see above
 */
int newArrayType(int dimension, int low1, int high1, int low2, int high2, int elementType)
{
   int tid;

   tid = typeid++;
   arrayTypeTable[tid].numElements = (high1-low1+1)*(high2-low2+1);;
   arrayTypeTable[tid].dimension = dimension;
   arrayTypeTable[tid].elementType = elementType;
   arrayTypeTable[tid].dim[0][0] = low1;
   arrayTypeTable[tid].dim[0][1] = high1;
   arrayTypeTable[tid].dim[1][0] = low2;
   arrayTypeTable[tid].dim[1][1] = high2;
   return tid;   
}  

/**
 * Set element type of an array type.
 *
 * @param typeId type id for an array type
 * @param elementTypeId type id of element type
 */
void setArrayElementType(int typeId, int elementTypeId)
{
    arrayTypeTable[typeId].elementType = elementTypeId; 
}

/**
 * Return element type of an array type.
 *
 * @param typeId type id for an array type
 * @return  type id of element type
 */
int getArrayElementType(int typeId)
{
    return arrayTypeTable[typeId].elementType; 
}

/**
 * Return element type of an array type.
 *
 * @param typeId type id for an array type
 * @return  type id of element type
 */
int getTypeSize(int typeId)
{
  if (typeId == INTEGER_TYPE)
    return INTEGER_SIZE;
  else {// array type
    return arrayTypeTable[typeId].numElements * getTypeSize(arrayTypeTable[typeId].elementType);
  }
}

/**
 * Return the second dimensoon size of a 2-d array.
 *
 * @param typeId type id for an array type
 * @return  see above
 */
int get2ndDimensionSize(int typeId)
{
  return arrayTypeTable[typeId].dim[1][1]-arrayTypeTable[typeId].dim[1][0]+1;
}

/**
 * Return the 1st dimensoon size of a 2-d array.
 *
 * @param typeId type id for an array type
 * @return  see above
 */
int get1stDimensionbase(int typeId)
{
  return arrayTypeTable[typeId].dim[0][0];
}

/**
 * Return the base of the second dimensoon of a 2-d array.
 *
 * @param typeId type id for an array type
 * @return  see above
 */
int get2ndDimensionbase(int typeId)
{
  return arrayTypeTable[typeId].dim[1][0];
}
