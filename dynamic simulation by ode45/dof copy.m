% timespan for simulation 
t_inital = 0;
t_final = 15;
tspan = [t_inital, t_final];

% inital state 
y0 = [0; 0; 0; 0];

% numerical integration 
[t, y] = ode45('springdamper', tspan, y0);

% compute displacement of the ground during the earthquake
tg = 0:0.01:10;
xg = zeros(1, length(tg));
for i = 1:length(tg)
    xg(i) = 0.005*sin(4*(2*pi)*tg(i));
end

% plotting 
figure 

subplot(2,1,1);
plot(t,y(:,1),t,y(:,3),tg,xg);
axis([0 15 -0.005 0.005]);
title('Vertical Displacement of Floor1 & Floor2 & Ground');
xlabel('Time (sec)');
ylabel('Displacement (s)');
legend('Floor 1','Floor 2','Ground');
grid on;

subplot(2,1,2);
plot(t,y(:,2),t,y(:,4));
axis([0 15 -0.02 0.02]);
title('Vertical Velocity of Floor1 & Floor2');
xlabel('Time (sec)');
ylabel('Velocity (m/s)');
legend('Floor 1','Floor 2');
grid on;