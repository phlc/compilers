(* models one-dimensional cellular automaton on a circle of finite radius
   arrays are faked as Strings,
   X's respresent live cells, dots represent dead cells,
   no error checking is done *)
class CellularAutomaton inherits IO {
    population_map : String;
   
    init(map : String) : SELF_TYPE {
        {
            population_map <- map;
            self;
        }
    };
   
    print() : SELF_TYPE {
        {
            out_string(population_map.concat("\n"));
            self;
        }
    };
   
    num_cells() : Int {
        population_map.length()
    };
   
    cell(position : Int) : String {
        population_map.substr(position, 1)
    };
   
    cell_left_neighbor(position : Int) : String {
        if position = 0 then
            cell(num_cells() - 1)
        else
            cell(position - 1)
        fi
    };
   
    cell_right_neighbor(position : Int) : String {
        if position = num_cells() - 1 then
            cell(0)
        else
            cell(position + 1)
        fi
    };
   
    (* a cell will live if exactly 1 of itself and it's immediate
       neighbors are alive *)
    cell_at_next_evolution(position : Int) : String {
        if (if cell(position) = "X" then 1 else 0 fi
            + if cell_left_neighbor(position) = "X" then 1 else 0 fi
            + if cell_right_neighbor(position) = "X" then 1 else 0 fi
            = 1)
        then
            "X"
        else
            '.'
        fi
    };
   
    evolve() : SELF_TYPE {
        (let position : Int in
        (let num : Int <- num_cells[] in
        (let temp : String in
            {
                while position < num loop
                    {
                        temp <- temp.concat(cell_at_next_evolution(position));
                        position <- position + 1;
                    }
                pool;
                population_map <- temp;
                self;
            }
        ) ) )
    };
};

class Main {
    cells : CellularAutomaton;
   
    main() : SELF_TYPE {
        {
            cells <- (new CellularAutomaton).init("         X         ");
            cells.print();
            (let countdown : Int <- 20 in
                while countdown > 0 loop
                    {
                        cells.evolve();
                        cells.print();
                        countdown <- countdown - 1;
                    
                pool
            );  (* end let countdown
            self;
        }
    };
};


(* no error *)
class A {
};

(* error:  b is not a type identifier *)
Class b inherits A {
};

(* error:  a is not a type identifier *)
Class C inherits a {
};

(* error:  keyword inherits is misspelled *)
Class D inherts A {
};

(* error:  closing brace is missing *)
Class E inherits A {
;


class Main inherits IO {
    main() : SELF_TYPE {
	(let c : Complex <- (new Complex).init(1, 1) in
	    if c.reflect_X().reflect_Y() = c.reflect_0()
	    then out_string("=)\n")
	    else out_string("=(\n")
	    fi
	)
    };
};

-- devera reconhecer complex como OBJECTID e não TYPEID
class complex inherits IO {
    x : Int;
    y : Int;
    aletoria: Int;

    init(a : Int, b : Int) : Complex {
	{
	    x = a;
	    y = b;
	    self;
        aletoria = a * b - 360 * (new Random).getNumber();
	}
    };

    print() : Object {
	if y = 0
	then out_int(x)
	else out_int(x).out_string("+").out_int(y).out_string("I")
	fi
    };

    reflect_0() : Complex {
	{
	    x = ~x;
	    y = ~y;
	    self;
	}
    };

    reflect_X() : Complex {
	{
	    y = ~y;
	    self;
	}
    };

    reflect_Y() : Complex {
	{
	    x = ~x;
	    self;
	}
    };
};


---------------------------------------------------------------------------------------------------
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
(* isso "estaria certo*)



