function plot_signal(y,FS)
% plot time-domain signal
%
% usage:
%   plot_time(y,FS)
%   y  : signal
%   FS : sampling rate 

fprintf('Plotting time-domain signal...\n')
time = linspace(0,length(y)/FS,length(y));
plot(time,y)
xlabel('Time (secs)')
ylabel('Amplitude')
axis([min(time) max(time) -1.1 +1.1])
grid on

end

