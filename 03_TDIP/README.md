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
| Metzabok-Tzibaná | 10/13/2019  | MET19-7 | - | 48 (5 m) | 235 m | Crossing land bridge from Metzabok to Tzibaná |
| Tzibaná | 10/14/2019  | TZI19-1 | 5 | 48 (5/10 m) | 345 m | On river delta; #1-12 and #36-48: 10 m spacing, #12-36: 5 m spacing |

*Profile number in the manuscript. Survey lines without profile number are not included in the manuscript.

All survey lines where measured with a Dipole-Dipole (DD) and a Wenner (We) configuration. DD measurements include TDIP data, We only electrical resistivity (no IP data).

TDIP data is provided as binary files *.bin*, which can be read, processed and exported to *.txt* files with the Prosys II software available free of charge on the homepage of the manufacturer of the measuring device (http://www.iris-instruments.com/download.html#processing). 

For lines with significant topograpy, we also include *.txt* files with the description of the electrode positions (1st column: electrode number, 2nd column: distance along the line; 3rd column: estimated altitude - relative to lowest electrode along the line.)

## Processed data (02_processesed)
This subfolder contains the filtered data used for the inversion. The first two columns of the *.crt* files contain the electrode numbers of the four-point measurement (format: A*10,000+B and M*10,000+N), the third the transfer resistance (in Ohm.m), and the fourth the phase (mrad) obtained by linearly converting the TDIP chargeability (see manuscript for more details).

## Complex-resistivity models (03_models)
This subfolder contains the complex-resistivity models inverted with the geophysical inversion algorithm CRTomo (Kemna, 2000).

## Visualization (04_visualization)
The visualization directory contains Matlab scripts (*.m* files) for the visualization of the inverted data.

Instead of the default Matlab colormaps, we use the perceptually uniform colormaps *viridis.m* and *cividis.m* implemented for Matlab by Ander Biguri (2020), which were originally designed for python´s matplotlib (see  https://bids.github.io/colormap/).

## References
Biguri, Ander (2020). Perceptually uniform colormaps (https://www.mathworks.com/matlabcentral/fileexchange/51986-perceptually-uniform-colormaps), MATLAB Central File Exchange. Retrieved March 31, 2020.

Kemna, Andreas (2000). Tomographic inversion of complex resistivity - theory and application, Ph.D., Ruhr-University of Bochum.
