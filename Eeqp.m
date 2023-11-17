function E=Eeqp(x)
load LMOp.txt;
E=interp1(LMOp(:,1),LMOp(:,2),x,'linear','extrap');
end
