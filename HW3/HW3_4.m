clc;
clear all;
close all;
%% 4.
%(a)
m = (-128:1:127);
n = (-128:1:127);
sigma = 4; % c 選項改這邊的sigma值:32
h1_matrix = 1/(2*pi*sigma^2)*exp(-((m.^2)'+n.^2)/(2*sigma^2));
H = ifftshift(fft2(h1_matrix));
figure();
imagesc(log(abs(H)));
title('log-magnitude of H[k,l]');
%(b)
lena = double(imread('lena.jpg'))/255.0;
lena = imresize(lena, [256,256]); %[]內的數字根據H的大小變動
figure();
imshow(lena);

Lena = ifftshift(fft2(lena));
Lena_H = Lena .* H;
lena_h = fftshift(ifft2(Lena_H));
figure();
imshow(abs(lena_h));

%(c) 上面備註有寫 改sigma 得到新的filter 跟 lena.jpg
%(d)
hp = padarray(h1_matrix, [128 128],0,'both');
Hp = ifftshift(fft2(hp));
lenap = padarray(lena,[128 128],0,'both');
LENAp = ifftshift(fft2(lenap));
LENA_Hp = LENAp .* Hp;
lena_hp = fftshift(ifft2(LENA_Hp));
figure()
imshow(abs(lena_hp));
figure()
imshow((abs(lena_hp(129:384, 129:384, :))));
% 在正常卷積（y = h * x）中，filter窗口從圖像邊緣掉落。
% 作為正常卷積，此圖像受padding為零（在顯示圖像時為黑色）的圖像外環影響。
% 前一個由於圓卷積中的空間域混疊效應而遭受了額外的失真，就像我們通過環繞圖像外推圖像一樣。
% 因此，我們看不到黑框。

%(e) Not sure !!!
H1 = ones(size(H)) - H;
figure();
imagesc(log(abs(H1)));
title('log-magnitude of 1-H[k,l]');
LENA_H1 = Lena .* H1;
lena_h1 = ifft2(fftshift(LENA_H1)); %這邊不太一樣
figure();
imshow(abs(lena_h1));
