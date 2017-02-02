function [CL, CD] = calcCL_CD(airplane, type)
  area = wingarea(type);
  [lift, drag] = L1_calcLD(airplane.AOA, airplane.N_force, airplane.A_force);

  CL = lift ./ (airplane.q_pitot .* area);
  CD = drag ./ (airplane.q_pitot .* area);
end
