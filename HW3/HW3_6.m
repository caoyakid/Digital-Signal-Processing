clc;
clear all;
close all;
%%  6
% s = spectrogram(x, window, noverlap, nfft)
n = (0:1:16000);
x = cos(pi*n/4 + 1000*sin(pi*n/8000));

figure();
spectrogram(x,ones(1,256),0,256);
title('256-point rectangular window');
figure();
spectrogram(x,256,0,256); %第二個參數非向量 則默認 hamming window
title('256-point hamming window');
% 如果使用Hamming函數來減少信號的邊緣，則頻譜圖看起來會更好

% 詳見: http://xilinx.eetrend.com/blog/2020/100049560.htmlhttp://xilinx.eetrend.com/blog/2020/100049560.html