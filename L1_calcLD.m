function [ Lift, Drag ] = L1_calcLD( AOA, N_force, A_force )
  Drag = N_force.*sind(AOA) + A_force.*cosd(AOA);
  Lift = N_force.*cosd(AOA) - A_force.*sind(AOA);
end
