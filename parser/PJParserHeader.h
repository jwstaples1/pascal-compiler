#ifndef _PASCALPARSERHEDER_H_
#define _PASCALPARSERHEDER_H_
#include <util/dlink.h>

typedef struct dim_struct {
        int lowerBound;    /**< the lower bound of an array dimension */
        int upperBound;    /**< the upper bound of an array dimension */
} ArrayBounds;

#endif
