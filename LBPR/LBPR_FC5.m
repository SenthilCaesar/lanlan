% Import raw CSV file
input_data = csvread('Podcast_Eyes_Closed_2.csv',2,0); % This excludes the first two rows
eegcols = 5:18; % EEG Columns
eeg.raw = input_data(:,eegcols);

% High pass filter the data to remove slow drifts
% High pass filter will center the data
fs = 128;
HP_freq = 0.5;
[b1,a1] = butter(6,HP_freq/(fs/2),'high');
x = filtfilt(b1,a1,eeg.raw);
eeg.HPfilt = filtfilt(b1,a1,x);

FC5data = eeg.HPfilt(:,4); % FC5

% Do FFT to computer power. We need the power value to know the TBP.
x = FC5data;
xdft = fft(x);
xdft = xdft(1:length(x)/2+1);
pw = abs(xdft).^2;
freq = 0:fs/length(x):fs/2;

% FC5 TBP
theta_L_index = 1249;
theta_H_index = 2496;
beta_L_index = 4366;
beta_H_index = 9354;

disp(['Theta band [' num2str(round(freq(theta_L_index))) ' - ' num2str(round(freq(theta_H_index))) ']']);
disp(['Beta band [' num2str(round(freq(beta_L_index))) ' - ' num2str(round(freq(beta_H_index))) ']']);

theta_L = pw(theta_L_index); % 4 Hz
theta_H = pw(theta_H_index); % 8 Hz
beta_L = pw(beta_L_index);   % 14 Hz
beta_H = pw(beta_H_index);   % 30 Hz

% FC5 LBPR
LBPR_TB_L = log(theta_L)/log(beta_L);
LBPR_TB_H = log(theta_H)/log(beta_H);

disp(' ');
disp(['LBPR Theta Beta low ratio ' num2str(LBPR_TB_L)]);
disp(['LBPR Theta Beta high ratio ' num2str(LBPR_TB_H)]);


