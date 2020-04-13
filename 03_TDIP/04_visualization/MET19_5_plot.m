clear all; close all; clc;

% Settings
fs = 8;                     % Font size
rrange = log10([2,250]);   	% Color bar limits, resistivity
prange = [0 6];             % Color bar limits, phase
zoffset = 17.2;       		% Depth offset (with respect to water surface)
xoffset = 980;              % X offset relative to longer SBP profile 8m)
cmin=-3;                    % Minimum coverage
inv=5;                      % Inversion number to be plotted
ary=195; nel=48; sep=5;   namary='MET';

% Read in element and electrode position data    
elem=dlmread(['../03_models/grids/' num2str(nel) '_' num2str(sep) 'm.elm']); 
elec=dlmread(['../03_models/grids/' num2str(nel) '_' num2str(sep) 'm.elc']); 
if elem(4,1)==11
    headerrows=4; 
else
    headerrows=3;
end    
header=elem(1:headerrows,:); 
elem(1:headerrows,:)=[]; 
coord=elem(1:header(1,1),:);
elem(1:header(1,1),:)=[]; 
elem=elem(1:header(2,2),:); 
elec(1,:)=[];
elecind=coord(elec,1); 
elec(:,2:3)=coord(elecind,2:3);
elemind=coord(elem,1); 
elemx(:,1)=coord(elemind,2);
elemx=reshape(elemx,header(2,2),header(2,3));
elemx=elemx'; 
elemz(:,1)=coord(elemind,3);
elemz=reshape(elemz,header(2,2),header(2,3));
elemz=elemz';

ct=0;
for ij=1 % Loop over array types
  	if ij==1
        nami='ddx100'; vali=2; cf='DD';
 	elseif ij==2
        nami='we';  vali=0; cf='WE'; 
    end
    
	for ff=2 % Loop over filters
    ct=ct+1;
    Fin=['../03_models/' namary num2str(ary) '_f' num2str(ff) '_' nami];
    lit=[Fin '/*.modl']; fph=1;
    rho=dlmread([Fin '/rho' num2str(fph,'%2.2d') '.mag']);
    pha=dlmread([Fin '/rho' num2str(fph,'%2.2d') '.pha']);
    cov=dlmread([Fin '/coverage.mag'],'', [1 0 size(rho,1)-1 2]);
    cov=cov(:,3)'; 
    rmsr=rho(1,2); rho(1,:)=[];  rho=rho(:,3)'; 
    rmsy=pha(1,2); pha(1,:)=[];  pha=pha(:,3)'; 

    for ix=1:length(cov); if cov(ix)<cmin; rho(ix)=NaN; pha(ix)=NaN;end; end
	end
end 

% Plot resistivity image
% Set figure size
figure('units','centimeters','position',[20,10,15,4.5]);
% Set size of axes
axes('units','centimeters','Position',[1 0.5 12 4],'Box','on');
% Visualize resistivity model
patch(elemx+xoffset,-elemz+zoffset,rho-vali,'edgecolor','none') %none take the grid out, k black
hold on
% Plot electrode positions
plot(elec(:,2)+xoffset,-elec(:,3)+zoffset,'.', ...
  'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',8)
% Fine tuning
set(gca,'Layer','top') % Plot axes in foreground
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'TickLength',[0.01, 0.001])
set(gca,'XTick',0:20:2000)
set(gca,'YTick',0:20:200)
h = gca;
h.XAxis.MinorTickValues=0:5:2000;
h.YAxis.MinorTickValues=0:5:200;
xlabel('Distance (m)','fontsize',fs)
ylabel('Depth (m)','fontsize',fs)
set(gca,'FontSize',fs)
axis ij
axis([xoffset max(elec(:,2))+xoffset 10 70]) % axis tight
h.DataAspectRatio = [1,1,1]; % axis equal
% Colorbar
caxis(rrange);
hcb=colorbar('fontsize',fs,'location','EastOutside');
set(get(hcb,'ylabel'),'String','\rho (\Omegam)',...
    'fontsize',fs)
set(hcb,'XTickMode','manual')
set(hcb,'YTick',[0 0.5 1 1.5 2 2.5 3])
set(hcb,'YTickLabel',{'1','3','10','32','100','316','1000'})
set(hcb,'TickLength',0.05)
set(hcb,'units','centimeters')
cbpos = get(hcb,'position');
cbpos(3) = cbpos(3)/2.5;
cbpos(1) = 13.5;
cbpos(2) = cbpos(2)-0.2;
cbpos(4) = cbpos(4)+0.4;
set(hcb,'position',cbpos);
colormap(viridis)
% Export to png
print('-dpng','-r300','MET19_5_res')

% Plot phase image
% Set figure size
figure('units','centimeters','position',[20,10,15,4.5]);
% Set size of axes
axes('units','centimeters','Position',[1 0.5 12 4],'Box','on');
% Visualize resistivity model
patch(elemx+xoffset,-elemz+zoffset,-pha,'edgecolor','none') %none take the grid out, k black
hold on
% Plot electrode positions
plot(elec(:,2)+xoffset,-elec(:,3)+zoffset,'.', ...
  'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',8)
% Fine tuning
set(gca,'Layer','top') % Plot axes in foreground
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'TickLength',[0.01, 0.001])
set(gca,'XTick',0:20:2000)
set(gca,'YTick',0:20:200)
h = gca;
h.XAxis.MinorTickValues=0:5:2000;
h.YAxis.MinorTickValues=0:5:200;
xlabel('Distance (m)','fontsize',fs)
ylabel('Depth (m)','fontsize',fs)
set(gca,'FontSize',fs)
axis ij
axis([xoffset max(elec(:,2))+xoffset 10 70]) % axis tight
h.DataAspectRatio = [1,1,1]; % axis equal
% Colorbar
caxis(prange);
hcb=colorbar('fontsize',fs,'location','EastOutside');
set(get(hcb,'ylabel'),'String','-\phi (mrad)',...
    'fontsize',fs)
set(hcb,'XTickMode','manual')
set(hcb,'YTick',0:1:10)
set(hcb,'TickLength',0.05)
set(hcb,'units','centimeters')
cbpos = get(hcb,'position');
cbpos(3) = cbpos(3)/2.5;
cbpos(1) = 13.5;
cbpos(2) = cbpos(2)-0.2;
cbpos(4) = cbpos(4)+0.4;
set(hcb,'position',cbpos);
colormap(cividis)
% Export to png
print('-dpng','-r300','MET19_5_pha')