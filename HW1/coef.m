function [b,a] = coef(A,r,omega0,phi)
b = [A*cos(phi) -A*r*cos(omega0-phi)];
a = [1 -2*r*cos(omega0) r^2];