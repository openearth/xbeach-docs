%% Set up idealized XBeach vegetation model 2D mangrove case.
%
% This script generates a simple idealized 2D XBeach model(surfbeat mode)
% for a case with mangrove trees in front of a coastal structure, and is
% meant to provide an example for XBeach users interested in using the
% vegetation module. It is based on the work by Phan et al. (2015, and
% makes use of a number of open source MATLAB functions that are part of
% the Open Earth initiative and can be download freely via
% https://publicwiki.deltares.nl/display/OET/OpenEarth
%
% For more information on the vegetation module in XBeach, please refer to:
%
% Phan, L.K; J. S. M. van Thiel de Vries, M. J. F. Stive (2015), Coastal
% Mangrove Squeeze in the Mekong Delta, J. of Coastal Research, 31( 2), pp.
% 233 – 243, doi: 10.2112/JCOASTRES-D-14-00049.1.
% 
% van Rooijen, A. A., McCall, R. T., van Thiel de Vries, J. S. M., van
% Dongeren, A. R., Reniers, A. J. H. M., & Roelvink, J. A. (2016). Modeling
% the effect of wave?vegetation interaction on wave setup. Journal of
% Geophysical Research: Oceans.
%
% Roelvink, D., van Dongeren, A., McCall, R., Hoonhout, B., van Rooijen,
% A., Van Geer, P., De Vet, L., Nederhof, K. & Quataert, E. (2015). XBeach 
% Technical Reference: Kingsday Release.
%
%
% Jan, 2017 AvR
clear all;close all

%% 1) Wave conditions
Hm0 = 2;  % significant wave height (m)
Tp  = 6;  % wave peak period (s)

% Save wave input in XBeach structure
xb_wav  = xb_generate_waves('Hm0',Hm0,'Tp',Tp,'duration',3600,'mainang',270);

%% 2) Mean water level (storm surge level)
zs0  = 3; % mean water storm surge level [m]

%% 3) Grid and Bathymetry profile 
dxmin = 5;% minimum grid size (near shore line)

% Define idealized bathymetry profile for case (here: 1/150 bathy + sea dike)
x0 = [0 100 1600 1615 1630 1645 1700];
y0 = [0:100:2000];
z0 = [-8 -8 2 7 7 3 3];

% create meshgrid (needed for interpolation later)
[x0g,y0g] = meshgrid(x0,y0);
z0g = repmat(z0,length(y0),1);

% Make a plot just to show what the profile / bathymetry look like
fig = figure;
set(fig,'units','centimeter','position',[2 2 15 18],'PaperPositionMode','auto');
ax1 = subplot(311);
plot(x0,z0,'k'); hold on
H(1)=plot([0 1300],[0 0],'b');
H(2)=plot([0 1600],[zs0 zs0],'b--');
xlabel('x [m]')
ylabel('z [m]')
title('Cross-shore bathy profile')
ax2 =subplot(3,1,2:3);
pcolor(x0g,y0g,z0g);hold on
xlabel('x [m]')
ylabel('y [m]')
shading interp
hc = colorbar;
title(hc,'z [m]')
title('Top view of 2D bathymetry')

% (Note that normally you would have some sort of data available to generate
% the bathymetry!)

% Use xb_grid_xgrid and xb_grid_ygrid tools to optimize the grid
xx      = xb_grid_xgrid(x0,z0,'dxmin',dxmin,'Tm',Tp/1.2,'wl',zs0);
yy      = xb_grid_ygrid(y0,'dymin',15,'dymax',25,'area_type','center','area_size',0.5);

% Now generate a mesh and interpolate the bathymetry
[xg,yg] = meshgrid(xx,yy);
zg      = griddata(x0g, y0g, z0g, xg, yg);

% Save grid/bathy in XBeach structure
xb_bat = xb_generate_bathy('x', xg, 'y', yg , 'z', zg,...
    'crop',false,'finalise',false,'world_coordinates',false,...
    'rotate',false,'optimize',false);

%% 4) Vegetation input
% Define polygon of location in model domain with vegetation
mangfor = load('mangrove_forest.txt');

% Plot location of mangroves in original figure
xm1 = min(mangfor(:,1));  xm2 = max(mangfor(:,1));
zm1 = interp1(x0,z0,xm1); zm2 = interp1(x0,z0,xm2);
H(3)=plot(ax1,[xm1 xm1 xm2 xm2],[zm1 zm1+3 zm2+3 zm2],'g');
legend(H,'MSL','SSL','Mangroves','location','SouthEast')

% Plot in figure to see location of mangrove forest
H2=plot(ax2,mangfor(:,1),mangfor(:,2),'r--');
legend(H2,'Mangroves','location','West')
saveas(gcf,'xbveg_mangrove_setup.png')

% Mangrove characteristics (loosely based on Phan et al., 2015)
nsec = 3;               % number of vertical sections (only for mangrroves)
ah   = [0.5 1 0.5] ;    % vegetation height of each section (m) - [roots -> trunk -> canopy]
bv   = [0.01 0.2 0.02]; % stem diameter / blade width (m)
Nv   = [100 5 50];      % density (units/m2)
Cd   = [1 1 1];         % drag coefficient (-)

% Find grid points with vegetation
veg = zeros(size(xg));
veg(inpolygon(xg,yg,mangfor(:,1),mangfor(:,2))) = 1;

% Save vegetaion input in XBeach structure
xb_veg = xb_generate_settings('vegetation',1,...
    'veggiefile','vegetation.txt','veggiemapfile','mangrove_forest.txt');

%% 5) General Model settings
% Directly save model settings in XBeach structure
xb_set = xb_generate_settings('sedtrans',0,'posdwn',-1,'single_dir',1,...
    'zs0',zs0,'thetamin',-90,'thetamax',90,'dtheta_s',15,...
    'tstart',0,'tstop',3601,'tintg',10,'tintm',3600,...
    'outputformat','netcdf',...
    'nglobalvar',{'H','zs','u','zb'},...
    'nmeanvar',{'H','zs'});

%% 6) Save model setup
% Define location / path of XBeach executable
binDir = [pwd filesep '2015-10-22_XBeach_v1.22.4867_Kingsday_x64_netcdf'];

% Save model setup 
dirName = 'xb_mangrove_01';
mkdir(dirName)

xb_tot = xs_join(xb_bat,xb_wav,xb_veg,xb_set);
xb_write_input([dirName '\params.txt'],xb_tot);

% Make batchfile to call XBeach executable
fid = fopen([dirName '\run_xbeach.bat'],'w');
    fprintf(fid,'%s',['call "' binDir  filesep 'xbeach.exe"']);
fclose(fid);

% Save additional vegetation input files (3x): 
% Veggiefile (lists all vegetation types in model):
fid = fopen([dirName '\vegetation.txt'],'w');
    fprintf(fid,'%s','sonneratia.txt');
fclose(fid);

% Veggiechars (lists all parameters for specified vegetation type):
fid = fopen([dirName,'\sonneratia.txt'],'w');
    fprintf(fid,'%s\n', ['nsec = ', num2str(nsec)]);
    fprintf(fid,'%s\n', ['ah = ',num2str(ah)]);
    fprintf(fid,'%s\n', ['bv = ',num2str(bv)]);
    fprintf(fid,'%s\n', ['N  = ',num2str(Nv)]);
    fprintf(fid,'%s\n', ['Cd = ',num2str(Cd)]);
fclose(fid);

% Veggiemapfile (location of vegetation types):
save([dirName '\mangrove_forest.txt'],'veg','-ascii');

% Now you're done! Time to hit the run button!
