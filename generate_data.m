%% SLAM in 2D

%% generate the data
Xr1_0=[2;3;0.2];
Ur1 = [1;pi/6];

Xr2_0=[4;1;0.5];
Ur2 = [2;pi/6];

Xr3_0=[1;5;0.3];
Ur3 = [3;pi/6];

Xf1=[2;2];
Xf2=[3;4];
Xf3=[4;3];

gt = zeros(9,4);
gt(:,1) = [Xr1_0;Xr2_0;Xr3_0];
observation = zeros(21,4);

for i = 1:3
    r1_ = motionmodel(gt(1:3,i),Ur1,0,1);%  x_pre,u,variance,dt
    r2_ = motionmodel(gt(4:6,i),Ur2,0,1);
    r3_ = motionmodel(gt(7:9,i),Ur3,0,1);
    
    ob_r1_f1 = calobservation(gt(1:3,i),Xf1,0); %   x,feature,variance
    ob_r1_f2 = calobservation(gt(1:3,i),Xf2,0);
    ob_r1_f3 = calobservation(gt(1:3,i),Xf3,0);
    
    ob_r2_f2 = calobservation(gt(4:6,i),Xf2,0);
    ob_r2_f3 = calobservation(gt(4:6,i),Xf3,0);
    
    ob_r3_f1 = calobservation(gt(7:9,i),Xf1,0);
    ob_r3_f3 = calobservation(gt(7:9,i),Xf3,0);
    
    gt(:,i+1) = [r1_;r2_;r3_]; %pose data
    observation(:,i+1) = [ob_r1_f1;1;ob_r1_f2;2;ob_r1_f3;3;ob_r2_f2;2;ob_r2_f3;3;ob_r3_f1;1;ob_r3_f3;3];
end
feature = [Xf1,Xf2,Xf3];
save multi_SLAM_pose gt feature 
save multi_SLAM_obse observation


% O01=func_H_O(Xr1,phir1,Xr0,phir0)
% O12=func_H_O(Xr2,phir2,Xr1,phir1)
% 
% Z0f1=func_H_Z(Xf1,Xr0,phir0)
% Z0f2=func_H_Z(Xf2,Xr0,phir0)
% Z1f1=func_H_Z(Xf1,Xr1,phir1)
% Z1f2=func_H_Z(Xf2,Xr1,phir1)
% Z1f3=func_H_Z(Xf3,Xr1,phir1)
% Z2f2=func_H_Z(Xf2,Xr2,phir2)
% Z2f3=func_H_Z(Xf3,Xr2,phir2)
% 
% save SLAM_2D_data O01 O12 Z0f1 Z0f2 Z1f1 Z1f2 Z1f3 Z2f2 Z2f3
