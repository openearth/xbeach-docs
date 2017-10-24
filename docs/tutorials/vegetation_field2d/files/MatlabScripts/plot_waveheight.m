% Plot wave height
clear; close all

dirName = 'xb_mangrove_01';

%% Load model results
ncFil     = fullfile(dirName,'xboutput.nc');    % Netcdf output file
x         = nc_varget(ncFil,'globalx');         % x grid
y         = nc_varget(ncFil,'globaly');         % y grid
Hrms_SS   = squeeze(nc_varget(ncFil,'H_mean')); % sea swell RMS wave height
zsvar     = squeeze(nc_varget(ncFil,'zs_var')); % water level variance (IG waves + mean flow/ tide etc.)
Hrms_IG   = 2*sqrt(2)*sqrt(abs(zsvar));         % infragravity RMS wave height
zb        = nc_varget(ncFil,'zb');              % bathymetry

mangfor   = load('mangrove_forest.txt');        % mangrove forest envelope

%% Plot results vs. measurements
fig = figure;
set(fig,'units','centimeter','position',[2 2 22 20],'PaperPositionMode','auto');

% Subplot 1: Spatial sea swell wave height
subplot(3,2,[1,3])
pcolor(x,y,Hrms_SS);hold on
plot(mangfor(:,1),mangfor(:,2),'w--')
axis equal
axis([0 1800 -500 2000])
caxis([0 1.5])
xlabel('x [m]')
ylabel('y [m]')
shading flat
colorbar('South')
title('RMS sea-swell wave height (m)')

% Subplot 2: Spatial infragravity wave height
subplot(3,2,[2,4])
pcolor(x,y,Hrms_IG);hold on
plot(mangfor(:,1),mangfor(:,2),'w--')
shading flat
axis equal
axis([0 1800 -500 2000])
caxis([0 0.2])
xlabel('x [m]')
ylabel('y [m]')
colorbar('South')
title('RMS infragravity wave height (m)')

% Subplot 3: sea-swell and infragravity wave height along cross-shore
% transect
subplot(3,2,[5,6])
[hAx,hLine1,hLine2] =plotyy(x(55,:),Hrms_SS(55,:),x(55,:),squeeze(zb(1,55,:)));hold on
hLine1.Color = 'b';
hLine2.Color = 'k';
H(1)=hLine1;
H(2)=plot(hAx(1),x(55,:),Hrms_IG(55,:),'r');
H(3)=plot(hAx(1),x(3,:),Hrms_SS(3,:),'b--');
H(4)=plot(hAx(1),x(3,:),Hrms_IG(3,:),'r--');
legend(H,'Sea-swell wave height','Infragravity wave height','location','West')
set(hAx(1),'Xlim',[0 1700],'Ylim',[0 1.5],'Ytick',[0:0.25:1.5])
set(hAx(2),'Xlim',[0 1700],'Ylim',[-10 8],'Ytick',[-12:4:8])
xlabel('x')
ylabel(hAx(2),'z (m)')
ylabel(hAx(1),'H_{rms} (m)')
saveas(gcf,'xbveg_mangrove_waveheight.png')
