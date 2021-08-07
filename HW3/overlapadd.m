function [y] = overlapadd(x,h,N)
% Overlap-Add method of block convolution
% [y] = overlapadd(x,h,N)
%
% y = output sequence
% x = input sequence
% h = impulse response
% N = block length >= 2*length(h)-1

Lenx = length(x);
P = length(h);
P1 = P-1;
L = N-P1;
K = ceil(Lenx/L); % # of blocks

h = [h zeros(1,N-P)];
x = [x zeros(1,L-1)];
y = zeros(1, Lenx+L-1);
% convolution with succesive blocks
for k=0:K-1
	xk = [x(k*L+1:k*L+L) zeros(1, N-L)];
	y(k*L+1:k*L+N) = y(k*L+1:k*L+N) + cconv(xk,h,N);
end
end
