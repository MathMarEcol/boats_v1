boats-plots-review
------------------

Output and plots of The ecological module of BOATS-1.0: 
A bioenergetically-constrained model of marine upper trophic
levels suitable for studies of fisheries and ocean biogeochemistry 

Version
-------

Model output, forcing data, and plot script required to prepare plots of manuscript submitted
for review to Geoscientific Model Development.

Authors
-------

David A. Carozza  (david.carozza@gmail.com; corresponding author)

Daniele Bianchi   (dbianchi@atmos.ucla.edu)

Eric D. Galbraith (eric.d.galbraith@gmail.com)

Summary
-------

The plot script for BOATS-1.0 is written in MATLAB version R2012a. Here we provide the
script, forcing data, model output, and functions required to prepare the plots in the 
manuscript submitted for review to Geoscientific Model Development.

Usage and examples
------------------

Run the plot script plot_md_figs_GMD.m in MATLAB as:

plot_md_figs_GMD.m

Files
-----

boats0d_md_BEN_NH.mat

Output from 0-D simulation of warm-water (Benguela Current) site.

boats0d_md_EBS_NH.mat

Output from 0-D simulation of cold-water (East Bering Sea) site.

data_monthly-review.mat

Structure with net primary production, temperature, and other forcing data.

geo_time.mat

Structure with geographical and time variables.

lbmap.m

Matlab colormap

suite_NPP_vs_T_HR.mat

Summary diagnostics of sensitivity test considering net primary production
and temperature.

Licensing
---------

Copyright 2016 David Anthony Carozza
