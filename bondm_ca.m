function [nets, fluxes,cens] = bondm_ca(L, nets_num, max_ite)
    len = length(L(1,:));
    wei_ltd = weight_estimate(L,nets_num);
    [nets, node_used] = rand_start(nets_num, len);
    weis = zeros(1, nets_num);
    cens = horzcat(nets{1:length(nets)});
    fluxes = cell(1, nets_num);
    sques = rand_list(nets_num, max_ite);
    curr_ite = 0;
    while curr_ite < max_ite && length(node_used) < len
        curr_ite = curr_ite + 1;
        % fprintf('Processing iteration %d\n', curr_ite)
        for index = sques(curr_ite, :)
            net = nets{index};
            if weis(index) < wei_ltd
                if growable(L, net, node_used)
                    new_node = grow(L, net, node_used);
                    nets{index} = sort([nets{index}, new_node]);
                    node_used = sort([node_used, new_node]);
                    [weis(index), cens(index), fluxes{index}] = physarum(L, nets{index}, cens(index));
                else
                    new_node = grow(L, net, net);
                    cmp_index = findnode(nets, new_node);
                    if ifedge(fluxes{cmp_index}, nets{cmp_index}, new_node) && cmpwin(L, cens(index), cens(cmp_index), new_node)
                        nets{cmp_index}(nets{cmp_index} == new_node) = [];
                        nets{index} = sort([nets{index}, new_node]);
                        [weis(index), cens(index), fluxes{index}] = physarum(L, nets{index}, cens(index));
                        [weis(cmp_index), cens(cmp_index), fluxes{cmp_index}] = physarum(L, nets{cmp_index}, cens(cmp_index));
                    end
                end
            else
                new_node = splitnode(L, net, cens(index));
                nets{index}(nets{index} == new_node) = [];
                node_used(node_used == new_node) = [];
                [weis(index), cens(index), fluxes{index}] = physarum(L, nets{index}, cens(index));
            end
        end
    end
    fprintf('The number of node remain unused is %d\n', 1200 - length(node_used))
    if 1200 - length(node_used) > 0
        for ite = 1:5
            node_unused = setdiff([1 : len], node_used);
            for node = node_unused
                mindis = inf;
                index = 0;
                for temp_index = 1: nets_num
                    distan = netnodedis(L, nets{temp_index}, node);
                    if distan < mindis
                        mindis = distan;
                        index = temp_index;
                    end
                end
                if mindis == inf
                    break;
                end
                nets{index} = sort(nets{index}, node);
                node_used = sort(node_used, node);
            end
            if length(node_used) == len
                break;
            end
        end
    end
end