clc, clear all, close all

syms y x;
y=x^5 - 8*x^3 + 10*x + 6;
figure;
ezplot(y);
axis([-3 3 -10 20])
hold on;

d1_y=diff(y); %primera derivada
d2_y=diff(d1_y); %segunda derivada
dx_conv=0.0001;  % convergencia
maxmins_x = [];
maxmins_y = [];
alfa=1;

for i = -3:3
    x_i=i;
    d1_y_eval=double(subs(d1_y, x, x_i));
    
    while abs(d1_y_eval)>dx_conv
        d1_y_eval=double(subs(d1_y, x, x_i)); %evaluamos la primera derivada.
        d2_y_eval=double(subs(d2_y, x, x_i));  %evaluamos la segunda derivada.
        x_i_plus_1=x_i - alfa*(d1_y_eval/d2_y_eval); %aplicamos la expresión de Newton Raphson.
        x_i=double(x_i_plus_1); % actualizamos el x_i.
    end
    
    eval = subs(y, x, x_i);
    maxmins_x = [maxmins_x x_i];
    maxmins_y = [maxmins_y eval];
end

maxIndex = find(maxmins_y == max(maxmins_y));
minINdex = find(maxmins_y == min(maxmins_y));
cor_yMax = max(maxmins_y);
cor_yMin = min(maxmins_y);
cor_xMax = maxmins_x(maxIndex);
cor_xMin = maxmins_x(minINdex);


plot(cor_xMax,cor_yMax,'or');

plot(cor_xMin,cor_yMin,'or');



