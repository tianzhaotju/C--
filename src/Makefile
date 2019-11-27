result:CMM.y CMM.lex gramtree.h
	bison -vdty  CMM.y
	flex CMM.lex
	gcc -o CMM y.tab.c lex.yy.c gramtree.c 
