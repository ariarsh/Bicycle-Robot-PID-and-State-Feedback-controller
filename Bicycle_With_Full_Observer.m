function dy=Bicycle_With_Full_Observer(y,u)
d2=1;
c1=1;
c2=-1;
c3=1;
d1=0.1;
A=readmatrix('A_barr');
B=readmatrix('B_barr');
C = [1 0 0 0];
D=0;
%
A_0=A';
B_1=C';
f=[-1 -2 -3 -4];
L=(acker(A_0,B_1,f))';
A_1=A-L*C;
B_1=[B L];
%dy=zeros(4,1);
dy(1,1)=y(2);
dy(2,1)=( 0.5*d2*c1*sin(2*y(3)) + c2*sin(y(3)*y(4)*y(4)) +c3*u  ) / (  1-d1*c1*cos(y(3))*cos(y(3))  );
dy(3,1)=y(4);
dy(4,1)=( 0.5*d1*c2*sin(2*y(3))*y(4)*y(4) + d1*c3*cos(y(3))*u + d2*sin(y(3))  )/ ( 1-d1*c1*cos(y(3))*cos(y(3)) );
dy(5:8,1)=A_1*y(1:4) + B_1*[u;C*y(1:4)];

