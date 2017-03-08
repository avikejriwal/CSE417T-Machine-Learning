clc
clear

x = linspace(-1,1,100)';

plot(x,computeLegPoly(x,3),'r')
hold on
plot(x, 0.5*(5*x.^3-3*x), 'g*')
hold off
%%
plot(x,computeLegPoly(x,1),'r*')
hold on
plot(x, x, 'g')
hold off