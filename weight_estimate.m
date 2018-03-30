function wei_ltd = weight_estimate(L, num)
% Input and Output
% name      class       shape
% L         matrix      n x n
% num       int         None
% wei_ltd   int         None
    factork=0.35;
    E = sum(sum(L))*factork;
    wei_ltd = E/num;
end