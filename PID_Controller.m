%PID Controller
clear;
clc;
A = [0 1 0 0;0 0 -10.9426 0;0 0 0 1;0 0 5.79882 0];
B = [0;7.06703;0;-0.0613];
C = [1 0 0 0];
D=0;
%sys=ss(A,B,C,D);
%sys_as_tf = tf(sys);
[b,a] = ss2tf(A,B,C,D);
sys = tf(b,a);
%[C_pid,info] = pidtune(sys,'PID')
%T_pid = feedback(C_pid*sys, 1);
%step(T_pid)
[C_pid,info] = pidtune(sys,'PID')
T_pid = feedback(C_pid*sys, 1);
T_pid
