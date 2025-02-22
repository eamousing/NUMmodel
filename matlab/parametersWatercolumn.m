function p = parametersWatercolumn(p, nTMmodel)

arguments
    p struct
    nTMmodel {mustBeInteger} = 2; % Use 1.0 deg model as default
end

p = parametersGlobal(p,nTMmodel);

p.nameModel = 'watercolumn';

p.tSave = 1;
