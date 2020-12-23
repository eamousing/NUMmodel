function panelTime(sim)
t = sim.t;

semilogy(t, sim.N,'b-')
hold on
semilogy(t, sim.DOC,'color',[181 100 30]/256)
for iGroup = 1:sim.p.nGroups
    semilogy(t, sim.Bgroup(:,iGroup),'k-');
end

legend({'N','DOC'},'location','eastoutside')