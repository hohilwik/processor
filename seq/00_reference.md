## Sequential

# 1_fetch

-reads instructions. "icode" is high nibble of first byte, ie, left half, "ifun" is low nibble, ie, right half, in terms of bits.
-possibly fetches a register specifier byte
-possibly fetches a 64-bit valC
-computes valP which is PC+(size of instruction fetched)

# 2_decode

-reads up to two registers, valA and valB
-sometimes reads %esp

# 3_execute

-performs the specified operation as decoded, according to ifun as switch case
-OR computes address of a memory reference
-OR increments/decrements a stack pointer

-resulting value is valE

-condition codes might be set
-jump instruction tests condition given by ifun to decide which branch to take

# 4_memory

-can read/write to memory
-read value is valM

# 5_write_back

-writes up to two registers

# 6_pc_update

-PC is set to the address of the next instruction

# 0_wrapper

-to abstract out all this


----------------------------------------------------

## Pipelining Considerations

-regF to hold predicted value of PC
-regD to hold info about fetched instruction, before decode stage
-regE to hold info about decoded instriction, before execute stage
-regM to hold result of execution, before memory stage
-regW to hold result for write_back, or ret address

-D_stat to hold status of regD
-E_stat to hold status of regE
-M_stat to hold status of regM

## Instructions to support

### Basic
	halt
	nop
### XXmov (memory operations)
	rrmovq
	irmovq
	rmmovq
	mrmovq
### OPl (integer operation)
    addq
    subq
    andq
    xorq
### jXXX (branch condition)
    jmp
    jle
    jl
    je
    jne
    jge
    jg
### cmovXX (data transfer condition)
    cmovle
    cmovq
    cmove
    cmovne
    cmovge
    cmovg
### Basic stack and PC operations
	call
	ret
	pushq
	popq



