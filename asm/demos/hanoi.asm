.include beta.uasm

| Constant and name definition(s)
BLUE   = 0b0000000000001111
WHITE  = 0b0000111111111111
zero   = R31
stack0 = R1
stack1 = R2
stack2 = R3

| Lib include(s)
BR(main)
.include gpu_utils.asm
.include stack.asm

| Draws a tower of hanoi at blk_center
|
| @param s0 address of stack
| @param blk_center center block x position
| void draw_hanoi(s0, blk_center)
draw_hanoi:
    init_draw_hanoi: 
        PUSH(LP) PUSH(BP)
        MOVE(SP, BP)
        PUSH(R1) PUSH(R2) PUSH(R3) PUSH(R4)
        PUSH(R5) PUSH(R6)
        LD(BP, -12, R1) LD(BP, -16, R2)
    func_draw_hanoi: 
        PUSH(R1)                                | Calls stack_is_empty
        CALL(stack_is_empty, 1) 
        BEQ(R0, not_empty_draw_hanoi)
    empty_draw_hanoi:
        CMOVE(54, R3)                           | y = 54
        CMOVE(6, R4)                            | n = 6
        BR(loop_init_draw_hanoi)                | Draw line
    not_empty_draw_hanoi:
        CMOVE(54, R3)                           | y = 54
        PUSH(R1)                                | Calls stack_peek_top
        CALL(stack_peek_top, 1)
        MOVE(R0, R4)                            | n = peek_top
        PUSH(R1)                                | Calls stack_size
        CALL(stack_size, 1)
        SUB(R3, R0, R3)                         | y = y - stack_size   
    loop_init_draw_hanoi:
        SUB(R2, R4, R5)                         | x  = center - n
        ADD(R2, R4, R6)                         | xf = center + n
        ADDC(R6, 1, R6)                         | xf = xf + 1
    loop_draw_hanoi:
        PUSH(zero) PUSH(zero) PUSH(R3) PUSH(R5) | Calls draw on (x, y)
        CMOVE(BLUE, R0)    PUSH(R0)
        CMOVE(WHITE, R0)   PUSH(R0)
        PUSH(zero)
        CALL(gpu_draw, 7)
        PUSH(zero) PUSH(zero)                   | Calls clear on (x, y-1)
        SUBC(R3, 1, R0) PUSH(R0)
        PUSH(R5)
        CALL(gpu_clear, 4)
        ADDC(R5, 1, R5)                         | x = x + 1
        CMPEQ(R5, R6, R0)                       | x == xf ?
        BEQ(R0, loop_draw_hanoi)
    exit_draw_hanoi: 
        POP(R6) POP(R5) POP(R4) POP(R3) 
        POP(R2) POP(R1)
        POP(BP) POP(LP)
        RTN()

