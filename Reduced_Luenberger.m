clear all;
close all;
clc;


%% Time Length
t0=0;
tf=10;
dt=0.01;
t=t0:dt:tf;


%% Parametrs
d2=1;
c1=1;
c2=-1;
c3=1;
d1=0.1;
A=readmatrix('A_barr');
B=readmatrix('B_barr');
C = [1 0 0 0;0 0 1 0];

%% Redused Luenbeger
n=rank(ctrb(A,B));
l=rank(C);

D=[-7 0;0 -10];
Q=[0 0 1 0;1 1 1 1;0 0 0 1;1 0 0 1];

A_t=inv(Q)*A*Q;

A_t_11=A_t(1:(n-l),1:(n-l));
A_t_12=A_t(1:(n-l),(n-l)+1:n);
A_t_21=A_t((n-l)+1:n,1:(n-l));
A_t_22=A_t((n-l)+1:n,(n-l)+1:n);

L_t=(D-A_t_11)*inv(A_t_21);
L=[eye(n-l) L_t]*inv(Q);
T=A_t_12+L_t*A_t_22-D*L_t;
R=L*B;

%% Initial Conditions
x1(1)=1;
x2(1)=0;
x3(1)=1;
x4(1)=0;
u(1)=1
x(:,1)=[x1(1);x2(1);x3(1);x4(1)];


%% Solving Equation Xdot=Ax+Bu
for i=2:length(t)
   u(i)=1;
   x1(i)=dt*x2(i-1) +x1(i-1);
x2(i)=dt*((0.5*d2*c1)*sin(2*x3(i-1)) + c2*sin(x3(i-1)*x4(i-1)*x4(i-1))) /(1-d1*d2*cos(x3(i-1))*cos(x3(i-1)))+ x2(i-1);
x3(i)=dt*x4(i-1) +x3(i-1);
x4(i)=dt*(0.5*d1*c2*sin(2*x3(i-1))*x4(i-1)*x4(i-1) + d1*c3*cos(x3(i-1)*u(i)) +d2*sin(x3(i-1)))/(1-d1*c3*(cos(x3(i-1))^2))+ x4(i-1);

    x(:,i)=[x1(i);x2(i);x3(i);x4(i)];
end


%% zdot=Az+Ty+Ru
z1(1)=0;
z2(1)=0;
z(:,1)=[z1(1);z2(1)];
y(:,1)=[x1(1);x3(1)];
for i=2:length(t)
    u(i)=0;
    z1(i)=z1(i-1)+ dt*(D(1,:)*z(:,i-1)+T(1,:)*y(:,i-1)+R(1)*u(i-1));
    z2(i)=z2(i-1)+ dt*(D(2,:)*z(:,i-1)+T(2,:)*y(:,i-1)+R(2)*u(i-1));
    z(:,i)=[z1(i);z2(i)];
    y(:,i)=[x1(i);x3(i)];
end

z=[z1;z2];
x_hat=inv([C;L])*[y;z];


%% Plot results
figure(1)
subplot(2,2,1)
plot(t,x1(1,:),'--','LineWidth', 1.5 );
grid on;
xlabel('Time');
ylabel('x1');
title('x1');
legend('x1');

subplot(2,2,2)
plot(t,x2(1,:),'--',t,x_hat(2,:),':','LineWidth' , 1.5);
grid on;
xlabel('Time');
ylabel('x2');
title('x2');
legend('x2','x2hat');

subplot(2,2,3)
plot(t,x3(1,:),'--','LineWidth' , 1.5);
grid on;
xlabel('Time');
ylabel('x3');
title('x3');
legend('x3');

subplot(2,2,4)
plot(t,x4(1,:),'--',t,x_hat(4,:),':','LineWidth' , 1.5);
grid on;
xlabel('Time');
ylabel('x4');
title('x4');
legend('x4','x4hat');

%% Error
e=[x1-x_hat(1,:);x2-x_hat(2,:);x3-x_hat(3,:);x4-x_hat(4,:)];

N2_2=norm(e(2,:),2);
N4_2=norm(e(4,:),2);
N2_INF=norm(e(2,:),inf);
N4_INF=norm(e(4,:),inf);

figure(2);
subplot(2,2,1)
plot(t,e(1,:),'LineWidth',1.5);
grid on;
xlabel('Time');
ylabel('Error x1');
legend('Error x1');

subplot(2,2,2)
plot(t,e(2,:),'LineWidth',1.5);
grid on;
xlabel('Time');
ylabel('Error x2');
legend('Error x2');

subplot(2,2,3)
plot(t,e(3,:),'LineWidth',1.5);
grid on;
xlabel('Time');
ylabel('Error x3');
legend('Error x3');

subplot(2,2,4)
plot(t,e(4,:),'LineWidth',1.5);
grid on;
xlabel('Time');
ylabel('Error x4');
legend('Error x4');