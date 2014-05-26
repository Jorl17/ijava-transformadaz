Situações de erro - Descrever no relatorio o que fazer. Exemplo: Declarar array de 5 inteiros e tentar aceder à posição 10. Em Java dá erro de execução. Aqui vamos primeiro concentrarmo-nos no caso em que tudo corre bem

Focar na implementação relativa aos parâmetros

Modificar estrutura dos nós para guardar o local onde armazenamos o no: %56, etc

Relatório:
	Estutura: Introdução, etc - Explicar o que nos foi proposto fazer, como resolvemos, explicar como implementámos. Como subdividimos tokens na Meta1. Porque é que o fizemos, para que é que o fizemos. Modificações à gramatica, porque, etc. AST, estrutura dos nós; Porque é que na geração de codigo decidimos guardar os parametros. Explicar decisões nossas, o nosso "processo de engenharia".Identificar problemas na linguagem: "return f()", em que f() é void, e a função em questão é void (Em Java dá erro, mas na nossa linguagem é permitido -- CONFIRMAR)
	Apreciação crítica: O que não implementámos (Não implementamos a situaçao em que a funcao retorna arrays, por exemplo), o que não implementámos mas que sabemos como fazer, que erros iria dar, que problemas iríamos ter, etc
	Não implemetámos Garbage Collection