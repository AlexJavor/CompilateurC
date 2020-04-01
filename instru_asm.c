#include "symbol_table.h"
#include "instru_asm.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

instruct table_instruct[255];
int index_asm = 0;

int get_next_asm_line(){
	return index_asm;
}

void add_instruct(char cmd[4], int nb_addr, int addr[]){
	strcpy(table_instruct[index_asm].cmd, cmd);
	table_instruct[index_asm].nb_addr = nb_addr;
	for(int i = 0; i< nb_addr; i++){
		table_instruct[index_asm].addr[i] = addr[i];
	}
	index_asm ++;
}

void print_code(){
	printf("Generated asm : \n");
	for(int j = 0; j < index_asm; j++){
		switch(table_instruct[j].nb_addr){
			case 0 :
				printf("%s\n", table_instruct[j].cmd);
				break;
			case 1 : 
				printf("%s %d\n", table_instruct[j].cmd, table_instruct[j].addr[0]);
				break;
			case 2 :
				printf("%s %d %d\n", table_instruct[j].cmd, table_instruct[j].addr[0], table_instruct[j].addr[1]);
				break;
			case 3 :
				printf("%s %d %d %d\n", table_instruct[j].cmd, table_instruct[j].addr[0], table_instruct[j].addr[1], table_instruct[j].addr[2]);
				break;
		}
	} 
}


void print_to_file(){
	FILE * f = fopen("result.s", "w");
	for(int j = 0; j < index_asm; j++){
		switch(table_instruct[j].nb_addr){
			case 0 :
				fprintf(f, "%s\n", table_instruct[j].cmd);
				break;
			case 1 : 
				fprintf(f, "%s %d\n", table_instruct[j].cmd, table_instruct[j].addr[0]);
				break;
			case 2 :
				fprintf(f, "%s %d %d\n", table_instruct[j].cmd, table_instruct[j].addr[0], table_instruct[j].addr[1]);
				break;
			case 3 :
				fprintf(f, "%s %d %d %d\n", table_instruct[j].cmd, table_instruct[j].addr[0], table_instruct[j].addr[1], table_instruct[j].addr[2]);
				break;
		}
	} 
	fclose(f);
}
