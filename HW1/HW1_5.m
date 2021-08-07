clc;
clear all;
close all;
%% 5
b50 = 0.05634;
b51 = [1 1];
b52 = [1 -1.0166 1];
a51 = [1 -0.683];
a52 = [1 -1.4461 0.7957];

zero5 = roots(b51);
zero5 = cat(1, zero5, roots(b52));
pole5 = roots(a51);
pole5 = cat(1, pole5, roots(a52));

figure
zplane(zero5, pole5);
title('zplane');

%% Problem 5b
sos5 = zp2sos(zero5, pole5, b50);
figure()
freqz(sos5, 'whole');
figure()
grpdelay(sos5, 512, 'whole');

%% Problem 5c
b53 = b50 * conv(b51, b52);
a53 = conv(a51, a52);
figure()
freqz(b53, a53, 'whole');
figure()
grpdelay(b53, a53, 512, 'whole');

%% Problem 5d
[r5,p5,k5] = residuez(b53,a53);

%% Problem 5e
L5 = 50;
impz(b53,a53,L5);
