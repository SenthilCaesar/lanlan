cfg            = [];
cfg.dataset    = 'Podcast_Eyes_Closed_2.edf';
cfg.continuous = 'yes';
cfg.channel    = {'AF3', 'AF4', 'F7', 'F3', 'F4', 'F8', 'FC5', 'FC6'};
data           = ft_preprocessing(cfg);

figure(1)
before = data.trial{1};
plot(before(1,:))
legend('Raw data')

cfg        = [];
cfg.numcomponent = 5;
cfg.method = 'runica';
comp = ft_componentanalysis(cfg, data);


% Remove the blink components
cfg = [];
cfg.component = [3 4]; % to be removed components
data = ft_rejectcomponent(cfg, comp, data);

figure(2)
after = data.trial{1};
plot(after(1,:))

legend('ICA filtered')
