L1 = 0.1; % connecting rod 
r1 = 0.0435; % crankshaft diameter
omega_OB = 8000*(2*pi)/60; % rotational speed of crank OB
omega_OB2 = 11000*(2*pi)/60;
omega_OB3 = 5000*(2*pi)/60;
theta = 0:1.0:720; % angle vector 

for i = 1:length(theta)
    
    A = [0 0 -omega_OB];
    A2 = [0 0 -omega_OB2];
    A3 = [0 0 -omega_OB3];
    
    B = [-r1*cosd(theta(i)) r1*sind(theta(i)) 0];
    
    Velocity_B = cross(A,B); % velocity B in vector form
    Velocity_B2 = cross(A2,B);
    Velocity_B3 = cross(A3,B);
    
    % linear velocity at Pin B
    vB = [(Velocity_B(1))^(2)+(Velocity_B(2))^(2)]^(1/2);
    vB2 = [(Velocity_B2(1))^(2)+(Velocity_B2(2))^(2)]^(1/2);
    vB3 = [(Velocity_B3(1))^(2)+(Velocity_B3(2))^(2)]^(1/2);
    
    Vector_vB(1,i) = vB;
    Vector_vB2(1,i) = vB2;
    Vector_vB3(1,i) = vB3;
    
    alpha = asind(sind(theta(i))*r1/L1); % aplpha in degree
    
    % rotational speed of connecting rod AB
    omega_AB = (-omega_OB *r1*cosd(theta(i)))/(L1*cosd(alpha));
    omega_AB2 = (-omega_OB2 *r1*cosd(theta(i)))/(L1*cosd(alpha));
    omega_AB3 = (-omega_OB3 *r1*cosd(theta(i)))/(L1*cosd(alpha));
    
    Vector_omega_AB(1,i) = omega_AB;
    Vector_omega_AB2(1,i) = omega_AB2;
    Vector_omega_AB3(1,i) = omega_AB3;

    % linear velocity of piston A
    vA = omega_OB*r1*(sind(theta(i))+cosd(theta(i))*tand(alpha));
    vA2 = omega_OB2*r1*(sind(theta(i))+cosd(theta(i))*tand(alpha));
    vA3 = omega_OB3*r1*(sind(theta(i))+cosd(theta(i))*tand(alpha));
    
    Vector_vA(1,i) = vA;
    Vector_vA2(1,i) = vA2;
    Vector_vA3(1,i) = vA3;
   
    % linear acceleration at Pin B
    Acceleration_B = cross(A,Velocity_B);
    Acceleration_B2 = cross(A2,Velocity_B);
    Acceleration_B3 = cross(A3,Velocity_B);
    
    Vector_aB_i(1,i) = Acceleration_B(1);
    Vector_aB_j(1,i) = Acceleration_B(2);
    
    Vector_aB_i2(1,i) = Acceleration_B2(1);
    Vector_aB_j2(1,i) = Acceleration_B2(2);
    
    Vector_aB_i3(1,i) = Acceleration_B3(1);
    Vector_aB_j3(1,i) = Acceleration_B3(2);
    
    % angular acceleration of connecting rod AB
    alpha_AB = ((omega_OB^2*r1*sind(theta(i)))-(omega_AB^2*L1*sind(alpha)))/(L1*cosd(alpha));
    alpha_AB2 = ((omega_OB2^2*r1*sind(theta(i)))-(omega_AB2^2*L1*sind(alpha)))/(L1*cosd(alpha));
    alpha_AB3 = ((omega_OB3^2*r1*sind(theta(i)))-(omega_AB3^2*L1*sind(alpha)))/(L1*cosd(alpha));
    
    Vector_alpha_AB(1,i) = round(alpha_AB);
    Vector_alpha_AB2(1,i) = round(alpha_AB2);
    Vector_alpha_AB3(1,i) = round(alpha_AB3);

    % linear acceleration of piston A
    aA = ((omega_OB)^(2)*r1*cosd(theta(i)))-(alpha_AB*L1*sind(alpha))+((omega_AB)^(2)*L1*cosd(alpha));
    aA2 = ((omega_OB2)^(2)*r1*cosd(theta(i)))-(alpha_AB2*L1*sind(alpha))+((omega_AB2)^(2)*L1*cosd(alpha));
    aA3 = ((omega_OB3)^(2)*r1*cosd(theta(i)))-(alpha_AB3*L1*sind(alpha))+((omega_AB3)^(2)*L1*cosd(alpha));
    
    Vector_aA(1,i) = aA;
    Vector_aA2(1,i) = aA2;
    Vector_aA3(1,i) = aA3;

end 

% plotting 
figure

% plot1: linear velocity of piston A
subplot(3,1,1);
TF = islocalmin(Vector_vA);
TA = islocalmax(Vector_vA);
plot(theta,Vector_vA,'r',theta,Vector_vA2,'b',theta,Vector_vA3,'g',theta(TF),Vector_vA(TF),'ko',theta(TA),Vector_vA(TA),'ko');
axis([0 720 -60 60]);
title('Linear Velocity of Piston A');
xlabel('Crank angle (degree)');
ylabel('Velocity (m/s)');
legend('8000 rpm','11000 rpm','5000 rpm');
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


