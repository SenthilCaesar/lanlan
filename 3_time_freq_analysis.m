saveFold='/Users/senthilp/Desktop/lanlan/subject1/';

% electrodes of Interest
elec = {'AF3', 'AF4', 'F7', 'F3', 'F4', 'F8', 'FC5',...
        'FC6', 'T7', 'T8', 'P7', 'P8', 'O1', 'O2'};   

fs = 128; % Sampling freqeuncy (128 recordings per second)


% Spectrogram shows the signal power as a function of time and frequency
% to observe how the frequency structure changes over time.
for elecID=1:length(elec)
    elecIS = elec{elecID};
    
    chanData_file = [saveFold 'electrode' elecIS '.mat'];
    load(chanData_file, 'chanData');
    chanData = chanData(1,:);

    %Time frequency analysis (Spectrogram) for each channel.
    cwt(chanData,'mors', fs);
    title(elecIS);
    imwrite(getframe(gcf).cdata, ['filename' num2str(elecID) '.png']);

end