saveFold='/Users/senthilp/Desktop/lanlan/subject1/';

edfData = '/Users/senthilp/Desktop/lanlan/subject1/lanlan_exp_5min.edf';

electrodes = {'TIME_STAMP_s' 'TIME_STAMP_ms' 'OR_TIME_STAMP_s' 'OR_TIME_STAMP_ms' 'COUNTER' 'INTERPOLATED'... 
'AF3' 'F7' 'F3' 'FC5' 'T7' 'P7' 'O1' 'O2' 'P8' 'T8' 'FC6' 'F4' 'F8' 'AF4' 'RAW_CQ' 'BATTERY' 'BATTERY_PERCENT' 'MarkerIndex' 'MarkerType'...
'MarkerValueInt' 'MARKER_HARDWARE' 'CQ_AF3' 'CQ_F7' 'CQ_F3' 'CQ_FC5' 'CQ_T7' 'CQ_P7' 'CQ_O1' 'CQ_O2' 'CQ_P8' 'CQ_T8'...
'CQ_FC6' 'CQ_F4' 'CQ_F8' 'CQ_AF4' 'CQ_OVERALL' 'EQ_SampleRateQua' 'EQ_OVERALL' 'EQ_AF3' 'EQ_F7' 'EQ_F3' 'EQ_FC5' 'EQ_T7'...
'EQ_P7' 'EQ_O1' 'EQ_O2' 'EQ_P8' 'EQ_T8' 'EQ_FC6' 'EQ_F4' 'EQ_F8' 'EQ_AF4' 'CQ_CMS' 'CQ_DRL'};

[header,record]=edfread(edfData);

subIS='subject1';

for elecID=1:length(electrodes)
    elecIS=electrodes{elecID};
    
    savData=[saveFold 'electrode' elecIS '.mat'];

    %Saving Individual Channels
    chanData = record(elecID,:);
    Characteristics.fs = header.samples(elecID)/header.duration;
    Characteristics.units = header.units(elecID);
    
    
    save(savData,'chanData','Characteristics','subIS','elecIS');
    clear chan Characteristics 

end