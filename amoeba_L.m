function [sumL]= amoeba_L(L,sourceNode,sinkNode)
    if sinkNode>0
        warning('off')
        n=length(L(:,1));
        L(L==0)=inf;
        D=0.5*ones(n);
        D=D-diag(diag(D));
        
        A=zeros(n,1);
        A(sourceNode)=-1;
        A(sinkNode)=1;
        temp_D=zeros(n);
        
        ite=0;
        templogiD=ones(n);
        maxite=20;
        while ite<=maxite%sum(sum(abs(temp_D-D)))>0.001
            %ite<=maxite
            % Bï¼šç”¨äºŽå­˜å‚¨å¤šé¡¹å¼çš„ç³»æ•°ï¼Œå³ç³»æ•°çŸ©é˜?ä¸‹é¢æ˜¯æ±‚å–æ–¹æ³?
            B=D./L;
            % èŽ·å–ç³»æ•°çŸ©é˜µ
            B=B-diag(sum(B));
            % è§„å®špnåŽ‹åŠ›ä¸ºé›¶ï¼Œæ­¤å¤„æ˜¯è¯¥å°†Bè½¬æ¢æˆ?n)*(n-1)
            B(:,n)=[];
            % è§£å„ç‚¹åŽ‹åŠ?
            P=B\A;
            P(n)=0;
            % æ ¹æ®åŽ‹åŠ›æ±‚Qï¼Œå…ˆæž„é?ä¸?¸ªpi-pjçš„çŸ©é˜?remat:å¤åˆ¶å‘é‡å˜æˆçŸ©é˜µ
            tempP=repmat(P,1,n)-repmat(P',n,1);
            Q=(D./L).*tempP;
            Q=abs(Q);
            temp_D=D;
            D=(Q+D)./2;
            ite=ite+1;
            if (ite>=maxite-2)&&(ite<=maxite+1)
                logiD=(D-temp_D)>0;
                templogiD=templogiD&logiD;
            end
        end
        % Q(Q<=0.2)=0;
        % Q(Q>0.8)=1;
        L(L==inf)=0;
        sumL=sum(sum(templogiD.*L))/2;
        %sumL=sum(sum(Q.*L))/2;
    else
        sumL=inf;
    end
end