clc;
close all;
clear all;
%%  1 
% Reconstruction

% CT signal xc(t)
B = 10;
tau = 10;
Fs = B;
t = 0:0.001:tau;
x_c = sin(pi*B*(t.^2)/tau);
subplot(3,1,1);
plot(t, x_c,'linewidth',1.5);
title('CT signal x_c(t)');
xlabel('t(sec)');
ylabel('x_c(t)');

% DT signal x[n]
Ts = 1/Fs;
n = 0:tau/Ts;
x_n = sin(pi*B*(n*Ts).^2./tau);
subplot(3,1,2);
plot(n, x_n,'linewidth',1.5);
title('Sampled signal x[n] with F_s=10');
xlabel('n(sample)');
ylabel('x[n]');
hold on;
stem(n, x_n,'-o');

% Analog signal reconstruction
y_t = x_n * sinc(Fs*(ones(length(n),1)*t-(Ts*n)'*ones(1,length(t))));
subplot(3,1,3);
plot(t,y_t,'linewidth',1.5);
title('Reconstructed Signal from x[n] using sinc function');
xlabel('t(sec)');
ylabel('x_a(t)');
hold on;
stem(n*Ts, x_n,'-r');


