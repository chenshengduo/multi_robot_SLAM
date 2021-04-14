close all
clear
clc

n = 10; % interation number

load multi_SLAM_pose 
load multi_SLAM_obse

X0 = gt(:,1:4) + normrnd(0,0.09, [9,4]);
% X0(:,1) = gt(:,1);
F0 = feature + normrnd(0,0.09,[2,3]); 
X = [];
% initialization
for i = 1:size(gt,2)
    X = [X;X0(:,i)];   
end
for i = 1:size(feature,2)
    X = [X;F0(:,i)];   
end

for inter = 1:n
    Xr1_0=X(1:3);
    Ur1 = [1;pi/6];
    Xr2_0=X(4:6);
    Ur2 = [2;pi/6];
    Xr3_0=X(7:9);
    Ur3 = [3;pi/6];
    
    Xf1=X(37:38);
    Xf2=X(39:40);
    Xf3=X(41:42);

    for t = 1:3
        e_o = X(1:3)-gt();
        e_o= X(4:6);
        e_o= X(7:9);

        ob_r1_f1 = calobservation(gt(1:3,i),Xf1,0); %   x,feature,variance
        ob_r1_f2 = calobservation(gt(1:3,i),Xf2,0);
        ob_r1_f3 = calobservation(gt(1:3,i),Xf3,0);

        ob_r2_f2 = calobservation(gt(4:6,i),Xf2,0);
        ob_r2_f3 = calobservation(gt(4:6,i),Xf3,0);

        ob_r3_f1 = calobservation(gt(7:9,i),Xf1,0);
        ob_r3_f3 = calobservation(gt(7:9,i),Xf3,0);
    end
    O01_X=func_H_O(Xr1,phir1,Xr0,phir0);
    O12_X=func_H_O(Xr2,phir2,Xr1,phir1);

    Z0f1_X=func_H_Z(Xf1,Xr0,phir0);
    Z0f2_X=func_H_Z(Xf2,Xr0,phir0);
    Z1f1_X=func_H_Z(Xf1,Xr1,phir1);
    Z1f2_X=func_H_Z(Xf2,Xr1,phir1);
    Z1f3_X=func_H_Z(Xf3,Xr1,phir1);
    Z2f2_X=func_H_Z(Xf2,Xr2,phir2);
    Z2f3_X=func_H_Z(Xf3,Xr2,phir2);

    eO=[(O01-O01_X);(O12-O12_X)];
    eZ=[(Z0f1-Z0f1_X);
    (Z0f2-Z0f2_X);
    (Z1f1-Z1f1_X);
    (Z1f2-Z1f2_X);
    (Z1f3-Z1f3_X);
    (Z2f2-Z2f2_X);
    (Z2f3-Z2f3_X)];

    e = [eO;eZ];
%     e = eZ;
    J = slam_grad(X);
    X_new = inv(J'*J)*J'*(e+J*X);
    X = X_new
end





















