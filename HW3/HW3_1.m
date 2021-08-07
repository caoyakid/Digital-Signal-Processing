clc;
clear all;
close all;
%% 1.
N = 15;
n = 0:1:9;
%(a)
x1 = 0.9.^n;
x2 = n.*(0.6.^n);
x3 = conv(x1, x2);
n2 = 1:length(x3);
figure(1);
stem(n2-1, x3);
title('x3[n]');
xlabel('time (sample)');
ylabel('Amplitude');
xlim([0 18]);
%(b)
x4 = cconv(x1, x2, N); %circular convolution
n3 = 1:length(x4);
figure(2);
stem(n3-1, x4);
title('x4[n]');
xlabel('time (sample)');
ylabel('Amplitude');
xlim([0 N-1]);
%(c)
e = x4 - x3(1:N);
x3_shift = [x3(N+1:N+4) zeros(1,11)]
n4 = 1:length(e);
figure(3);
stem(n4-1, e);
title('e[n]');
xlabel('time (sample)');
ylabel('Amplitude');
xlim([0 N-1]);
ylim([0 0.35]);


figure(4);
subplot(3,1,1);
stem(n4-1, e);
xlim([0 N-1]); ylim([0 0.5]);
xlabel('time (sample)'); ylabel('Amplitude');
title('e[n]');
subplot(3,1,2);
stem(n4-1, x3_shift);
xlim([0 N-1]); ylim([0 0.5]);
xlabel('time (sample)'); ylabel('Amplitude');
title('x3[n+15]');
subplot(3,1,3);
stem(n4-1, e - x3_shift);
xlim([0 N-1]); ylim([0 0.5]);
xlabel('time (sample)'); ylabel('Amplitude');
title('Difference between e[n] & x3[n+15]');


