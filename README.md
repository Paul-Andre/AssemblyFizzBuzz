# AssemblyFizzBuzz
Because why not

Assembly and link instructions for x86 linux:
```bash
nasm -felf FizzBuzz.asm
ld -o FizzBuzz FizzBuzz.o
```

For x64 (arm64) linux:
```bash
nasm -felf32 FizzBuzz.asm
ld -o FizzBuzz -melf_i386 FizzBuzz.o
```
