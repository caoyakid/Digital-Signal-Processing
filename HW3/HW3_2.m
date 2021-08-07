clc;
clear all;
close all;
%% 2.
n = (0:1:3999);
x = cos(pi*n/500);
h = [1 -1 1 -1];

% 請參見附的m檔 function
y = conv(x,h);
y1 = overlapadd(x,h,128);
y2 = overlapsave(x,h,128);
y3 = overlapaddfft(x,h,128);
y4 = overlapsavefft(x,h,128);

figure(1);
plot(y,'linewidth',2);
title('y = conv(x,h)');
xlim([0 4001]);
ylim([-1 1]);

figure(2);
sgtitle('Computing in Time Domain (Low Speed)','FontSize',18)
subplot(2,1,1);
plot(y1(1:4003),'linewidth',2);
title('y1 = overlapadd(x,h,128)');
xlim([0 4001]);
subplot(2,1,2);
plot(y2(1:4003),'linewidth',2);
title('y2 = overlapsave(x,h,128);');
xlim([0 4001]);
figure(3);
sgtitle('Computing in Time Domain (High Speed)','FontSize',18)
subplot(2,1,1);
plot(y3(1:4003),'linewidth',2);
title('y3 = overlapaddfft(x,h,128);');
xlim([0 4001]);
subplot(2,1,2);
plot(y4(1:4003),'linewidth',2);
title('y4 = overlapsavefft(x,h,128);');
xlim([0 4001]);

norm(y-y1(1:4003))
norm(y-y2(1:4003))
norm(y-y3(1:4003))
norm(y-y4(1:4003))
