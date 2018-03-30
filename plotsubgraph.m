function [g] = subgraph(index, nets, fluxes)
    vector = nets{1, index};
    len = length(vector);
    names = cell(1, len);
    for ite = 1 : len
        names{1, ite} = num2str(vector(1, ite));
    end
    g = graph(fluxes{1, index}, names);

end