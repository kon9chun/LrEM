function dcsep=fom(rp,Dsp,I)
taup=rp^2/Dsp;
% taun=rn^2/Dsn;

ap=[1,12/95*sqrt(taup)];
% an=[1,12/95*sqrt(taun)];

na=[0,0.5];
b=0.2;
nb=0;
% ap=[1,0.142570867246456*sqrt(taup)];
% an=[1,0.142570867246456*sqrt(taun)];
% 
% na=[0,0.5];
% b=0.244188370659625;
% nb=0;

tfp=fotf(ap,na,b,nb);
% tfn=fotf(an,na,b,nb);

dcsep=lsim(tfp,I,1:length(I))*rp/Dsp;
% dcsen=lsim(tfn,I,1:length(I))*rn/Dsn;
end