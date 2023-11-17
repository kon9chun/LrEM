function dcsep=deltacsep(I,socsurfp) %直接load txt文件就行
epssp=0.297;
Lp=183e-6;
cs0pos=3900;
csmaxpos=22860;
A=1;
F=96485.33289;
%Ah
csp=cumsum(-I)/Lp/A/epssp/F;

csesurfp=socsurfp(:,2)*csmaxpos;

dcsep=csesurfp-csp-cs0pos;
end