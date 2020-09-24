
Sets

i  numero de losa      /losa1*losa20/;
Variables
x(i)   levanto o no esa valdosa
z        variable objetivo;


Binary Variable x;

Equations

objectiveFunction         Función objetivo
tubo1                    Me encuentro al tubo 1
tubo2                    Me encuentro al tubo 2
tubo3                    Me encuentro al tubo 3
tubo4                    Me encuentro al tubo 4
tubo5                    Me encuentro al tubo 5
tubo6                    Me encuentro al tubo 6
tubo7                    Me encuentro al tubo 7;


objectiveFunction        ..     z =e= sum((i), x(i));
tubo1            ..              x('losa1') + x('losa5') =g= 1;
tubo2            ..              x('losa2') + x('losa3')+x('losa6')+x('losa7') =g= 1;
tubo3            ..              x('losa5') + x('losa9') =g= 1;
tubo4            ..              x('losa9') + x('losa10')+x('losa13')+x('losa14') =g= 1;
tubo5            ..              x('losa10') + x('losa11')+x('losa14')+x('losa15') =g= 1;
tubo6            ..              x('losa13') + x('losa17') =g= 1;
tubo7            ..              x('losa8') + x('losa12')+x('losa16')+x('losa20')+x('losa19') =g= 1;



Model modell /all/;
option mip = CPLEX
Solve modell using mip minimizing z;


Display x.l;
Display z.l;