dataFold='/Users/senthilp/Desktop/lanlan/matlab_code/podcast1/';
saveFold='/Users/senthilp/Desktop/lanlan/matlab_code/podcast1/spectrogram/';

frontal_elec = {'AF3', 'AF4', 'F7', 'F3', 'F4', 'F8', 'FC5', 'FC6'};
occ_elec = {'O1', 'O2'};

%------------- Parameters---------------------------------------%
N = 2.5;
overlap = .05;
freq_resolution = 4;
TW = (N * freq_resolution)/2;
K = floor(2 * TW)-1;

fs = 128;                    % Sampling Frequency
frequency_range = [0 60];    % Limit frequencies from 0 to 60 Hz
taper_params = [TW K];       % Time bandwidth and number of tapers
window_params = [N overlap]; % Window size is 2.5s with step size of .05s
min_nfft = 0;                % No minimum nfft
detrend_opt = 'constant';    % detrend each window by subtracting the average
weighting = 'unity';         % weight each taper at 1
plot_on = true;              % plot spectrogram
verbose = true;              % print extra info
%-------------------------------------------------------------%

for elecID=1:length(frontal_elec)
   
    elecIS = frontal_elec{elecID};
    mat_data = [ dataFold '/electrode' elecIS '.mat'];
    data = load(mat_data);
    saveData=[saveFold 'electrode_' elecIS '_spectrogram.mat'];
    data=data.chanData';
    [spect,stimes,sfreqs] = multitaper_spectrogram(data,fs,frequency_range, taper_params, window_params, min_nfft, detrend_opt, weighting, plot_on, verbose);
    save(saveData, 'spect','stimes','sfreqs','fs','N','Freq','overlap');
    
end




