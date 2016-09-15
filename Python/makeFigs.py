from __future__ import division
import pandas as pd
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
import seaborn as sns
import os

mydir = os.path.expanduser("~/github/RPF_RNA/")

def site_by_gene():
    IN = pd.read_csv(mydir + 'data/cuffdiff_out/genes.read_group_tracking', sep = '\t')
    names = IN.tracking_id.values[::12]
    #IN = IN.set_index('tracking_id')
    site_by_gene = pd.DataFrame()
    named_df = pd.DataFrame({'tracking_id': names})
    site_by_gene = pd.concat([site_by_gene,named_df], ignore_index=True, axis=1)
    #site_by_gene = site_by_gene.append(index)
    treatments = ['D', 'DR', 'V', 'VR']
    for treatment in treatments:
        IN_treat = IN.loc[IN['condition'] == treatment]
        for i in range(3):
            IN_treat_i = IN_treat.iloc[i::3, 6].values
            data_i = pd.DataFrame({treatment + str(i+1): IN_treat_i})
            site_by_gene = pd.concat([site_by_gene,data_i], ignore_index=True, axis=1)
    site_by_gene = site_by_gene.set_index(0)
    site_by_gene.columns = ['D1', 'D2', 'D3', 'DR1', 'DR2', 'DR3', \
        'V1', 'V2', 'V3', 'VR1', 'VR2', 'VR3']
    site_by_gene.to_csv(mydir + 'data/site_by_gene.txt', sep = '\t', index = True, header = True)

def expressionBoxplot():
    IN = pd.read_csv(mydir + 'data/cuffdiff_out/genes.count_tracking', sep = '\t')
    data_to_plot = [IN.D_count.values, IN.DR_count.values, IN.V_count.values, IN.VR_count.values]
    data_to_plot = [np.log10(x) for x in data_to_plot]
    # Create a figure instance
    fig = plt.figure(1, figsize=(9, 6))

    # Create an axes instance
    ax = fig.add_subplot(111)

    ## add patch_artist=True option to ax.boxplot()
    ## to get fill color
    bp = ax.boxplot(data_to_plot, patch_artist=True)

    ## change outline color, fill color and linewidth of the boxes
    for box in bp['boxes']:
        # change outline color
        box.set( color='#7570b3', linewidth=2)
        # change fill color
        box.set( facecolor = '#1b9e77' )

    ## change color and linewidth of the whiskers
    for whisker in bp['whiskers']:
        whisker.set(color='#7570b3', linewidth=2)

    ## change color and linewidth of the caps
    for cap in bp['caps']:
        cap.set(color='#7570b3', linewidth=2)

    ## change color and linewidth of the medians
    for median in bp['medians']:
        median.set(color='#b2df8a', linewidth=2)

    ## change the style of fliers and their fill
    for flier in bp['fliers']:
        flier.set(marker='o', color='#e7298a', alpha=0.5)

    ## Custom x-axis labels
    ax.set_xticklabels(['Dormant', 'Dormant + RPF', 'Viable', 'Viable + RPF'])
    ## Remove top axes and right axes ticks
    ax.get_xaxis().tick_bottom()
    ax.get_yaxis().tick_left()

    # Save the figure
    fig.savefig(mydir + 'figs/fig1.png', bbox_inches='tight')


def expressionHeatmap():
    IN = pd.read_csv(mydir + 'data/site_by_gene.txt', sep = '\t', index_col=0)
    IN = IN[(IN.T != 0).any()]
    IN.columns = ['Dormant', 'Dormant', 'Dormant', 'Dormant + RPF', 'Dormant + RPF', 'Dormant + RPF', \
        'Viable', 'Viable', 'Viable', 'Viable + RPF', 'Viable + RPF', 'Viable + RPF']
    #cmap = sns.cubehelix_palette(as_cmap=True, light=1, rot=-.3)
    #IN_norm = IN.div(IN.sum(axis=1), axis=0)
    #IN_norm = IN_norm.dropna(axis = 0)
    g = sns.clustermap(IN,  z_score=0)
    plt.setp(g.ax_heatmap.xaxis.get_majorticklabels(), rotation=90)
    #g = sns.clustermap(IN_norm)
    g.savefig(mydir + 'figs/fig2.png')

def clean_axis(ax):
    """Remove ticks, tick labels, and frame from axis"""
    ax.get_xaxis().set_ticks([])
    ax.get_yaxis().set_ticks([])
    for sp in ax.spines.values():
        sp.set_visible(False)




def testHeatmap():
    IN = pd.read_csv(mydir + 'data/site_by_gene.txt', sep = '\t', index_col=0)
    #IN = IN[(IN.T != 0).any()]
    IN.columns = ['Dormant', 'Dormant', 'Dormant', 'Dormant + RPF', 'Dormant + RPF', 'Dormant + RPF', \
        'Viable', 'Viable', 'Viable', 'Viable + RPF', 'Viable + RPF', 'Viable + RPF']
    IN_norm = IN.div(IN.sum(axis=1), axis=0)
    IN_norm = IN_norm.dropna(axis = 0)

    #mpl.rcParams.update({'font.size': 16})
    # Arial font
    #mpl.rc('font',**{'family':'sans-serif','sans-serif':['Arial']})

    axi = plt.imshow(IN_norm,interpolation='nearest',cmap=mpl.cm.RdBu)
    ax = axi.get_axes()
    clean_axis(ax)
    plt.savefig(mydir + 'figs/test.png', bbox_inches='tight')


expressionHeatmap()

#expressionHeatmap()
