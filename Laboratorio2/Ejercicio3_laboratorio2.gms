
Sets

i  numero de losa      /p1*p20/
t  tubos               /t1*t7/;

Table tubos(t,i) tubos que se tienen
         p1      p2      p3      p4      p5      p6      p7      p8      p9      p10     p11     p12     p13     p14     p15     p16     p17     p18     p19     p20
t1       1       0       0       0       1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
t2       0       1       1       0       0       1       1       0       0       0       0       0       0       0       0       0       0       0       0       0
t3       0       0       0       0       1       0       0       0       1       0       0       0       0       0       0       0       0       0       0       0
t4       0       0       0       0       0       0       0       0       1       1       0       0       1       1       0       0       0       0       0       0
t5       0       0       0       0       0       0       0       0       0       1       1       0       0       1       1       0       0       0       0       0
t6       0       0       0       0       0       0       0       0       0       0       0       0       1       0       0       0       1       0       0       0
t7       0       0       0       0       0       0       0       1       0       0       0       1       0       0       0       1       0       0       1       1
;
Variables
x(i)   levanto o no esa valdosa
z        variable objetivo;


Binary Variable x;

Equations

objectiveFunction         Función objetivo
minimoTubo                Hay que ver todos los tubo es decir debemos saber el material de los 7;

objectiveFunction        ..     z =e=sum((i), x(i));
minimoTubo(t)            ..      sum((i),x(i)*tubos(t,i))=g=1;



Model modell /all/;
option mip = CPLEX
Solve modell using mip minimizing z;


Display x.l;
Display z.l;
