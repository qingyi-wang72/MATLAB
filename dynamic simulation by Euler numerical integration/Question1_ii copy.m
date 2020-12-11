
% set up function with two inputs
% which are the initial velocity and the model
function [t,s,v,u]= Question1_ii(v0,Model)

dt = 0.01; % change in time 
t = 0:dt:10.0; % time vector

v = zeros(1, length(t)); % velocity vector 
s = zeros(1, length(t)); % displacement vector

s(1) = 0; % initial displacement 
g = 9.81; % gravitational acceleration

% Model A represents 0
if Model==0
    u=0.7; % coefficient of friction on the asphalt
    v(1)=v0; % store the v0 into the velocity vector
    
    % solve velocity and position vs. time 
    % using Euler's method 
    for k=1:length(t)
        a=-u*g; % decceleration of the car
        
        v(k+1)=v(k)+a*dt; % v at current step
        s(k+1)=s(k)+v(k)*dt; % s at current step
        
        % output arrays for each stimulation timestep
        if v(k)<0.0
            break;
        else 
            fprintf('t:%0.2f, s:%.2f, v:%.2f, u:%.2f\n',t(k),s(k),v(k),u);
        end  
    end 
    
% Model B represents 1
elseif Model==1
    v(1)=v0; % store the v0 into the velocity vector
    
    % solve velocity and position vs. time 
    % using Euler's method
    for k=1:length(t)
      
        % stage 1: on the asphalt 
        if s(k)>=0 && s(k)<14
            u=0.7; % coefficient of friction on the asphalt
            a=-u*g;
            
            v(k+1)=v(k)+a*dt; % v at current step
            s(k+1)=s(k)+v(k)*dt; % s at current step
            
            % break out the loop when the velocity is negative
            if v(k)<0.0
                break;
            % output arrays for each stimulation timestep
            else 
                fprintf('t:%0.2f, s:%.2f, v:%.2f, u:%.2f\n',t(k),s(k),v(k),u);
            end
            
        % stage 2: on the ice  
        elseif s(k)>=14 && s(k)<31
            u=0.12+0.07*exp(0.06*v(k)); % coefficient of friction on the ice
            a=-u*g;
            
            v(k+1)=v(k)+a*dt; % v at current step
            s(k+1)=s(k)+v(k)*dt; % s at current step
            
            % break out the loop when the velocity is negative
            if v(k)<0.0
                break;
            % output arrays for each stimulation timestep
            else 
                fprintf('t:%0.2f, s:%.2f, v:%.2f, u:%.2f\n',t(k),s(k),v(k),u);
            end
            
        % stage 3: on the asphalt   
        elseif s(k)>=31 
            u=0.7; % coefficient of friction on the asphalt
            a=-u*g;
            
            v(k+1)=v(k)+a*dt; % v at current step
            s(k+1)=s(k)+v(k)*dt; % s at current step
            
            % break out the loop when the velocity is negative
            if v(k)<0.0
                break;
            % output arrays for each stimulation timestep
            else 
                fprintf('t:%0.2f, s:%.2f, v:%.2f, u:%.2f\n',t(k),s(k),v(k),u);
            end
        end
    end 
end 
end 