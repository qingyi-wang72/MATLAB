L1 = 0.1; % connecting rod 
L2 = 0.2;
L3 = 0.5;
r1 = 0.0435; % crankshaft diameter
omega_OB = 8000*(2*pi)/60; % rotational speed of crank OB
theta = 0:1.0:720; % angle vector 

for i = 1:length(theta)
    
    A = [0 0 -omega_OB];
    B = [-r1*cosd(theta(i)) r1*sind(theta(i)) 0];
    Velocity_B = cross(A,B); % velocity B in vector form
    
    % linear velocity at Pin B
    vB = [(Velocity_B(1))^(2)+(Velocity_B(2))^(2)]^(1/2);
    Vector_vB(1,i) = vB;
    
    alpha = asind(sind(theta(i))*r1/L1); % aplpha in degree
    alpha2 = asind(sind(theta(i))*r1/L2);
    alpha3 = asind(sind(theta(i))*r1/L3);
    
    % rotational speed of connecting rod AB
    omega_AB = (-omega_OB *r1*cosd(theta(i)))/(L1*cosd(alpha));
    omega_AB2 = (-omega_OB *r1*cosd(theta(i)))/(L2*cosd(alpha2));
    omega_AB3 = (-omega_OB *r1*cosd(theta(i)))/(L3*cosd(alpha3));
    
    Vector_omega_AB(1,i) = omega_AB;
    Vector_omega_AB2(1,i) = omega_AB2;
    Vector_omega_AB3(1,i) = omega_AB3;

    % linear velocity of piston A
    vA = omega_OB*r1*(sind(theta(i))+cosd(theta(i))*tand(alpha));
    vA2 = omega_OB*r1*(sind(theta(i))+cosd(theta(i))*tand(alpha2));
    vA3 = omega_OB*r1*(sind(theta(i))+cosd(theta(i))*tand(alpha3));
    
    Vector_vA(1,i) = vA;
    Vector_vA2(1,i) = vA2;
    Vector_vA3(1,i) = vA3;
   
    % linear acceleration at Pin B
    Acceleration_B = cross(A,Velocity_B);
    Vector_aB_i(1,i) = Acceleration_B(1);
    Vector_aB_j(1,i) = Acceleration_B(2);
    
    % angular acceleration of connecting rod AB
    alpha_AB = ((omega_OB^2*r1*sind(theta(i)))-(omega_AB^2*L1*sind(alpha)))/(L1*cosd(alpha));
    alpha_AB2 = ((omega_OB^2*r1*sind(theta(i)))-(omega_AB2^2*L2*sind(alpha2)))/(L2*cosd(alpha2));
    alpha_AB3 = ((omega_OB^2*r1*sind(theta(i)))-(omega_AB3^2*L3*sind(alpha3)))/(L3*cosd(alpha3));
    
    Vector_alpha_AB(1,i) = round(alpha_AB);
    Vector_alpha_AB2(1,i) = round(alpha_AB2);
    Vector_alpha_AB3(1,i) = round(alpha_AB3);

    % linear acceleration of piston A
    aA = ((omega_OB)^(2)*r1*cosd(theta(i)))-(alpha_AB*L1*sind(alpha))+((omega_AB)^(2)*L1*cosd(alpha));
    aA2 = ((omega_OB)^(2)*r1*cosd(theta(i)))-(alpha_AB2*L2*sind(alpha2))+((omega_AB2)^(2)*L2*cosd(alpha2));
    aA3 = ((omega_OB)^(2)*r1*cosd(theta(i)))-(alpha_AB3*L3*sind(alpha3))+((omega_AB3)^(2)*L3*cosd(alpha3));
    
    Vector_aA(1,i) = aA;
    Vector_aA2(1,i) = aA2;
    Vector_aA3(1,i) = aA3;

end 

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
plot(theta,Vector_aA,'r',theta,Vector_aA2,'b',theta,Vector_aA3,'g');
axis([0 720 -30000 50000]);
title('Linear Acceleration of Piston A');
xlabel('Crank angle (degree)');
ylabel('Acceleration (m/s^2)');
legend('L = 0.1m','L = 0.2m','L = 0.5m');
grid on;

% Plot: linear acceleration at Pin B (i/j-component)
subplot(3,1,3);
plot(theta,Vector_aB_i,'r',theta,Vector_aB_j,'b');
axis([0 720 -50000 50000]);
title('Linear Acceleration of Crank Pin B');
xlabel('Crank angle (degree)');
ylabel('Acceleration (m/s^2)');
grid on;
