.include beta.uasm

| Constant and name definition(s)
BLUE   = 0b0000000000001111
YELLOW = 0b0000111111110000
RED    = 0b0000111100000000
GREEN  = 0b0000000011110000
zero   = R31
blk_y  = R1
blk_x  = R2
tmp1   = R3
tmp2   = R4

| Lib include(s)
BR(main)
.include gpu_utils.asm

main:
    init_loop:
        CMOVE(SCREEN_HEIGHT, blk_y) | Sets blk_y
    loop_y:
        SUBC(blk_y, 1, blk_y)       | Decrements blk_y 
        CMOVE(SCREEN_WIDTH, blk_x)  | Sets blk_x
    loop_x:
        SUBC(blk_x, 1, blk_x)       | Decrements blk_x
        XOR(blk_x, blk_y, tmp1)     | xor to decide which tile it is
        CMOVE(0x0001, tmp2)         | Creates the mask to get last bit
        AND(tmp1, tmp2, tmp1)       | Applies mask
        BNE(tmp1, tile2)            | Selects tile
    tile1:
        | Call gpu_draw
        PUSH(zero) PUSH(zero) PUSH(blk_y) PUSH(blk_x)
        CMOVE(BLUE, tmp1)     PUSH(tmp1)
        CMOVE(YELLOW, tmp1)   PUSH(tmp1)
        PUSH(zero)
        CALL(gpu_draw, 7)

        BR(end_draw)
    tile2:
        | Call gpu_draw
        PUSH(zero) PUSH(zero) PUSH(blk_y) PUSH(blk_x)
        CMOVE(RED, tmp1)     PUSH(tmp1)
        CMOVE(GREEN, tmp1)   PUSH(tmp1)
        PUSH(zero)
        CALL(gpu_draw, 7)
    end_draw:
        BNE(blk_x, loop_x)          | Loops on blk_x
        BNE(blk_y, loop_y)          | Loops on blk_y
        EXIT()                      | Stops the machine