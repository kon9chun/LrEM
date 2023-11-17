clear;
load dynamics_load\NEDC_C.mat;
tdst=22415:58651;
dst_data=NEDC_C(tdst);

nedc=[(1:length(tdst))',dst_data];