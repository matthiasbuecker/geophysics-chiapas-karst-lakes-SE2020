% Plots velocity models inverted from srt data using pyGIMLi
clc; clear all; close all;

% Settings
fs = 8;                 % Font size
vrange = [0,3000];      % Color bar limits
zoffset = 10.3;         % Depth offset (with respect to water surface)
xoffset = 209+72.5;     % x offset (m)

% Read mesh
[elemx,elemz] = vtk2patch('../03_inverted/TZI19-1/velocity.vtk');
% Read velocity model
vel = dlmread('../03_inverted/TZI19-1/velocity.vector');
% Read coverage
cov = dlmread('../03_inverted/TZI19-1/velocity-scov.vector');
% Geophone positions
geop = dlmread('../TZI19-1-topo-SRT.txt','',1,1);

% Visualize
% Set figure size
figure('units','centimeters','position',[20,10,15,5]);
% Set size of axes
ax1 = axes('units','centimeters','Position',[1 0.8 11.5 4],'Box','on');

% Plot velocity image
patch(elemx+xoffset,-elemz+zoffset,vel,'edgecolor','none',...
          'FaceAlpha','flat','FaceVertexAlphaData',cov);
hold on
plot(geop(:,1)+2.5+xoffset,-geop(:,2)+zoffset,'vk','MarkerSize',3,'MarkerFaceColor','k') % Geophone positions


set(gca,'Layer','top') % Plot axes in foreground
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'TickLength',[0.01, 0.001])
set(gca,'XTick',0:10:1000)
set(gca,'YTick',0:10:1000)
h = gca;
h.XAxis.MinorTickValues=0:2:1000;
h.YAxis.MinorTickValues=0:2:1000;

xlabel('Distance (m)','fontsize',fs)
ylabel('Depth (m)','fontsize',fs)
set(gca,'FontSize',fs)

axis ij
axis equal
axis tight
ylim([5,40])
% ylim([0,40])

% Colorbar
caxis(vrange);
hcb=colorbar('fontsize',fs,'location','EastOutside');
set(get(hcb,'ylabel'),'String','v_p (m/s)',...
    'fontsize',fs)
set(hcb,'XTickMode','manual')
set(hcb,'TickLength',0.03)
set(hcb,'units','centimeters')
cbpos = get(hcb,'position');
cbpos(3) = cbpos(3)/2.5;
cbpos(1) = 13;
cbpos(2) = cbpos(2)-0.3;
cbpos(4) = cbpos(4)+0.6;
set(hcb,'position',cbpos);

colormap(plasma)

print('-dpng','-r300','TZI19_1')