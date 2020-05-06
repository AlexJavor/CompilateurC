#ifndef INSTRUASM_H
#define INSTRUASM_H

#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <string.h>
#include "symbol_table.h"

/************************************ instruction_asm STRUCT ************************************/
/* cmd      : Command to be executed in the instruction.  (ex: ADD, COP, EQL...)                */
/* operator : Array containg the addresses and values of the asm instruction (Maximum 3 values) */
/* type_cmd : Number showing the type of command depending on the number of operators required  */
/************************************************************************************************/

typedef struct {
	char cmd[4]; // 3 character command
	int operator[3];
    int type_cmd;
} instruction_asm;

/* Get the next line from the assembly code */
int get_next_asm_line();

/* Add an instruction to the assembly code */
void add_instruct(char cmd[4], int type_cmd, int operator[]);

/* Relate the assambly line with the operator at a given position */
int patch(int line, int operator, int position);

/* Print the assembly code directly to the terminal aswell as write it into a file named "asm_code.s" */
void print_asm_code();

#endif
