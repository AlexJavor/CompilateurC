%{
    #include <stdio.h>
    int yylex();
    void yyerror(char*str);
%}

%union{
    int nb;
    char* str;
}

%token tPLUS 
%token tMINUS 
%token tTIMES 
%token tSLASH 
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
%token tTAB 
%token tNEWLINE 
%token tSPACE 
%token tCONST 
%token tPRINTF 
%token tTYPE 
%token tENTIER
%token tIF
%token tELSE
%token tWHILE
%token tID
%%
%start File;
File:
    Main;
Main:
    tINT tMAIN tPO tPF tAO Body tAF;
Body:
    Definition
    | Affectation;
Definition:
    tINT tID DefinitionN tPV; 
DefinitionN:
    /*vide*/
    | tVR tID DefinitionN;
Affectation:
    tID tEQ tPV;
%%
void yyerror(char*str){printf("Low terrain, pull up\n");};
int main(){
    yyparse();
    return 0;
}