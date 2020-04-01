#include "symbol_table.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

// Global variable table
symbol_table *table; // = (symbol_table*)malloc(SYMBOLTABLE_SIZE*(sizeof(symbol_var)+sizeof(int)))
int depth = 0;

void printsymbolTable()
{
    printf("*********************************************\n");
    printf("|Printing the SYMBOL TABLE :                |\n");
    printf("*********************************************\n");
    int table_size = table->last_symbol;
    printf("|Number of variables : %d                    |\n", table_size);
    printf("*********************************************\n");
    printf("|Address|Var Name|Constant|Initialized|Depth|\n");
    printf("*********************************************\n");
    for (int i = 0; i <= table_size; i++)
    {
        printf("|   %d   |   %s    |   %d    |     %d     |  %d  |\n", table->symbolarray[i].address, table->symbolarray[i].name, table->symbolarray[i].constant, table->symbolarray[i].init, table->symbolarray[i].depth);
        printf("*********************************************\n");
    }
    printf("\n\n");
}

void init_table()
{
    printf("coucou\n");
    table = (symbol_table *)malloc(SYMBOLTABLE_SIZE * (sizeof(symbol_var) + sizeof(int)));
    int i;
    for (i = 0; i <= SYMBOLTABLE_SIZE; i++)
    {
        printf("coucou : %d <= %d \n", i, SYMBOLTABLE_SIZE);
        table->symbolarray[i].init = -1;
    }
    table->last_symbol = -1;
    printf("Table initialized \n");
}

void add_symbol(char *name, int constant, int init)
{
    table->last_symbol++;
    int last_symbol = table->last_symbol;
    // Symbol creation
    table->symbolarray[last_symbol].name = name;
    table->symbolarray[last_symbol].constant = constant;
    table->symbolarray[last_symbol].init = init;
    table->symbolarray[last_symbol].address = table->last_symbol;
    table->symbolarray[last_symbol].depth = depth;
    printsymbolTable();
}

int find_symbol_by_name(char *name)
{
    int i = table->last_symbol;
    int index = -1;
    while (i >= 0 && index == -1)
    {
        // If we find a matching name take its index
        if (strcmp(table->symbolarray[i].name, name) == 0)
        {
            index = i;
        }
        i--;
    }
    printf("Find symbole : Indice = %d \n", index);
    return index;
}

void increase_depth()
{
    depth++;
}
void decrease_depth()
{
    depth--;
    int i = table->last_symbol;
    while (table->symbolarray[i].depth > depth)
    {
        table->symbolarray[i].init = -1;
        i--;
    }
    printf("Decrease depth : depth = %d; init de l'ancienne case = %d \n", depth, table->symbolarray[depth + 1].init);
}

void affectation_symbol(char *name)
{
    int id = find_symbol_by_name(name);
    if (id == -1 && table->symbolarray[id].constant == 1)
    {
        printf("Error: Symbol can not be affected!");
    }
    else
    {
        table->symbolarray[id].init = 1;
    }
    printf("symbole affected\n");
    printsymbolTable();
}
