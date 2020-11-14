$ontext
Para los juegos olímpicos un entrenador del equipo de natación debe llevar a sus 4 mejores nadadores, el mejor por cada tipo de nado. Sin embargo, el entrenador cuenta con 6 candidatos. Los tiempos de todos los candidatos por cada tipo de nado se resumen en la siguiente tabla:


Tipo de Nado        Nadador 1        Nadador 2        Nadador 3        Nadador 4        Nadador 5        Nadador 6
Espalda                  85                 88               87               82               89               86
Pecho                    78                 77               77               76               79               78
Mariposa                 82                 81               82               80               83               81
Libre                    84                 84               86               83               84               85

Cuales deberían ser los 4 nadadores que el entrenador debería llevar a los olímpicos?

Aclaraciones:
-Tienen que ser obligatoriamente 4 jugadores. No pueden ser menos ni más.
-Todos los tipos de nados deben ser cubiertos por un nadador.
-Un nadador seleccionado no podría desempeñarse en los olímpicos en dos estilos distintos, es decir,
un nadador seleccionado solo se desempeñaría en un único tipo de nado.
$offtext
Sets

j representa el tipo de dado que se llevará a cabo /Espalda, Pecho, Mariposa, Libre/
i representa el nadador actual /1*6/;

Table nados(i,j) representa los tiempos que tiene un nadador j:
               Espalda   Pecho   Mariposa        Libre
         1     85        78      82              84
         2     88        77      81              84
         3     87        77      82              86
         4     82        76      80              83
         5     89        79      83              84
         6     86        78      81              85;
Variables
         x(i,j) nadadores escogidos
         z funcion objetivo;
Binary Variable x;

Equations

funcObj  Funcion Objetivo
restCantJug      Restriccion cantidad de nadadores
maximoUnaVez     Un nadador solo puede ser elegido por 1 estilo y no para varios
unoPorEstilo     Un nadador por estilo.
;

funcObj       ..      z =e= sum((i,j), x(i,j)*nados(i,j));
restCantJug      ..      sum((i,j),x(i,j)) =e= 4;
maximoUnaVez(j)     ..   sum(i,x(i,j)) =l= 1;
unoPorEstilo(i)  ..      sum(j,x(i,j)) =l=1;



Model model1 /all/ ;
option mip=CPLEX
Solve model1 using mip minimizing z;

Display z.l;
Display x.l;
Display nados;
