function [ CM ] = L1_calcCM( M_pitch, N_force, A, q, S, c )
	% ASEN 2004 LAB 1 GROUP 34 SPRING 2017
  % PARAMS: M_pitch => type double, containing the measured pitching moments. [N*m]
	% N_force => type double, containing the measured normal forces [N]
	% A => type double, offset distance of aerodynamic center from center of sting gauge [m]
	% q => type double, measured dynamic pressure [Pa]
	% S => type double, wing area of model [m^2]
	% c => type double, chord length of the model [m]
  % RETURNS: CM => type double, the moment coefficient [unitless] 
	P_M_cg = M_pitch - N_force*A;
	CM = P_M_cg/(q*S*c);
end
