clc;
clear all;
close all;
%% 3
%mode=1為題目要求解法，mode=2為逐項代入
%%
%設定參數
mode=1;
N=101;
NN=linspace(-2,N,N+2);
y(1)=-3;
y(2)=-2;
x(1)=1;
x(2)=1;

switch mode

    case 1
        
        for i=1:N
            x(i+2)=cos(i*pi/3);
        end  
        
        b11=[1 1 1];
        b12=[1 -1/2];
        a11=[3 -0.95*3 0.9025*3];
        a12=[1 -1 1];     
        
        b21=[-1.47416 2.805];
        b22=[1 -1 1];
        a21= [1 -0.95 0.9025];
        a22=[1 -1 1];
        
        %%
        %以conv計算乘開後的各項數
        b1=conv(b11,b12);
        a1=conv(a11,a12);
        b2=conv(b21,b22);
       
        b=b1+b2;
        a=a1;
      %%
       %以filter函式計算y[n]
        imp = [1,zeros(1,100)];
        y= filter(b,a,imp);
        y=[-3 -2 y];
   %%
       %以residuez函式計算部分分式
       [r,p,k] = residuez(b,a);
    
 
    case 2      %逐項代入
        for i=1:N
            x(i+2)=cos(i*pi/3);
            y(i+2)=(1/3)*(x(i+2)+x(i+1)+x(i))+0.95*y(i+1)-0.9025*y(i); 
        end
end
%%
%繪圖
subplot(2,1,1)
stem(NN,x);
grid on
axis([-inf,inf,-inf,inf])
title('x[n]')
ylabel('y[n]')
xlabel('n')

subplot(2,1,2)
stem(NN,y);
grid on
axis([-inf,inf,-inf,inf])
title('y[n]')
ylabel('y[n]')
xlabel('n')