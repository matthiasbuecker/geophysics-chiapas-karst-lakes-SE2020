clc; clear all; close all;
% Plot TEM sounding data as interpolated 2D sections
% Matthias B?cker
% March 2020

%% Input
% Settings
fs = 8;                     % Font size
rrange = log10([2,250]);  	% Color bar limits (log scaled)
% Number of layers (manually adjust to model data)
% nll = 5;
nll = 20;
nls = 20;
% Extrapolation distance to the right and the left
xextra = 20; 
% Sounding numbers
sn = [13:18,44:-1:41];
% Name of inversion directories
layered = '02_smooth_models/TZI_line1_tr1_rc-cs03_s0';
smooth = '02_smooth_models/TZI_line1_tr1_rc-cs03_s0';

%% Read in data
% Read sounding x positions
xz = dlmread('TZI_distances_and_depths.txt','',1,1);
x = xz(:,5);
% Read smooth models (for background)
for ss=1:length(sn)
    d(:,:,ss) = dlmread(['../' smooth '/tzi' num2str(sn(ss)) '.txt'],'',19,0);
end
% Layer thicknesses
y = zeros(nls,length(sn));
y(:,:) = d(:,7,:);
% Read layered models (for bar plots)
for ss=1:length(sn)
    dl(:,:,ss) = dlmread(['../' layered '/tzi' num2str(sn(ss)) '.txt'],'',19,0);
end
% Layer thicknesses
yl = zeros(nll,length(sn));
yl(:,:) = dl(:,7,:);

%% Prepare interpolation of smooth background models
xx = repmat(x',nls,1);
vv = xx*0;
vv(:,:) = log10(d(:,2,:));
yy = xx*0;
yy(:,:) = d(:,8,:)+d(:,7,:)/2;
% Devide water layer into n smaller layers
n = 5;
xx=[xx;xx(1:n-1,:)];
yy(1,:)=[];
yym = yy(1,:)*0;
yym(:,:) = d(1,7,:)/(2*n+1);
yym=[yym*2;yym*4;yym*6;yym*8;yym*10];
yy=[yym;yy];
vv=[repmat(vv(1,:),n-1,1);vv];
% Devide last thick layer in 5 smaller ones
xx=[xx;xx(1:4,:)];
yy(end,:)=[];
yy=[yy;yy(end,:)+5;yy(end,:)+10;yy(end,:)+15;yy(end,:)+20;yy(end,:)+25];
vv=[vv;repmat(vv(end,:),4,1)];
% Convert matrix to column array
xx = reshape(xx,size(xx,1)*size(xx,2),1);
yy = reshape(yy,size(yy,1)*size(yy,2),1);
vv = reshape(vv,size(vv,1)*size(vv,2),1);
xs=12; % Scaling factor for x to force smoothing in x-direction
F = scatteredInterpolant(xx/xs,yy,vv,'natural');
X = linspace(0-xextra,433+xextra,100);
Y = linspace(0,80,50);
[XX,YY] = meshgrid(X,Y);
VV = F(XX/xs,YY);

%% Visualization
% Set figure size
figure('units','centimeters','position',[20,10,15,4]);
% Set size of axes
ax1 = axes('units','centimeters','Position',[1 0.5 12 4],'Box','on');
% Set colormap and range
cmap = colormap(viridis);
caxis(rrange)
hold on

% Plot smooth interpolated model
% imagesc(X,Y,VV)
contourf(X,Y,VV,500,'LineStyle','none')
% Plot layered models
b = bar(x,yl',0.2,'stacked','FaceColor','flat','LineWidth',0.3);
% Assign face colors corresponding to layer resistivity
cvals = logspace(rrange(1),rrange(2),64);
for ss=1:length(sn)
    for ll=1:nll
        [~,ind]=min(abs(cvals-dl(ll,2,ss)));
        b(1,ll).CData(ss,:) = cmap(ind,:);
    end
end
% Plot sounding stations
plot(xz(:,5),xz(:,5)*0,'vr','MarkerSize',3,'MarkerFaceColor','r')

% Fine tuning
set(gca,'Layer','top') % Plot axes in foreground
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'TickLength',[0.01, 0.001])
set(gca,'XTick',0:50:1000)
set(gca,'YTick',0:20:200)
h = gca;
h.XAxis.MinorTickValues=0:10:1000;
h.YAxis.MinorTickValues=0:5:200;
xlabel('Distance (m)','fontsize',fs)
ylabel('Depth (m)','fontsize',fs)
set(gca,'FontSize',fs)
axis ij
h.DataAspectRatio = [1,1/1.2,1]; % axis equal
xlim([-20 max(xz(:,5))+20])
ylim([0 80])

% Colorbar
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

print('-dpng','-r300','TZI')