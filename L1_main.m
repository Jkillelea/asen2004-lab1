clear all; close all; clc;
format shortG

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INITIALIZE GIVEN DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[F16_CLEAN, F16_LOADED, B787, F16_CLEAN_ERR, F16_LOADED_ERR, B787_ERR] = L1_readInput('./data');

F16_CLEAN.S  = wingarea('f16');
F16_LOADED.S = wingarea('f16');
B787.S       = wingarea('b787');

F16_CLEAN.c  = 1; % [m]
F16_LOADED.c = 1; % [m]
B787.c  	   = 1; % [m]

F16_CLEAN.A  = 14.4*10^-3; % [m]
F16_LOADED.A = 15.5*10^-3; % [m]
B787.A  	   = 63.0*10^-3; % [m]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RE-FORMATTING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

airplanes = [{F16_CLEAN}, {F16_LOADED}, {B787}];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CALCULATIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:length(airplanes) % iterate over list of airplanes
  airplane = airplanes{i};

	for j = 1:size(airplane.P_atm, 1) % calculate CL, CD, and CM
    [airplane.CL(j, :), airplane.CD(j, :)] = L1_calcLD(airplane.AOA(j), ...
                                                       airplane.N_force(j), ...
                                                       airplane.A_force(j), ...
                                                       airplane.q_pitot(j), ...
                                                       airplane.S);
    [ airplane.CM(j, :) ] = L1_calcCM(airplane.M_pitch(j), ...
                                      airplane.N_force(j), ...
                                      airplane.A, ...
                                      airplane.q_pitot(j), ...
                                      airplane.S, ...
                                      airplane.c);
	end
	airplanes{i} = airplane; % reassign the values back into the list so they make it out of the loop.
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLOTTING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:length(airplanes)
  airplane = airplanes{i};
	select   = airplane.V_air > 10;

	if sum(size(airplane.P_atm)) > 0
		figure; hold on; % plot CL
		plot(airplane.AOA(select), airplane.CL(select), '.', 'MarkerSize', 12)
		xlabel('Angle of Attack, \alpha [^\circ degrees]')
		ylabel('Lift Coefficient')
		title([airplane.name ' CL vs \alpha'])

    print(['./graphs/' airplane.name ' CL vs alpha'],'-djpeg','-noui') % relatives paths are okay since data is on a relative path. Otherwise the data reading failes and nothing is saved

		figure; hold on; % plot CD
		plot(airplane.AOA(select), airplane.CD(select), '.', 'MarkerSize', 12)
		xlabel('Angle of Attack, \alpha [^\circ degrees]')
		ylabel('Drag Coefficient')
		title([airplane.name ' CD vs \alpha'])

    print(['./graphs/' airplane.name ' CD vs alpha'],'-djpeg','-noui')

		figure; hold on; % plot CD
		plot(airplane.CL(select), airplane.CD(select), '.', 'MarkerSize', 12)
    xlabel('Lift Coefficient');
    ylabel('Drag Coefficient')
		title([airplane.name ' Drag Polar'])

    print(['./graphs/' airplane.name ' Drag Polar'],'-djpeg','-noui')

		figure; hold on; % plot CM
		plot(airplane.AOA(select), airplane.CM(select), '.', 'MarkerSize', 12)
		xlabel('Angle of Attack, \alpha [^\circ degrees]')
		ylabel('Moment Coefficient')
		title([airplane.name ' CM vs \alpha'])

    print(['./graphs/' airplane.name ' CM vs alpha'],'-djpeg','-noui')

  else
    disp(['skipping ' airplane.name]);
	end
end
