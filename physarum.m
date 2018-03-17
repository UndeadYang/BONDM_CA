function [wei, cen, flux] = physarum(L, net, cen)
% Input and Output
% name      class       shape
% L         matrix      n x n
% net       vector      1 x m
% cen       int         None
% wei       int         None
% flux      matrix      m x m
    [~, flux, cen, wei]=amoebanet(L, net, cen);
end

function [D,Q,centr,weight]=amoebanet(TL,node_subset,pre_cen)
    if length(node_subset)>=3
        L=TL(node_subset,node_subset);
        n=length(node_subset);
        L(L==0)=inf;
        if pre_cen<=0
            Cennum=1:n;
        else
            numofcen=find(node_subset==pre_cen);
            Centrs=L(numofcen,:);
            Cennum=find(Centrs~=inf);
            Cennum=sort(horzcat(Cennum,numofcen));
        end
        DS=zeros(n,n,n);QS=zeros(n,n,n);Weights=inf*zeros(1,n);
        for i=Cennum
            sourceNode=i;
            A=ones(n,1);
            A(sourceNode)=-n+1;
            D=0.5*ones(n);
            D=D-diag(diag(D));
            temp_D=zeros(n);
            ite=0;
            lambda=n*1e-6+7e-5;
            while (sum(sum(abs(temp_D-D)))>lambda)&&ite<=10000
                B=D./L;
                B=B-diag(sum(B));
                B(:,n)=[];
                P=B\A;
                P(n)=0;
                tempP=repmat(P,1,n)-repmat(P',n,1);
                Q=abs((D./L).*tempP);
                temp_D=D;
                D=(Q+D)./2;
                ite=ite+1;
            end
            DS(:,:,i)=D;
            QS(:,:,i)=Q;
            Weights(i)=sum(sum(D.*TL(node_subset,node_subset)));
        end
        [weight,pl]=min(Weights);
        D=DS(:,:,pl);
        Q=QS(:,:,pl);
        centr=node_subset(pl);
    elseif isempty(node_subset)
        centr=0;
        D=[];
        Q=[];
        weight=0;
    elseif length(node_subset)==1
        centr=node_subset(1);
        D=1;
        Q=1;
        weight=0;
    elseif length(node_subset)==2
        centr=node_subset(1);
        D=[0 1; 1 0];
        Q=[0 1; 1 0];
        weight=0;
    end
end