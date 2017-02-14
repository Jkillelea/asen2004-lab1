
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INITIALIZE GIVEN DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[F16_CLEAN, F16_LOADED, B787, F16_CLEAN_ERR, F16_LOADED_ERR, B787_ERR] = L1_readInput('./Data/Group Data Save Here');

[ F16_CLEAN.S, F16_CLEAN.b ]  	= wingarea('f16');
[ F16_LOADED.S, F16_LOADED.b ]	= wingarea('f16');
[ B787.S, B787.b ]       		= wingarea('b787');

F16_CLEAN.A  = 14.4*10^-3; % [m]
F16_LOADED.A = 15.5*10^-3; % [m]
B787.A  	 = 63.0*10^-3; % [m]

F16_CLEAN.lambda  	= (23.52/79.02)*10^-3; % [m]
F16_LOADED.lambda 	= (23.52/79.02)*10^-3; % [m]
B787.lambda  		= (0/53.18)*10^-3; % [m]

F16_CLEAN.c  = (2/3)*(79.02*10^-3)*((F16_CLEAN.lambda^2 + F16_CLEAN.lambda + 1)/(F16_CLEAN.lambda + 1)); % [m]
F16_LOADED.c = (2/3)*(79.02*10^-3)*((F16_LOADED.lambda^2 + F16_LOADED.lambda + 1)/(F16_LOADED.lambda + 1)); % [m]
B787.c  	 = (2/3)*(53.18*10^-3)*((B787.lambda^2 + B787.lambda + 1)/(B787.lambda + 1)); % [m]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CALCULATIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:size(F16_CLEAN.P_atm,1);

	% Lift and drag coefficients

	[ F16_CLEAN.CL(i,:), F16_CLEAN.CD(i,:) ] = L1_calcLD(	F16_CLEAN.AOA(i), ...
															F16_CLEAN.N_force(i), ...
															F16_CLEAN.A_force(i), ...
															F16_CLEAN.q_pitot(i), ...
															F16_CLEAN.S);

	% Moment coefficient

	[ F16_CLEAN.CM(i,:) ] = L1_calcCM(	F16_CLEAN.M_pitch(i), ...
										F16_CLEAN.N_force(i), ...
										F16_CLEAN.A, ...
										F16_CLEAN.q_pitot(i), ...
										F16_CLEAN.S, ...
										F16_CLEAN.c);

end

for i = 1:size(F16_LOADED.P_atm,1);

	% Lift and drag coefficients

	[ F16_LOADED.CL(i,:), F16_LOADED.CD(i,:) ] = L1_calcLD(	F16_LOADED.AOA(i), ...
															F16_LOADED.N_force(i), ...
															F16_LOADED.A_force(i), ...
															F16_LOADED.q_pitot(i), ...
															F16_LOADED.S);

	% Moment coefficient

	[ F16_LOADED.CM(i,:) ] = L1_calcCM(	F16_LOADED.M_pitch(i), ...
										F16_LOADED.N_force(i), ...
										F16_LOADED.A, ...
										F16_LOADED.q_pitot(i), ...
										F16_LOADED.S, ...
										F16_LOADED.c);


end

for i = 1:size(B787.P_atm,1);

	% Lift and drag coefficients

	[ B787.CL(i,:), B787.CD(i,:) ] = L1_calcLD(	B787.AOA(i), ...
												B787.N_force(i), ...
												B787.A_force(i), ...
												B787.q_pitot(i), ...
												B787.S);

	% Moment coefficient

	[ B787.CM(i,:) ] = L1_calcCM(	B787.M_pitch(i), ...
									B787.N_force(i), ...
									B787.A, ...
									B787.q_pitot(i), ...
									B787.S, ...
									B787.c);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RE-FORMATTING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

airplanes = [{F16_CLEAN}, {F16_LOADED}, {B787}];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLOTTING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:length(airplanes)
  airplane = airplanes{i};

	if sum(size(airplane.P_atm)) > 0
		figure; % plot CL
		plot(airplane.AOA, airplane.CL, '.', 'MarkerSize', 12)
		xlabel('Angle of Attack, \alpha [^\circ degrees]')
		ylabel('Lift Coefficient')
		title(airplane.name)

		figure; % plot CD
		plot(airplane.AOA, airplane.CD, '.', 'MarkerSize', 12)
		xlabel('Angle of Attack, \alpha [^\circ degrees]')
		ylabel('Drag Coefficient')
		title(airplane.name)

		figure; % plot CM
		plot(airplane.AOA, airplane.CM, '.', 'MarkerSize', 12)
		xlabel('Angle of Attack, \alpha [^\circ degrees]')
		ylabel('Moment Coefficient')
		title(airplane.name)

		figure; % plot Drag Polar
		plot(airplane.CL, airplane.CD, '.', 'MarkerSize', 12)
		xlabel('Lift Coefficient')
		ylabel('Drag Coefficient')
		title(airplane.name)
	end
end

