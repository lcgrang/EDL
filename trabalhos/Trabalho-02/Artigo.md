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
### Writability x Readability
<p>Uma funcionalidade nativa interessante em Go é o retorno de múltiplos valores em uma função, também conhecida
como a estrutura de Tupla. Em C# é possível criar tuplas com o auxílio de uma biblioteca.
Em Go, se escreve pouco, porém no código em C# fica um pouco mais clara a ideia passada pelo código.
</p>

```go
package main

import "fmt"

func valores() (int, int) {
    return 3, 7
}
func main() {
    a, b := valores()
    fmt.Println(a)
    //Retorna 3
    fmt.Println(b)
    //Retorna 7
}
```
Código em C#:

```c#
using System;

namespace ConsoleApplication1 {
    public class Program {
        static void Main(string[] args) {

            Tuple<string, int> dados = Tuple.Create("Olá Mundo", 50);
            Console.WriteLine(dados);
            //retorna ("Olá mundo", 50)
            Console.ReadKey();

        }
    }
}
```

Em uma breve comparação com Python, utilizando um código que retorna o fatorial de um número passado, podemos notar que ambas possuem uma escrita e legibilidade bem parecidas.

Go:
```go
func Fatorial(value int) {
	aux := 1
	for i := 1; i <= value; i++ {
		aux = aux * i
	}
	fmt.Println(aux)
}
```

Python:
```python
def Fatorial(num):
	aux = 1
	for x in xrange(2,num+1):
		aux = aux * x
	return aux

print Fatorial(5)
```

### Expressividade
<p>Ainda em comparação com Pyhon, podemos utilizar trechos de código para criação de loop nas duas linguagens.
Como vemos a seguir, em Go, há diversas maneiras diferentes de se criar um loop atravéns da instrução 'for', porém
a instrução 'while' de python, não existe em Go. Para se criar um loop semanticamente parecido com o 'while' em Go, 
é necessario utilizar uma das modificações de 'for', de uma forma sintaticamente diferente. 
Nesse ponto, podemos dizer que Go é menos expressiva que Python.
</p>


```go
    //Declaração normal do loop for, muito parecido com outras linguagens
    sum := 0
	for i := 0; i < 10; i++ {
		sum += i
	}
	fmt.Println(sum)

    // Podemos criar o loop sem passar a declaração inicial e final
	sum := 1
	for ; sum < 100; {
		sum += sum
	}
	fmt.Println(sum)

    // O for funciona da mesma forma que o While em Python
    count := 1
	for sum < 100 {
		sum += sum
	}
	fmt.Println("Good bye!")
```

```python
count = 1
while (count < 100):
   count = count + 1

print "Good bye!"

for x in xrange(2,num+1):
		aux = aux * x
	return aux
```

<p>Em Go encontramos suporte à closures.<p>

```go
func intSeq() func() int {
    i := 0
    return func() int {
        i += 1
        return i
    }
}

func main() {
    nextInt := intSeq()
  
    fmt.Println(nextInt())
    //retorna 1
    fmt.Println(nextInt())
    //retorna 2
    fmt.Println(nextInt())
    //retorna 3
 
}
```

<p>O maior diferencial de Go é o recurso de concorrência nativa. Para isso existem funções chamdas ´Goroutines´, que são funções
executadas de forma concorrente com outras. Essas funções trocam informações através de channels, evitando o compartilhamento de memória. O conceito de goroutine é parecido com de Threads.</p>

Exemplos de código usando goroutine:

Exemplo 1:

```go
package main
import "fmt"
func f(from string) {
    for i := 0; i < 3; i++ {
        fmt.Println(from, ":", i)
    }
}
func main() {

    f("direto")

    //Ao invocarmos uma goroutine a função não irá esperar a execução
    //da função anterior acabar.
    go f("goroutine")

    go func(msg string) {
        fmt.Println(msg)
    }("indo")

    var input string
    fmt.Scanln(&input)
    fmt.Println("pronto")
}
```

Exemplo 2:

```go
package main

import{
    "fmt"
    "time"
}
func main(){
    /*
        Nesse exemplo, é feita uma chamada recursiva para calcular um número de fibonacci
        Esse tipo de função é muito lenta, então é criada uma goroutine que exibe
        uma pequena animação enquanto a função recursiva executa
    */
    go spinner(1000 * time.Milisecond)
    const n = 45
    fibN := fib(n)
    fmt.Printf("\rFibonacci(%d) = %d\n", n, fibN)
}

func spinner(delay time.Duration){
    for{
        for _, r := range `-\|/`{
            fmt.Printf("\r%c", r)
            time.Sleep(delay)
        }
    }
}

func fib(x int) int {
    if x < 2 {
        return x
    }
    return fib(x-1) + fib(x-2)
}
```

# Conclusão

Go é uma linguagem focada em concorrência, então seu uso é indicado para projetos que necessitem de sistemas distribuídos.
O ideal é analisar os requisitos de cada sistema para decidir a linguagem usada, porém Go vem se popularizando bastante ao passar dos anos
e vem sendo uma ótima alternativa  para quem busca uma linguagem nova e com bom desempenho.

# Referências 

- Donavan, Alan A. A.; Kerninghan, Brian W.; A Linguagem de programação Go;

<https://golang.org/>

<https://imasters.com.br/linguagens/trabalhando-com-go-golang-a-linguagem-do-google/>

<http://drizin.io/tag/golang/>

<https://blog.codeshare.com.br/golang-routines-e-channels/>