| Hanoi algorithm - recursive version 
|
| @param n_disks number of used disks (must be 5 for the first call)
| @param s0 address of first stack
| @param s1 address of second stack
| @param s2 address of third stack
| @param from address of stack "from"
| @param to address of stack "to"
| @param static address of "static" stack
| void hanoi(n_disks, s0, s1, s2, from, to, static)
hanoi:
    init_hanoi:
        PUSH(LP) PUSH(BP)
        MOVE(SP, BP)
        PUSH(R1) PUSH(R2) PUSH(R3) PUSH(R4)
        PUSH(R5) PUSH(R6) PUSH(R7)
        LD(BP, -12, R1) LD(BP, -16, R2)
        LD(BP, -20, R3) LD(BP, -24, R4)
        LD(BP, -28, R5) LD(BP, -32, R6)
        LD(BP, -36, R7)
    func_hanoi:
        BEQ(R1, exit_hanoi)                  | Don't do anything if n_disks == 0
        SUBC(R1, 1, R1)                      | Decrements number of disks

        PUSH(R6) PUSH(R7) PUSH(R5) PUSH(R4)  | Call hanoi with n-1
        PUSH(R3) PUSH(R2) PUSH(R1)
        CALL(hanoi, 7)

        PUSH(R5)                             | Call stack_pop on "from"
        CALL(stack_pop, 1)

        PUSH(R0) PUSH(R6)                    | Call stack_push on "to"
        CALL(stack_push, 2)

        CMOVE(14, R0) PUSH(R0)               | Call draw_hanoi for s0
        PUSH(R2)
        CALL(draw_hanoi, 2)
        CMOVE(35, R0) PUSH(R0)               | Call draw_hanoi for s1
        PUSH(R3)
        CALL(draw_hanoi, 2)
        CMOVE(56, R0) PUSH(R0)               | Call draw_hanoi for s2
        PUSH(R4)
        CALL(draw_hanoi, 2)

        wait_init_hanoi:
            CMOVE(1000, R0)                        | Sets tmp
            MULC(R0, 2000, R0)                     | tmp = 2x10E6
        wait_hanoi:   
            SUBC(R0, 1, R0)                        | Decrements tmp
            BNE(R0, wait_hanoi)                    | Wait...

        PUSH(R5) PUSH(R6) PUSH(R7) PUSH(R4)  | Call hanoi with n-1
        PUSH(R3) PUSH(R2) PUSH(R1)
        CALL(hanoi, 7)
    exit_hanoi:
        POP(R7) POP(R6) POP(R5) POP(R4) 
        POP(R3) POP(R2) POP(R1)
        POP(BP) POP(LP)
        RTN()

main:
    | Stacks setup
    ALLOCATE(21)               | Allocates memory for the stacks

    CMOVE(0, stack0)           | stack0 = 0
    PUSH(stack0)               | calls stack_init for stack0
    CALL(stack_init, 1)        

    CMOVE(28, stack1)           | stack1 = 28
    PUSH(stack1)               | calls stack_init for stack1
    CALL(stack_init, 1) 

    CMOVE(56, stack2)          | stack2 = 56
    PUSH(stack2)               | calls stack_init for stack2
    CALL(stack_init, 1) 

    CALL(gpu_clear_all)        | Clears all the graphical memory

    | Filling stack0 and drawing it

    CMOVE(6, R0) PUSH(R0)
    PUSH(stack0)
    CALL(stack_push, 2)
    CMOVE(14, R0) PUSH(R0)
    PUSH(stack0)
    CALL(draw_hanoi, 2)

    CMOVE(5, R0) PUSH(R0)
    PUSH(stack0)
    CALL(stack_push, 2)
    CMOVE(14, R0) PUSH(R0)
    PUSH(stack0)
    CALL(draw_hanoi, 2)

    CMOVE(4, R0) PUSH(R0)
    PUSH(stack0)
    CALL(stack_push, 2)
    CMOVE(14, R0) PUSH(R0)
    PUSH(stack0)
    CALL(draw_hanoi, 2)

    CMOVE(3, R0) PUSH(R0)
    PUSH(stack0)
    CALL(stack_push, 2)
    CMOVE(14, R0) PUSH(R0)
    PUSH(stack0)
    CALL(draw_hanoi, 2)

    CMOVE(2, R0) PUSH(R0)
    PUSH(stack0)
    CALL(stack_push, 2)
    CMOVE(14, R0) PUSH(R0)
    PUSH(stack0)
    CALL(draw_hanoi, 2)

    CMOVE(1, R0) PUSH(R0)
    PUSH(stack0)
    CALL(stack_push, 2)
    CMOVE(14, R0) PUSH(R0)
    PUSH(stack0)
    CALL(draw_hanoi, 2)

    wait_init_main:
        CMOVE(1000, R0)                        | Sets tmp
        MULC(R0, 2000, R0)                     | tmp = 2x10E6
    wait_main:   
        SUBC(R0, 1, R0)                        | Decrements tmp
        BNE(R0, wait_main)                     | Wait...

    | Call hanoi algorithm
    PUSH(stack2) PUSH(stack1) PUSH(stack0) PUSH(stack2) 
    PUSH(stack1) PUSH(stack0)
    CMOVE(6, R0) PUSH(R0)
    CALL(hanoi, 7) 

    DEALLOCATE(21)
    EXIT()