#include "preprocessing.h"
#include <stdio.h>

#define PRINT_STR(str) printf("%s\n", str)

int main() {
#ifdef PREPROCESSING_H
    PRINT_STR(GLOBAL_VAR);
#else
    PRINT_STR("'GLOBAL_VAR' not found.");
#endif

    return 0;
}

