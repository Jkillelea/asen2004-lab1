[F16_CLEAN, F16_LOADED, B787, F16_CLEAN_ERR, F16_LOADED_ERR, B787_ERR] = ...
	L1_readInput('./Data/Group Data Save Here');

for i = 1:size(F16_CLEAN.P_atm,1);
	[ F16_CLEAN.L(i,:), F16_CLEAN.D(i,:) ] = ...
	L1_calcLD(F16_CLEAN.AOA(i), F16_CLEAN.N_force(i), F16_CLEAN.A_force(i));
end

for i = 1:size(F16_LOADED.P_atm,1);
	[ F16_LOADED.L(i,:), F16_LOADED.D(i,:) ] = ...
	L1_calcLD(F16_LOADED.AOA(i), F16_LOADED.N_force(i), F16_LOADED.A_force(i));
end

for i = 1:size(B787.P_atm,1);
	[ B787.L(i,:), B787.D(i,:) ] = ...
	L1_calcLD(B787.AOA(i), B787.N_force(i), B787.A_force(i));
end

plot(F16_CLEAN.AOA,F16_CLEAN.L,'.','MarkerSize',12)
xlabel('Angle of Attack, \alpha [^\circ degrees]')
ylabel('Lift [N]')
title('F16 Clean Configuration')