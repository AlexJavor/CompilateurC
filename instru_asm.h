#ifndef INSTRUASM_H
#define INSTRUASM_H

typedef struct {
	char cmd[4];
	int addr[3];
    int nb_addr;
} instruct;

/* Get the next line from the assembly code */
int get_next_asm_line();

/* Add an instruction to the assembly code */
void add_instruct(char cmd[4], int nb_addr, int addr[]);

/* Print the assembly code directly to the terminal*/
void print_asm_code();

/* Write the assembly code into a file */
void print_asm_to_file();

#endif