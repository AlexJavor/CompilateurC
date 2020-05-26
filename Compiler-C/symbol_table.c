#include "symbol_table.h"

//******* Variables Globales *******//
symbol_var symbol_table[SYMBOLTABLE_SIZE];
int depth = 0;
int last_symbol = -1;
int stackId = 200;
//**********************************//

void printsymbolTable() {
    printf("*********************************************\n");
    printf("|Printing the SYMBOL TABLE :                |\n");
    printf("*********************************************\n");
    printf("|Number of variables : %d                    |\n", last_symbol + 1);
    printf("*********************************************\n");
    printf("|Address|Var Name|Constant|Initialized|Depth|\n");
    printf("*********************************************\n");
    for (int i = 0; i <= last_symbol; i++) {
        printf("|   %d   |   %s    |   %d    |     %d     |  %d  |\n", i, symbol_table[i].name, symbol_table[i].constant, symbol_table[i].init, symbol_table[i].depth);
        printf("*********************************************\n");
    }
    printf("\n\n");
}

int find_symbol_by_name(char * name){
    int i = last_symbol;
	int index = -1;
    while(i >= 0){
		// If we find a matching name take its index
    	if(strcmp(symbol_table[i].name, name) == 0){ 
			index = i;
    		break;
		}
    	i--;
    }
	//printf("Find symbole : Indice = %d \n", i);
    return index;
}

void add_symbol(char * name, int constant, int init){
	last_symbol ++;
	// Symbol creation
	symbol_table[last_symbol].name     = name;
	symbol_table[last_symbol].constant = constant;
	symbol_table[last_symbol].init     = init;
	symbol_table[last_symbol].depth    = depth;
	// Print the current state of the table
	// Avoid printing twice the same element
	if(init != 1){
		printsymbolTable();
	}
}

void affectation_symbol(char * name){
	int id = find_symbol_by_name(name);
	if(id >= 0){
		if(symbol_table[id].init == 1 && symbol_table[id].constant == 1){
			printf("Error: Symbol can not be affected! It is a constant already initialized");
		} else {
			symbol_table[id].init = 1;
			symbol_table[id].depth = depth;
			printsymbolTable();
		}	
	}
}


void increase_depth(){
    depth ++;
	printf("Increase depth : depth = %d\n\n", depth);
}

void decrease_depth(){
	depth--;
	int i = last_symbol;
	while((symbol_table[i].depth > depth) && (i >= 0)){
		symbol_table[i].init = -1;
		i--;
    }
    last_symbol = i;
	printf("Decrease depth : depth = %d; init de l'ancienne case = %d \n\n", depth, symbol_table[depth + 1].init);
}

int push(){
    stackId--;
    return stackId + 1;
}

int pop(){
    if (stackId >= SYMBOLTABLE_SIZE){
        printf("pop impossible \n");
    } else {
        stackId++;
    }
    return stackId;
}




