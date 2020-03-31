clc; clear all; close all;

% Script visualizes resistivity and phase spectra measured on lab samples 

% Settings
fs = 8;                         % Font size
m = {'<','>','v','^','x','+'};  % Markers
ms = [1 1 1 1 1.7 1.7]*3;       % Marker size
ml = [1 1 1 1 2 2];             % Marker line width
mc = [0.850000000000000,0.325000000000000,0.0980000000000000;...
    0.929000000000000,0.694000000000000,0.125000000000000;...
    0.494000000000000,0.184000000000000,0.556000000000000;...
    0.466000000000000,0.674000000000000,0.188000000000000;...
    0.301000000000000,0.745000000000000,0.933000000000000;
    0,0.447000000000000,0.741000000000000];

% Read in data
[num,txt,raw] = xlsread('Means_Met_Tzi.xlsx') ;

% Visualize
% Set figure size
f1 = figure(1);
set(f1,'units','centimeters','position',[20,10,7.5,14.5]);

% Plot magnitude data
% Set size of axes
ax1 = axes('units','centimeters','Position',[1.2 8.3 6 6]);
for ii=1:6
    semilogx(num(:,1),num(:,1+ii),m{ii},'MarkerSize',ms(ii),...
        'MarkerEdgeColor',mc(ii,:),...
        'MarkerFaceColor',mc(ii,:),'LineWidth',ml(ii))
    hold on
end
set(gca,'YMinorTick','on','XMinorTick','on')
set(gca,'TickLength',[0.02, 0.002])
set(gca,'XTick',10.^(-4:2:10))
h = gca;
h.XAxis.MinorTickValues=10.^(-4:1:10);


lh = legend('Draga 3','MET19-A','MET19-B','MET19-C','TZI19-A','TZI19-B');
set(lh,'units','centimeters','Position',[1.7 11.6 2 2]);

xlabel('Frequency (Hz)','fontsize',fs)
ylabel('Resistivity magnitude (\Omegam)','fontsize',fs)
set(gca,'FontSize',fs)
grid on
axis([0.0001 1000000 9.5 20])

% Plot phase data
% Set size of axes
ax2 = axes('units','centimeters','Position',[1.2 1 6 6]);
for ii=1:6
    loglog(num(:,1),num(:,9+ii),m{ii},'MarkerSize',ms(ii),...
        'MarkerEdgeColor',mc(ii,:),...
        'MarkerFaceColor',mc(ii,:),'LineWidth',ml(ii))
    hold on
end
set(gca,'YMinorTick','on','XMinorTick','on')
set(gca,'TickLength',[0.02, 0.002])
set(gca,'XTick',10.^(-4:2:10))
h = gca;
h.XAxis.MinorTickValues=10.^(-4:1:10);

lh = legend('Draga 3','MET19-A','MET19-B','MET19-C','TZI19-A','TZI19-B');
set(lh,'units','centimeters','Position',[1.7 4.7 2 2]);

xlabel('Frequency (Hz)','fontsize',fs)
ylabel('Resistivity phase (mrad)','fontsize',fs)
set(gca,'FontSize',fs)
grid on
axis([0.0001 1000000 10^-1 10^3])
 
print('-dpng','-r300','lab')