% θ
% Make a basic run of the chemostat model
% In:
%  mAdult is the adult sizes of copepods (can be left empty to simulate only
%         unicellular organisms) (default = [], ie only generalists).
%
% Out:
%  sim: Structure holding the results of the simulation
%
function sim = baserunChemostat(mAdult)

arguments
    mAdult double = []
end
%   
% Set parameters:
%
%     n = 10;
%     nCopepods = 10;
%     nPOM = 10;
%     p = setupNUMmodel(mAdult, n,nCopepods,nPOM);
%     
% p = setupNUMmodel();
% p = setupGeneric(10);
% p = setupGeneralistsSimpleOnly;
% p = setupGeneralistsOnly;
p = setupGeneralistsDiatoms;
% p = setupGenDiatCope(2,2,1);
%  p = setupDiatomsOnly;
p = parametersChemostat(p);
p.tEnd = 2000;
p.d = 0.1;
%
% Set to "normal" HTL mortality if there are no copepods:
%
if isempty(mAdult)
    setHTL(0.1, 1/500^1.5, false, false);
else 
    setHTL(0.1, 1, true, true);
end
%
% Simulate
%
% p.d=0.1;
tic
sim = simulateChemostat(p, 100);
toc
%
% Plot
%
plotSimulation(sim);
% checkConservation(sim);
