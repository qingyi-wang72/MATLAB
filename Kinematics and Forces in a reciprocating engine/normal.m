L1 = 0.1; % connecting rod 
r1 = 0.0435; % crankshaft diameter
omega_OB = 8000*(2*pi)/60; % rotational speed of crank OB
%theta = 0:1.0:720; % angle vector 
theta = 40;

for i = 1:length(theta)
    
    A = [0 0 -omega_OB];
    B = [-r1*cosd(theta(i)) r1*sind(theta(i)) 0];
    Velocity_B = cross(A,B); % velocity B in vector form
    
    % linear velocity at Pin B
    vB = [(Velocity_B(1))^(2)+(Velocity_B(2))^(2)]^(1/2);
    Vector_vB(1,i) = vB;
    
    alpha = asind(sind(theta(i))*r1/L1); % aplpha in degree
    
    % rotational speed of connecting rod AB
    omega_AB = (-omega_OB *r1*cosd(theta(i)))/(L1*cosd(alpha));
    Vector_omega_AB(1,i) = omega_AB;

    % linear velocity of piston A
    vA = omega_OB*r1*(sind(theta(i))+cosd(theta(i))*tand(alpha));
    Vector_vA(1,i) = vA;
   
    % linear acceleration at Pin B
    Acceleration_B = cross(A,Velocity_B);
    Vector_aB_i(1,i) = Acceleration_B(1);
    Vector_aB_j(1,i) = Acceleration_B(2);
    
    
    % angular acceleration of connecting rod AB
    alpha_AB = ((omega_OB^2*r1*sind(theta(i)))-(omega_AB^2*L1*sind(alpha)))/(L1*cosd(alpha));
    Vector_alpha_AB(1,i) = round(alpha_AB);

    % linear acceleration of piston A
    aA = ((omega_OB)^(2)*r1*cosd(theta(i)))-(alpha_AB*L1*sind(alpha))+((omega_AB)^(2)*L1*cosd(alpha));
    Vector_aA(1,i) = aA;

end 

disp(Vector_vA);
disp(Vector_omega_AB);
disp(Vector_aA);
disp(Vector_alpha_AB);

% plotting 
figure

% plot1: linear velocity of piston A
subplot(3,1,1);
plot(theta,Vector_vA);
axis([0 720 -50 50]);
title('Linear Velocity of Piston A');
xlabel('Crank angle (degree)');
ylabel('Velocity (m/s)');
grid on;

% plot2: linear acceleration of piston A
subplot(3,1,2);
plot(theta,Vector_aA,'r');
axis([0 720 -30000 50000]);
title('Linear Acceleration of Piston A');
xlabel('Crank angle (degree)');
ylabel('Acceleration (m/s^2)');
grid on;

% Plot: linear acceleration at Pin B (i/j-component)
subplot(3,1,3);
plot(theta,Vector_aB_i,'r',theta,Vector_aB_j,'b');
axis([0 720 -50000 50000]);
title('Linear Acceleration of Crank Pin B');
xlabel('Crank angle (degree)');
ylabel('Acceleration (m/s^2)');
grid on;
