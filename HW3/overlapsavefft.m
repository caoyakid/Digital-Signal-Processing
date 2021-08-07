function [y] = overlapsavefft(x,h,N)
% Overlap-Save method of block convolution
% ----------------------------------------
% [y] = ovrlpsav(x,h,N)
% y = output sequence
% x = input sequence
% h = impulse response
% N = block length

Lenx = length(x);
P = length(h);
P1 = P-1;
L = N-P1;
K = ceil((Lenx+P1)/(L)); % # of blocks

h = [h zeros(1,N-P)];
H = fft(h);
x = [zeros(1,P1), x, zeros(1,N-1)]; % preappend (P-1) zeros
Y = zeros(K,N);
% convolution with succesive blocks
for k=0:K-1
	xk = x(k*L+1:k*L+N);
    X = fft(xk);
    HX = H.*X;
	Y(k+1,:) = ifft(HX);
end
Y = Y(:,P:N)'; % discard the first (P-1) samples
y = (Y(:))'; % assemble output
end
