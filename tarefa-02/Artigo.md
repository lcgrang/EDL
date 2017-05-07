# Origem
<p>Go é uma linguagem de programação criada Robert Griesemer, Rob Pike e Ken Thompson, alguns dos colaboradores para o projeto do Unix. 
Go nasceu devido a uma necessidade do Google por uma linguagem com maior escalabilidade, melhor desempenho e facilidade de manutenção.</p>

<p>O inicio do desenvolvimento da linguagem foi no ano de 2007 seguindo algumas diretrizes definidas pelo Google e seu lançamento foi em 2009, 
ainda sendo escolhida com a “linguagem do ano 2009” pelo Tiobe (ranking mundial popularidade de linguagens de programação). 
Go foi feita com foco em  Programação concorrente/paralela nativa e ser Multiplataforma. Além de tudo possui, Garbage Collector nativo. 
Recurso muito apreciado em linguagens de alto nível como C# e Java. O Google incorporou o Garbage Collector para facilitar a vida 
do programador, que não precisa mais se preocupar em “limpar seu rastro” na memória.</p>

# Classificação
<p>O GO é uma linguagem estática, compilada, similar ao C (inclusive em termos de performance). 
A compilação é efetivamente realizada para código nativo, e não é interpretado por uma JVM, como no Java, nem CLR, no caso do .Net. 
Ele gera um binário de acordo com a plataforma (Linux, Windows ou Mac-OS).</p>

# Comparação com outras linguagens
<p>Apesar de possuir tipagem estática, Go oferece um recurso chamado inferência de tipo. Através dele 
não precisamos declarar o tipo da variável ao fazer a atribuição do valor.</p>

```go
x := 50
fmt.Printf("x é do tipo %T\n", x)

//Retorna "x é do tipo int"
```
Porém, diferentemente de outras linguagens como PHP, não podemos reutilizar essa variável com um
valor de outro tipo.

```go
x := 50
x = "Olá mundo"
fmt.Printf(x)
//Retorna cannot use "Olá" (type string) as type int in assignment
```

Em PHP:

```php
$x = 50;
$x = "Olá";
echo $x;

//Retorna "olá"
```