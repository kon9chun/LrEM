function [cse_1s,t_1s]=simCsePDE(Rs,Ds,j)
dr=0.1e-6;
dt=0.001;
Tfinal=length(j);

x=0:dr:Rs;
t=0:dt:Tfinal;

options=odeset('RelTol',1e-8,'AbsTol',1e-10);
sol=pdepe(2,@csefun,@cseic,@csebc,x,t,options);
cse=sol(:,end,1);

cse_1s=cse(1:1/dt:end);
t_1s=t(1:1/dt:end);

cse_1s=cse_1s(1:end-1);
t_1s=t_1s(1:end-1);

    function [c,f,s]=csefun(~,~,~,DuDx)
        c=1/Ds;
        f=DuDx;
        s=0;
    end
    function u0=cseic(~,~)
        c0=0;
        u0=c0;
    end
    function [pl,ql,pr,qr]=csebc(~,~,~,~,t)
        pl=0;
        ql=1;
        qr=Ds;
        pr=j(fix(t-0.0001)+1);
    end

end