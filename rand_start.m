function [nets, node_used] = rand_start(num, rage)
% Input and Output
% name      class       shape
% num       int         None
% rage      vector      1 x 2
% nets      cell        1 x num
% node_used vector      1 x num
    seed = 970202;
    nets = cell(1,num);
    rng(seed);
    raw = randperm(rage, num);
    node_used = sort(raw);
    ite = 0;
    for node = raw
        ite = ite + 1;
        nets{1, ite} = raw(ite);
    end
    rng('default')
end