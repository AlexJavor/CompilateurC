#include "symbol_table.h"

int depth = 0; 

void init_table(){
    int i;
    for(i = 0; i <= SYMBOLTABLE_SIZE; i++){
        table->symbolarray[i].init = -1;
    }
    table->last_symbol = -1;
}

void add_symbol(char* name, int constant, int init){
    table->last_symbol++;
    int last_symbol = table->last_symbol;
    // Symbol creation
    table->symbolarray[last_symbol].name     = name;
    table->symbolarray[last_symbol].constant = constant;
    table->symbolarray[last_symbol].init     = init;
    table->symbolarray[last_symbol].address  = table->last_symbol;
    table->symbolarray[last_symbol].depth    = depth;
}

int find_symbol_by_name(char* name){
	int i = table->last_symbol;
    int index = -1;
    while(i >= 0 && index == -1){
        // If we find a matching name take its index
    	if(strcmp(table->symbolarray[i].name, name) == 0){ index = i; }
    	i--;
    }
    return index;
}

void increase_depth(){
    depth++;
}
void decrease_depth(){
    depth--;
    int i = table->last_symbol;
    while( table->symbolarray[i].depth > depth ){ 
        table->symbolarray[i].init = -1;
        i--; 
    }
}

void affectation_symbol(char* name){
    int id = find_symbol_by_name(name);
    if(id == -1 && table->symbolarray[id].constant == 1){
        printf("Error: Symbol can not be affected!");
    } else {
        table->symbolarray[id].init = 1;
    }
}