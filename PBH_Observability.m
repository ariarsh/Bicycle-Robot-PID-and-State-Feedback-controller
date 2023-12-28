%PBH Observability
A = [0 1 0 0;0 0 -10.9426 0;0 0 0 1;0 0 5.79882 0];
B = [0;7.06703;0;-0.0613];
C = [1 0 0 0];
landa=-2.4081;
PBH=[A-landa*eye;C]
rank(PBH)