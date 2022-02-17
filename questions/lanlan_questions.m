fs = 256; % Sampling frequency (samples per second) 
dt = 1/fs; % seconds per sample 
StopTime = 10; % seconds 
t = (0:dt:StopTime)'; % seconds 

F1 = 1; % Sine wave frequency (1 hertz) 
F5 = 5; % Sine wave frequency (5 hertz) 
F8 = 8; % Sine wave frequency (8 hertz) 
F3 = 9;

data1 = sin(2*pi*F1*t);
data2 = sin(2*pi*F5*t);
data3 = sin(2*pi*F8*t);
data4 = sin(2*pi*F3*t);

mixed_data = data1 + data2 + data3;

figure(1);
plot(t, data1);
xlabel('Time in sec','FontSize', 15);
ylabel('Micro Volt', 'FontSize', 15);
title('1 Hz', 'FontSize', 20);

figure(2);
plot(t, data2);
xlabel('Time in sec','FontSize', 15);
ylabel('Micro Volt', 'FontSize', 15);
title('5 Hz', 'FontSize', 20);

figure(3);
plot(t, data3);
xlabel('Time in sec','FontSize', 15);
ylabel('Micro Volt', 'FontSize', 15);
title('8 Hz', 'FontSize', 20);

figure(4);
plot(t,mixed_data);
xlabel('Time in sec','FontSize', 15);
ylabel('Micro Volt', 'FontSize', 15);
title('1+5+8 Hz', 'FontSize', 20);


[X,f,t] = mydft(mixed_data, fs);
figure(5);
plot(f(1:100),abs(X));
xlabel('Frequency','FontSize', 15);
ylabel('Power', 'FontSize', 15);
title('Static Power spectrum', 'FontSize', 20);

figure(6);
spectrogram(mixed_data,256,128,256,fs,'yaxis')
colormap('jet');
xlabel('Time in sec','FontSize', 15);
ylabel('Frequency', 'FontSize', 15);
title('Dynamic Power spectrum', 'FontSize', 20);


plot(t, mixed_data);
hold on
plot(t, data4, 'r');
xlabel('Time in sec','FontSize', 15);
ylabel('Micro Volt', 'FontSize', 15);
legend('Raw EEG signal', '9Hz sine wave', 'FontSize', 15)
title('dot(EEG signal, 9Hz sine wave)/length(EEG signal) = -3.9071e-13', 'FontSize', 20);
hold off


%-- Filtering in time domain--------------
frange = [7.9 8.1];
nyquist = fs/2;

[b1,a1]=butter(6,frange(1)/nyquist,'high'); % Change band here
[b2,a2]=butter(6,frange(2)/nyquist,'low'); % Change band here
x= filtfilt(b1,a1,mixed_data);
filteredCh= filtfilt(b2,a2,x);
timeVec=(1:length(mixed_data))/fs;
clear a1 b1 a2 b2 x

plot(timeVec, mixed_data); % raw EEG signal
hold on
plot(timeVec, filteredCh, 'r'); % Filtered signal
xlabel('Time [s]');
ylabel('Micro Volts');
legend({'8Hz filtered'},'FontSize',10);
%-----------------------------------------------------




% Filtering in frequency---------------------------------------------
[X,f,t] = mydft(mixed_data, fs);
figure(5);
plot(f(1:100),abs(X));
hold on
[X1,f1,t1] = mydft(filteredCh, fs);
figure(5);
plot(f1(1:100),abs(X1));
xlabel('Frequency','FontSize', 15);
ylabel('Power', 'FontSize', 15);
title('Frequency domain', 'FontSize', 20);
legend({'Original signal power spectrum','Filtered signal power spectrum'},'FontSize',10);
%---------------------------------------------------------------------



function [ X,f,t ] = mydft(x,Fs)
     N = size(x,1);
     dt = 1/Fs;
     t = dt*(0:N-1)';
     dF = Fs/N;
     f = dF*(0:N/2-1)';
     X = fft(x)/N;
     X = X(1:floor(N/2));
     X = X(1:100);
end
