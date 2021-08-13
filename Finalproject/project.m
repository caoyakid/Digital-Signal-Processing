clear all;
%-------------------------------------------------
% 1. analyze the information about the audio file
%-------------------------------------------------
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
% plot
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

%繪出原音檔左右雙聲道複合頻譜
arrayx=(f_per_point:f_per_point:22050);

figure(2);
plot(arrayx, mag_y(1:len/2,:));
title('Both channel spectrum of original noisy audio file')
xlabel('Hz');
ylabel('mag of fft');
%繪出原音檔左聲道頻譜
figure(3);
plot(arrayx, mag_y(1:len/2,1));
title('Left channel spectrum of original noisy audio file')
xlabel('Hz');
ylabel('mag of fft');
%繪出原音檔右聲道頻譜
figure(4);
plot(arrayx, mag_y(1:len/2,1));
title('Right channel spectrum of original noisy audio file')
xlabel('Hz');
ylabel('mag of fft');

%-------------------------------------------------
% 2. Use matlab filter design toolbox to call comb filter
%-------------------------------------------------
disp(sprintf('-----------------------------------------\n'));
disp(sprintf('Start Calcualting - Toolbox\n'));
output = Comb(double(y));
disp(sprintf('Calcualting - Toolbox .... OK\n'));
disp(sprintf('-----------------------------------------\n'));

%-------------------------------------------------
% 3. Get the file and spectrum after filter 
%-------------------------------------------------
fft_output = fft(output);
mag_fft_output = abs(fft_output);
figure(5);
plot(arrayx, mag_fft_output(1:len/2,1));
title('Left channel spectrum of filtered audio file by Comb')

figure(6);
plot(arrayx, mag_fft_output(1:len/2,2));
title('Right channel spectrum of filtered audio file by Comb')

figure(7);
subplot(3,1,1)
plot_spectrum(output(:,1)+output(:,2),fs)
title('濾波後的音訊的頻譜')
xlabel('Hz')
ylabel('Magnitude')
grid on
axis([-inf inf -inf inf])
subplot(3,1,2)
plot_spectrogram(output(:,1)+output(:,2),fs)
title('濾波後的音訊的頻譜')
subplot(3,1,3)
plot_signal(output(:,1)+output(:,2),fs)
grid on
title('濾波後的音訊的波型')

%-------------------------------------------------
% 4. Output the audio file 
%-------------------------------------------------
%audiowrite('Lisa_1.wav',output,fs);













