# Y86 processor

## For the assembler

```bash
make Y86asm
./Y86asm <input file> <output file(optional)> 
```
	Input ys file will get turned into an executable binary readable by the processor
	
## Sample assembly code

A simple test program
```asm
.pos 0x100			# Start code at address 0x100
	irmovl $15, %ebx	#     Load 15 into %ebx
	rrmovl %ebx, %ecx	#     Copy 15 to %ecx
loop:				# loop:
	rmmovl %ecx, -3(%ebx)	#     Save %ecx at address 15-3 = 12
	addl   %ebx, %ecx	#     Increment %ecx by 15
	jmp loop		#     Goto loop
```

And another.....
```asm
	irmovl mem,%ebx
	mrmovl 0(%ebx), %esp
	ret
	halt
rtnpt:	irmovl $5,%esi
	halt
.pos 0x40
mem:	.long stack
.pos 0x50
stack:	.long rtnpt
```

Program for summing an array with a function
```asm
# Execution begins at address 0
	.pos 0
init:	irmovl Stack,%esp	# Set up stack pointer
	irmovl Stack,%ebp	# Set up base pointer
	call Main
	halt

# Array of 4 elements
	.align 4
array:	.long 0xd
	.long 0xc0
	.long 0xb00
	.long 0xa000

Main:	pushl %ebp
	rrmovl %esp,%ebp
	irmovl $4,%eax
	pushl %eax		# Push 4
	irmovl array,%edx
	pushl %edx		# Push array
	call Sum		# Sum(array, 4)
	rrmovl %ebp,%esp
	popl %ebp
	ret

	# int Sum(int *Start, int Count)
Sum:	pushl %ebp
	rrmovl %esp,%ebp
	mrmovl 8(%ebp),%ecx	# ecx = Start
	mrmovl 12(%ebp),%edx	# edx = Count
	xorl %eax,%eax		# sum = 0
	andl %edx,%edx		# Set condition codes
	je	End
Loop:	mrmovl (%ecx),%esi	# get *Start
	addl %esi,%eax		# add to sum
	irmovl $4,%ebx		#
	addl %ebx,%ecx		# Start++
	irmovl $-1,%ebx		#
	addl %ebx,%edx		# Count--
	jne	Loop		# Stop when 0
End:	rrmovl %ebp,%esp
	popl %ebp
	ret

# The stack starts here and grows to lower addresses
	.pos 0x100
Stack:
```
which gets assembled into
```
 30 f4 0001 0000 
 30 f5 0001 0000 
 80   24 0000 00
 00 0000
 0d00 0000 
 c000 0000 
 000b 0000 
 00a0 0000 
 a0 5f 
 20 45 
 30 f0 0400 0000 
 a0 0f  
 30 f2 1400 0000 
 a0 2f 
 80 42 0000 00
 20 54
 b0 5f
 90 
 a0
 5f
 20 45 
 50 15 0800 0000 
 50 25 0c00 0000 
 63 00 
 62 22 
 73 78 0000 00
 50 61 00 0000 00
 60 60
 30 f3 04 0000 00 
 60 31
 30 f3 ff ffff ff
 60 32
 74 5b00 0000 
 20 54 
 b0 5f 
 90         
```

I took this sample Y86 asm code from some online pdf that I can no longer find, but it serves very useful as it tests almost all the instructions that the processor supports
