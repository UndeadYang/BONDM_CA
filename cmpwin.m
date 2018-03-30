function flag = cmpwin (L, cen1, cen2, newnode)
% flage=Ture when net1 beat the net2 in newnode
% Input and Output
% name      class       shape
% L         matrix      n x n
% cen1      int         None
% cen2      int         None
% newnode   int         None
% flag      bool        None
    distan1 = amoeba_L(L, cen1, newnode);
    distan2 = amoeba_L(L, cen2, newnode);
    flag = 0;
    if distan1 < distan2
        flag = 1;
    end
end