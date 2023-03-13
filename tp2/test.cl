
class Main {
    cells : CellularAutomaton;
   
    main() : SELF_TYPE {
        {
            String teste <- "Testes do analisador lexico!";
            cells <- (new CellularAutomaton).init("         X         ");
            cells.print();
            (let countdown : Int <- 20 in
                while countdown > 0 loop
                    {
                        cells.evolve();
                        cells.print();
                        countdown <- countdown - 1;
                    }
                    
                pool
            );  (* end let countdown *)
            self;
        }
    };
};

class Main inherits IO {
  main(): Object {{
    let a: int <- 5,
        b: int <- 3,
        soma: int <- a+b
    in 
    out_string(soma);
  }};
};

(* Testa se o scanner reconhece a limite máximo de caracteres permitidos (1024). *)
class Main inherits IO {
  main(): Object {{
    out_string("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrraaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrraaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
  }};
};

(* sem erro *)
class A {
};

(* erro:  inherits esta escrito errado *)
Class D inherts A {
};

(* erro: falta as chaves de fechamento de escopo *)
Class E inherits A {
;

--TESTES PARA IDENTIFICADORES
3invalido
valido3
valido_3
valido_
val1do
*invalido
-INVALIDO
_invalido
in-va-li-do-
@invalido

--TESTE DE KEYWORDS
ISVOID
LET
LOOP
POOL
THEN
WHILE
CASE
ESAC
NEW
OF
NOT
true
false



--TESTE DE SINTAXE DE EXPRESSOES CONDICIONAIS/PALAVRAS RESERVADAS

Int a;	
String b;

if a==2 then b<-'dois'
elif a<0 then b<-"negativo!"
else then "positivo!"=>b

new Teste()

--TESTES DE STRING
"String sem EOF, nao tem aspas duplas de fechamento

"Essa string nao deve acabar aqui \", uma vez que a aspas foi escapada, e sim aqui"

"O \0 deve ser interpretado como 0, mas nao deve gerar erro. "



--TESTES PARA CARACTERES DE ESCAPE
\'\#\%\$\&\*\\\/\(\[\{\)\]\}\"\~\^\t\r\v\n\0

--TESTES PARA DIGITOS
1234567890
022
00000000000
0x2BC


--TESTES DE OPERADORES
i++
<=
7-4=3
8+5=13
>=
2>1
3<5
3<=7
>

--TESTES DE COMENTARIOS

- - isso nao e um comentario!

--este seria um comentario em uma linha

--esse comentario tem 2 
linhas e deveria gerar erro

-- comentario (* de uma linha
-- comentario *) de uma linha (erro!)
nao e um comentario *)

(* comentario
de
multiplas
linhas 
*)

(* comentario (*aninhado (*(*))))
(*-- continuando o teste
de comentariao de multiplas linhas)



