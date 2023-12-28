%linearization
clear;clc;
syms y1 y2 y3 y4  u
d2=1;
c1=1;
c2=-1;
c3=1;
d1=0.1;

f1(y1,y2,y3,y4,u)=y2;
f2(y1,y2,y3,y4,u)=( 0.5*d2*c1*sin(2*y3) + c2*sin(y3*y4*y4) +c3*u  ) / (  1-d1*c1*cos(y3)*cos(y3)  );
f3(y1,y2,y3,y4,u)=y4;
f4(y1,y2,y3,y4,u)=( 0.5*d1*c2*sin(2*y3)*y4*y4 + d1*c3*cos(y3)*u + d2*sin(y3)  )/ ( 1-d1*c1*cos(y3)*cos(y3) );
j_y=jacobian([f1,f2,f3,f4],[y1,y2,y3,y4]);
j_u=jacobian([f1,f2,f3,f4],[u]);
y1=0;
y2=0;
y3=0;
y4=0;
ky=j_y(y1,y2,y3,y4,u);
ku=j_u(y1,y2,y3,y4,u);

A_bar=zeros(4,4);
B_bar=zeros(4,1);

for i=1:4
    for j=1:4
        A_bar(i,j)=ky(i,j);
    end
end

for q=1:4
    for p=1
    B_bar(q,p)=ku(q,p);
    end
end

A_bar;
B_bar;
C=[1 0 0 0 ];
D=0;
linear_sys=ss(A_bar,B_bar,C,D);
rank(ctrb(A_bar,B_bar));%it is controolable



%saving as file
filenameA='C:\Users\ariar\Desktop\arshad\term1\Modern Control Alipour\A_barr';
writematrix(A_bar,filenameA);

filenameB='C:\Users\ariar\Desktop\arshad\term1\Modern Control Alipour\B_barr';
writematrix(B_bar,filenameB);

