main.c:2:19: error: no include path in which to search for stdio.h
    2 | #include <stdio.h>
      |                   ^
# 0 "main.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "main.c"
# 1 "main.h" 1



const char *GLOBAL_VAR = "This is the 'GLOBAL_VAR'.";
# 2 "main.c" 2




int main() {

    printf("%s\n", GLOBAL_VAR);




    return 0;
}
