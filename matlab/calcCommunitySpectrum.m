%
% Calculate the community size spectrum from all groups using interplotation.
%

function [mc, Bc] = calcCommunitySpectrum(B, sim, iTime)

    arguments
        B;
        sim struct;
        iTime = NaN;
    end

    p = sim.p;
    mc = logspace(log10(sim.p.m(3)), log10(sim.p.m(end)), 100);
    nPoints = length(mc);
    Bc = zeros(1, nPoints);
    
    for iGroup = 1:p.nGroups
    
        ix = p.ixStart(iGroup):p.ixEnd(iGroup);
        m = p.m(ix);
        Delta = p.mUpper(ix)./p.mLower(ix);
        ixB = ix-p.idxB+1;

        if isnan(iTime)
            ixAve = find( sim.t > sim.t(end)/2 );
        
            % Interpolation
            log_k = mean( log(B( ixAve, ixB)./log(Delta)),1);
            vq1 = exp(interp1(log(m), log_k, log(mc), 'linear'));
        
            vq1(isnan(vq1)) = 0; % get rid of the NAs
            Bc = Bc + vq1;
        else
      
            % Interpolation
            log_k = mean( log(B( iTime, ixB)./log(Delta)),1);
            vq1 = exp(interp1(log(m), log_k, log(mc), 'linear'));
        
            vq1(isnan(vq1)) = 0; % get rid of the NAs
            Bc = Bc + vq1;
        end
    end
    
    end    


% function Bc = calcCommunitySpectrum(sim, mc)
% 
%     p = sim.p;
%     nPoints = length(mc);
%     Bc = zeros(1, nPoints);
% 
%     for iGroup = 1:p.nGroups
% 
%         ix = p.ixStart(iGroup):p.ixEnd(iGroup);
%         m = p.m(ix);
%         Delta = p.mUpper(ix)./p.mLower(ix);
%         ixB = ix-p.idxB+1;
%         ixAve = find( sim.t > sim.t(end)/2 );
% 
%         % Interpolation
%         log_k = mean( log(sim.B(ixAve, ixB)./log(Delta)),1);
%         vq1 = exp(interp1(log(m), log_k, log(mc), 'linear'));
% 
%         vq1(isnan(vq1)) = 0; % get rid of the NAs
%         Bc = Bc + vq1;
%     end
% 
% end