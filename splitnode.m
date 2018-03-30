function new_node = splitnode(L, net, cen)
    sub_L = L(net, net);
    maxs = 0;
    new_node = [];
    cen_index = find(net == cen);
    for index = 1: length(net)
        if index ~= cen_index
            distan = amoeba_L(sub_L, index, cen_index);
            if distan > maxs
               maxs = distan;
               new_node = net(index); 
            end
        end
    end
end