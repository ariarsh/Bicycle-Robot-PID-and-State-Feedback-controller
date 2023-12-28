%State Feedback Controler
clear;
clc;
A=readmatrix('A_barr');
B=readmatrix('B_barr');
C = [1 0 0 0];
D=0;
%controlability
rank(ctrb(A,B))
%our eigen values
eig(A);
%designing K
eigs = [-0.1;-0.2;-0.3;-0.4]; %desired eigen values we want!
K = place (A,B,eigs);
eig(A-B*K)
%testing on our nonlinear system
tspan=[0 100];
yinit=[1 0 0 0];
[t,y] = ode45(@(t,y)bicycle(y,-K*y),tspan,yinit);
plot(t,y(:,1),t,y(:,2),t,y(:,3),t,y(:,4))
xlabel=('time');
ylable=('x3');
legend('x_1','x_2','x_3','x_4');
