function x_ = motionmodel(x,u,noise,dt)
%u = [v,w] x = [x;y;theta]
u = u + normrnd(0,noise,[2,1]);

dx = [-u(1)/u(2)*sin(x(3)) + u(1)/u(2)*sin(x(3)+u(2)*dt);
      u(1)/u(2)*cos(x(3)) - u(1)/u(2)*cos(x(3)+u(2)*dt);
      u(2)*dt];

x_ = x + dx;