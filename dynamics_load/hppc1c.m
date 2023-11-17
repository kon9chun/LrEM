clear;
t1=zeros(300,1);
tl=t1;
for i=1:9
    tn1=-ones(10,1);
    tn2=zeros(10,1);
    tn3=ones(10,1);
    tn4=zeros(10,1);
    tn5=-0.1*ones(3600,1);
    tn6=zeros(7200,1);
    point(i)=length(tl);
    tl=[tl;tn1;tn2;tn3;tn4;tn5;tn6];
end
tl=[tl;tn1;tn2;tn3;tn4];
point(10)=length(tl);
t=1:length(tl);
t=t';
hppc=[t,tl];