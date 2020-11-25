clc, clear all, close all

syms y x;

y=x^5 - 8*x^3 + 10*x + 6;

figure;
ezplot(y);
axis([-3 3 -10 20])
hold on;


x_i=-2.5; %punto de arranque
x_old=double(x_i);
d1_y=diff(y); %primera derivada
d2_y=diff(d1_y); %segunda derivada

d1_y_eval=double(subs(d1_y, x, x_old)); %evaluamos la primera derivada en x_old.
dx_conv=0.0001;  % convergencia

alfa=1;

cont=1;
while abs(d1_y_eval)>dx_conv
    cont=cont+1;       
    
    d1_y_eval=double(subs(d1_y, x, x_i)); %evaluamos la primera derivada.
    
    d2_y_eval=double(subs(d2_y, x, x_i));  %evaluamos la segunda derivada.

    x_i_plus_1=x_i - alfa*(d1_y_eval/d2_y_eval); %aplicamos la expresión de Newton Raphson.
      
    x_i=double(x_i_plus_1); % actualizamos el x_i.
    
    y_eval=double(subs(y,x_i));
   
    
    plot(x_i, y_eval, 'or'); %pintamos cada nuevo punto hallado.
    
end

y_coor=double(subs(y,x_i));

plot(x_i,y_coor,'o')
str2 = num2str(y_coor);
if d2_y_eval <0
    text(x_i -0.3,y_coor+30,['máximo ',str2])
else
    text(x_i -0.3,y_coor-30,['mínimo ',str2])
end
