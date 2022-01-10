saveFold='/Users/senthilp/Desktop/lanlan/subject1/';

elec = {'AF3', 'AF4', 'F7', 'F3', 'F4', 'F8', 'FC5',...
        'FC6', 'T7', 'T8', 'P7', 'P8', 'O1', 'O2'};   % electrodes of Interest

% Frequency Bands
delta = [0.5 4];
theta = [4 8];
alpha = [8 12];
sigma = [12 15];
beta = [15 30];

fs = 128; % Sampling rate (128 recordings per second)

%------code to filter the signal around specific band of interest-----%
for elecID=1:length(elec)
    elecIS = elec{elecID};
    
    chanData_file = [saveFold 'electrode' elecIS '.mat'];
    load(chanData_file, 'chanData');
   
    % Butterworth IIR filter
    [b1,a1]=butter(6,delta(1)/(fs/2),'high'); % Change band here
    [b2,a2]=butter(6,delta(2)/(fs/2),'low'); % Change band here
    x= filtfilt(b1,a1,chanData);
    filteredCh= filtfilt(b2,a2,x);
    timeVec=(1:length(chanData))/fs;
    clear a1 b1 a2 b2 x
    
    subplot(4, 4, elecID)
    
    plot(timeVec, chanData-mean(chanData)); % raw EEG signal
    hold on
    plot(timeVec, filteredCh); % Filtered signal
    xlabel('Time [s]');
    ylabel('Micro Volts');
    title(elecIS);
    legend({'Raw EEG','Delta band filtered'},'FontSize',10);
end
