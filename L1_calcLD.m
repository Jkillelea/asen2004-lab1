function [ CL, CD ] = L1_calcLD( AOA, N_force, A_force, q, S )
  % ASEN 2004 LAB 1 GROUP 34 SPRING 2017
  % PARAMS: AOA => type double, the angle of attack of the airplane [degrees]
  % N_force => type double, measured normal force on the airplane [N]
  % A_force => type double, measured axial force on the airplane [N]
  % q => type double, measured dynamic pressure [Pa]
  % S => type double, wing area of scale model [m^2]
  % RETURNS: CL => type double, lift coefficient of the model
  % CD => type double, drag coefficient of the model
  D = N_force.*sind(AOA) + A_force.*cosd(AOA);
  L = N_force.*cosd(AOA) - A_force.*sind(AOA);

  CD = D/(q*S);
  CL = L/(q*S);
end
