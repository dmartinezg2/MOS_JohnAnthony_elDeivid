$ontext
Una compañía posee cuatro máquinas que deben completar cuatro trabajos. Cada máquina debe ser asignada para completar un único trabajo. El tiempo requerido por cada máquina para que complete cada trabajo se muestra en la siguiente figura:
Maquina        Trabajo 1 (horas)        Trabajo 2 (horas)        Trabajo 3 (horas)        Trabajo 4 (horas)
1        14        5        8        7
2        2        12        6        5
3        7        8        3        9
4        2        4        6        10

La compañía desea minimizar el tiempo total requerido por las máquinas para completar los cuatro trabajos. Diseñe un modelo matemático que resuelva el problema.

Realizado por:
Juan Antonio Restrepo - 201730269
David Martinez Granados - 201729870
$offtext
Sets
i maquinas /m1*m4/
j trabajos /t1*t4/

Variables
 x(i,j)                Variable que determina si se elige el proyecto en la posición i j o no
 v(j)                  Para solo llevar una vez el valor de X y que no se repita la fila
z minimizar;

parameter tablaTrabajos(i,j);
          tablaTrabajos("m1","t1")= 14;
          tablaTrabajos("m1","t2")= 5;
          tablaTrabajos("m1","t3")= 8;
          tablaTrabajos("m1","t4")= 7;
          tablaTrabajos("m2","t1")= 2;
          tablaTrabajos("m2","t2")= 12;
          tablaTrabajos("m2","t3")= 6;
          tablaTrabajos("m2","t4")= 5;
          tablaTrabajos("m3","t1")= 7;
          tablaTrabajos("m3","t2")= 8;
          tablaTrabajos("m3","t3")= 3;
          tablaTrabajos("m3","t4")= 9;
          tablaTrabajos("m4","t1")= 2;
          tablaTrabajos("m4","t2")= 4;
          tablaTrabajos("m4","t3")= 6;
          tablaTrabajos("m4","t4")= 10;

Binary Variable x;
Binary Variable v;

Equations

funcObjetivo             Funcion Objetivo

res1                     Sólo debe haber un valor mínimo por tarea por columna
res2                     Sólo debe haber un valor mínimo por tarea por fila

;

funcObjetivo     ..      z=e= sum ((i, j), tablaTrabajos(i,j)* x(i,j));


res1(i)             ..      sum((j), x(i,j)) =e=1;
res2(j)             ..      sum((i), x(i,j)) =e=1;


Model modell /all/;

option mip=CPLEX;

Solve modell using mip minimizing z;

Display tablaTrabajos;

Display z.l
