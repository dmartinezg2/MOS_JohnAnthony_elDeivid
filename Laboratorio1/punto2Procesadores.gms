$ontext
Un sistema de multiprocesamiento consta de una cantidad m de procesadores de los cuales se requieren transmitir cierto número de procesos hasta otra cantidad n de procesadores para luego ser almacenados en memoria. Suponga que el costo por transmitir un proceso desde un procesador i hasta un procesador j es cij. Adicionalmente, asuma que la oferta de procesos desde un procesador i es ai y que la demanda de procesos desde un procesador j es bj. De acuerdo a la anterior información, debe encontrarse la cantidad de procesos que deben ser transportados desde un procesador i hasta un procesador j de manera que el costo total de transporte sea mínimo.

Tener en cuenta los siguientes parámetros:

Número de procesadores origen: 3
Número de procesadores destino: 4
Cantidad de procesos a suministrar por los procesadores origen 1, 2 y 3: 300, 500 y 200 respectivamente.
Cantidad de procesos demandada por los procesadores destino 1, 2, 3 y 4: 200, 300, 100 y 400 respectivamente.

Costos:
Del procesador origen 1 a los procesadores destino 1, 2, 3 y 4: 8, 6, 10 y 9 respectivamente.
Del procesador origen 2 a los procesadores destino 1, 2, 3 y 4: 9, 12, 13 y 7 respectivamente.
Del procesador origen 3 a los procesadores destino 1, 2, 3 y 4: 14, 9, 16 y 5 respectivamente.

Implemente en GAMS el modelo matemático GENERICO que resuelva el caso descrito.

Realizado por:
Juan Antonio Restrepo - 201730269
David Martinez Granados - 201729870
$offtext




Sets
i procesadores orgigen /1,2,3/
j procesadores destino /1,2,3,4/;

Parameters

s(i) supply capacidad procesadores origen /1 300, 2 500, 3 200/

d(j) demand capacidad procesadores destino/1 200,2 300,3 100,4 400/;

Table precios(i,j) valor de trasladar de i a j
                 1       2       3       4
         1       8       6       10      9
         2       9       12      13      7
         3       14      9       16      5;

Variables
         x(i,j) cantidad de procesos trasladados por la ruta i--->j
         z      valor total de transporte de los paquetes;
Positive variables x;


Equations
         costo   define objective function
         oferta(i)       limite de capacidad que puede suplir el procesador i
         demanda(j)      limite de capacidad que puede recibir el procesador j;

costo    ..      z=e= sum((i,j),x(i,j)*precios(i,j));
oferta(i)        ..      sum(j,x(i,j)) =l= s(i);
demanda(j)       ..      sum(i,x(i,j)) =g= d(j);

Model procesadores /all/;

Solve procesadores using LP minimizing z;




