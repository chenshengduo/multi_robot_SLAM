function o = calobservation(x,f,noise)
% range and bearing related to x
% f is [x;y] and x is [x;y;theta]
d = f-x(1:2);
o = [sqrt(d'*d)+ normrnd(0,noise,1);...
    wrap2pi(atan2(d(2),d(1))-x(3))+ normrnd(0,noise,1)];