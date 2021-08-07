clc;
clear all;
close all;
%% 1
% (a)
a = 0.8;
N = 10;
%時間長度
%linspace(開始時間,結束時間,間隔數)
X = linspace(-5,25,41);
Y1=(a.^X).*unit_step_fun(X);
Y2=(a^N)*(a.^(X-N)).*unit_step_fun(X-N);
Y=Y1-Y2;

figure();
subplot(3,1,1)
stem(X,Y1)
grid on
legend("h_1")
title('h_{1}[n] = (0.8)^n')
ylabel('h_1[n]')
xlabel('n')

subplot(3,1,2)
stem(X,Y2)
axis([-inf,inf,0,1])
grid on
legend("h_2")
title('h_{2}[n]=(0.8)^nu[n-10] ')
ylabel('h_2[n]')
xlabel('n')

subplot(3,1,3)
stem(X,Y)
grid on
legend("h_1-h_2")
title('h[n] = (0.8)^n - (0.8)^nu[n-10] ')
ylabel('y[n]')
xlabel('n')


% (d)
n= linspace(0,N,N+1);
u_10 = 2.*unit_step_fun(n-10);
h1=(a.^n).*unit_step_fun(n);
h2=(a.^n).*unit_step_fun(n-N);
h=h1-h2;
%以filter函式計算y
b = [1 zeros(1,9) -(0.8)^10];
a = [1 -0.8];
imp = [1,zeros(1,N)];
y = filter(b,a,imp);

x = 0:(length(y)+length(imp)-1-1);

figure();
subplot(3,1,1)
stem(n,h)
grid on
title('h[n] = (0.8)^n - (0.8)^nu[10] ')
axis([0,20,-inf,inf])
ylabel('y[n]')
xlabel('n')

subplot(3,1,2)
stem(n,y)
grid on
title('h[n] = filter(b,a,imp)');
axis([0,20,-inf,inf])
ylabel('y[n]')
xlabel('n')

subplot(3,1,3)
stem(x,conv(y,imp))
grid on
title('conv(h[n],impulse)');
axis([0,20,-inf,inf])
ylabel('y[n]')
xlabel('n')