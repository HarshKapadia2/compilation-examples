# Compilation Examples

Examples to illustrate all the basic steps of compilation

-	Preprocessing
-	Compilation
-	Assembling
-	Linking

Created for [talks.harshkapadia.me/elf](https://talks.harshkapadia.me/elf).

NOTE: Starter files are [`main.c`](main.c) and [`main.h`](main.h).

## Preprocessing

The preprocessor substitutes macros, includes and conditional compilation
instructions with code.

### Commands

-	Normal preprocessing

	```shell
	$ gcc -E main.c > main.i
	```

	Output: [`main.i`](main.i)

-	Preprocessing without standard includes

	```shell
	$ gcc -E -nostdinc main.c > main-nostdinc.i 2>&1
	```

	Output: [`main-nostdinc.i`](main-nostdinc.i)

## Compilation

Processes source code to convert it to Assembly that the Assembler can
understand.

If dealing with GCC, then using the command below directly on the source code or
on the preprocessed code yields the same output.

### Commands

```shell
$ gcc -S main.c
```

Output: [`main.s`](main.s)

Even if the preprocessed file generated in the Prepreocessing step
([`main.i`](main.i)) is used, the same output as the above command can be
expected. This can be verified:

-	After running the above command, run

	```shell
	$ gcc -S main.i -o main-preproc.s
	```

	Output: [`main-preproc.s`](main-preproc.s)

-	Now, to verify the differences between the output files `main.s` and
	`main-preproc.s`:

	```shell
	$ diff -s main.s main-preproc.s
	Files main.s and main-preproc.s are identical
	```

## Resources

-	[Running gcc's steps manually, compiling, assembling, linking](https://stackoverflow.com/questions/8527743/running-gccs-steps-manually-compiling-assembling-linking)
-	[How to view C preprocessor output?](https://stackoverflow.com/questions/3742822/how-to-view-c-preprocessor-output)
-	[[Interpreting] Preprocessor Output](https://gcc.gnu.org/onlinedocs/cpp/Preprocessor-Output.html)
-	[Running gcc's steps manually, compiling, assembling, linking](https://stackoverflow.com/questions/8527743/running-gccs-steps-manually-compiling-assembling-linking)

