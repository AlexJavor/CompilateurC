%{
    #include <stdio.h>
    #include "symbol_table.h"
    #include "instru_asm.h"
    int yylex();
    void yyerror(char*str);
%}

%union{int nb; char* str;}

%start File;

%left tPLUS tMINUS
%left tTIMES tSLASH

%token tSEMICOLON 
%token tPO 
%token tPF 
%token tAO 
%token tAF 
%token tCOMMA 
%token tPERIOD 
%token tAFF
%token tEQL 
%token tLSS 
%token tGTR 
%token tLEQ 
%token tGEQ 
%token tCONST 
%token tPRINTF 
%token tTYPE 
%token <nb> tENTIER 
%token <nb> tIF
%token tELSE
%token <nb> tWHILE
%token <str> tID

%type <nb> Expression
%type <nb> Then


%%
/********************************** Structure basique du fichier ************************************/
File:
    Main;

Main:
    tTYPE tID tPO tPF Body ;

Body:
    tAO {increase_depth();} Instructions tAF {decrease_depth();};

Instructions: 
    Instruction Instructions 
    | Instruction
    ;

Instruction: 
    InstructionBody tSEMICOLON ;
    | BlockIf
    | BlockWhile
    ;

InstructionBody:
    Definition
    | Affectation
    | Printf
    ;


/******************************* Definitions + affectations ****************************************/
Definition:
    tTYPE tID DefinitionN {add_symbol($2, 0, 0);}
    | tTYPE tID tAFF Expression DefinitionN {add_symbol($2, 0, 1); 
                                             affectation_symbol($2); 
                                             int operator[2]={find_symbol_by_name($2), pop()}; 
                                             add_instruct("COP", 2, operator);} 
    | tCONST tTYPE tID DefinitionConst {add_symbol($3, 1, 0);} 
    | tCONST tTYPE tID tAFF Expression DefinitionConst {add_symbol($3, 1, 1);
                                                        affectation_symbol($3);
                                                        int operator[2]={find_symbol_by_name($3), pop()};
                                                        add_instruct("AFC", 2, operator);} 
    ;

DefinitionN:
    /*vide*/
    | tCOMMA tID DefinitionN {add_symbol($2, 0, 0);}
    | tCOMMA tID tAFF Expression DefinitionN {add_symbol($2, 0, 1);
                                              affectation_symbol($2);}
    ;

DefinitionConst:
    /*vide*/
    | tCOMMA tID DefinitionConst {add_symbol($2, 1, 0);} 
    | tCOMMA tID tAFF Expression DefinitionConst {add_symbol($2, 1, 1); 
                                                  affectation_symbol($2);} 
    ;

Affectation:
    tID tAFF Expression {affectation_symbol($1);
                         int operator[2] = {find_symbol_by_name($1), pop()};
                         add_instruct("COP", 2, operator);}
    ;

/********************************* Expressions arithmetiques ****************************************/
Expression:
    tENTIER {int operator[2]={push(), $1}; 
             add_instruct("AFC", 2, operator);}
    | tID {int operator[2]={push(), find_symbol_by_name($1)}; 
          add_instruct("COP", 2, operator);}
    | tPO Expression tPF {$$ = ($2);}
    | Expression tPLUS Expression {int expr2=pop(); 
                                   int expr1=pop();
                                   int operator[3] = {push(), expr1, expr2};
                                   add_instruct("ADD", 3, operator);}
    | Expression tMINUS Expression {int expr2=pop(); 
                                    int expr1=pop();
                                    int operator[3] = {push(), expr1, expr2};
                                    add_instruct("SOU", 3, operator);}
    | Expression tTIMES Expression {int expr2=pop(); 
                                    int expr1=pop();
                                    int operator[3] = {push(), expr1, expr2};
                                    add_instruct("MUL", 3, operator);}
    | Expression tSLASH Expression {int expr2=pop(); 
                                    int expr1=pop();
                                    int operator[3] = {push(), expr1, expr2};
                                    add_instruct("DIV", 3, operator);}
    | Expression tEQL Expression {int expr2=pop(); 
                                  int expr1=pop(); 
                                  int operator[3] = {push(), expr1, expr2};
                                  add_instruct("EQU", 3, operator);}
    | Expression tGTR Expression {int expr2=pop(); 
                                  int expr1=pop(); 
                                  int operator[3] = {push(), expr1, expr2};
                                  add_instruct("SUP", 3, operator);}
	| Expression tLSS Expression {int expr2=pop(); 
                                  int expr1=pop();
                                  int operator[3] = {push(), expr1, expr2}; 
                                  add_instruct("INF", 3, operator);}
    ;

/**************************** Structures Conditionalles (Block if) **********************************/
BlockIf: 
    tIF tPO Expression tPF Then                       // Block if seul
    	Body {patch($5, get_next_asm_line(), 1);} 
    
    | tIF tPO Expression tPF Then Body                // Block if + else 
      tELSE {patch($5, get_next_asm_line()+1, 1);     // on remplace le "-1" par le numéro de la ligne suivante
             int operator[1]={-1};
             $1 = get_next_asm_line();
             add_instruct("JMP", 1, operator);} 
      Body {patch($1, get_next_asm_line(), 0);}
    ;

Then:
	{int operator[2]={pop(), -1};            // le "-1" ici sert à occuper de la place. $1 mémorise la ligne de où se trouve JMF;
     $$ = get_next_asm_line();
     add_instruct("JMF", 2, operator);}
    ;

/**************************************** Print function *******************************************/
Printf:
    tPRINTF tPO tID tPF {int operator[1] = {find_symbol_by_name($3)};
						 add_instruct("PRI", 1, operator);}
    ;


/******************************* Structures de type Boucle (Block while) ***************************/
BlockWhile:
	tWHILE {$1 = get_next_asm_line();} tPO Expression tPF Then
		Body {int operator[1]={$1}; 
              add_instruct("JMP", 1, operator);
              patch($6, get_next_asm_line(), 1);}
	;

%%
void yyerror(char*str){printf("\nCritical Error!\n");};
int main(){
    yyparse();
    print_asm_code();
    return 0;
}
