function cseTilde=DRA(Rs,Ds,J)
F1=256;%采样频率
T1=1/F1;%采样周期
minTlen=256;
N=2^(ceil(log2(minTlen*F1)));
f=0:N-1;
s=(2j/T1)*tan(pi*f/N);

beta=Rs*sqrt(s/Ds);
Hd=Rs/Ds*(1./(1-beta.*coth(beta)))+(3/Rs)./s;
Hd(1)=-Rs/5/Ds;
hd=real(ifft(Hd))*F1;
td=T1*(0:N-1);

hstep=T1*cumsum(hd);

Ts=1;
tdisc=0:Ts:256;
hdisc=[0 diff(interp1(td,hstep,tdisc))];

bigHankel=hankel(hdisc(2:257));
Hankel=bigHankel(1:127,1:127);
HankelUp=bigHankel(2:128,1:127);
[U,S,V]=svd(Hankel);

n=2;
Us=U(:,1:n);
Ss=S(1:n,1:n);
Vs=V(:,1:n);
ok=Us*sqrtm(Ss);
cl=sqrtm(Ss)*Vs';

Ahat=(ok\HankelUp)/cl;
Bhat=cl(1:n,1);
Chat=-ok(1,1:n);
Dhat=0;

sysDRA = ss(Ahat,Bhat,Chat,Dhat,Ts);

[cseTilde,tk]=lsim(sysDRA,J);
end