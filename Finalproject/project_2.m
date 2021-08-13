clear all;
%%
[y, fs] = audioread('Lisa_noise.wav');

len = length(y); %audio length
fft_y = fft(y); %signal of fft
mag_y = abs(fft_y); %sqr(r^2+i^2)
f_per_point = double(fs/length(fft_y)); %經fft後每一點之頻寬值

% show para.
disp(sprintf('Sampling rate = %u Hz\n',fs));
disp(sprintf('Dimension of Audio Data =  %u x %u\n ',size(y)));
disp(sprintf('Length of Audio Data =  %u\n ',len));
disp(sprintf('Freq per point in FFT Result =  %3.6f Hz/Point\n ',f_per_point));

figure(1)
subplot(3,1,1)
plot_spectrum(y(:,1)+y(:,2),fs)
title('濾波前的音訊的頻譜')
xlabel('Hz')
ylabel('Magnitude')
grid on
axis([-inf inf -inf inf])
subplot(3,1,2)
plot_spectrogram(y(:,1)+y(:,2),fs)
title('濾波前的音訊的頻譜')
subplot(3,1,3)
plot_signal(y(:,1)+y(:,2),fs)
grid on
title('濾波前的音訊的波型')

%para
Fstop = 6500;
Fpass = 4500;
Astop = 400;
Apass = 1;
%-------------------------------------------------
% filter1: chebyshev I
d1= designfilt('lowpassiir','StopbandFrequency',Fstop, ...
  'PassbandFrequency',Fpass,'StopbandAttenuation',Astop, ...
  'PassbandRipple',Apass,'SampleRate',fs,'DesignMethod','cheby1');

y_cheb = filter(d1,y);
%plot
figure(2)
subplot(3,1,1)
plot_spectrum(y_cheb(:,1)+y_cheb(:,2),fs)
title('濾波後的音訊的頻譜')
xlabel('Hz')
ylabel('Magnitude')
grid on
axis([-inf inf -inf inf])
subplot(3,1,2)
plot_spectrogram(y_cheb(:,1)+y_cheb(:,2),fs)
title('濾波後的音訊的頻譜')
subplot(3,1,3)
plot_signal(y_cheb(:,1)+y_cheb(:,2),fs)
grid on
title('濾波後的音訊的波型')

%-------------------------------------------------
% filter2: Butterworth(for specific frequency)
%除掉600Hz的雜音
d2= designfilt('bandstopiir','FilterOrder',8, ...
    'HalfPowerFrequency1',599,'HalfPowerFrequency2',601, ...
    'DesignMethod','butter','SampleRate',fs);
%除掉1200Hz的雜音
d3= designfilt('bandstopiir','FilterOrder',8, ...
    'HalfPowerFrequency1',1199,'HalfPowerFrequency2',1201, ...
    'DesignMethod','butter','SampleRate',fs);
%除掉1800Hz的雜音
d4= designfilt('bandstopiir','FilterOrder',8, ...
    'HalfPowerFrequency1',1799,'HalfPowerFrequency2',1801, ...
    'DesignMethod','butter','SampleRate',fs);
%除掉2400Hz的雜音
d5= designfilt('bandstopiir','FilterOrder',8, ...
    'HalfPowerFrequency1',2399,'HalfPowerFrequency2',2401, ...
    'DesignMethod','butter','SampleRate',fs);
%除掉3000Hz的雜音
d6= designfilt('bandstopiir','FilterOrder',8, ...
    'HalfPowerFrequency1',2999,'HalfPowerFrequency2',3001, ...
    'DesignMethod','butter','SampleRate',fs);
%除掉3600Hz的雜音
d7= designfilt('bandstopiir','FilterOrder',8, ...
    'HalfPowerFrequency1',3599,'HalfPowerFrequency2',3601, ...
    'DesignMethod','butter','SampleRate',fs);
%除掉4200Hz的雜音
d8= designfilt('bandstopiir','FilterOrder',8, ...
    'HalfPowerFrequency1',4199,'HalfPowerFrequency2',4201, ...
    'DesignMethod','butter','SampleRate',fs);

y_butt = filter(d2,y);
y_butt = filter(d3,y_butt);
y_butt = filter(d4,y_butt);
y_butt = filter(d5,y_butt);
y_butt = filter(d6,y_butt);
y_butt = filter(d7,y_butt);
y_butt = filter(d8,y_butt);

figure(3)
subplot(3,1,1)
plot_spectrum(y_butt(:,1)+y_butt(:,2),fs)
title('濾波後並且去掉特定頻率音訊的頻譜')
xlabel('Hz')
ylabel('Magnitude')
grid on
axis([-inf inf -inf 18.15])
subplot(3,1,2)
plot_spectrogram(y_butt(:,1)+y_butt(:,2),fs)
title('濾波後並且去掉特定頻率音訊的頻譜')
subplot(3,1,3)
plot_signal(y_butt(:,1)+y_butt(:,2),fs)
grid on
title('濾波後並且去掉特定頻率音訊的波型')

%%
fvtool(d1)
title('Chebyshev type1 IIR lowpass Filter')

fvtool(d2,d3,d4,d5,d6,d7,d8)
legend('600Hz','1200Hz','1800Hz','2400Hz','3000Hz','3600Hz','4200Hz')
title('Butterworth BandStop IIR Filter')
axis([-inf 5 -0.6 0.5])

%audiowrite('Lisa_2.wav',2*y_cheb, fs);
%audiowrite('Lisa_3.wav',2*y_butt, fs);