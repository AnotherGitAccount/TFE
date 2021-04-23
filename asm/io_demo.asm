.include beta.uasm

init:
    leds_addr = R1
    butt_addr = R2
    butt_data = R3
    tmp       = R4
main:
    CMOVE(0x0001, leds_addr)
    SHLC(leds_addr, 30, leds_addr)
    ORC(leds_addr, 0x0004, leds_addr)
    CMOVE(0x0001, butt_addr)
    SHLC(butt_addr, 30, butt_addr)
while_true:
    LD(butt_addr, 0, butt_data)
    ANDC(butt_data, 0x001, tmp)
    BEQ(tmp, leds_on)
    CMOVE(0x0000, tmp)
    ST(tmp, 0, leds_addr)
    ANDC(butt_data, 0x002, tmp)
    BEQ(tmp, exit)
    BR(while_true)
leds_on:
    CMOVE(0x00ff, tmp)
    ST(tmp, 0, leds_addr)
    BR(while_true)
exit:
    EXIT()
