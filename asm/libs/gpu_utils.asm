| Constants 
SCREEN_WIDTH  = 72
SCREEN_HEIGHT = 54
BLOCK_WIDTH   = 8

| Draws mask(color1, color2) at the given location (blk_x, blk_y)
| with an offset (off_x, off_y)
|
| @param mask_id the id of the mask (must be in [0, 255])
| @param color1  the first color to use for the mask
| @param color2  the second color to use for the mask
| @param blk_x   the x location of the block selected (must be
|                in [0, 71])
| @param blk_y   the y location of the block selected (must be
|                in [0, 53])
| @param off_x   the x offset of the mask in the block (must be
|                in [0, 7])
| @param off_y   the y offset of the mask in the block (must be
|                in [0, 7])
| void gpu_draw(mask_id, color1, color2, blk_x, blk_y, off_x, off_y)
gpu_draw:
    init_gpu_draw:
        PUSH(LP) PUSH(BP)
        MOVE(SP, BP)
        PUSH(R1) PUSH(R2) PUSH(R3) PUSH(R4)
        PUSH(R5) PUSH(R6) PUSH(R7) PUSH(R8)
        PUSH(R9)
        LD(BP, -12, R1) LD(BP, -16, R2)
        LD(BP, -20, R3) LD(BP, -24, R4)
        LD(BP, -28, R5) LD(BP, -32, R6)
        LD(BP, -36, R7)
    func_gpu_draw:
        | Setting R8 = address
        CMOVE(0x0010, R8)       | adds b10 at the beginning of the word (gpu address space)
        SHLC(R8, 15, R8)        | shifts for blk_x 
        OR(R8, R4, R8)          | adds blk_x
        SHLC(R8, 6, R8)         | shifts for blk_y 
        OR(R8, R5, R8)          | adds blk_y
        SHLC(R8, 3, R8)         | shifts for off_x
        OR(R8, R6, R8)          | adds off_x
        SHLC(R8, 3, R8)         | shifts for off_y
        OR(R8, R7, R8)          | adds off_y
        | Setting R9 = data
        MOVE(R1, R9)            | adds mask id
        SHLC(R9, 12, R9)        | shifts for color2
        OR(R9, R3, R9)          | adds color2
        SHLC(R9, 12, R9)        | shifts for color1
        OR(R9, R2, R9)          | adds color1
        | Draw
        ST(R9, 0, R8)
    exit_gpu_draw:
        POP(R9) POP(R8) POP(R7) POP(R6)
        POP(R5) POP(R4) POP(R3) POP(R2)
        POP(R1)
        POP(BP) POP(LP)
        RTN()

| Clears the whole block at (blk_x, blk_y) with and offset (off_x, off_y)
|
| @param blk_x   the x location of the block selected (must be
|                in [0, 71])
| @param blk_y   the y location of the block selected (must be
|                in [0, 53])
| @param off_x   the x offset of the mask in the block (must be
|                in [0, 7])
| @param off_y   the y offset of the mask in the block (must be
|                in [0, 7])
| void gpu_clear(blk_x, blk_y, off_x, off_y)
gpu_clear:
    init_gpu_clear:
        PUSH(LP) PUSH(BP)
        MOVE(SP, BP)
        PUSH(R1) PUSH(R2) PUSH(R3) PUSH(R4) PUSH(R5) PUSH(R6)
        LD(BP, -12, R1) LD(BP, -16, R2) LD(BP, -20, R3) LD(BP, -24, R4)
    func_gpu_clear:
        | Setting R5 = address
        CMOVE(0x0010, R5)       | adds b10 at the beginning of the word (gpu address space)
        SHLC(R5, 15, R5)        | shifts for blk_x 
        OR(R5, R1, R5)          | adds blk_x
        SHLC(R5, 6, R5)         | shifts for blk_y 
        OR(R5, R2, R5)          | adds blk_y
        SHLC(R5, 3, R5)         | shifts for off_x
        OR(R5, R3, R5)          | adds off_x
        SHLC(R5, 3, R5)         | shifts for off_y
        OR(R5, R4, R5)          | adds off_y
        | Setting R6 = data
        CMOVE(0x00ff, R6)       | adds mask id (255, clear mask)
        SHLC(R6, 24, R6)        | shifts for colors (no colors)
        | Draw
        ST(R6, 0, R5)
    exit_gpu_clear:
        POP(R6) POP(R5) POP(R4) POP(R3) POP(R2) POP(R1)
        POP(BP) POP(LP)
        RTN()

| Clears the whole screen. Note that this function is slow.
|
| void gpu_clear_all(void)
gpu_clear_all:
    init_gpu_clear_all:
        PUSH(LP) PUSH(BP)
        MOVE(SP, BP)
        PUSH(R1) PUSH(R2)
    func_gpu_clear_all:
        | R1 = block_x, R2 = block_y
        CMOVE(SCREEN_HEIGHT, R2)                | Setting blk_y
    loop_y_gpu_clear_all:
        SUBC(R2, 1, R2)                         | Decrements blk_y
        CMOVE(SCREEN_WIDTH, R1)                 | Setting blk_x
    loop_x_gpu_clear_all:
        SUBC(R1, 1, R1)                         | Decrements blk_x
        
        | Calls gpu_clear
        PUSH(zero) PUSH(zero) PUSH(R2) PUSH(R1)            
        CALL(gpu_clear, 4)            
        BNE(R1, loop_x_gpu_clear_all)           | Loop on blk_x
        BNE(R2, loop_y_gpu_clear_all)           | Loop on blk_y 
    exit_gpu_clear_all:
        POP(R2) POP(R1)
        POP(BP) POP(LP)
        RTN()