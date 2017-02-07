function [ CL, CD ] = L1_calcLD( AOA, N_force, A_force, q, S )
  D = N_force.*sind(AOA) + A_force.*cosd(AOA);
  L = N_force.*cosd(AOA) - A_force.*sind(AOA);

  CD = D/(q*S);
  CL = L/(q*S);
end
