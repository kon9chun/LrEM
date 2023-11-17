function E=Eeqn(x)
load Cn.txt;
E=interp1(Cn(:,1),Cn(:,2),x,'linear','extrap');
end
