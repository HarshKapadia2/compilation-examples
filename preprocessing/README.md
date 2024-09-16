# Preprocessing

## Commands

- Normal preprocessing

	```shell
	$ gcc -E preprocessing.c
	```

- Preprocessing without standard includes

	```shell
	$ gcc -E -nostdinc preprocessing.c
	```

## Sample Output

```shell
$ gcc -E -nostdinc preprocessing.c
# 0 "preprocessing.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "preprocessing.c"
# 1 "preprocessing.h" 1



const char *GLOBAL_VAR = "This is the 'GLOBAL_VAR'.";
# 2 "preprocessing.c" 2
preprocessing.c:2:19: error: no include path in which to search for stdio.h
    2 | #include <stdio.h>
      |                   ^




int main() {

    printf("%s\n", GLOBAL_VAR);




    return 0;
}
```

## Resources

- [Running gcc's steps manually, compiling, assembling, linking](https://stackoverflow.com/questions/8527743/running-gccs-steps-manually-compiling-assembling-linking)
- [How to view C preprocessor output?](https://stackoverflow.com/questions/3742822/how-to-view-c-preprocessor-output)
- [[Interpreting] Preprocessor Output](https://gcc.gnu.org/onlinedocs/cpp/Preprocessor-Output.html)

