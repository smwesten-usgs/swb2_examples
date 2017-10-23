import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.colors import ListedColormap
import seaborn as sns

# create dataset
residue_state_options = ['H', '0', 'S', 'b']
residue_state_arr = np.random.choice(residue_state_options,
                                     (100, 100), p=[0.7, 0.1, 0.1, 0.1])

df = pd.DataFrame(residue_state_arr)

# map dataset to numbers
residue_state_map = {'H': 0, '0': 1, 'S': 2, 'b': 3}
df.replace(residue_state_map, inplace=True)


colors = ['#edf8fb', '#b2e2e2', '#66c2a4', '#238b45']

grid_kws = {'height_ratios': (0.9, 0.05), 'hspace': 0.2}
fig, (ax, cbar_ax) = plt.subplots(2, gridspec_kw=grid_kws)
ax = sns.heatmap(df, ax=ax, cbar_ax=cbar_ax, cmap=ListedColormap(colors),
                 xticklabels=False, yticklabels=False,
                 cbar_kws={'orientation': 'vertical'})

cbar_ax.set_yticklabels(residue_state_options)
cbar_ax.yaxis.set_ticks([0.125,  0.375,  0.625,  0.875])
