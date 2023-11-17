function [cen,cep]=sp_electrolyte(I)
Lneg=100e-6;
Lsep=52e-6;
Lpos=183e-6;
Lsum=Lneg+Lsep+Lpos;
F=96485.33289;
Aera=1;
cl=1000;
De=2.7877e-10;
epsl=0.4;
Xequ=(-2*Lneg^2+3*Lsep^2+2*Lpos^2+6*Lsep*Lpos)/6/Lsum;
P=-epsl*(Lneg^2/3+Lneg*Xequ+Xequ^2/2);
Q1=-2/(Lneg+2*Xequ);
Q2=-2/(Lpos+2*(Lsep-Xequ));
t_plus=0.363;
Rg=8.314;

dcen(1)=0;
dcep(1)=0;

for i=1:length(I)
    ddcen=De*epsl^1.5*dcen(i)/P-(1-t_plus)*I(i)/F/Aera/P/Q1;
    dcen(i+1)=dcen(i)+ddcen;
    ddcep=De*epsl^1.5*dcep(i)/P+(1-t_plus)*I(i)/F/Aera/P/Q2;
    dcep(i+1)=dcep(i)+ddcep;
end
cen=dcen(1:end-1)+cl;
cep=dcep(1:end-1)+cl;
end