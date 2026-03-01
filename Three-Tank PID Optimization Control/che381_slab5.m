Kc = 23 ;
Ti = 262;
Td = 1.96;
sim("che381_sim5.slx",1000);

load("ans_file.mat","ans");
error=ans(2,:);
time=ans(1,:);
value1 = error.*error;
value2 = value1.*time;
ITSE=trapz(time,value2);