clc;
close all;
clear all;
%%  3
% 題目要求此filter應有monotone passband 和 equiripple stopband ，
% 並且要將100-Hz的部分壓制40dB以上，表示此filter是Chebyshev type2的highpass filter
% (a)
fs = 1000;
Ws = 100/(fs/2); 
Wp = 150/(fs/2);
Rs = 40;
Rp = 1;
[n, Ws] = cheb2ord(Wp, Ws, Rp, Rs);
[b, a] = cheby2(n, Rs, Ws, 'high');
[H,w] = freqz(b,a,1000,'whole');
H = H(1:500); 
w = w(1:500);
Magnitude = abs(H);
Magnitude_dB = mag2db(Magnitude);
figure();
plot(w/pi,Magnitude_dB); 
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
title('log-magnitude response of IIR');

% (b)
fs = 1000;
Ws = 100/(fs/2); 
Wp = 150/(fs/2);
Rs = 40;
Rp = 1;
%----db2delta----
K = 10^(Rp/20);
delta1 = (K-1)/(K+1);
delta2 = (1+delta1)*(10^(-Rs/20));
[n,f,m,weights] = firpmord([Ws,Wp],[0,1], [delta2,delta1]);
B = firpm(n,f,m,weights);
[H,w] = freqz(B,1,1000,'whole');
Magnitude_dB = mag2db(abs(H(1:500)));
w = w(1:500);
figure();
plot(w/pi,Magnitude_dB);
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
title('log-magnitude response of FIR');

% (c)
% 在part(c)的圖中，觀察xa(t)的頻譜可以發現，在濾波前，
% xa(t)的頻譜主要就是100Hz和150Hz最大，但由右下的頻譜可以發現，
% 濾波後xa(t)的頻譜只剩150Hz，100Hz的部分被濾掉了，
% 表示設計出的濾波器都有確實的濾掉100Hz的成分。
fs = 1000;  N = 300;
Ws = 100/(fs/2); 
Wp = 150/(fs/2);
Rs = 40;
Rp = 1; 
dt = 1/fs;
t = 0: dt : (N-1)*dt;
xa = 5*sin(200*pi*t)+2*cos(300*pi*t);
f_axis = (-N/2:N/2-1)*fs/N;
F_xa = abs(fftshift(fft(xa)));
F_xa = F_xa(1:N);
figure()
subplot(6,1,1);
plot(t,xa);
title('Original xa(t)');
subplot(6,1,2);
plot(f_axis,F_xa);
title('Spectrum of xa(t)');
ylim([0 1000]);
xlabel('Normalized Frequency (\times\pi rad/sample)');
%----the processing result of (a)----
[n, Ws] = cheb2ord(Wp, Ws, Rp, Rs);
[b, a] = cheby2(n, Rs, Ws, 'high');
result_a = filter(b,a,xa);
subplot(6,1,3);
plot(t,result_a);
title('IIR filtered xa(t)');
F_result_a = abs(fftshift(fft(result_a)));
F_result_a = F_result_a(1:N);
subplot(6,1,4);
plot(f_axis,F_result_a);
title('Spectrum of IIR filtered xa(t)');
ylim([0 1000]);
xlabel('Normalized Frequency (\times\pi rad/sample)');
%----the processing result of (b)----
K = 10^(Rp/20);
delta1 = (K-1)/(K+1);
delta2 = (1+delta1)*(10^(-Rs/20));
[n,f,m,weights] = firpmord([Ws,Wp],[0,1],[delta2,delta1]);
B = firpm(n,f,m,weights);
result_b = filter(B,1,xa);
subplot(6,1,5);
plot(t,result_b);
title('FIR filtered xa(t)');
F_result_b = abs(fftshift(fft(result_b)));
F_result_b = F_result_b(1:N);
subplot(6,1,6);
plot(f_axis,F_result_b);
title('Spectrum of FIR filtered xa(t)');
ylim([0 1000]);
xlabel('Normalized Frequency (\times\pi rad/sample)');
