%{
    #include <stdio.h>
    #include "symbol_table.h"
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
    /*| BlockIf
    | BlockWhile
    ;*/

InstructionBody:
    Definition
    | Affectation
    ;

Definition:
    tTYPE tID {add_symbol($2, 0, 0);} DefinitionN
    | tTYPE tID tAFF Expression {add_symbol($2, 0, 1); affectation_symbol($2);} DefinitionN
    | tCONST tTYPE tID {add_symbol($3, 1, 0);} DefinitionConst
    | tCONST tTYPE tID tAFF Expression {add_symbol($3, 1, 1); affectation_symbol($3);} DefinitionConst
    ;

DefinitionN:
    /*vide*/
    | tCOMMA tID {add_symbol($2, 0, 0);} DefinitionN
    | tCOMMA tID tAFF Expression {add_symbol($2, 0, 1);affectation_symbol($2);} DefinitionN
    ;

DefinitionConst:
    /*vide*/
    | tCOMMA tID {add_symbol($2, 1, 0);} DefinitionConst
    | tCOMMA tID tAFF Expression {add_symbol($2, 1, 1);affectation_symbol($2);} DefinitionConst
    ;

Affectation:
    tID tAFF Expression { affectation_symbol($1); };

Expression:
    tENTIER { $$ = $1; }
    |tID {$$ = 0;}
    | tPO Expression tPF { $$ = ($2); }
    | Expression tPLUS Expression { $$ = $1 + $3; }
    | Expression tMINUS Expression { $$ = $1 - $3; } 
    | Expression tTIMES Expression { $$ = $1 * $3; }
    | Expression tSLASH Expression { $$ = $1 / $3; }
    ;

%%
void yyerror(char*str){printf("Low terrain, pull up\n");};
int main(){
    init_table();
    yyparse();
    return 0;
}
