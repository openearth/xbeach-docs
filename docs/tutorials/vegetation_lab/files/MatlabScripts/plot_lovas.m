% Plot wave height
clear

%% Input
tests      = {'test1','test2'};

%% Load measurements
m(1).Hmeas = load('lovas_waves_test1.txt');
m(2).Hmeas = load('lovas_waves_test2.txt');

%% Load model results
for ii = 1:length(tests)
    ncFil       = fullfile(tests{ii},'xboutput.nc');% Netcdf output file
    r(ii).x     = nc_varget(ncFil,'globalx');% x grid       
    r(ii).Hm0   = nc_varget(ncFil,'H_mean')*sqrt(2);% wave height
end

%% Plot results vs. measurements
figure; 
hold on
c = {'b','k'};
for ii = 1:length(tests)
    plot(m(ii).Hmeas(1,:),m(ii).Hmeas(2,:),[c{ii} '*']); 
    LL(ii) =plot(r(ii).x,r(ii).Hm0,c{ii});
end
xlabel('x [m]')
ylabel('Hm0 [m]')
title({'Measured vs. modelled wave heights over kelp','Test 1+2 of the Lovas experiments'})
legend(LL,'No kelp (test 1)','With kelp (test 2)','location','SouthWest')
