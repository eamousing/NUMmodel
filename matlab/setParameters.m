function setParameters(p)

calllib(loadNUMmodelLibrary(), 'f_setparameters', ...
    int32(p.n), ...
    double(p.m), ...
    double(p.rhoCN), ...
    double(p.epsilonL), ...
    double(p.epsilonF), ...
    double(p.ANm), ...
    double(p.ALm), ...
    double(p.AFm), ...
    double(p.Jmax), ...
    double(p.JFmaxm), ...
    double(p.Jrespm), ...
    double(p.Jloss_passive_m), ...
    double(p.theta), ...
    double(p.mort), ...
    double(p.mort2), ...
    double(p.mortHTLm), ...
    double(p.remin), ...
    double(p.remin2), ...
    double(p.cLeakage) ...
)