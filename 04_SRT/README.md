# Seismic refraction tomography (SRT) data

## Raw data (01_raw)
This subfolder contains the seismic refraction tomography data sets of lakes Metzabok (MET) and Tzibaná (TZI) acquired in October 2019. The following table summarizes the available survey lines.

| Lake | Acquisition date | Line ID | Profile* | Geophones (spacing) | Total length | Remarks |
| --- | --- | --- | --- | --- | --- | --- |
| Metzabok | 10/11/2019  | MET19-3b | 2 | 24 (5 m) | 115 m | Central part of TDIP line MET19-3 (electrodes 13-36) |
| Metzabok | 10/13/2019  | MET19-5b | 4 | 24 (5 m) | 115 m | Central part of TDIP line MET19-5 (electrodes 13-36) |
| Tzibaná | 10/14/2019  | TZI19-1 | 5 | 24 (5 m) | 115 m | Central part of TDIP line MTZI19-1 (electrodes 13-36) |

*Profile number in the manuscript.

SRT data is provided as separate ASCII files *.dat* for each shot point. Information on the measurement parameters and shot-point locations along the line are summarized in the *info.txt* files in the corresponding subdirectories.

GPS positions (datum: WGS84) of 2-3 geophones along each SRT line are listed in the file *SRT_GPS.txt*. 

For line TZI19-1, which has a significant topograpy, we also include a *.txt* file with the description of the geophone positions (1st column: geophone number, 2nd column: distance along the line; 3rd column: estimated altitude - relative to lowest geophone along the line.)

## Processed data (02_processed)
This subfolder contains the picked first arrivals used for the inversion.

## P-wave velocity models (03_models)
This subfolder contains the fine-element grids used for the inversion as well as the p-wave velocity models obtained with the geophysical inversion package pyGIMLi (Rücker et al., 2017).

## Visualization (04_visualization)
The visualization directory contains Matlab scripts (*.m* files) for the visualization of the inverted data.

To read the *.vtk* mesh files used by pyGIMLi, we use elements of a Matlab script prepared by Mario Richtsfeld (2020).

Instead of the default Matlab colormaps, we use the perceptually uniform colormaps *plasma.m* implemented for Matlab by Ander Biguri (2020), which were originally designed for python´s matplotlib (see  https://bids.github.io/colormap/).

## GIS files (*SRT_shp.zip*)
GIS files for all SRT lines.

## References
Biguri, Ander (2020). Perceptually uniform colormaps (https://www.mathworks.com/matlabcentral/fileexchange/51986-perceptually-uniform-colormaps), MATLAB Central File Exchange. Retrieved March 31, 2020.

Richtsfeld, Mario (2020). read_vtk.m (https://github.com/gpeyre/matlab-toolboxes/blob/master/toolbox_graph/read_vtk.m), Github, Retrieved February, 2020.

Rücker, C., Günther, T., Wagner, F. M. (2017). pyGIMLi: An open-source library for modelling and inversion in geophysics, Computers and Geosciences, 109, 106-123.
