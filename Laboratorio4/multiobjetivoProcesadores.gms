*************************************************************************
***      Multiobjective case                                          ***
***                                                                   ***
***      Author: German Montoya                                       ***
***      Modificado por: David Martinez y Juan Antonio Restrepo       ***
*************************************************************************
Set i   packet types / p1, p2 /;
Set j   source nodes  / s1, s2, s3 /;
Set k   destination nodes / d1, d2, d3, d4 /;

*set iter iterations /it1*it11/;
*scalar w1 weight 1 / 0 /;
*scalar w2 weight 2 / 0 /;

*parameter w1_vec(iter) w1 values
*                 /it1 1, it2 0.9, it3 0.8, it4 0.7, it5 0.6, it6 0.5,
*                  it7 0.4, it8 0.3, it9 0.2, it10 0.1, it11 0/;
*parameter w2_vec(iter) w2 values;

set iter iterations /it1*it9/

scalar ep epsilon /0/

*M�ximo de 2640 y m�nimo de 2450, estos valores se hacen con el m�todo de sumas ponderadas
parameter ep_vec(iter) vector de valores de epsilon
                         /it1 2640, it2 2625, it3 2600, it4 2575, it5 2550, it6 2525, it7 2500, it8 2475, it9 2450/






Table c(j,k) sending cost
                  d1       d2      d3       d4
s1               10        9      10       11
s2                9       10      11       10
s3               11        9      10       10;

Table t(j,k) sending delay
                 d1       d2      d3       d4
s1               12       14      10       11
s2               11        8       7       13
s3                6       11       4       15;

Table inv(i,j) inventory
                  s1       s2       s3
p1                60       80       50
p2                20       20       30;

Table dem(i,k) demand
                 d1      d2      d3       d4
p1               50      90      40       10
p2               10      20      10       30;


Variables
  x(i,j,k)    Amount of i type packets sent from the source node j
              to the destination node k.
  z           minimization
  f1          function 1
  f2          function 2;

Positive Variable x;

Equations
funObj                        Objective Function

invConstraint(i,j)            inventory constraint

demConstraint(i,k)            demand constraint

f1_value                      f1 value
f2_value                      f2 value
f1constraint                  f1constraint;


f1_value               ..     f1=e= sum((i,j,k), c(j,k) * x(i,j,k));

f2_value               ..     f2=e= sum((i,j,k), t(j,k) * x(i,j,k));

funObj                 ..     z =e= f2;

invConstraint(i,j)     ..     sum((k), x(i,j,k)) =l= inv(i,j);

demConstraint(i,k)     ..     sum((j), x(i,j,k)) =e= dem(i,k);

f1constraint                    ..  f1 =l= ep ;


Model Model1 /all/ ;

parameter z_res(iter) "z results to store";
parameter f1_res(iter) "f1 results to store";
parameter f2_res(iter) "f2 results to store";
parameter x_res(i,j,k,iter) "x results to store";

loop (iter,
    ep = ep_vec(iter)
    option lp=CPLEX;
    Solve Model1 using lp minimizing z;
    z_res(iter)=z.l;
    f1_res(iter)=f1.l;
    f2_res(iter)=f2.l;
    x_res(i,j,k,iter)=x.l(i,j,k);
    );

display z_res;
display f1_res;
display f2_res;
display ep_vec;
display x_res;

file GAMSresults /C:\Users\usuario\Documents\septimo\MOS\Labo 4\resultsProcesadores.dat/;
put GAMSresults;
loop(iter,
         put iter.tl, @5, f1_res(iter), @18, f2_res(iter) /

         );
