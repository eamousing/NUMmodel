%
% Returns all rates from the generalists for a given state (u) and light
% level.
%
function rates = getRates(u, L)
%
% First make a call to calc a derivative:
%
dudt = 0*u';
[u, dudt] = calllib(loadNUMmodelLibrary(), 'f_calcderivatives', ...
            length(u), u, L, 0.0, dudt);
%
% Then extract the rates:
%
zero = zeros(length(u)-2,1);
jN = zero;
jDOC = zero; 
jL = zero; 
jF = zero;
jFreal = zero;
jTot = zero;
jMax = zero;
jFmaxx = zero;
jR = zero;
jLossPassive = zero;
jNloss = zero;
jLreal = zero;
mortpred = zero;
mortHTL = zero;
mort2 = zero;
mort = zero;

[rates.jN, rates.jDOC, rates.jL, rates.jF, rates.jFreal, rates.jTot, rates.jMax, rates.jFmaxx, ...
    rates.jR, rates.jLossPassive, rates.jNloss, rates.jLreal, rates.mortpred, rates.mortHTL, ...
    rates.mort2, rates.mort] = ...
    calllib(loadNUMmodelLibrary(), 'f_getrates', ...
    jN, jDOC, jL, jF, jFreal,...
    jTot, jMax, jFmaxx, jR, jLossPassive, ...
    jNloss,jLreal, ...
    mortpred, mortHTL, mort2, mort);