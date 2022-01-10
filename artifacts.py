import os
import mne
from mne.preprocessing import (ICA, create_eog_epochs, create_ecg_epochs,
                               corrmap)

lanlan_exp = '/Users/sxp116/Desktop/lanlan/lanlan_exp_5min.edf'
elec = ['AF3', 'AF4', 'F7', 'F3', 'F4', 'F8', 'FC5',
        'FC6', 'T7', 'T8', 'P7', 'P8', 'O1', 'O2'] 
sl = dict(eeg=10e-5,)

raw = mne.io.read_raw_edf(lanlan_exp, preload=True)
raw = raw.copy().pick_channels(elec)
raw.plot(scalings=sl, proj=False, remove_dc=True, duration=60.0)

montage_kind = "standard_1005"
montage = mne.channels.make_standard_montage(montage_kind)
raw.set_montage(montage, match_case=False)

filt_raw = raw.copy().load_data().filter(l_freq=1., h_freq=None)
ica = ICA(n_components=14, max_iter='auto', random_state=97)
ica.fit(filt_raw)
ica.plot_components()

ica.exclude = [0, 2, 3, 4, 5, 6, 7, 8, 10, 11]
reconst_raw = raw.copy()
ica.apply(reconst_raw)

fig1 = raw.plot(scalings=sl, proj=False, remove_dc=True, duration=60.0)
fig1.suptitle('Raw EEG signal', size='xx-large',weight='bold')
fig1.subplots_adjust(top=0.9)
fig1.savefig('eye_movements.png', dpi=600)

fig2 = reconst_raw.plot(scalings=sl, proj=False, remove_dc=True, duration=60.0)
fig2.suptitle('Applying ICA to Raw EEG signal', size='xx-large',weight='bold')
fig2.subplots_adjust(top=0.9)
fig2.savefig('eye_movements_removed.png', dpi=600)
