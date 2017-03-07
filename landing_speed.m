function [full_landing_speed, scale_landing_speed] = landing_speed(airplane)
  % JUST ASSUME MAX LIFT = WEIGHT ACCORDING TO TA
  % rho = 1.225; % [kg / m^3] - sea level
  rho = 1;     % [kg / m^3] - at boulder's altitude

  sorted_cl = sort(airplane.CL);
  CL_max    = mean(sorted_cl(end-10:end)); % last 10 points


  if strcmp(airplane.name, 'F16 Clean Configuration')
    % weight = 30,000; % [lb]
    full_weight    = 13607.787 * 9.81; % [N] - the values from class
    full_wing_area = 27.8709; % [m^2]

    scale_weight = 219.3 * (10^-3); % [kg]
    scale_wing_area = wingarea('f16'); % [m^2]

    margin = 1.2; % miliary

  elseif strcmp(airplane.name, 'F16 Loaded Configuration')
    full_weight    = 13607.787 * 9.81 * (252.7/219.3); % [N] scaled by ratio of weights of the two models
    full_wing_area = 27.8709; % [m^2]

    scale_weight = 252.7 * (10^-3); % [kg]
    scale_wing_area = wingarea('f16'); % [m^2]

    margin = 1.2; % miliary

  elseif strcmp(airplane.name, 'Boeing 787 Clean Configuration')
    % weight = 360,000; % [lb]
    full_weight    = 163293.447 * 9.81; %[N]
    full_wing_area = 360.5; % [m^2]

    scale_weight =  93.9 * (10^-3); % [kg]
    scale_wing_area = wingarea('b787'); % [m^2]

    margin = 1.3; % civil

  else
    error('Unknown plane name %s', airplane.name);
  end

  full_landing_speed = margin * sqrt(full_weight ... % margin * stall_speed
                           / ...
                    (0.5 * rho * full_wing_area * CL_max));

  scale_landing_speed = margin * sqrt(scale_weight ... % margin * stall_speed
                           / ...
                    (0.5 * rho * scale_wing_area * CL_max));
end
