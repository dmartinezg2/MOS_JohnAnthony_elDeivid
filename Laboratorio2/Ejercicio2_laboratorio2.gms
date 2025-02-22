

Sets

       i respresentan los jugadores disponibles para escoger /1,2,3,4,5,6,7/

       j respresenta las caracteristicas que bpuede tener un jugador /Control,Disparo,Rebotes, Defensa,posDef, posCen, posAta/;

Table skills(i,j) representa las habilidades que tiene un jugar i
                 Control Disparo Rebotes Defensa posDef  posCen  posAta
         1       3       3       1       3       0       0       1
         2       2       1       3       2       0       1       0
         3       2       3       2       2       1       0       1
         4       1       3       3       1       1       1       0
         5       3       3       3       3       1       0       1
         6       3       1       2       3       1       1       0
         7       3       2       2       1       1       0       1;


Variables
         x(i) jugadores escogidos
         z funcion objetivo;
Binary variables x;

Equations

         objFunc funcion objetivo
         numJugadores numero de jugadores en el equipo
         numDefensas al menos 4 jugadores deben poder jugar defensa
         promControl el promedio de control del equipo debe de ser al meno 2
         promDisparo     el promedio de disparo del equipo debe de al menos 2
         promRebotes el promedio de rebotes debe ser de al menos 2
         jugador2o3 se debe tener al 2 o al tres de titulares
         maximoUnaVez el jugador s�lo puede ser escogido 1 vez;

objFunc(j)$(ord(j)=4) ..   z=e= sum((i),x(i)*skills(i,j));
numJugadores     ..      sum(i, x(i)) =e= 5;
numDefensas(j)$(ord(j)=5)        ..       sum(i, x(i)*skills(i,j)) =g= 4;
promControl(j)$(ord(j)=1)        ..       sum(i,x(i)*skills(i,j))/5 =g= 2;
promDisparo(j)$(ord(j)=2)        ..       sum(i,x(i)*skills(i,j))/5 =g= 2;
promRebotes(j)$(ord(j)=3)        ..       sum(i,x(i)*skills(i,j))/5 =g=2;
maximoUnaVez(i)                  ..       x(i) =l=1;
jugador2o3                       ..       x('2')+ x('3')=e=1;

Model model1 /all/ ;
option mip=CPLEX
Solve model1 using mip minimizing z;

Display z.l;
Display x.l;












