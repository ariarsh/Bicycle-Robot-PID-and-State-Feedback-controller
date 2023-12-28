%Full Luenberger
clear all;
close all;
clc;
dt=0.01;
t=0:0.01:100;
A=readmatrix('A_barr');
B=readmatrix('B_barr');
C = [1 0 0 0];
D=0;
%% Luenberger
A_0=A';
B_1=C';
f=[-1 -2 -3 -4];
L=(place(A_0,B_1,f))';
A_1=A-L*C;
B_1=[B L];
%parameters
d2=1;
c1=1;
c2=-1;
c3=1;
d1=0.1;

%% Initial Conditions
u=1;
x1(1)=0;
x2(1)=0;
x3(1)=0;
x4(1)=0;
x(:,1)=[x1(1);x2(1);x3(1);x4(1)];

x1_hat(1)=0;
x2_hat(1)=1;
x3_hat(1)=0;
x4_hat(1)=0;
x_hat(:,1)=[x1_hat(1);x2_hat(1);x3_hat(1);x4_hat(1)];


%% Solving Equation X^dot=A^*x^+B^*u^
for i=2:length(t)    
    u(i)=0;
    
x1(i)=dt*x2(i-1) +x1(i-1);
x2(i)=dt*((0.5*d2*c1)*sin(2*x3(i-1)) + c2*sin(x3(i-1)*x4(i-1)*x4(i-1))) /(1-d1*d2*cos(x3(i-1))*cos(x3(i-1)))+ x2(i-1);
x3(i)=dt*x4(i-1) +x3(i-1);
x4(i)=dt*(0.5*d1*c2*sin(2*x3(i-1))*x4(i-1)*x4(i-1) + d1*c3*cos(x3(i-1)*u(i)) +d2*sin(x3(i-1)))/(1-d1*c3*(cos(x3(i-1))^2))+ x4(i-1);

    x(:,i)=[x1(i);x2(i);x3(i);x4(i)];
end

y=C*[x1;x2;x3;x4];


%% X^dot=(A-LC)X^+[B U][u;y]

for i=2:length(t)
    u(i)=0;
    U_1(:,i)=[u(i);y(i)];
    x1_hat (i) = x1_hat(i-1)+ dt*(A_1(1,:)*x_hat(:,i-1)+B_1(1,:)*U_1(:,i-1));
    x2_hat (i) = x2_hat(i-1)+ dt*(A_1(2,:)*x_hat(:,i-1)+B_1(2,:)*U_1(:,i-1));
    x3_hat (i) = x3_hat(i-1)+ dt*(A_1(3,:)*x_hat(:,i-1)+B_1(3,:)*U_1(:,i-1));
    x4_hat (i) = x4_hat(i-1)+ dt*(A_1(4,:)*x_hat(:,i-1)+B_1(4,:)*U_1(:,i-1));
    x_hat(:,i)=[x1_hat(i);x2_hat(i);x3_hat(i);x4_hat(i)];
end


%% plot result
figure(1);
subplot(2,2,1)
plot(t,x1(1,:),'--',t,x1_hat(1,:),':','LineWidth' , 1.5);
grid on;
xlabel('Time');
ylabel('x1');
title('x1');
legend('x1','x1hat');

subplot(2,2,2)
plot(t,x2(1,:),'--',t,x2_hat(1,:),':','LineWidth' , 1.5);
grid on;
xlabel('Time');
ylabel('x2');
title('x2');
legend('x2','x2hat');

subplot(2,2,3)
plot(t,x3(1,:),'--',t,x3_hat(1,:),':','LineWidth' , 1.5);
grid on;
xlabel('Time');
ylabel('x3');
title('x3');
legend('x3','x3hat');

subplot(2,2,4)
plot(t,x4(1,:),'--',t,x4_hat(1,:),':','LineWidth' , 1.5);
grid on;
xlabel('Time');
ylabel('x4');
title('x4');
legend('x4','x4hat');
%% Error
e=[x1-x1_hat;x2-x2_hat;x3-x3_hat;x4-x4_hat];
N1_2=norm(e(1,:),2);
N2_2=norm(e(2,:),2);
N3_2=norm(e(3,:),2);
N4_2=norm(e(4,:),2);

N1_INF=norm(e(1,:),inf);
N2_INF=norm(e(2,:),inf);
N3_INF=norm(e(3,:),inf);
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
ylabel('Error x4)');
legend('Error x4');