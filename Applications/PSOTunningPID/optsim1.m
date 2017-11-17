Kp = pid(1);
Ki = pid(2);
Kd = pid(3);
% yout = sim('optsim1',[0 50],simopt);
e=yout-1 ;  
% compute the error 
sys_overshoot=max(yout)-1; 
% compute the overshoot
alpha=10;beta=10;
F=e2*beta+sys_overshoot*alpha;
