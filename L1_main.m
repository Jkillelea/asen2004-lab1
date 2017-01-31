[f16_clean, f16_loaded, b787, f16_clean_err, f16_loaded_err, b787_err] = L1_readInput('./data');

for i = 1:size(f16_clean.P_atm,1);
	[ f16_clean.L(i,:), f16_clean.D(i,:) ] = L1_calcLD(f16_clean.AOA(i), f16_clean.N_force(i), f16_clean.A_force(i));
end

for i = 1:size(f16_loaded.P_atm,1);
	[ f16_loaded.L(i,:), f16_loaded.D(i,:) ] = L1_calcLD(f16_loaded.AOA(i), f16_loaded.N_force(i), f16_loaded.A_force(i));
end

for i = 1:size(b787.P_atm,1);
	[ b787.L(i,:), b787.D(i,:) ] = L1_calcLD(b787.AOA(i), b787.N_force(i), b787.A_force(i));
end

airplane = f16_clean;
select = airplane.V_air >= 10; % select by airspeed
data = sortrows([airplane.AOA(select), airplane.L(select)]); % sorts by 1st col, ascending order

plot(data(:, 1), data(:, 2), '.', 'MarkerSize',12);
xlabel('Angle of Attack, \alpha [^\circ degrees]');
ylabel('Lift [N]');
title('F16 Clean Configuration');
