function dconcentration=three_parameter(Ds,R,J)
A=-30*Ds/R^2;
B=45/2/R^2;
C=8*R/35;
D=R/35/Ds;

three=ss(A,B,C,D);
dconcentration=lsim(three,J,0:length(J)-1);
end