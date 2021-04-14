function j = cal_grad(X)
j = zeros(20,12);
Xr0=[0;0];
phir0=0;
Xr1=X(1:2);
phir1=X(3);

Xr2=X(4:5);
phir2=X(6);
% Xr1=[2;1];
% Xr2=[4;2];
% phir1=0.2;
% phir2=0.5;

Xf1=X(7:8);
Xf2=X(9:10);
Xf3=X(11:12);
% Xf1=X(1:2);
% Xf2=X(3:4);
% Xf3=X(5:6);

dx1 = Xr1-Xr0;
J01 =[cos(phir0),-sin(phir0),0;
      sin(phir0),cos(phir0),0;
      0,0,1]; 
j(1:3,1:3) = j(1:3,1:3)+J01;

dx2 = (Xr2-Xr1);
J12 =[-cos(phir1),sin(phir1),-sin(phir1)*dx2(1)-cos(phir1)*dx2(2),cos(phir1),-sin(phir1),0;
      -sin(phir1),-cos(phir1),cos(phir1)*dx2(1)-sin(phir1)*dx2(2),sin(phir1),cos(phir1),0;
      0,0,-1,0,0,1]; 
j(4:6,1:6) = j(4:6,1:6) + J12;  
% e(1:3) = e(1:3) + J01*X(1:3);
% e(4:6) = e(4:6) + J12*X(1:6);


J0f1 =[cos(phir0),-sin(phir0);
      sin(phir0),cos(phir0)];
J0f2 =[cos(phir0),-sin(phir0);
      sin(phir0),cos(phir0)];
j(7:8,7:8) = j(7:8,7:8) + J0f1;
j(9:10,9:10)= j(9:10,9:10)+ J0f2;
% e(7:8) = e(7:8) + J0f1*X(7:8);
% e(9:10) = e(9:10) + J0f2*X(9:10);
  
df1 = Xf1-Xr1;
J1f1 =[-cos(phir1),sin(phir1),-sin(phir1)*df1(1)-cos(phir1)*df1(2),zeros(1,3),cos(phir1),-sin(phir1);
      -sin(phir1),-cos(phir1),cos(phir1)*df1(1)-sin(phir1)*df1(2),zeros(1,3),sin(phir1),cos(phir1)];
j(11:12,1:8)=j(11:12,1:8)+J1f1;
  
df2 = Xf2-Xr1;
J1f2 =[-cos(phir1),sin(phir1),-sin(phir1)*df2(1)-cos(phir1)*df2(2),zeros(1,3),zeros(1,2),cos(phir1),-sin(phir1);
      -sin(phir1),-cos(phir1),cos(phir1)*df2(1)-sin(phir1)*df2(2),zeros(1,3),zeros(1,2),sin(phir1),cos(phir1)];
j(13:14,1:10)=j(13:14,1:10)+J1f2;
  
df3 = Xf3-Xr1; 
J1f3 =[-cos(phir1),sin(phir1),-sin(phir1)*df3(1)-cos(phir1)*df3(2),zeros(1,3),zeros(1,2),zeros(1,2),cos(phir1),-sin(phir1);
      -sin(phir1),-cos(phir1),cos(phir1)*df3(1)-sin(phir1)*df3(2),zeros(1,3),zeros(1,2),zeros(1,2),sin(phir1),cos(phir1)];
j(15:16,1:12)=j(15:16,1:12)+J1f3;

  
% e(11:12) = e(11:12) + J1f1*X(1:8);
% e(13:14) = e(13:14) + J1f2*X(1:10);
% e(15:16) = e(15:16) + J1f3*X(1:12);

d2f2 = Xf2-Xr2;
J2f2 =[zeros(1,3),-cos(phir2),sin(phir2),-sin(phir2)*d2f2(1)-cos(phir2)*d2f2(2),zeros(1,2),cos(phir2),-sin(phir2);
      zeros(1,3),-sin(phir2),-cos(phir2),cos(phir2)*d2f2(1)-sin(phir2)*d2f2(2),zeros(1,2),sin(phir2),cos(phir2)];
j(17:18,1:10)=j(17:18,1:10)+J2f2;  
  
d2f3 = Xf3-Xr2;
J2f3 =[zeros(1,3),-cos(phir2),sin(phir2),-sin(phir2)*d2f3(1)-cos(phir2)*d2f3(2),zeros(1,2),zeros(1,2),cos(phir2),-sin(phir2);
      zeros(1,3),-sin(phir2),-cos(phir2),cos(phir2)*d2f3(1)-sin(phir2)*d2f3(2),zeros(1,2),zeros(1,2),sin(phir2),cos(phir2)];
j(19:20,1:12)=j(19:20,1:12)+ J2f3;

% e(17:18) = e(17:18) + J2f2*X(4:10);
% e(19:20) = e(19:20) + J2f3*X(4:12);
