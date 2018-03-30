function flag = growable(L, net, node_used)
% Input and Output
% name      class       shape
% L         matrix      n x n 
% net       vector      1 x m
% node_used vector      1 x i
% flag      bool        None
    L(L == 0) = inf;
    L(node_used, :) = inf;
    temp = L(:, net);
    flag = 1;
    if min(min(temp)) == inf
        flag = 0;
    end
end