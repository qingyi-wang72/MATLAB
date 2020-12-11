function dydt = springdamper(t,y)

% parameters for the system 
m1 = 22.5; 
k1 = 2000;

m2 = 18.5;
k2 = 3000;
b2 = 500;

% split up state vector y
x1 = y(1);
v1 = y(2);
x2 = y(3);
v2 = y(4);

% step input 
if (t>=0 && t<=10)
    xg = 0.005*sin(4*(2*pi)*t);
else 
    xg = 0;
end 

% equation of motion 
dydt_x1dot = v1;
dydt_v1dot = -((k1+k2)/m1)*x1 + (k2/m1)*x2 - (b2/m1)*v1 + (b2/m1)*v2 + (k1/m1)*xg;

dydt_x2dot = v2;
dydt_v2dot = (k2/m2)*x1 - (k2/m2)*x2 +(b2/m2)*v1 - (b2/m2)*v2 ;

dydt = [dydt_x1dot; dydt_v1dot; dydt_x2dot; dydt_v2dot];
dydt = dydt(:);
end