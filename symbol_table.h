#ifndef SYMBOLTABLE_H
#define SYMBOLTABLE_H

#include <stdio.h>
#include <string.h>

#define SYMBOLTABLE_SIZE 100


/******************************* symbol_var STRUCT ********************************/
/* name     : symbol name                                                         */
/* constant : 0 => variable, 1 => constant                                        */
/* init     : -1 => not used, 0 => declared but not initialized, 1 => initialized */
/* address  : variable address in memory                                          */
/* depth    : 0 => global depth                                                   */
/**********************************************************************************/

typedef struct {
    char* name;
    int constant;
    int init;
    int address;
    int depth;
} symbol_var;

typedef struct {
    //int nb_offset;
    int last_symbol;
    symbol_var symbolarray[SYMBOLTABLE_SIZE];
} symbol_table;

// Global variable table
symbol_table *table;

void init_table();
void add_symbol(char* name, int constant, int init);
int  find_symbol_by_name(char* name);
void increase_depth();
void decrease_depth();
void affectation_symbol(char* name);

#endif
