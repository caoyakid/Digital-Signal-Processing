clc;
clear all;
close all;
%% 6
%% Problem 6a
% [b,a] = coef(A,r,omega0,phi);

%% Problem 6b
A6 = 20;
r6 = 0.95;
omega06 = 2*pi/17;
phi6 = pi/4;
[b6,a6] = coef(A6,r6,omega06,phi6);
d6 = [1 zeros(1, 50)];
h61 = filter(b6, a6, d6);

n6 = (0:1:50);
h62 = A6*r6.^n6.*cos(omega06.*n6 + phi6);

figure()
stem(n6, h61);
xlabel('n');
ylabel('h[n]');
title('h[n] by coef()');

figure()
stem(n6, h62);
xlabel('n');
ylabel('h[n]');
title('h[n] by analytic');

figure()
subplot(3,1,1)
stem(n6, h61);
xlabel('n');
ylabel('h[n]');
title('h[n] by coef()');

subplot(3,1,2)
stem(n6, h62);
xlabel('n');
ylabel('h[n]');
title('h[n] by analytic');

subplot(3,1,3)
stem(n6, h62-h61);
xlabel('n');
ylabel('h[n]');
ylim([-20, 20]);
title('Difference');


%% Problem 6c
[r6,p6,k6] = residuez(b6, a6);
k6 = [k6 zeros(1, 51 - length(k6))];
h63 = sum(r6.*p6.^n6) + k6;

figure()
stem(n6, h63);
xlabel('n');
ylabel('h[n]');
title('h[n] by [R,P,K]');

%% Problem 6d
figure()
freqz(b6, a6);

% 方法2
[hh,w] = freqz(b6,a6,'whole');
figure();
subplot(2,1,1)
plot(w,20*log10(abs(hh)))
grid on
title('Magnitude')
xlabel('radians')
ylabel('magnitude in dB scale')
axis([-inf inf -inf inf])

subplot(2,1,2)
plot(w,angle(hh))
grid on
title('Phase')
xlabel('radians')
ylabel('radians')
axis([-inf inf -inf inf])