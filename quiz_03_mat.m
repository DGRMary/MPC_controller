clear all 
close all 
clc

Ts = 0.05;

A = [-1 0;1 0];
B = [1;0];
C = [0 1];
D = [0];

sys = ss(A,B,C,D);
sys_x = ss(A,B,eye(2),zeros(2,1));
sys_dt = c2d(sys,Ts,'zoh');

Ad = sys_dt.a;
Bd = sys_dt.b;
Cd = sys_dt.c;
Dd = sys_dt.d;

Cy = eye(2);
Cc = Cd;
Cz = Cd;
Dc = Dd;
Dz = Dd;

Q = 10000;
R = 1;

cmode = 0;
h = Ts;
Hw = 1;
Hu = 50;
Hp = 50;
zblk = 1;
ublk = 1;
dumax = [inf];
dumin = [-inf];
umax = [1];
umin = [-1];
zmax = [1.01];
zmin = [-1.01];

md = MPCInit(Ad,Bd,Cy,Cz,Dz,Cc,Dc,Hp,Hw,zblk,Hu,ublk,...
   dumax,dumin,umax,umin,zmax,zmin,Q,R,[],[],h,cmode,...
   'qp_as')
MPC_block 

out = sim('quiz_03_simulink')

figure(1)
hold on 
plot(out.y.time, out.y.data, 'b','linewidth', 1.2)
grid on 
xlabel('t(s)');
ylabel('y(t)');

figure(2)
hold on 
plot(out.e.time, out.e.data, 'b','linewidth', 1.2)
grid on 
xlabel('t(s)');
ylabel('e(t)');

figure(3)
hold on 
plot(out.u.time, out.u.data, 'b','linewidth', 1.2)
grid on 
xlabel('t(s)');
ylabel('u(t)');