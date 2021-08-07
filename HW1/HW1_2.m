clc;
clear all;
close all;
%% 2
%設定參數
b = [0.5264 -1.5224 1.5224 -0.5264];
a = [1 -1.7163 1.1724 -0.2089];

%以filter函式計算h[n]
n = 0:50;
imp = [1,zeros(1,50)];
h = filter(b,a,imp);

%以freqz函式計算h[n]
[hh,w] = freqz(b,a,'whole');

%繪圖
figure(1)
stem(h)
grid on
title('impulse response h[n]')
xlabel('n')
ylabel('h[n]')
axis([-inf inf -inf inf])

figure(2)
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