clear;
clc;
tspan=[0 10];
yinit=[1 0 0 0];

u=0;
[t,y] = ode45(@(t,y)bicycle(y,u),tspan,yinit);
plot(t,y(:,1),t,y(:,2),t,y(:,3),t,y(:,4))
xlabel=('time');
ylable=('x3');
legend('x_1','x_2','x_3','x_4');