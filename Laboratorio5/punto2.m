clc, clear, close all
syms x y z;
z = (1-x)^2 + 100 * (y - x^2)^2;
figure
ezsurf(x,y,z);
grid("on");
hold on;

cordx = [];
cordy = [];
cordz = [];
x_0 = 0;
y_0 = 10;
cordxy = [x_0; y_0];
z_eval = double(subs(z, [x; y], cordxy));
alfa = 0.9;
convergencia = 0.001;

grad_z = gradient(z);
grad_z_eval = double(subs(grad_z, [x; y], cordxy));

hess_z = hessian(z);
hess_z_eval = double(subs(hess_z, [x; y], cordxy));

while norm(abs(grad_z_eval)) > convergencia
    xyn = cordxy - alfa *(inv(hess_z_eval)*grad_z_eval);
    cordxy = xyn;
    grad_z_eval = double(subs(grad_z, [x; y], cordxy));
    hess_z_eval = double(subs(hess_z, [x; y], cordxy));
    z_eval = double(subs(z, [x; y], cordxy));
    cordx = [cordx, cordxy(1)];
    cordy = [cordy, cordxy(2)];
    cordz = [cordz, z_eval];
end

plot3(cordx,cordy,cordz,'-or');
