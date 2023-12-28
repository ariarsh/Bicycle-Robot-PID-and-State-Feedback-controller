%State Feedback Controler
clear;
clc;
A=readmatrix('A_barr');
B=readmatrix('B_barr');
C = [1 0 0 0];
D=0;
%controlability
rank(ctrb(A,B))
%eigen values
eig(A)
%designing K
eigs = [-1;-4;-5;-6];
K = place (A,B,eigs);
eig(A-B*K)
%GCL
GCLZ=C*inv(B*K-A)*B;
%testing on our nonlinear system
tspan=[0 10];
yinit=[1 0 0 0];
r=4;
[t,y] = ode45(@(t,y)bicycle(y,-K*y+r*inv(GCLZ)),tspan,yinit);
plot(t,y(:,1),t,y(:,2),t,y(:,3),t,y(:,4))
xlabel=('time');
ylable=('x3');
legend('x_1','x_2','x_3','x_4');
