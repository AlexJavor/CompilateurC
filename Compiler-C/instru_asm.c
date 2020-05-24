#include "instru_asm.h"

//******* Variables Globales *******//
instruction_asm table_code[255];
int index_asm = 0;
//**********************************//

int get_next_asm_line(){
	return index_asm;
}

void add_instruct (char cmd[4], int type_cmd, int operator[]){
	strcpy(table_code[index_asm].cmd, cmd);
	table_code[index_asm].type_cmd = type_cmd;
	for(int i = 0; i< type_cmd; i++){
		table_code[index_asm].operator[i] = operator[i];
	}
	//printf("Adding instruction: %s %d\n", cmd, operator[0]);
	index_asm ++;
}

int patch(int line, int operator, int position){
	table_code[line].operator[position] = operator;
}

void print_asm_code(){
	printf("//************ ASM Code Generated *************// \n");
	FILE * asm_file = fopen("asm_code.s", "w");
	for(int j = 0; j < index_asm; j++){
		if(table_code[j].type_cmd == 0){
			printf("%s\n", table_code[j].cmd);
			fprintf(asm_file, "%s\n", table_code[j].cmd);
		} else if (table_code[j].type_cmd == 1) {
			printf("%s %d\n", table_code[j].cmd, table_code[j].operator[0]);
			fprintf(asm_file, "%s %d\n", table_code[j].cmd, table_code[j].operator[0]);
		} else if (table_code[j].type_cmd == 2) {
			printf("%s %d %d\n", table_code[j].cmd, table_code[j].operator[0], table_code[j].operator[1]);
			fprintf(asm_file, "%s %d %d\n", table_code[j].cmd, table_code[j].operator[0], table_code[j].operator[1]);
		} else if (table_code[j].type_cmd == 3) {
			printf("%s %d %d %d\n", table_code[j].cmd, table_code[j].operator[0], table_code[j].operator[1], table_code[j].operator[2]);
			fprintf(asm_file, "%s %d %d %d\n", table_code[j].cmd, table_code[j].operator[0], table_code[j].operator[1], table_code[j].operator[2]);
		}
	}
	fclose(asm_file);
	printf("//**********************************************// \n");
}
