# Time-domain induced polarization (TDIP) data

## Raw data (01_raw)
This subfolder contains the time-domain induced polarization data sets of lakes Metzabok (MET) and Tzibaná (TZI) acquired in October 2019. The following table summarizes the available survey lines.

| Lake | Acquisition date | Line ID | Profile* | Electrodes (spacing) | Total length | Remarks |
| --- | --- | --- | --- | --- | --- | --- |
| Metzabok | 10/08/2019  | MET19-1 | 1 | 48 (10 m) | 470 m | Starting from the northern shore |
| Metzabok | 10/08/2019  | MET19-2 | 1 | 48 (10 m) | 470 m | Roll along, overlap 24 electrodes with MET19-1 |
| Metzabok | 10/09/2019  | MET19-3 | 2 | 48 (5 m) | 235 m | Parallel to MET19-2, shifted 10 m East |
| Metzabok | 10/09/2019  | MET19-4 | 3 | 24 (5 m) | 115 m | Perpendicular to MET19-3, centred at residual pond |
| Metzabok | 10/10/2019  | MET19-5 | 4 | 48 (5 m) | 235 m | Along TEM line, roughly soundings MET3-MET7 |
| Metzabok | 10/11/2019  | MET19-6 | - | 24 (5 m) | 115 m | Parallel to MET19-1/2, shifted ~20 m East |
| Metzabok | 10/13/2019  | MET19-7 | - | 48 (5 m) | 235 m | Crossing land bridge from Metzabok to Tzibaná |
| Metzabok | 10/14/2019  | TZI19-1 | - | 48 (5/10 m) | 235 m | On river delta; #1-12 and #36-48 - 10 m |

*Survey lines, which are not associated with a profile are not included in the manuscript.

DD (TDIP) and We (ERT),

For every line, TEM sounding data are provided as a separate *.tem* file for each sounding. Location and water-depth data for the soundings are listed for each lake in the *.txt* files included in the raw-data directory. 

## Smooth models (02_smooth_models)
This subfolder contains the smooth 20-layer resistivity models inverted with the geophysical inversion software ZondTEM1d (Kaminsky, 2001).

The *.xls* files are have been created with the software ZondTEM1d and contain the processed sounding data and the adjusted 20-layer models. The Matlab scripts *xls2txt.m* included in the model directories have to be run to export the models to *.txt* files prior to visualization.

## Visualization (03_visualization)
The visualization directory contains Matlab scripts (*.m* files) for the visualization of the inverted data and *.txt* files with the positions of the individual TEM soundings along the profiles (Profile 4 of Lake Metzabok and Profile 5 of Lake Tziabaná) presented in the manuscript.

Instead of the default Matlab colormaps, we use the perceptually uniform colormap *viridis.m* implemented for Matlab by Ander Biguri (2020), which were originally designed for python´s matplotlib (see  https://bids.github.io/colormap/).

## References
Biguri, Ander (2020). Perceptually uniform colormaps (https://www.mathworks.com/matlabcentral/fileexchange/51986-perceptually-uniform-colormaps), MATLAB Central File Exchange. Retrieved March 31, 2020.

Kaminsky, Alex (Zond software corporation). 2001. Zondtem1d. Version 28092019. http://zond-geo.com/english/zond-software/electromagnetic-sounding/zondtem1d/.
