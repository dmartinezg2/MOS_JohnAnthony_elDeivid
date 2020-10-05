

Sets

         i 'nodos' /1,2,3,4,5,6,7/
         alias(j,i);

Scalar l distancia entr4e los nodos sedún sus coordenadas;

Parameters

         cordX(i) /1 20,2 22,3 9,4 3,5 21,6 29,7 14/
         cordY(i) /1 6,2 1,3 2,4 25,5 10,6 2,7 12/
         d(i,j) distancias
         loop((i,j),
         l = sqrt(power(cordX(i)-cordX(j),2)+ power(cordY(i)-cordY(j),2))
         if (l<21 and l>0,
         d(i,j)=l
         else
         d(i,j)=10000);
         );
Variables

         z       objective function variable
         x(i,j)      Indica si se escoge el arco entre los nodos i ---> j;

Binary variables x;

Equations
objectiveFunction        objective function
sourceNode(i)            source node
destinationNode(j)       destination node
intermediateNode         intermediate node;

objectiveFunction                                  ..  z =e= sum((i,j), d(i,j) * x(i,j));

sourceNode(i)$(ord(i) = 4)                         ..  sum((j), x(i,j)) =e= 1;

destinationNode(j)$(ord(j) = 6)                    ..  sum((i), x(i,j)) =e= 1;

intermediateNode(i)$(ord(i) <> 4 and ord(i) ne 6)  ..  sum((j), x(i,j)) - sum((j), x(j,i)) =e= 0;

Model model1 /all/ ;
option mip=CPLEX
Solve model1 using mip minimizing z;


Display x.l;
Display z.l;
Display d;






