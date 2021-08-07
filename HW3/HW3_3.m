clc;
clear all;
close all;
%% 3.
%(a)
for m = 1:100
    for n = 1:100
        x(m,n) = 0.9 .^ (m+n-2);
    end
end
Xa = fft(fft(x).').';
Xa_mag = abs(fftshift(Xa)); % fftshift reason : 一般影像處理(2維)的原點在左上角 需移到中間
% 詳見: https://www.itread01.com/content/1541093349.html
figure(1);
imagesc(Xa_mag); 
title("Magnitude Response");
%(b)
m = 0:99;
x1 = 0.9 .^ m;
n = 0:99;
x2 = 0.9 .^ n;
X1 = fft(x1);
X2 = fft(x2);
for k = 1:100
    for l = 1:100
        Xb(k,l) = X1(k)*X2(l);
    end
end
Xb_mag = abs(fftshift(Xb));
figure(2)
imagesc(Xb_mag);
title("Magnitude Response");

norm(Xa - Xb) % the same
