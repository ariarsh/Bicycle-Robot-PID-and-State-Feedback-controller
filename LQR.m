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
Q=[10 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1];
R=0.01;
K = lqr(A,B,Q,R);
eig(A-B*K) %new eigen values after using linear quadratic regulator
%testing on our nonlinear system
tspan=[0 10];
yinit=[1 0 0 0];
[t,y] = ode45(@(t,y)bicycle(y,-K*y),tspan,yinit);
plot(t,y(:,1),t,y(:,2),t,y(:,3),t,y(:,4))
xlabel=('time');
ylable=('x3');
legend('x_1','x_2','x_3','x_4');
