clc;
clear all;
close all;
%%  5
% 它們只是DFT頻譜中間隔0≤k≤64的兩個頻率分量。 
% DFT索引k = 64對應於DTFT中的pi。
% 我們可以預期信號中只有兩個頻率分量pi / 8（k = 8）和pi / 4（k = 16）。
% 因此，只有x2，x3和x6可以作為答案。正弦波，餘弦波或相位都不會影響頻譜的絕對值。
n = (0:1:127);
x1 = cos(pi*n/4) + cos(0.26*pi*n);
x2 = cos(pi*n/4) + 1/3*sin(pi*n/8);
x3 = cos(pi*n/4) + 1/3*cos(pi*n/8);
x4 = cos(pi*n/8) + 1/3*cos(pi*n/16);
x5 = 1/3*cos(pi*n/4) + cos(pi*n/8);
x6 = cos(pi*n/4) + 1/3*cos(pi*n/8 + pi/3);

X1 = fft(x1,128);
X2 = fft(x2,128);
X3 = fft(x3,128);
X4 = fft(x4,128);
X5 = fft(x5,128);
X6 = fft(x6,128);

figure();
subplot(3,2,1);
stem(abs(X1), '.');
xlim([0 70]);
xlabel('DFT index k'); ylabel('|V1[k]|');
title('|V1[k]|');
subplot(3,2,2);
stem(abs(X2), '.');
xlim([0 70]);
xlabel('DFT index k'); ylabel('|V2[k]|');
title('|V2[k]|');
subplot(3,2,3);
stem(abs(X3), '.');
xlim([0 70]);
xlabel('DFT index k'); ylabel('|V3[k]|');
title('|V3[k]|');
subplot(3,2,4);
stem(abs(X4), '.');
xlim([0 70]);
xlabel('DFT index k'); ylabel('|V4[k]|');
title('|V4[k]|');
subplot(3,2,5);
stem(abs(X5), '.');
xlim([0 70]);
xlabel('DFT index k'); ylabel('|V5[k]|');
title('|V5[k]|');
subplot(3,2,6);
stem(abs(X6), '.');
xlim([0 70]);
xlabel('DFT index k'); ylabel('|V6[k]|');
title('|V6[k]|');