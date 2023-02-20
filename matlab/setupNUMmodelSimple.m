%
% Setup with generalists and a number of copepods
%
function p = setupNUMmodelSimple(mAdult, n,nCopepods,nPOM, bParallel)

arguments
    mAdult (1,:) = [0.1 1 10 100 1000];
    n = 10;
    nCopepods = 10;
    nPOM = 10;
    bParallel = false;
end

loadNUMmodelLibrary(bParallel);
calllib(loadNUMmodelLibrary(), 'f_setupnummodelsimple', ...
    int32(n), int32(nCopepods), int32(nPOM),length(mAdult), mAdult );
if bParallel
    h = gcp('nocreate');
    poolsize = h.NumWorkers;
    parfor i=1:poolsize
        calllib(loadNUMmodelLibrary(), 'f_setupnummodelsimple', ...
            int32(n), int32(nCopepods), int32(nPOM),length(mAdult), mAdult );
    end
end

p.idxN = 1;
p.idxDOC = 2;
p.idxB = 4; % We have two nutrient groups so biomass groups starts at index 3.
p.idxSi = 3;
p.n = 3;
% Generalists simple:
p = parametersAddgroup(1,p,n);
% Diatoms simple:
p = parametersAddgroup(4,p,n);

for i = 1:length(mAdult)
    p = parametersAddgroup(11,p,nCopepods, mAdult(i)); % Active copepods
end

% POM:
p = parametersAddgroup(100, p, nPOM);

p = getMass(p);

p.u0(1:3) = [150, 0, 10]; % Initial conditions (and deep layer concentrations)
% Initial condition at a Sheldon spectrum of "0.1":
ix = p.idxB:p.n;
p.u0(ix) = 0.1*log( p.mUpper(ix)./p.mLower(ix)); 

p.u0( p.ixStart(end):p.ixEnd(end) ) = 0; % No POM in initial conditions