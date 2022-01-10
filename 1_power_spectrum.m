saveFold='/Users/senthilp/Desktop/lanlan/subject1/';

elec = {'AF3', 'AF4', 'F7', 'F3', 'F4', 'F8', 'FC5',...
        'FC6', 'T7', 'T8', 'P7', 'P8', 'O1', 'O2'};   % electrodes of Interest

fs = 128; % Sampling freqeuncy (128 recordings per second)

% Power spectrum code
% Power spectrum is a function that represents the strength(power) of the
% channel oscillations at each frequency. It shows at which frequencies
% energy are strong and at which frequencies energy are weak. The
% theoretical basis for spectrum estimate is Fourier analysis which is a
% methods to decompose a time-domain signal into a series of pure sine
% waves of different wavelength. This is particularly useful in the
% analysis of EEG data, where the signal represents the combined activity
% of mutiple network of neruons throughout the brain that oscillate at
% different frequencies.

for elecID=1:length(elec)
    elecIS = elec{elecID};
    
    chanData_file = [saveFold 'electrode' elecIS '.mat'];
    load(chanData_file, 'chanData');
    
    [pxx,f] = pwelch(chanData,256,128,256,fs,'power');

    subplot(4, 4, elecID)
    plot(f,10*log10(pxx))
    xlabel('Frequency (Hz)')
    ylabel('Magnitude (dB)')
    title([elecIS ' Power spectrum']);
    grid
    clear chanData
end

% Purpose of FFT
% You have a time series channel data and you want to know which SINE
% waves with which FREQUENCIES, AMPLITUDE, PHASE will reconstruct that time
% series. Fourier analysis works by computing the dot product between the
% different SINE WAVES of different FREQUENCIES and the EEG data.








