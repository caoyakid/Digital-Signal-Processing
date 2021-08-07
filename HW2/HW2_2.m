clc;
close all;
clear all;
%%  2
n = -200:1:200;
%這邊h根據a的結果 會不一樣 
h = sinc(n/8)/8+5*sinc(5*n/8)/12-sinc(3*n/8)/4+sinc(n)/3-7*sinc(7*n/8)/24;
%h = (1/3*sin(pi*n) - 1/3*sin(7*pi/8*n) + 2/3*sin(5*pi/8*n) - 2/3*sin(3*pi/8*n) + sin(pi/8*n)) ./ (pi*n);
figure();
stem(n,h);
hold on;
plot(n, h);
xlabel('n (sample)');
ylabel('h[n]');
title('Impulse Response for nd=0');

% c 方法一
f_axis = -(length(n)-1)/(length(n)): 2/length(n) :(length(n)-1)/(length(n));
f_axis = f_axis(1:400);
H = abs(fftshift(fft(h)));
H = H(1:400);
figure();
plot(f_axis, H);
title('frequency response of h[n]');
xlabel('Normalized frequency');
ylabel('Magnitude');

% c 方法2
H = abs(fftshift(fft(h)));
Hi = zeros(1, 200);
Hi(1:24) = 1;
Hi(76:124) = 2/3;
Hi(176:199) = 1/3;
Hi = [Hi(200:-1:1) 0 Hi(1:200)];
figure()
subplot(3, 1, 1);
plot(n/200, H);
ylim([0 1.2]);
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude');
title('Spectrum of the truncated impulse response');
subplot(3, 1, 2);
plot(n/200, Hi);
ylim([0 1.2]);
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude');
title('Spectrum of the ideal filter response');
subplot(3, 1, 3);
plot(n/200, abs(Hi-H));
ylim([0 1.2]);
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude');
title('Difference between above two methods');