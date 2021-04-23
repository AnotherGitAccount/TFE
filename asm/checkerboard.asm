.include beta.uasm

| Constants
HEIGHT = 54
WIDTH  = 72
BLUE   = 0b000000001111
YELLOW = 0b111111110000
RED    = 0b111100000000
GREEN  = 0b000011110000

| Clears all used registers
init:
    zero   = R31
    posy   = R1
    posx   = R2
    vaddr  = R3
    vdata  = R4
    tmp1   = R5
    tmp2   = R6
    
    SHRC(zero, 32, zero) | makes sure that zero = 0
main:
    CMOVE(HEIGHT, posy)
loop_y:
    SUBC(posy, 1, posy)
    CMOVE(WIDTH, posx)
loop_x:
    SUBC(posx, 1, posx)
draw:
    CMOVE(0x0010, vaddr)    | adds 1 at the beginning of the word (graphical mode)
    SHLC(vaddr, 16, vaddr)  | shifts posx 
    OR(vaddr, posx, vaddr)  | adds posx 
    SHLC(vaddr, 6, vaddr)   | shifts posx 
    OR(vaddr, posy, vaddr)  | adds posy
    SHLC(vaddr, 5, vaddr)   | puts block location in [18:6]

    XOR(posx, posy, tmp1)    | xor to decide which tile it is
    ORC(zero, 0x0001, tmp2) | creates the mask
    AND(tmp1, tmp2, tmp1)   | apply mask
    BNE(tmp1, tile2)
tile1:
    CMOVE(BLUE, vdata)         | adds blue color
    SHLC(vdata, 12, vdata)     | shift blue
    ORC(vdata, YELLOW, vdata)  | adds yellow color
    BR(end_draw)
tile2:
    CMOVE(RED, vdata)         | adds red color
    SHLC(vdata, 12, vdata)    | shift red
    ADDC(vdata, GREEN, vdata) | adds green color
end_draw:
    ST(vdata, 0, vaddr)       | draw
    | END_CODE
    BNE(posx, loop_x)
    BNE(posy, loop_y)