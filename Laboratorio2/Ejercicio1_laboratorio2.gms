

Sets

         i procesadores de origen /1,2,3/

         j procesadores destino /1,2/;

Parameters

         oK(i) la oferta de procesos Kernel de los procesadores de origen /1 60,2 80, 3 50/

         oU(i) la oferta de procesos de Usuasrio de los procesadores origen /1 80, 2 50, 3 50/

         dK(j) la demanda de procesos kernel de los procesadores destino /1 100, 2 90/

         dU(j) la demanda de procesos kernel de los procesadores destino /1 60,2 120/;

Table precios(i,j) valor de transportar procesos en la ruta i ---> j
                 1       2
         1       300     500
         2       200     300
         3       600     300;

Variables

         xK(i,j) cantidad de proceso kernel trasladados por la ruta i--->j
         xU(i,j) cantidad de proceso de usuario trasaladados por la ruta i ---> j
         z costo de el transporte de los procesos;
Positive variables xK,xU;

Equations
         costo define la funcion objetivo se trata de minimizar
         ofertaKernel(i)       limite de capacidad que puede suplir el procesador i
         demandaKernel(j)      limite de capacidad que puede recibir el procesador j
         ofertaUsuario(i)       limite de capacidad que puede suplir el procesador i
         demandaUsuario(j)      limite de capacidad que puede recibir el procesador j;

         costo   ..      z=e= sum((i,j),xK(i,j)*precios(i,j))+ sum((i,j),xU(i,j)*precios(i,j));
         ofertaKernel(i)        ..      sum(j,xK(i,j)) =l= oK(i);
         demandaKernel(j)       ..      sum(i,xK(i,j)) =g= dK(j);
         ofertaUsuario(i)        ..      sum(j,xU(i,j)) =l= oU(i);
         demandaUsuario(j)       ..      sum(i,xU(i,j)) =g= dU(j);
Model procesadores /all/;

Solve procesadores using LP minimizing z;

display xK.l;
display xU.l
display z.l;

