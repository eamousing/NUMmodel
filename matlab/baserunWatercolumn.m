%
% Run a watercolumn with only generalists
%
function sim = baserunWatercolumn(lat,lon)

arguments
    lat double = 60;
    lon double = -10;
end

p = setupGeneralistsOnly(25);
p = parametersWatercolumn(p);

sim = simulateWatercolumn(p, lat,lon);
%%
figure(1)
plotGlobalWatercolumnTime(sim);

figure(2)
plotGlobalWatercolumn(sim,150);

figure(3)
plotGlobalSizespectrum(sim,150,1);

figure(4)
plotGlobalSizespectrumTime(sim,1);