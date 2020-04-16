% Plots velocity models inverted from srt data using pyGIMLi
clc; clear all; close all;

% Settings
fs = 8;                 % Font size
vrange = [0,3000];      % Color bar limits
zoffset = 17.2;         % Depth offset (with respect to water surface)
xoffset = 980+57.5;     % x offset relative to longer TEM profile

% Read mesh
[elemx,elemz] = vtk2patch('../03_inverted/MET19-5b/velocity.vtk');
% Read velocity model
vel = dlmread('../03_inverted/MET19-5b/velocity.vector');
% Read coverage
cov = dlmread('../03_inverted/MET19-5b/velocity-scov.vector');
% Geophone positions
geop = 2.5:5:120;

% Visualize
% Set figure size
figure('units','centimeters','position',[20,10,15,4]);
% Set size of axes
ax1 = axes('units','centimeters','Position',[1 0.5 11.5 4],'Box','on');

% Plot velocity image
patch(elemx+xoffset,-elemz+zoffset,vel,'edgecolor','none',...
          'FaceAlpha','flat','FaceVertexAlphaData',cov);
hold on
plot(geop+xoffset,geop*0+zoffset,'vk','MarkerSize',3,'MarkerFaceColor','k') % Geophone positions


set(gca,'Layer','top') % Plot axes in foreground
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'TickLength',[0.01, 0.001])
set(gca,'XTick',0:10:2000)
set(gca,'YTick',0:10:200)
h = gca;
h.XAxis.MinorTickValues=0:2:2000;
h.YAxis.MinorTickValues=0:2:200;

xlabel('Distance (m)','fontsize',fs)
ylabel('Depth (m)','fontsize',fs)
set(gca,'FontSize',fs)

axis ij
h.DataAspectRatio = [1,1/0.7,1]; % axis equal
axis tight

% Colorbar
caxis(vrange);
hcb=colorbar('fontsize',fs,'location','EastOutside');
set(get(hcb,'ylabel'),'String','v_p (m/s)',...
    'fontsize',fs)
set(hcb,'XTickMode','manual')
set(hcb,'TickLength',0.05)
set(hcb,'units','centimeters')
cbpos = get(hcb,'position');
cbpos(3) = cbpos(3)/2.5;
cbpos(1) = 13;
cbpos(2) = cbpos(2)-0.23;
cbpos(4) = cbpos(4)+0.46;
set(hcb,'position',cbpos);

colormap(plasma)

print('-dpng','-r300','MET19_5b')