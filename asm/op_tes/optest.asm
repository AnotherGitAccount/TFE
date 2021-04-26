.include beta.uasm
main:
    | Negative ADD
    CMOVE(20, R1)
    ADDC(R1, -4, R1)
    
    | Negative MUL
    CMOVE(20, R2)
    MULC(R2, -2, R2)

    | Negative ST
    ST(R2, -4, R1)

    | Negative LD
    LD(R1, -4, R3)

    EXIT() | Stops the machine

    | Result should be
    | RF: 
    |   R1 = 16
    |   R2 = -40
    |   R3 = -40
    | DM:
    |   word-4 = -40