%
% Plot a size spectrum at a given lat, lon, index of depth, and time
% (day).
%
function s = plotSizespectrum(sim, time, iDepth, lat, lon)
arguments
    sim struct;
    time = sim.p.tEnd;
    iDepth {mustBeInteger} = 1;
    lat double = [];
    lon double = [];
end

m = [sim.p.mLower(3:end), sim.p.mLower(end)+sim.p.mDelta(end)];
[~, iTime] = min(abs(sim.t-time));

switch sim.p.nameModel
    
    case 'chemostat'
        % Extract from a chemostat:
        s.B = squeeze(sim.B(iTime,:));
        if isfield(sim,'Si')
            u = [sim.N(iTime), sim.DOC(iTime), sim.Si(iTime), s.B];
        else
            u = [sim.N(iTime), sim.DOC(iTime), s.B];
        end
        s.L = sim.L;
    
    case 'watercolumn'
        % Extract from a single water column:
        z = sim.z;
        s.B = squeeze(sim.B(iDepth,:,iTime));
        if isfield(sim,'Si')
            u = [sim.N(iDepth,iTime), sim.DOC(iDepth,iTime), sim.Si(iDepth,iTime), s.B];
        else
            u = [sim.N(iDepth,iTime), sim.DOC(iDepth,iTime), s.B];
        end
        s.L = sim.L(iDepth,iTime);
        
        
    case 'global'
        % Extract from global run:
        idx = calcGlobalWatercolumn(lat,lon,sim);
        z = [sim.z(idx.z)-0.5*sim.dznom(idx.z); sim.z(idx.z(end))+0.5*sim.dznom(idx.z(end))];
        s.B = squeeze(sim.B(idx.x, idx.y, iDepth, :, iTime))';
        if isfield(sim,'Si')
            u = [sim.N(idx.x, idx.y,iDepth,iTime), ...
                sim.DOC(idx.x, idx.y,iDepth,iTime), ...
                sim.Si(idx.x, idx.y,iDepth,iTime), ...
                squeeze(sim.B(idx.x, idx.y, iDepth, :, iTime))'];
        else
            u = [sim.N(idx.x, idx.y,iDepth,iTime), ...
                sim.DOC(idx.x, idx.y,iDepth,iTime), ...
                squeeze(sim.B(idx.x, idx.y, iDepth, :, iTime))'];
        end
        s.L = sim.L(idx.x, idx.y, iDepth,iTime);
        
end

s.p = sim.p;
s.t = sim.t;
%
% Setup tiles:
%
clf
tiledlayout(3,1,'tilespacing','compact','padding','compact')
%
% Spectrum
%
nexttile
panelSpectrum(s,1)
xlabel('')
set(gca,'XTickLabel','');
%
% Gains:
%
nexttile

rates = getRates(sim.p, u, s.L);
%panelGains(sim.p,rates)
panelGains(sim.p,rates);
set(gca,'XTickLabel','');
%
% Losses:
%
nexttile
panelLosses(sim.p, rates);

s.rates = rates;