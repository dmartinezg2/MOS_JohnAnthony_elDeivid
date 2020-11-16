*************************************************************************
***      Minimizing the number of hops in a directed graph            ***
***                                                                   ***
***      Modificado de ejMinimoSaltos  hecho en clase                 ***
***      Author: Germ�n Montoya                                       ***
***      Modificado por: David Martinez el come gordas y Juan Res k   ***
*************************************************************************

Sets
  i   nodos / 1*6 /

alias(j,i);

Table tiempos(i,j) tiempo que le toma de un lugar a otro
                 1       2       3       4       5       6
1                999     5       999     5       999     999
2                999     999     3       7       999     999
3                999     3       999     999     7       5
4                5       7       999     999     3       999
5                999     999     7       999     999     5
6                999     999     5       999     5       999;

Variables
  x(i,j)      Indicasi es elegido el camino entre i-j.
  z           Objective function  ;

Binary Variable x;

Equations
objectiveFunction        objective function
sourceNode(i)            source node
not_source_node(i)       not source node
intermediateNode(i)         intermediate node
no_repetir_node(i,j)     no se puede repetir el nodo por donde ya pas� el repartidor fachero;

objectiveFunction                                  ..  z =e= sum((i,j), tiempos(i,j) * x(i,j));

*Si se encuentra en el 1 o en el 4 son los comienzos de los domiciliarios y por eso no debe ser exactamente 1
sourceNode(i)$(ord(i) = 1 or ord(i) = 4)                         ..  sum((j), x(i,j)) =e= 1;

*Si no me encuentro en ninguno de los comienzos entonces debe pasar por lo menos una vez
not_source_node(i)$(ord(i) <> 1 and ord(i) <> 4)                    ..  sum((j), x(j,i)) =e= 1;

intermediateNode(i)$(ord(i) <> 1 and ord(i) <> 4)  ..            sum((j), x(j,i)) =l= 1;

no_repetir_node(i,j)                             ..              x(i,j)+x(j,i) =l=1

Model model1 /all/ ;
option mip=CPLEX
Solve model1 using mip minimizing z;

Display tiempos;
Display x.l;
Display z.l;
*$offtext

$ontext
Display i;
Display coorX;
Display coorY;
Display dij;
Display c;
$offtext
