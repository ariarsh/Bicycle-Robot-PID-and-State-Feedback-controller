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
%new matrices
new_A=[A [0;0;0;0];-C 0];
new_B=[B;0];
new_C=[C 0];
%Controlability of augmented matrices
rank([B A;0 -C])
%designing K
eigs = [-.1;-.4;-.5;-.6;-10];
K = place(new_A,new_B,eigs);
eig(new_A-new_B*K)
%testing on our nonlinear system
tspan=[0 100];
yinit=[1 0 0 0 0];
[t,y] = ode45(@(t,y)bicycle_integral(y,-K*y),tspan,yinit);
plot(t,y(:,1),t,y(:,2),t,y(:,3),t,y(:,4))
xlabel=('time');
ylable=('x3');
legend('x_1','x_2','x_3','x_4');
%in ghesmat hanooz takmil nashode ast