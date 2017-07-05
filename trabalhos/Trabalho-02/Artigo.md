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
Em uma breve comparação com Python, utilizando um código que retorna o fatorial de um número passado, podemos notar que Go possui uma escrita muito parecida e legibilidade levemente melhor.

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

<p>Uma funcionalidade nativa interessante em Go é o retorno de múltiplos valores em uma função,
coisa que não é possível fazer na linguagem C. Em C# é possível com o uso de uma biblioteca.
Em comparação com C# podemos notar que go perde em expressividade.</p>

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
executadas simultaneamente com outras. Essas funções trocam informações através de channels, evitando o compartilhamento de memória.</p>

Exemplo de código usando goroutine:

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

# Conclusão

Go é uma linguagem focada em concorrência, então seu uso é indicado para projetos que necessitem de sistemas distribuídos.
O ideal é analisar os requisitos de cada sistema para decidir a linguagem usada, porém Go vem se popularizando bastante ao passar dos anos
e vem sendo uma ótima alternativa  para quem busca uma linguagem nova e com bom desempenho.

# Referências 

<https://golang.org/>

<https://imasters.com.br/linguagens/trabalhando-com-go-golang-a-linguagem-do-google/>

<http://drizin.io/tag/golang/>

<https://blog.codeshare.com.br/golang-routines-e-channels/>
