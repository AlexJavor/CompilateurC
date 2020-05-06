#ifndef SYMBOLTABLE_H
#define SYMBOLTABLE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define SYMBOLTABLE_SIZE 200

/******************************* symbol_var STRUCT ********************************/
/* name     : symbol name                                                         */
/* constant : 0 => variable, 1 => constant                                        */
/* init     : -1 => not used, 0 => declared but not initialized, 1 => initialized */
/* depth    : 0 => global depth                                                   */
/**********************************************************************************/
typedef struct {
    char * name;
    int constant;
    int init;
    int depth;
} symbol_var;

/* Add a new symbol to the table of symbols */
void add_symbol(char * name, int constant, int init);

/* Find a symbol by providing its name */
int find_symbol_by_name(char * name);

/* Increase the depth by 1 */
void increase_depth();

/* Decrease the depth by 1 */
void decrease_depth();

/* If it is not constant, change the value of the variable */
void affectation_symbol(char * name);

/* Add a new symbole to the top of the stack */
int push();

/* Delete the symbol situated at the top of the stack */
int pop();

#endif
