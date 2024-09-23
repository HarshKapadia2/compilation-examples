# Compilation Examples

<p align="center">
    <img src="compilation-steps.png" alt="The high level view of the compilation and loading steps of a program." loading="lazy" />
	<br />
    <sub>
        Image source: <a href="https://www.tenouk.com/ModuleW.html" target="_blank" rel="noreferrer">Compiler, Assembler, Linker and Loader: A Brief Story</a>
    </sub>
</p>

Examples to illustrate all the basic steps of compilation

-	Preprocessing
-	Compilation
-	Assembling
-	Linking

Created for [talks.harshkapadia.me/elf](https://talks.harshkapadia.me/elf).

**NOTE**: Starter files are [`main.c`](main.c) and [`main.h`](main.h).

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

## Assembling

Generates machine code from Assembly and stores it in an object file.

Machine code is a sequence of numbers that the CPU can understand and carry out
actions based on.

### Commands

```shell
$ gcc -c main.c
```

Output: [`main.o`](main.o)

The same output can be generated through the following commands:

-	Using GCC with the `main.s` file generated in the previous step

	```shell
	$ gcc -c main.s -o main-s.o
	```

	Output: [`main-s.o`](main-s.o)

-	Using the assembler `as` (GNU Assembler)

	```shell
	$ as main.s -o main-as.o
	```

	Output: [`main-as.o`](main-as.o)

-	Comparing the output of the three object files

	```shell
	$ diff -s main.o main-s.o
	Files main.o and main-s.o are identical

	$ diff -s main-s.o main-as.o
	Files main-s.o and main-as.o are identical

	# If main.o and main-s.o, and main-s.o and main-as.o are identical, then
	# main.o and main-as.o are also identical.
	```

### Examining Object Files

Object (`*.o`) files can be examined using
[parse-elf](https://github.com/HarshKapadia2/parse-elf), `readelf`, `objdump`,
`file`, etc.

Eg:

```shell
$ file main.o
main.o: ELF 64-bit LSB relocatable, x86-64, version 1 (SYSV), not stripped
```

Eg:

```shell
$ readelf --all main.o > main-o-readelf.txt
```

Output: [`main-o-readelf.txt`](main-o-readelf.txt)

The utility `objdump` can be used to disassemble the object file to view how the
machine code translates back to Asssembly.

```shell
$ objdump -d main.o

main.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:
   0:   f3 0f 1e fa             endbr64
   4:   55                      push   %rbp
   5:   48 89 e5                mov    %rsp,%rbp
   8:   48 8b 05 00 00 00 00    mov    0x0(%rip),%rax        # f <main+0xf>
   f:   48 89 c7                mov    %rax,%rdi
  12:   e8 00 00 00 00          call   17 <main+0x17>
  17:   48 8d 05 00 00 00 00    lea    0x0(%rip),%rax        # 1e <main+0x1e>
  1e:   48 89 c7                mov    %rax,%rdi
  21:   e8 00 00 00 00          call   26 <main+0x26>
  26:   b8 00 00 00 00          mov    $0x0,%eax
  2b:   5d                      pop    %rbp
  2c:   c3                      ret
```

As a side note, the machine code instructions consist of an Opcode and
Operand(s). For example, `55` in the above disassembly output is an opcode for
the mnemonic `PUSH` in Assembly, which pushes a register's value onto the stack.
An opcode is an operation that the CPU can understand and execute. What an
opcode represents is dependent on the Instruction Set Architecture (ISA) of the
processor and is usually very well documented. (Eg: Vol. 2A of the [Intel 64 and IA-32 Architectures Software Developer Manuals](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html))

[More information on opcodes, mnemonics, machine code, etc.](https://stackoverflow.com/questions/17638888/difference-between-opcode-byte-code-mnemonics-machine-code-and-assembly)

## Linking

This is the last step in compilation that takes contents from several object
files and/or libraries and combines them into one executable. References to
extenal symbols are resolved.

### Commands

```shell
$ gcc main.c
```

Output: [`a.out`](a.out)

The default file name for the executable `a.out` is an abbreviation for
'assembler output'.

Running the output file

```shell
$ ./a.out
This is the 'GLOBAL_VAR'.
69
```

The output file is an executable ELF file.

```shell
$ file a.out
a.out: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=d3f6d6241d69c2e0de9d136fb09190d9175f5171, for GNU/Linux 3.2.0, not stripped
```

GNU's Linker (`ld`) can also be used to link files.

```shell
ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 /usr/lib/x86_64-linux-gnu/Scrt1.o /usr/lib/x86_64-linux-gnu/crti.o /usr/lib/gcc/x86_64-linux-gnu/11/crtbeginS.o -lc main.o /usr/lib/gcc/x86_64-linux-gnu/11/crtendS.o /usr/lib/x86_64-linux-gnu/crtn.o -o a-ld.out
```

Output: [`a-ld.out`](a-ld.out)

All the extra files apart from `main.o` in the `ld` command are to set up the
`_start`, 'init' and 'fini' symbols and functions, which bootstrap the program
by helping set up important registers for the program.

[More information on the `crtxxx.o` files.](https://dev.gentoo.org/%7Evapier/crt.txt) (The letters `crt` are an abbreviation for 'C RunTime'.)

Running the output file

```shell
$ ./a-ld.out
This is the 'GLOBAL_VAR'.
69
```

### Examining Executable Files

Executable files are ELF files that can be examined similar to Object files, as
shown above in the ['Examining Object Files' section](#examining-object-files).

```shell
$ file a.out
a.out: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=c070be8a9201dd54b100277176bed8c1b6d68ffe, for GNU/Linux 3.2.0, not stripped
```

In the ['Examining Object Files' section](#examining-object-files) above, the
`main.o` file was disassembled. Let us check if disassembling the fully compiled
executable `a.out` yields a different disassembled `main` function.

```shell
$ objdump -d a.out
# ...

0000000000001149 <main>:
    1149:       f3 0f 1e fa             endbr64
    114d:       55                      push   %rbp
    114e:       48 89 e5                mov    %rsp,%rbp
    1151:       48 8b 05 b8 2e 00 00    mov    0x2eb8(%rip),%rax        # 4010 <GLOBAL_VAR>
    1158:       48 89 c7                mov    %rax,%rdi
    115b:       e8 f0 fe ff ff          call   1050 <puts@plt>
    1160:       48 8d 05 b7 0e 00 00    lea    0xeb7(%rip),%rax        # 201e <_IO_stdin_used+0x1e>
    1167:       48 89 c7                mov    %rax,%rdi
    116a:       e8 e1 fe ff ff          call   1050 <puts@plt>
    116f:       b8 00 00 00 00          mov    $0x0,%eax
    1174:       5d                      pop    %rbp
    1175:       c3                      ret

# ...
```

The opcodes in the instructions are unchanged, but there is a difference between
the addresses in the operands. This fully compiled version knows the location
(address) of the library functions and variables required to run the program,
unlike the disassembled output of the object file `main.o`.

Some of the changes:

```shell
# main.o
           8:   48 8b 05 00 00 00 00    mov    0x0(%rip),%rax        # f <main+0xf>
# a.out
    1151:       48 8b 05 b8 2e 00 00    mov    0x2eb8(%rip),%rax        # 4010 <GLOBAL_VAR>

# ----------------

# main.o
          12:   e8 00 00 00 00          call   17 <main+0x17>
# a.out
    115b:       e8 f0 fe ff ff          call   1050 <puts@plt>
```

### Static and Dynamic Linking

Static linking includes library functions and variables into the main
executable, thus making the executable independent of any runtime dependepcies,
but increasing the size of the executable.

A dynamically linked execuatble includes references to functions and variables
that are resolved at runtime or load time. This reduces the executable's size
and makes it easy to update the library without updating the executable, but
makes the executable vulnerable to breaking library changes and buggy library
updates.

Generating statically and dynamically linked binaries/executables
```shell
# Generating a statically linked executable
$ gcc -static main.c -o a-static.out

# Generating a dynamically linked executable (this is the default)
$ gcc main.c     # Output file is 'a.out'
```

Checking the `file` command outputs

```shell
# Note 'statically linked' in the output
$ file a-static.out
a-static.out: ELF 64-bit LSB executable, x86-64, version 1 (GNU/Linux), statically linked, BuildID[sha1]=7d33ef89855ee508d79b4293e3489c860910abad, for GNU/Linux 3.2.0, not stripped

# Note 'dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2' in the output
$ file a.out
a.out: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=c070be8a9201dd54b100277176bed8c1b6d68ffe, for GNU/Linux 3.2.0, not stripped
```

Checking the `ldd` command output to check for dynamic library dependencies

```shell
# Statically linked binary does not have any dynamic dependencies
$ ldd a-static.out
        not a dynamic executable

# Dynamically linked binary has dynamic libraries that it depends on
$ ldd a.out
        linux-vdso.so.1 (0x00007ffe79d1f000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007bcd55000000)
        /lib64/ld-linux-x86-64.so.2 (0x00007bcd553ba000)
```

Checking the size of the two binaries

```shell
# Large size of the static binary!
$ size a-static.out
   text    data     bss     dec     hex filename
 781885   23240   23016  828141   ca2ed a-static.out

# Dynamically linked binary is smaller in size than the statically linked binary
$ size a.out
   text    data     bss     dec     hex filename
   1430     608       8    2046     7fe a.out
```

Dynamic linking can be of two types:
-	Load-time Dynamic Linking
	-	Shared libraries and symbols are resolved by the Loader when the program
		is loaded into memory to be executed.
-	Run-time Dynamic Linking
	-	References to functions and variables are left unresolved.
	-	When a function or variable is referenced, an exception is raised, which
		is when the required entity is loaded and resolved.

## Resources

-	General
	-	[Compiler, Assembler, Linker and Loader: A Brief Story](https://www.tenouk.com/ModuleW.html)
	-	[How does the compilation/linking process work?](https://stackoverflow.com/questions/6264249/how-does-the-compilation-linking-process-work)
	-	[Compiler, Linker, Assembler, and Loader](https://www.baeldung.com/cs/compiler-linker-assembler-loaderhttps://www.baeldung.com/cs/compiler-linker-assembler-loader)
	-	[Running gcc's steps manually, compiling, assembling, linking](https://stackoverflow.com/questions/8527743/running-gccs-steps-manually-compiling-assembling-linking)
-	Preprocessing
	-	[Running gcc's steps manually, compiling, assembling, linking](https://stackoverflow.com/questions/8527743/running-gccs-steps-manually-compiling-assembling-linking)
	-	[How to view C preprocessor output?](https://stackoverflow.com/questions/3742822/how-to-view-c-preprocessor-output)
	-	[[Interpreting] Preprocessor Output](https://gcc.gnu.org/onlinedocs/cpp/Preprocessor-Output.html)
-	Assemling
	-	[Running gcc's steps manually, compiling, assembling, linking](https://stackoverflow.com/questions/8527743/running-gccs-steps-manually-compiling-assembling-linking)
	-	[Difference between: Opcode, byte code, mnemonics, machine code and assembly](https://stackoverflow.com/questions/17638888/difference-between-opcode-byte-code-mnemonics-machine-code-and-assembly)
	-	[Intel 64 and IA-32 Architectures Software Developer Manuals](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html)
	-	[x86 and amd64 instruction reference](https://www.felixcloutier.com/x86)
	-	[X86 Opcode and Instruction Reference](https://ref.x86asm.net)
-	Linking
	-	[Running gcc's steps manually, compiling, assembling, linking](https://stackoverflow.com/questions/8527743/running-gccs-steps-manually-compiling-assembling-linking)
	-	[How to link a gas assembly program that uses the C standard library with ld without using gcc?](https://stackoverflow.com/questions/3577922/how-to-link-a-gas-assembly-program-that-uses-the-c-standard-library-with-ld-with)
	-	[More information on the `crtxxx.o` files.](https://dev.gentoo.org/%7Evapier/crt.txt)
	-	[How to write and execute PURE machine code manually without containers like EXE or ELF?](https://stackoverflow.com/a/58489219/11958552)
	-	[How does a linker know what all libraries to link?](https://stackoverflow.com/questions/9248533/how-does-a-linker-know-what-all-libraries-to-link)
	-	[What do 'statically linked' and 'dynamically linked' mean?](https://stackoverflow.com/questions/311882/what-do-statically-linked-and-dynamically-linked-mean)

