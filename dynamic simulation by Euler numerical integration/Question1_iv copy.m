
dt = 0.01; % change in time 
t = 0:dt:10.0; % time vector
g = 9.81; % gravitational acceleration

% solve for Model A
va = zeros(1, length(t)); % velocity vector 
sa = zeros(1, length(t)); % displacement vector
 
va(1) = 25.7; % initial velocity 
sa(1) = 0; % initial displacement 

for k=1:length(t)
    u=0.7;
    a=-u*g;
    va(k+1)=va(k)+a*dt;
    sa(k+1)=sa(k)+va(k)*dt; 
    u_1(1,k)=u; % Coefficient of friction vector
    
    % break out the loop when the velocity is negative
    if v(k)<0.0
        break;
    end
    
end

% Solve for Model B
vb = zeros(1, length(t)); % velocity vector 
sb = zeros(1, length(t)); % displacement vector

sb(1) = 0; % initial displacement 
vb(1) = 23; % initial velocity

for h=1:length(t)
    
    % stage 1: on the asphalt 
    if sb(h)>=0 && sb(h)<14
       u=0.7;
       a=-u*g;
            
       vb(h+1)=vb(h)+a*dt;
       sb(h+1)=sb(h)+vb(h)*dt;
       u_2(1,h)=u; % Coefficient of friction vector 
       
       % break out the loop when the velocity is negative
       if v(h)<0.0
           break;
       end
    
    % stage 2: on the ice
    elseif sb(h)>=14 && sb(h)<31
       u=0.12+0.07*exp(0.06*vb(h));
       a=-u*g;
            
       vb(h+1)=vb(h)+a*dt;
       sb(h+1)=sb(h)+vb(h)*dt;
       u_2(1,h)=u; % Coefficient of friction vector
       
       % break out the loop when the velocity is negative
       if v(h)<0.0
           break;
       end
    
    % stage 3: on the asphalt
    elseif sb(h)>=31 
       u=0.7;
       a=-u*g;
            
       vb(h+1)=vb(h)+a*dt;
       sb(h+1)=sb(h)+vb(h)*dt;
       u_2(1,h)=u; % Coefficient of friction vector
       
       % break out the loop when the velocity is negative
       if v(h)<0.0
           break;
       end
       
    end 
end

% cancel zero value in the displacement vector 
sa_no0=sa(sa~=0);
sb_no0=sb(sb~=0);

% plotting 
figure 

% Plot 1 for Model A and B
% Velocity vs. Time 
subplot(3,1,1); 
plot(t,va,'r',t,vb,'b');
axis([0 4 0 30]);
title('Velocity vs. Time');
ylabel('Velocity (m/s)');
xlabel('Time (s)');
legend('Model A','Model B');
grid on;

% Plot 2 for Model A and B
% Displacement vs. Time
subplot(3,1,2); 
plot(t,sa,'r',t,sb,'b');
axis([0 4 0 50]);
title('Displacement vs. Time');
ylabel('Displacement (m)');
xlabel('Time (s)');
legend('Model A','Model B');
grid on;

% Plot 3 for Model A and B
% Friction coefficient vs.Displacement
subplot(3,1,3); 
plot(sa_no0,u_1,'r',sb_no0,u_2,'b');
axis([0 50 0 1]);
title('Friction coefficient vs.Displacement');
ylabel('Friction coefficient');
xlabel('Displacement (m)');
legend('Model A','Model B');
grid on;