
dv0=0.1; % velocity increments
v0=20:dv0:30; % initial velocity range 

% stopping distance vectors for two models
s_model1 = zeros(1, length(v0)); 
s_model2 = zeros(1, length(v0)); 

% calculate stopping distance 
% which at the corresponding initial velocity 
for i=1:length(v0) 
    
    dt = 0.01; % change in time
    t = 0:dt:10.0; % time vector 

    v = zeros(1, length(t)); % velocity vector 
    s = zeros(1, length(t)); % displacement vector

    g = 9.81; % gravitational acceleration
    s(1) = 0; % initial displacement 
    v(1) = v0(i); % inital velocity
    
    % Solve for Model A
    for k=1:length(t)
        u=0.7;
        a=-u*g;
        v(k+1)=v(k)+a*dt;
        s(k+1)=s(k)+v(k)*dt; 
        
        % store each outputs for each timestep into a matrix
        if v(k)<0.0
            break;
        elseif v(k)>0.0
            matrix(length(v(k)),:)=[t(k),s(k),v(k),u];
        end
    end
    
    % Find the biggest distance for each timestep
    % then, store into stopping distance vectors for Model 1
    sd=max(matrix,[],2);
    s_model1(1,i)=sd;
    
    % Solve for Model B
    for h=1:length(t)
        
        % stage 1: on the asphalt 
        if s(h)>=0 && s(h)<14
            u=0.7;
            a=-u*g;
            v(h+1)=v(h)+a*dt;
            s(h+1)=s(h)+v(h)*dt;
            
            % store each outputs for each timestep into a matrix
            if v(h)<0.0
                break;
            elseif v(h)>0.0 
                matrix(length(v(h)),:)=[t(h),s(h),v(h),u];
            end
        
        % stage 2: on the ice
        elseif s(h)>=14 && s(h)<31
            u=0.12+0.07*exp(0.06*v(h));
            a=-u*g;
            
            v(h+1)=v(h)+a*dt;
            s(h+1)=s(h)+v(h)*dt;
            
            % store each outputs for each timestep into a matrix
            if v(h)<0.0
                break;
            elseif v(h)>0.0
                matrix(length(v(h)),:)=[t(h),s(h),v(h),u];
            end
        
        % stage 3: on the asphalt
        elseif s(h)>=31 
            u=0.7;
            a=-u*g;
            
            v(h+1)=v(h)+a*dt;
            s(h+1)=s(h)+v(h)*dt;
            
            % store each outputs for each timestep into a matrix
            if v(h)<0.0
                break;
            elseif v(h)>0.0
                matrix(length(v(h)),:)=[t(h),s(h),v(h),u];
            end
        end 
        
        % Find the biggest distance for each timestep
        % then, store into stopping distance vectors for Model 1
        sd=max(matrix,[],2);
        s_model2(1,i)=sd;
    end  
end 

% plotting 
figure 

% Plot 1 for Model A
% Initial velocity vs. Stopping distance
subplot(2,1,1); 
plot(s_model1,v0,'r.','markersize',1);
axis([25 70 15 35]);
title('Initial velocity vs. Stopping distance');
ylabel('Initial velocity (m/s)');
xlabel('Stopping distance (m)');
legend('Model A');
grid on;

% Plot 2 for Model B
% Initial velocity vs. Stopping distance
subplot(2,1,2); 
plot(s_model2,v0,'b.','markersize',1);
axis([35 75 15 35]);
title('Initial velocity vs. Stopping distance (Model B)');
ylabel('Initial velocity (m/s)');
xlabel('Stopping distance (m)');
legend('Model B');
grid on;
