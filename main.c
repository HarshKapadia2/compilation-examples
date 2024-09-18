#include "main.h"
#include <stdio.h>

#define PRINT_STR(str) printf("%s\n", str)

int main() {
#ifdef MAIN_H
    PRINT_STR(GLOBAL_VAR);
#else
    PRINT_STR("'GLOBAL_VAR' not found.");
#endif

    return 0;
}

