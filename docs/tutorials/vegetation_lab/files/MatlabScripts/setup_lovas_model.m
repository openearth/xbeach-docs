%% Setup XB vegetation model for Lovas experiment.
%
% This script generates a simple 1D XBeach model(surfbeat mode) for some
% laboratory experiments with mimic kelp by Lovas (test 1 and 2), and is
% meant to provide an example for XBeach users interested in using the
% vegetation module. It makes use of a number of open source MATLAB
% functions that are part of the Open Earth initiative and can be download
% freely via https://publicwiki.deltares.nl/display/OET/OpenEarth
%
% For more information on these experiments reference is made to:
%
% Løvås, S. M., & Tørum, A. (2001). Effect of the kelp Laminaria hyperborea
% upon sand dune erosion and water particle velocities. Coastal
% Engineering, 44(1), 37-63. Løvås, S. M. (2000). Hydro-physical conditions
% in kelp forests and the effect on wave damping and dune erosion: A case
% study on Laminaria hyperborea. Norwegian University of Science and
% Technology.
%
% For more information on the vegetation module in XBeach, please refer to:
%
% van Rooijen, A. A., McCall, R. T., van Thiel de Vries, J. S. M., van
% Dongeren, A. R., Reniers, A. J. H. M., & Roelvink, J. A. (2016). Modeling
% the effect of wave?vegetation interaction on wave setup. Journal of
% Geophysical Research: Oceans. Roelvink, D., van Dongeren, A., McCall, R.,
% Hoonhout, B., van Rooijen, A., Van Geer, P., ... & Quataert, E. (2015).
% XBeach Technical Reference: Kingsday Release.
%
%
% Jan, 2017 AvR

%% 1) Wave conditions
Hm0 = 0.14;  % significant wave height (m)
Tp  = 2.5;   % wave peak period (s)

% Save wave input in XBeach structure
xb_wav  = xb_generate_waves('Hm0',Hm0,'Tp',Tp,'duration',600,'mainang',270,...
    's', 100000,'fnyq',2,'gammajsp',7);

%% 2) Mean water level
zs0  = 0.77; % mean water level [m]

%% 3) Grid and Bathymetry profile 
dxmin = 0.1;% minimum grid size (near shore line)

% Define profile(based on Lovas & Torum paper)
x     = -1*[-0.45-1 -0.45 0 1 (0.77-0.1)*30+1 27.79];
z     = [0.45/1.5 0.45/1.5 0 -1*0.1 -0.77 -0.77]+0.77;
x     = fliplr(x);
z     = fliplr(z);

% Use xb_grid_xgrid tool to get optimized cross-shore grid
[xx,zz] = xb_grid_xgrid(x,z,'dxmin',dxmin,'Tm',Tp/1.2,'wl',zs0);

% Save grid/bathy in XBeach structure
xb_bat = xb_generate_bathy('x', xx, 'z', zz,...
    'crop',false,'finalise',false,'world_coordinates',false,...
    'rotate',false,'optimize',false);

%% 4) Vegetation input
Lh   = 7.27;          % length over which vegetation is present
xveg = [-13 -13+Lh];  % location of vegetation
nsec = 1;             % number of vertical sections (only for mangroves)
ah   = 0.09;          % vegetation height (m)
bv   = 0.025;         % stem diameter / blade width (m)
Nv   = 1200;          % density (units/m2)
Cd   = 0.25;          % drag coefficient (-)

% Find grid points with vegetation
veg = zeros(size(xx));
veg(xx >= xveg(1) & xx < xveg(2)) = 1;

% Save vegetaion in put in XBeach structure
xb_veg = xb_generate_settings('vegetation',1,...
    'veggiefile','vegetation.txt','veggiemapfile','kelpbed.txt');

%% 5) General Model settings
% Directly save model settings in XBeach structure
xb_set = xb_generate_settings('xori',-27.79,...
    'sedtrans',0,'morphology',0,'roller',1,'CFL',1.4,...
    'order',1,'ARC',0,'rt',600,'cf',0.001,'zs0',zs0,...
    'front','abs_1d','left','wall','right','wall',...
    'posdwn',-1,'depthscale',50,'rho',1000,'random',0,...
    'thetamin',-90,'thetamax',90,'dtheta',180,...
    'tstart',600,'tstop',1200,'tintg',0.1,'tintm',600,...
    'outputformat','netcdf',...
    'nglobalvar',{'H','zs','u','zb'},...
    'nmeanvar',{'H','zs'});

%% 6) Plot experimental setup
figure;

% Plot profile
plot(xx,zz,'k-o');hold on
plot([-28 0],[zs0 zs0],'b')

% Plot vegetation
vegs = interp1([-30 xveg(1)-0.01 xveg(1) xveg(2) xveg(2)+0.01 5],[0 0 0.09 0.09 0 0],xx);
for j = 1:length(xx)
    plot([xx(j),xx(j)],[zz(j) zz(j)+vegs(j)],'Color',[76 153 0]/255);
end
    
% Figure labels
xlabel('x [m]')
ylabel('z [m]')

% Title
title('Experimental setup Lovas-study')

%% 7) Save model setup
% Define location / path of XBeach executable
binDir = [pwd filesep '2015-10-22_XBeach_v1.22.4867_Kingsday_x64_netcdf'];

% 7.1) Save model setup for test 1 (no kelp)
dirName1 = 'test1';mkdir(dirName1)

% Combine XBeach structures
xb_tot = xs_join(xb_bat,xb_wav,xb_set);
xb_write_input([dirName1 '\params.txt'],xb_tot);

% Make batchfile to call XBeach executable
fid = fopen([dirName1 '\run_xbeach.bat'],'w');
    fprintf(fid,'%s',['call "' binDir filesep 'xbeach.exe"']);
fclose(fid);

% 7.2) Save model setup for test 2 (with kelp)
dirName2 = 'test2';mkdir(dirName2)
xb_tot = xs_join(xb_bat,xb_wav,xb_veg,xb_set);
xb_write_input([dirName2 '\params.txt'],xb_tot);

% Make batchfile to call XBeach executable
fid = fopen([dirName2 '\run_xbeach.bat'],'w');
    fprintf(fid,'%s',['call "' binDir  filesep 'xbeach.exe"']);
fclose(fid);

% Save additional vegetation input files (3x) Veggiefile (lists all
% vegetation types in model):
fid = fopen([dirName2 '\vegetation.txt'],'w');
    fprintf(fid,'%s','kelp.txt');
fclose(fid);

% Veggiechars (lists all parameters for specified vegetation type):
fid = fopen([dirName2,'\kelp.txt'],'w');
    fprintf(fid,'%s\n', ['nsec = ', num2str(nsec)]);
    fprintf(fid,'%s\n', ['ah = ',num2str(ah)]);
    fprintf(fid,'%s\n', ['bv = ',num2str(bv)]);
    fprintf(fid,'%s\n', ['N  = ',num2str(Nv)]);
    fprintf(fid,'%s\n', ['Cd = ',num2str(Cd)]);
fclose(fid);

% Veggiemapfile (location of vegetation types):
save([dirName2 '\kelpbed.txt'],'veg','-ascii');% vegetation characteristitcs

