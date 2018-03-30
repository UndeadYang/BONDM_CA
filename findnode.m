function index = findnode(nets, node)
% Input and Output
% name      class       shape
% nets      cell        1 x n
% node      int         None
% index     int         None
    for ite = 1: length(nets)
        if ismember(node, nets{ite})
            index = ite;
        end
    end
end