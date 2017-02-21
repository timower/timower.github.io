---
title: "tLISP"
layout: page
---

tLISP is a small lisp implementation in c.
The main purpose was to learn lisp and learn how to build an interpreter and compiler.

Data Storage
----

### Cells

All data is built up of cells.
A cell is a piece of memory big enough to store a pointer.
Only even number of cells can be allocated because type information 
is stored in the least significant three bits.

### Cons

One of the most common data types is the cons. 
This is a pair of cells both storing data.
This data can be accessed by the functions `car` and `cdr`.


    +-----+-----+
    | car | cdr |
    +-----+-----+

### Vectors

Another data type is the vector, this is a fixed length list.
The first cell stores the length and the consequent cells store data.
As cells can only be allocated in even numbers even length vectors need a dummy cell after the data.

    +-----+------+------+
    | len | data | .... |
    +-----+------+------+


### Data Types

Type information is stored in the 3 lsb of a pointer. Some data types aren't pointer but store data in the pointer.

The data types are:

  * ERR

    The error type, used for returning and handling errors.

  * CONS

    The cons type, as explained above.

  * TEST: unused
  * INT

    The pointer in this cell points to a 64 bit integer stored in a cons.

  * SYM

    The pointer in this cell is an index into the symbol table.

  * FLT

    The pointer in this cell references a double stored in a cons cell.

  * SINT

    A 29 bit integer stored in this cell.

  * VEC

    This cell points to a vector.


Garbage Collector
------

Every lisp needs a garbage collector, tLISP uses a simple mark and sweep GC.
All cells are allocated at startup and aranged in a continuous linked free-list.

Environment
-----------

The environment is a linked key value list containing pairs of (symbol . value).

cur-env is a cons, the car is the parent env, the cdr is a pointer to the current environment.

Bytecode
--------

  * PUSH: pushes operand to stack
  * PUSH_VAR: pushes variable associated with operands symbol to stack
  * POP_VAR: pops the stack into a new variable
  * POP_SET: pops the stack into an existing variable
  * CALL: calls the function with operand args
  * PUSH_ENV: pushes the current env to the stack and creates a new one with the current env as top
  * POP_ENV: pops an environment of the stack and sets current.
  * RET: returns from function
  * JMP: jumps to offset in code
  * JF:  jumps to offset if top of stack is nil