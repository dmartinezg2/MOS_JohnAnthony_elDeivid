$ontext
Suponga que el gobernador de un departamento de 6 pueblos desea determinar en cuál de ellos debe poner una estación de bomberos. Para ello la gobernación desea construir la mínima cantidad de estaciones que asegure que al menos habrá una estación dentro de 15 minutos (tiempo para conducir) en cada pueblo. Los tiempos requeridos (en minutos) para conducir entre ciudades se muestran en la siguiente tabla:

Tiempo entre pueblos(min)        Pueblo 1        Pueblo 2        Pueblo 3        Pueblo 4        Pueblo 5        Pueblo 6
Pueblo 1        0        10        20        30        30        20
Pueblo 2        10        0        25        35        20        10
Pueblo 3        20        25        0        15        30        20
Pueblo 4        30        35        15        0        15        25
Pueblo 5        30        20        30        15        0        14
Pueblo 6        20        10        20        25        14        0

Implemente un modelo matemático GENÉRICO que permita hallar la cantidad de estaciones de bomberos a construir y donde construirlas.

$offtext

Sets

i        pueblos /p1*p6/
alias(j,i)

Table tiempos(i,j) tiempo que me toma de ir de i-->j
                 p1      p2      p3      p4      p5      p6
         p1      0       10      20      30      30      20
         p2      10      0       25      35      20      10
         p3      20      25      0       15      30      20
         p4      30      35      15      0       15      25
         p5      30      20      30      15      0       14
         p6      20      10      20      25      14      0;


Variables
e(i) determina si se construye la estación o no.
z    funcion objetivo;

Binary Variable e;

Equations

objectiveFunction        Funcion onjetivo
restriccionEstacion(i)      Restriccion de la estacion en terminos de tiempo;

objectiveFunction        ..      z=e=sum((i),e(i));
restriccionEstacion(i)   ..      sum((j)$(tiempos(i,j)<=15),e(j))=g=1;


Model model1 /all/ ;
option mip=CPLEX
Solve model1 using mip minimizing z;

Display z.l;
Display e.l;


