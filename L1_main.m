[F16_CLEAN, F16_LOADED, B787, F16_CLEAN_ERR, F16_LOADED_ERR, B787_ERR] = L1_readInput('./Data/Group Data Save Here');

F16_CLEAN.S 	 = wingarea('f16');
F16_LOADED.S 	= wingarea('f16');
B787.S 			    = wingarea('b787');

for i = 1:size(F16_CLEAN.P_atm,1);
	[ F16_CLEAN.CL(i,:), F16_CLEAN.CD(i,:) ] = ...
	L1_calcLD(F16_CLEAN.AOA(i), F16_CLEAN.N_force(i), F16_CLEAN.A_force(i), F16_CLEAN.q_pitot(i), F16_CLEAN.S);
end

for i = 1:size(F16_LOADED.P_atm,1);
	[ F16_LOADED.CL(i,:), F16_LOADED.CD(i,:) ] = ...
	L1_calcLD(F16_LOADED.AOA(i), F16_LOADED.N_force(i), F16_LOADED.A_force(i), F16_LOADED.q_pitot(i), F16_LOADED.S);
end

for i = 1:size(B787.P_atm,1);
	[ B787.CL(i,:), B787.CD(i,:) ] = ...
	L1_calcLD(B787.AOA(i), B787.N_force(i), B787.A_force(i), B787.q_pitot(i), B787.S);
end

F16_CLEAN.I  = F16_CLEAN.V_air 	> 15;
F16_LOADED.I = F16_LOADED.V_air > 15;
B787.I  	 = B787.V_air		> 15;

% Lift Plotting

plot(F16_CLEAN.AOA(F16_CLEAN.I),F16_CLEAN.CL(F16_CLEAN.I),'.','MarkerSize',12)
xlabel('Angle of Attack, \alpha [^\circ degrees]')
ylabel('Lift Coefficient')
title('F16 Clean Configuration')

plot(F16_LOADED.AOA(F16_LOADED.I),F16_LOADED.CL(F16_LOADED.I),'.','MarkerSize',12)
xlabel('Angle of Attack, \alpha [^\circ degrees]')
ylabel('Lift Coefficient')
title('F16 Loaded Configuration')

plot(B787.AOA(B787.I),B787.CL(B787.I),'.','MarkerSize',12)
xlabel('Angle of Attack, \alpha [^\circ degrees]')
ylabel('Lift Coefficient')
title('Boeing 787 Clean Configuration')

% Drag Plotting

plot(F16_CLEAN.AOA(F16_CLEAN.I),F16_CLEAN.DL(F16_CLEAN.I),'.','MarkerSize',12)
xlabel('Angle of Attack, \alpha [^\circ degrees]')
ylabel('Drag Coefficient')
title('F16 Clean Configuration')

plot(F16_LOADED.AOA(F16_LOADED.I),F16_LOADED.DL(F16_LOADED.I),'.','MarkerSize',12)
xlabel('Angle of Attack, \alpha [^\circ degrees]')
ylabel('Drag Coefficient')
title('F16 Loaded Configuration')

plot(B787.AOA(B787.I),B787.DL(B787.I),'.','MarkerSize',12)
xlabel('Angle of Attack, \alpha [^\circ degrees]')
ylabel('Drag Coefficient')
title('Boeing 787 Clean Configuration')
