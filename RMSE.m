function rmse=RMSE(Vsim,V) %单位V
rmse=sqrt(mean((Vsim-V).^2));
% disp(sprintf("RMSE为%.6f",rmse));
end