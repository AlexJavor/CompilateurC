all :
	yacc -d compiler.y
	flex compiler.l
	gcc symbol_table.c lex.yy.c y.tab.c instru_asm.c -o compiler


lexer :
	flex lexicale.l
	gcc lex.yy.c -o lexer

clean :
	rm -f lex.yy.c lexer t.tab.c compiler y.tab.c y.tab.h y.output output.s compiler.tab.c

