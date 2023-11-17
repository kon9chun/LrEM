function mape=MAPE(Vsim,V) %单位百分号
mape=mean(abs((Vsim-V)./V))*100;
% disp(sprintf("MAPE为%.6f %%",mape));
end