function new_node = grow(L, net, node_used)
    L(L == 0) = inf;
    L(node_used, :) = inf;
    mat = L(:, net);

    len = length(net);
    minx = zeros(len, 1);
    pls = zeros(len,1);
    
    for ite = 1: len
       [minx(ite, 1), pls(ite, 1)] = min(mat(:, ite));
    end
    [minmal, pl] = min(minx);
    if minmal < inf
       new_node = pls(pl); 
    else
        error ('can not find a newnode')
    end
end