all:
	yacc -d compiler.y
	flex compiler.l
	gcc symbol_table.c lex.yy.c y.tab.c instru_asm.c -o compiler
clean:
	rm -f lex.yy.c y.tab.* compiler