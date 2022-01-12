% Median of Spectrogram
% The following code will load and calculate the median for a group of channels

% Location of the Spectrogram
specFold='/Users/senthilp/Desktop/lanlan/matlab_code/podcast1/spectrogram/';
subIS='exp1';
electrodes = {'AF3', 'AF4', 'F7', 'F3', 'F4', 'F8', 'FC5', 'FC6'};
%electrodes = {'O1', 'O2'};

for elecID=1:length(electrodes)
    elecIS=electrodes{elecID};
    
    specData=[specFold 'electrode_' elecIS '_spectrogram.mat'];
    load(specData,'spect','stimes','sfreqs','fs')
    
    if elecID==1
        %Initiating Data Matrices
        frontStack=zeros(length(electrodes),length(stimes),length(sfreqs));
    end

    frontStack(elecID,:,:) = spect';
    clear spect
end
clear specFold elecIS elecID

%--------------- Taking the Median of the Data ---------------------
figure;
FRmed=squeeze(median(frontStack));
colormap('jet');
imagesc(stimes,sfreqs,nanpow2db(FRmed'));
c = colorbar;
caxis([-30 30])
ax = gca;
ax.YDir = 'normal';
title('Median of Frontal electrodes 5 minute Activity');
xlabel('Time [s]');
ylabel('Frequency [Hz]');
%---------------------------------------------------------------------


function ydB = nanpow2db(y)
    ydB = (10.*log10(y)+300)-300;
    ydB(y(:)<=0) = nan;
end