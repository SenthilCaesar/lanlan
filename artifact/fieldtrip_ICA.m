cfg            = [];
cfg.dataset    = 'eye_open_2.edf';
cfg.continuous = 'yes';
cfg.channel    = {'AF3', 'AF4', 'F7', 'F3', 'F4', 'F8', 'FC5', 'FC6',...
                   'T7', 'T8', 'P7', 'P8', 'O1', 'O2'};
data           = ft_preprocessing(cfg);

before = data.trial{1};
subplot(2,1,1)
plot(before(1,:))
legend('Raw data')

cfg        = [];
cfg.numcomponent = 5;
cfg.method = 'runica';
comp = ft_componentanalysis(cfg, data);


% Remove the blink components
cfg = [];
cfg.component = (2); % to be removed components
data = ft_rejectcomponent(cfg, comp, data);


after = data.trial{1};
subplot(2,1,2)
plot(after(1,:))

legend('ICA filtered')
