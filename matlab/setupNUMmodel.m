%
% Setup with generalists and a number of copepods
%
function p = setupNUMmodel(mAdultPassive, mAdultActive, n,nCopepods,nPOM, bParallel)

arguments
    mAdultPassive (1,:) = [0.2 5];
    mAdultActive (1,:) = [1 10 100 1000];
    n = 10;
    nCopepods = 10;
    nPOM = 10;
    bParallel = false;
end

loadNUMmodelLibrary(bParallel);
calllib(loadNUMmodelLibrary(), 'f_setupnummodel', ...
    int32(n), int32(nCopepods), int32(nPOM), ...
    length(mAdultPassive), mAdultPassive, length(mAdultActive), mAdultActive );
if bParallel
    h = gcp('nocreate');
    poolsize = h.NumWorkers;
    parfor i=1:poolsize
        calllib(loadNUMmodelLibrary(), 'f_setupnummodel', ...
            int32(n), int32(nCopepods), int32(nPOM),...
            length(mAdultPassive), mAdultPassive, length(mAdultActive), mAdultActive );
    end
end

p.idxN = 1;
p.idxDOC = 2;
p.idxB = 3; % We have two nutrient groups so biomass groups starts at index 3.

p.n = 2;
% Generalists:
p = parametersAddgroup(1,p,n);

for i = 1:length(mAdultPassive)
    p = parametersAddgroup(10,p, nCopepods, mAdultPassive(i));
end
for i = 1:length(mAdultActive)
    p = parametersAddgroup(11,p, nCopepods, mAdultActive(i));
end

% POM:
p = parametersAddgroup(100, p, nPOM);

p = getMass(p);

p.u0(1:2) = [150, 0]; % Initial conditions (and deep layer concentrations)
% Initial condition at a Sheldon spectrum of "0.1":
ix = 3:p.n;
p.u0(ix) = 0.1*log( p.mUpper(ix)./p.mLower(ix)); 

p.u0( p.ixStart(end):p.ixEnd(end) ) = 0; % No POM in initial conditions
