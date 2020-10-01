$ontext
Una empresa requiere cierto número de trabajadores que laboren durante 8 horas
diarias en diferentes días de la semana. Los trabajadores deben desempeñar sus
cargos 5 días consecutivos y descansar 2 días. Por ejemplo, un trabajador que
labora de martes a sábado, descansaría el domingo y el lunes.

Juan Antonio Restrepo
David Martinez
$offtext
Sets
d dias /Lunes,Martes,Miercoles,Jueves,Viernes,Sabado,Domingo/
o opciones /o1*o7/;
Parameter necesario(d) /Lunes    17, Martes      13, Miercoles   15, Jueves      19, Viernes     14, Sabado      16, Domingo     11/;

Table freeDays(o,d) dias libres que hay que darle a los empleados despues de 5 consecutivos
         Lunes   Martes  Miercoles       Jueves  Viernes Sabado  Domingo
o1       0       0       1               1       1       1       1
o2       1       0       0               1       1       1       1
o3       1       1       0               0       1       1       1
o4       1       1       1               0       0       1       1
o5       1       1       1               1       0       0       1
o6       1       1       1               1       1       0       0
o7       0       1       1               1       1       1       0


Positive Variable f(o)
Variable z;

Equations
objectiveFunction        Funcion objetivo
dayRes(d);

objectiveFunction        ..      z =e=sum((o),f(o));
dayRes(d)                ..      sum((o),f(o)*freeDays(o,d))=g=necesario(d);



Model model1 /all/ ;
option mip=CPLEX
Solve model1 using mip minimizing z;

Display z.l;

