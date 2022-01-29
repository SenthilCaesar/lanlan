input_data = csvread('Podcast_Eye_Closed_2_Chinese.csv',2,0); % This excludes the first two rows
eegcols = 5:18; % EEG Columns
eeg.raw = input_data(:,eegcols);

% AF3
channel_data = eeg.raw(:,1);


%------------- Time frequncy analysis Parameters---------------------------%
N = 2.5;
overlap = .05;
freq_resolution = 4;
TW = (N * freq_resolution)/2;
K = floor(2 * TW)-1;

fs = 128;                    % Sampling Frequency
frequency_range = [0 64];    % Limit frequencies from 0 to 60 Hz
taper_params = [TW K];       % Time bandwidth and number of tapers
window_params = [N overlap]; % Window size is 2.5s with step size of .05s
min_nfft = 0;                % No minimum nfft
detrend_opt = 'constant';    % detrend each window by subtracting the average
weighting = 'unity';         % weight each taper at 1
plot_on = true;              % plot spectrogram
verbose = true;              % print extra info
%-------------------------------------------------------------%

saveData='lanlan_spectrogram.mat';
[spect,stimes,sfreqs] = multitaper_spectrogram(channel_data,fs,frequency_range, taper_params, window_params, min_nfft, detrend_opt, weighting, plot_on, verbose);
save(saveData, 'spect','stimes','sfreqs','fs','N','overlap');

theta_pw = bandpower(spect, sfreqs, [4,8], 'psd');
plot(stimes, theta_pw)
title('Real time Theta band power')
xlabel('Time');
ylabel('Power');



