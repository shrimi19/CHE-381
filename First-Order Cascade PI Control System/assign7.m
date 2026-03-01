b = [1];
a = [100 80 17 1 0];
[r,p] = residue(b,a);
fun = @(t) r(1)*(p(1)^2)*exp(p(1)*t) + r(2)*(p(2)^2)*exp(p(2)*t)+ r(3)*(p(3)^2)*exp(p(3)*t) + r(4)*(p(4)^2)*exp(p(4)*t);
t0 = [9];
t = fzero(fun,t0);
slope_a_tt =  r(1)*(p(1))*exp(p(1)*t) + r(2)*(p(2))*exp(p(2)*t)+ r(3)*(p(3))*exp(p(3)*t)+ r(4)*(p(4))*exp(p(4)*t);
y_at_tt = r(1)*exp(p(1)*t) + r(2)*exp(p(2)*t)+ r(3)*exp(p(3)*t)+ r(4)*exp(p(4)*t);
tmesh = linspace(0,100,1000);
ymesh = r(1)*exp(p(1).*tmesh) + r(2)*exp(p(2).*tmesh)+ r(3)*exp(p(3).*tmesh) + r(4)*exp(p(4).*tmesh);
y_linear_mesh = y_at_tt + slope_a_tt*(tmesh - t);

plot(tmesh,ymesh);
ylim([0 1])
hold on
plot(tmesh,y_linear_mesh);
xlabel('time');
ylabel('y');
legend('y vs time','tangential line')

td = (-y_at_tt/slope_a_tt) + t;
K = 1;
tau = 1/slope_a_tt;
Kc = 1/K*(tau/td)*(0.9 + td/(12*tau));
taui = (td*(30 + (3*td)/tau))/(9 + (20*td)/tau);

%bode plot
s = tf('s');
gc = Kc*(1 + 1/(taui*s));
gv = 1;
gp = 1/((2*s+1)*(5*s+1));
gm = 1/(10*s + 1);
gol = gc*gv*gp*gm;
figure(2);
bode(gol);