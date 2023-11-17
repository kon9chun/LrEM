function dcsen=deltacsen(I,socsurfn) %直接load txt文件就行
epssn=0.471;
Ln=100e-6;
cs0neg=14870;
csmaxneg=26390;
A=1;
F=96485.33289;

csn=cumsum(I)/Ln/A/epssn/F;

csesurfn=socsurfn(:,2)*csmaxneg;

dcsen=csesurfn-csn-cs0neg;
end