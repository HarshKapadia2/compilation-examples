#include "main.h"
#include <stdio.h>

#define PRINT_STR(str) printf("%s\n", str)

int main() {
#ifdef MAIN_H
    PRINT_STR(GLOBAL_VAR);
    PRINT_STR(NICE_VAR_69);
#else
    PRINT_STR("Variables not found.");
#endif

    return 0;
}

