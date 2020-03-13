%{
    #include <stdio.h>
    int yylex();
    void yyerror(char*str);
%}

%union{
    int nb;
    char* str;
}

%left tPLUS tMINUS
%left tTIMES tSLASH
/* */

%token tSEMICOLON 
%token tPO 
%token tPF 
%token tAO 
%token tAF 
%token tCOMMA 
%token tPERIOD 
%token tEQL 
%token tAFF 
%token tLSS 
%token tGTR 
%token tLEQ 
%token tGEQ 
%token tCONST 
%token tPRINTF 
%token tTYPE 
%token <nb> tENTIER
%token tIF
%token tELSE
%token tWHILE
%token <str> tID

%type <nb> Expression
%%
%start File;
File:
    Main;
Main:
    tTYPE tID tPO tPF Body ;
Body:
    tAO Instructions tAF;

Instructions: 
    Instruction Instructions 
    | Instruction;

Instruction: 
    InstructionBody tSEMICOLON ;
    /*| BlockIf
    | BlockWhile;*/

InstructionBody:
    Definition
    | Affectation;

Definition:
    tTYPE tID DefinitionN
    | tTYPE tID tAFF Expression DefinitionN;

DefinitionN:
    /*vide*/
    | tCOMMA tID DefinitionN
    | tCOMMA tID tAFF Expression DefinitionN;

Affectation:
    tID tAFF Expression;

Expression:
    tENTIER
    | tPO Expression tPF
    | Expression tPLUS Expression { $$ = $1 + $3}
    | Expression tMINUS Expression
    | Expression tTIMES Expression
    | Expression tSLASH Expression;

%%
void yyerror(char*str){printf("Low terrain, pull up\n");};
int main(){
    yyparse();
    return 0;
}