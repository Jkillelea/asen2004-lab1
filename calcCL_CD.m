function [CL, CD] = calcCL_CD(airplane, type)
  % ASEN 2004 LAB 1 GROUP 34 SPRING 2017
  % PARAMS: airplane => type struct, containing the data relevant data
  %         type => type string, either 'f16' or 'b787'. Other values will throw an error.
  % RETURNS: [CL, CD] => two column vectors of type double, with the values of CL and CD for each lift point
  area = wingarea(type);
  [lift, drag] = L1_calcLD(airplane.AOA, airplane.N_force, airplane.A_force, airplane.q_pitot, area);

  CL = lift ./ (airplane.q_pitot .* area);
  CD = drag ./ (airplane.q_pitot .* area);
end
