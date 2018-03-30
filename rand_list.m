function sques = rand_list(num, high)
% Input and Output
% name      class       shape
% num       int         None
% high      int         None
% sques     matrix      num x high
    seed = 970922;
    rng(seed);
    sques =zeros(high, num);
    for ite = 1: high
        sques(ite, :) = randperm(num, num);
    end
    rng('default')
end