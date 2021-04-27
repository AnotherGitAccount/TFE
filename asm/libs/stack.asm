| Inits a stack
|
| @param address the address of the stack. Note that to implement a stack
|                of size N the user must allocate N + 1 words, starting
|                at `address`
| void stack_init(address)
stack_init:
    init_stack_init:
        PUSH(LP) PUSH(BP)
        MOVE(SP, BP)
        PUSH(R1)
        LD(BP, -12, R1)
    func_stack_init:
        ST(R1 , 0, R1)      | Sets the stack current address
    exit_stack_init:
        POP(R1)
        POP(BP) POP(LP)
        RTN()

| Pushes a value on top of the stack. Note that no security is provided,
| if this function isn't used properly it will corrupt your memory.
|
| @param address the address of the stack
| @param value the value to be added
| void stack_push(address, value)
stack_push:
    init_stack_push:
        PUSH(LP) PUSH(BP)
        MOVE(SP, BP)
        PUSH(R1) PUSH(R2) PUSH(R3)
        LD(BP, -12, R1) LD(BP, -16, R2)
    func_stack_push:
        LD(R1, 0, R3)    | Get stack head address
        ADDC(R3, 4, R3)  | Increments head address
        ST(R3, 0, R1)    | Updates head address
        ST(R2, 0, R3)    | Push the value 
    exit_stack_push:
        POP(R3) POP(R2) POP(R1)
        POP(BP) POP(LP)
        RTN()

| Pops a value out of the stack. Note that no security is provided,
| if this function isn't used properly it will corrupt your memory.
|
| @param address the address of the stack
| @return value the value that has been popped
| value stack_pop(address)
stack_pop:
    init_stack_pop:
        PUSH(LP) PUSH(BP)
        MOVE(SP, BP)
        PUSH(R1) PUSH(R2)
        LD(BP, -12, R1)
    func_stack_pop:
        LD(R1, 0, R2)    | Get stack head address
        LD(R2, 0, R0)    | Set value to value at head address
        SUBC(R2, 4, R2)  | Decrement head address
        ST(R2, 0, R1)    | Updates head address
    exit_stack_pop:
        POP(R2) POP(R1)
        POP(BP) POP(LP)
        RTN()

| Peeks the top value of the stack, doesn't modify the stack.
|
| @param address the address of the stack
| @return value the value that has been peeked
| value stack_peek_top(address)
stack_peek_top:
    init_stack_peek_top:
        PUSH(LP) PUSH(BP)
        MOVE(SP, BP)
        PUSH(R1)
        LD(BP, -12, R1)
    func_stack_peek_top:
        LD(R1, 0, R1)    | Get stack head address
        LD(R1, 0, R0)    | Set value to value at head address
    exit_stack_peek_top:
        POP(R1)
        POP(BP) POP(LP)
        RTN()

| Peeks the bottom value of the stack, doesn't modify the stack.
|
| @param address the address of the stack
| @return value the value that has been peeked
| value stack_peek_bot(address)
stack_peek_bot:
    init_stack_peek_bot:
        PUSH(LP) PUSH(BP)
        MOVE(SP, BP)
        PUSH(R1)
        LD(BP, -12, R1)
    func_stack_peek_bot: 
        LD(R1, 4, R0)    | Set value to value at stack tail
    exit_stack_peek_bot: 
        POP(R1)
        POP(BP) POP(LP)
        RTN()

| Checks if the stack is empty
|
| @param address the address of the stack
| is_empty stack_is_empty(address)
stack_is_empty:
    init_stack_is_empty:
        PUSH(LP) PUSH(BP)
        MOVE(SP, BP)
        PUSH(R1)
        LD(BP, -12, R1)
    func_stack_is_empty:
        LD(R1, 0, R0)     | Loads head address
        CMPEQ(R0, R1, R0) | Compares address to head address, return comparison
    exit_stack_is_empty:
        POP(R1)
        POP(BP) POP(LP)
        RTN()

| Gets the size of the stack
|
| @param address the address of the stack
| size stack_size(address)
stack_size:
    init_stack_size:
        PUSH(LP) PUSH(BP)
        MOVE(SP, BP)
        PUSH(R1)
        LD(BP, -12, R1)
    func_stack_size:
        LD(R1, 0, R0)     | Loads head address
        SUB(R0, R1, R0)   | R0 = head - address
        SHRC(R0, 2, R0)   | R0 = R0 / 4
    exit_stack_size:
        POP(R1)
        POP(BP) POP(LP)
        RTN()
