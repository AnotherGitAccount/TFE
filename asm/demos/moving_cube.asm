.include beta.uasm

| Constant and name definition(s)
BLUE   = 0b0000000000001111
WHITE  = 0b0000111111111111
zero   = R31
blk_x  = R1
blk_y  = R2
off_x  = R3
off_y  = R4
tmp    = R5

| Lib include(s)
BR(main)
.include gpu_utils.asm

main:
    CMOVE(25, blk_y)                        | Set blk_y
    CMOVE(2, off_y)                         | Set off_y 
    MOVE(zero, blk_x)                       | Set blk_x
    MOVE(zero, off_x)                       | Set off_x
move:
    | Call gpu_draw
    PUSH(off_y) PUSH(off_x) PUSH(blk_y) PUSH(blk_x)
    CMOVE(BLUE, tmp)    PUSH(tmp)
    CMOVE(WHITE, tmp)   PUSH(tmp)
    PUSH(zero)
    CALL(gpu_draw, 7)

wait_init:
    CMOVE(1000, tmp)                        | Sets tmp
    MULC(tmp, 100, tmp)                     | tmp = 10E5
wait:   
    SUBC(tmp, 1, tmp)                       | Decrements tmp
    BNE(tmp, wait)                          | Wait...

    | Call gpu_clear
    PUSH(off_y) PUSH(off_x) PUSH(blk_y) PUSH(blk_x)
    CALL(gpu_clear, 4)

    ADDC(off_x, 1, off_x)                   | Increments off_x
    CMPEQC(off_x, BLOCK_WIDTH, tmp)         | Compares off_x to BLOCK_WIDTH 
    BEQ(tmp, move)                          | Branches if off_x != BLOCK_WIDTH
    MOVE(zero, off_x)                       | Resets off_x
    ADDC(blk_x, 1, blk_x)                   | Increments blk_x
    CMPEQC(blk_x, SCREEN_WIDTH, tmp)        | Compares blk_x to SCREEN_WIDTH
    BEQ(tmp, move)                          | Branches if blk_x != SCREEN_WIDTH
    MOVE(zero, blk_x)                       | Reset blk_x
    BR(move)                                | Repeat