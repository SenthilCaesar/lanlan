import mne
import pandas as pd
import numpy as np
from save_edf import write_mne_edf
 
# reading csv file
df = pd.read_csv("eye_open_1.csv", skiprows=[0])

df_ch = df.iloc[:, 4:18]
data = df_ch.to_numpy()
data = np.swapaxes(data,0,1)

ch_names = list(df_ch.columns)
sfreq = 128
info = mne.create_info(ch_names, sfreq, ch_types=['eeg'] * 14)
raw = mne.io.RawArray(data, info)

write_mne_edf(raw, 'test.edf', overwrite=True)
