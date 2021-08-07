clc;
close all;
clear all;
%%  4
%設定N
%order
N = 50;

%設定F
%取樣頻率
Fs = 1000;
%bandpass filter的各項頻率點，單位是Hz
Fstop1 = 200;
Fpass1 = 250;
Fpass2 = 260;
Fstop2 = 310;

F = [0 Fstop1 Fpass1 Fpass2 Fstop2 Fs/2]/(Fs/2);

%設定S
%bandpass filter各項頻率點的amplitude
S = [0 0 1 1 0 0];

%設定W
%W則是用於調整每個頻帶的fit，W的長度通常為F跟S的1/2倍，正好每個頻帶對上一個W參數

Wstop1 = 0.00095;
Wpass = 1;
Wstop2 = 0.00095;

W = [Wstop1 Wpass Wstop2];

%使用remez函式建立FIR filter
b1=remez(N,F,S,W);
%b2=firpm(N,F,S,W);

[h1,w1]=freqz(b1,1,512);
S=[0.0316 0.0316 1 1 0.0316 0.0316];

figure(1)
freqz(b1,1,512);
title('Magnitude & Phase  Response')
grid on
axis([-inf inf -inf inf])

figure(2)
plot(F,20*log10(S),w1/pi,20*log10(abs(h1)))
grid on
legend('Ideal','remez Design')
title('Magnitude Response(dB)')
xlabel('Normalized Frequency')
ylabel('Magnitude Response(dB)')
axis([-inf inf -75 10])

%---------------
fvtool(b1,1)
%---------------

% x[n]
t=100:200;
a=1;
x=2*cos(0.5*pi*t);


%xpower=mean(x.^2);
%SNR=10*log10(xpower);
%x = awgn(x,SNR);

w=sqrt(1)*randn(1,length(t))+0;
x=w+x;
y=filter(b1,a,x);

figure();
subplot(2,1,1);
stem(t,x);
title('x[n]');
xlabel('n')
ylabel('magnitude')
grid on
axis([-inf inf -inf inf])

subplot(2,1,2);
stem(t,y);
title('y[n]');
xlabel('n')
ylabel('magnitude')
grid on
axis([-inf inf -inf inf])

figure();
subplot(2,1,1);
plot(t,x);
title('x[n]');
xlabel('n')
ylabel('magnitude')
grid on
axis([-inf inf -inf inf])

subplot(2,1,2);
plot(t,y);
title('y[n]');
xlabel('n')
ylabel('magnitude')
grid on
axis([-inf inf -inf inf])