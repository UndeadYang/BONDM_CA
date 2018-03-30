load L_HWserver
nets_num = 30;
max_ite = 50;
[subnets, fluxes, centers] = bondm_ca(L, nets_num, max_ite);
examples = [1, 15, 30];
ite = 0;
for net = examples
    ite = ite+1;
    g = subgraph(net, nets, fluxes)
    figure(ite), plot(g)
end