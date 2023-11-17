function output=LSTM_cc8000(net_dcsn8000)
netn1=net_dcsn8000;
netn2=[zeros(1,2000),-net_dcsn8000(1:6000)];
netn3=[zeros(1,2300),-net_dcsn8000(1:5700)];
netn4=[zeros(1,4300),net_dcsn8000(1:3700)];
output=netn1+netn2+netn3+netn4;
end