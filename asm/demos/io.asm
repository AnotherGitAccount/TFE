.include beta.uasm

| Constant and name definition(s)
zero   = R31
data   = R1

| Lib include(s)
BR(main)
.include io_utils.asm

main:
    CALL(io_read_switches)  | Call io_read_switches
    MOVE(R0, data)          | Puts result in data
    SHLC(data, 4, data)     | Shifts left by 4
    CALL(io_read_buttons)   | Call io_read_buttons
    OR(data, R0, data)      | Adds buttons state to data
    PUSH(data)
    CALL(io_write_leds, 1)  | Call io_write
    BR(main)                | Replay