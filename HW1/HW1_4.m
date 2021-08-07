clc;
clear all;
close all;
%% 4
A4 = 2;
w4 = 0.1*pi;

n4 = (0:1:100);
y41 = A4 * sin((n4+1) * w4);
figure()
stem(n4, y41);
xlabel('n');
ylabel('y[n]');
ylim([-2.5 2.5]);
title('LCCDE by analytic');

b4 = [A4*sin(w4)];
a4 = [1 -2*cos(w4) 1];
yic4 = [0 -A4*sin(w4)];
xic4 = [];
zic4 = filtic(b4, a4, yic4, xic4);
d4 = zeros(1,101);
y42 = filter(b4, a4, d4, zic4);
figure()
stem(n4, y42);
xlabel('n');
ylabel('y[n]');
title('LCCDE by filter and filtic');

figure()
subplot(3,1,1)
stem(n4, y41);
xlabel('n');
ylabel('y[n]');
ylim([-2.5 2.5]);
title('LCCDE by analytic');

subplot(3,1,2)
stem(n4, y42);
xlabel('n');
ylabel('y[n]');
title('LCCDE by filter and filtic');

subplot(3,1,3)
stem(n4, y42-y41);
xlabel('n');
ylabel('y[n]');
ylim([-2, 2]);
title('Difference');