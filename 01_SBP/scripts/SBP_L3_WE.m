% Plot SBP seismograms
% Matthias Buecker
% March 2020

clc; clear all; close all;

% Settings
fs = 8;                % Font size

% Full path to input raw data file (.seg)
filename = '../MET\EW-WE\SBP L3 WE/20180313172145';

% Include paths to LargeDataSeismic_CODE
% Stuart Kozola (2020). Large Data in MATLAB: A Seismic Data Processing 
% Case Study (https://www.mathworks.com/matlabcentral/fileexchange/30585-large-data-in-matlab-a-seismic-data-processing-case-study), 
% MATLAB Central File Exchange. 
addpath('D:\Software\LargeDataSeismic_CODE\fileReader')
addpath('D:\Software\LargeDataSeismic_CODE\migration')

%% Read in velocity model data
% SegYFileReader open the SEG Y file and reads the header information.
% Creates an object used to access trace data.
V = SegYFileReader([filename '.seg'],true,false);
nt = V.NumberOfTraces-1;
for ii = 1:nt
    d(:,ii) = V(:,ii); % Read in trace by trace
end

%% Prepare data for visualization
% Length scale for horizontal axis
x = [0,665];
% Compute depth scale for vertical axis
f = 1024*0.9; % Sampling frequency in Hz
si = 1/f*1000; % Sampling interval in ms
y = (1:size(d,1))*si; % Two-way travel time in ms
vw = 1.4866; % Average sound velocity in water (m/ms)
y = y/2/vw+0.4; % Depth in m

%% Visualize
% Set figure size
figure('units','centimeters','position',[20,10,15,5]);
% Set size of axes
axes('units','centimeters','Position',[1 1 13.8 3.54]);

% Plot SBP data as gray scale image
imagesc(x,y,d)
colormap(flipud(gray))

% Fine tuning of axes appearence, etc.
set(gca,'FontSize',fs)
axis([0 665 0 40])
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'TickLength',[0.01, 0.001])
set(gca,'XTick',0:50:1000)
h = gca;
h.YAxis.MinorTickValues=0:2:200;
xlabel('Distance (m)','fontsize',fs)
ylabel('Depth (m)','fontsize',fs)
set(gca,'FontSize',fs)
grid on
axis ij
 
print('-dpng','-r600','SBP L3 WE')