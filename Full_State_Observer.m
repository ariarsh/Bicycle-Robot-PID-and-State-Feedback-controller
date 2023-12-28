%Designing Full State Estimator!
clear;
clc;
A=readmatrix('A_barr');
B=readmatrix('B_barr');
C = [1 0 0 0];
D=0;
%controlability
rank(ctrb(A,B)) %because our system is controlable we can design state feed_back controler!
%observability
rank(obsv(A,C)) %because our system is observable we can design state estimator!
%eigen values
eig(A)
%designing K
eigs = [-1;-4;-5;-6];
K = place (A,B,eigs);
eig(A-B*K)
%GCL
GCLZ=(C/(B*K-A))*B;%using A/B instead of A*inv(B) is really faster way!
%designing L
observer_eigs=[-1 -2 -3 -4];
L=(place(A',C',observer_eigs))';
%kallman filter-> kf=(lqr(A',C',Vd,Vn))';       Vd=0.1*eye(4);    Vn=1;
%testing on our nonlinear system
tspan=[0 10];
yinit=[1 0 0 0 0 0 0 0];
r=4;
[t,y] = ode45(@(t,y)Bicycle_With_Full_Observer(y,-K*y(5:8)+r*inv(GCLZ)),tspan,yinit);
plot(t,y(:,1),t,y(:,2),t,y(:,3),t,y(:,4))
xlabel=('time');
ylable=('x3');
legend('x_1','x_2','x_3','x_4');
