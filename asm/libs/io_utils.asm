| Writes a binary number on the LEDs
|
| @param number the number to be writen (must be in [0, 255])
| void io_write_leds(number)
io_write_leds:
    init_io_write_leds:
        PUSH(LP) PUSH(BP)
        MOVE(SP, BP)
        PUSH(R1) PUSH(R2) PUSH(R3)
        LD(BP, -12, R1)
    func_io_write_leds:
        | Setting R2 = address
        CMOVE(0x0001, R2)       | adds b01 at the begining of the word (io address space)
        SHLC(R2, 30, R2)        | shifts b01 to the begining of the word
        ORC(R2, 0x0004, R2)     | sets leds address
        | Setting R3 = data
        OR(R3, R1, R3)          | sets data to number
        ST(R3, 0, R2)           | writes
    exit_io_write_leds:
        POP(R3) POP(R2) POP(R1)
        POP(BP) POP(LP)
        RTN()

| Reads buttons states
|
| @return buttons states, bit_i contains button_i state
| state io_read_buttons(void)
io_read_buttons:
    init_io_read_buttons:
        PUSH(LP) PUSH(BP)
        MOVE(SP, BP)
        PUSH(R1)
    func_io_read_buttons:
        | Setting R1 = address
        CMOVE(0x0001, R1)       | adds b01 at the begining of the word (io address space)
        SHLC(R1, 30, R1)        | shifts b01 to the begining of the word
        LD(R1, 0, R0)           | reads
    exit_io_read_buttons:
        POP(R1)
        POP(BP) POP(LP)
        RTN()

| Reads switches states
|
| @return switches states, bit_i contains switche_i state
| state io_read_switches(void)
io_read_switches:
    init_io_read_switches:
        PUSH(LP) PUSH(BP)
        MOVE(SP, BP)
        PUSH(R1)
    func_io_read_switches:
        | Setting R1 = address
        CMOVE(0x0001, R1)       | adds b01 at the begining of the word (io address space)
        SHLC(R1, 30, R1)        | shifts b01 to the begining of the word
        ORC(R1, 0x0008, R1)     | sets switches address
        LD(R1, 0, R0)           | reads
    exit_io_read_switches:
        POP(R1)
        POP(BP) POP(LP)
        RTN()