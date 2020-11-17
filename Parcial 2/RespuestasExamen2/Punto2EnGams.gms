*************************************************************************
***      Minimizing the number of hops in a directed graph            ***
***                                                                   ***
***      Modificado de ejMinimoSaltos  hecho en clase                 ***
***      Author: Germán Montoya                                       ***
***      Modificado por: David Martinez  y Juan Restrepo   ***
***      Para modificar los tiempos se puede cambiar los valores en      ***
**       la tabla tiempos(i,j). Los nodos fuente son inicio A e inicio B ***
*************************************************************************

*Set de nodos donde van a repartir las pizzas dominoes y papa johns
Sets
  i   nodos / 1*6 /

alias(j,i);
*Punto de salida de las pizzerias
Scalar
         inicioA /1/
         inicioB /4/;
*Tiempo entre los nodos
Table tiempos(i,j) tiempo que le toma de un lugar a otro
                 1       2       3       4       5       6
1                999     3       999     5       999     999
2                999     999     3       7       999     999
3                999     3       999     999     7       5
4                5       7       999     999     3       999
5                999     999     7       999     999     5
6                999     999     5       999     5       999;

Variables
  x(i,j)      Indica si es elegido el camino entre i-j.
  z           Objective function  ;

Binary Variable x;

Equations
objectiveFunction        funcion objetivo
nodoFuente(i)            nodoFuente
no_es_fuente(i)          no es nodo fuente
nodoItermedio(i)         nodo intermedio
no_repetir_nodo(i,j)     no se puede repetir el nodo por donde ya pasó el repartidor fachero;
*Funcion objetivo de minimizar el tiempo en el que los domiciliarios reparten sus pizzas
objectiveFunction                                  ..  z =e= sum((i,j), tiempos(i,j) * x(i,j));

*Si se encuentra en el 1 o en el 4 son los comienzos de los domiciliarios y por eso  debe ser exactamente 1
nodoFuente(i)$(ord(i) = inicioA or ord(i) = inicioB)                         ..  sum((j), x(i,j)) =e= 1;

*Si no me encuentro en ninguno de los comienzos entonces debe pasar por lo menos una vez
no_es_fuente(i)$(ord(i) <> inicioA and ord(i) <> inicioB)                    ..  sum((j), x(j,i)) =e= 1;

*Si no es un nodo fuente su valor debe ser uno o menos dependiendo si se ecogio la ruta i->j o no
nodoItermedio(i)$(ord(i) <> inicioA and ord(i) <> inicioB)  ..            sum((j), x(j,i)) =l= 1;

*No se debe poder devolver por un camino. O sea si hay ruta i->j no debe haber ruta j->i
no_repetir_nodo(i,j)                             ..              x(i,j)+x(j,i) =l=1

Model model1 /all/ ;
option mip=CPLEX
Solve model1 using mip minimizing z;

Display tiempos;
Display x.l;
Display z.l;

