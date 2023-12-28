clc
clear all
%time length
t_0=0;
t_final=20;
dt=0.001;
t =t_0:dt:t_final;

%initialization
d2=1;
c1=1;
c2=-1;
c3=1;
d1=0.1;
u=1;
x1(1)=0;
x2(1)=0;
x3(1)=0;
x4(1)=0;

%for loop
for i=2:length(t)
x1(i)=dt*x2(i-1) +x1(i-1);
x2(i)=dt*((0.5*d2*c1)*sin(2*x3(i-1)) + c2*sin(x3(i-1)*x4(i-1)*x4(i-1))) /(1-d1*d2*cos(x3(i-1))*cos(x3(i-1)))+ x2(i-1);
x3(i)=dt*x4(i-1) +x3(i-1);
x4(i)=dt*(0.5*d1*c2*sin(2*x3(i-1))*x4(i-1)*x4(i-1) + d1*c3*cos(x3(i-1)*u) +d2*sin(x3(i-1)))/(1-d1*c3*(cos(x3(i-1))^2))+ x4(i-1);
end
figure(1);
subplot(2,1,1)%2 satr yek sootoon avali
plot(t,x1,t,x2,t,x3,t,x4);
xlabel=('time');
ylable=('x3');
legend('x_1','x_2','x_3','x_4');
subplot(2,1,2)
plot(t,x2)
xlabel=('time');
ylable=('x3');
legend('x_1','x_2','x_3','x_4');

