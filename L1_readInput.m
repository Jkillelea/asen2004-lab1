function [ F16_CLEAN, F16_LOADED, B787, F16_CLEAN_ERR, F16_LOADED_ERR, B787_ERR ] = L1_readInput( direc )

% find the names of all the files in the data directory that name structure
% for data

F16_CLEAN_temp = dir(strcat(direc,'/F16_CLEAN*'));

% save the number of files as a variable for ease of use
numFile = size(F16_CLEAN_temp,1);

% Read input for data files
for i = 1:numFile
    temp = csvread(strcat(direc,'/',F16_CLEAN_temp(i).name),1,0);
    F16_CLEAN_temp(i).group  =   str2double(F16_CLEAN_temp(i).name(12:13));
    for k = 1:30
        F16_CLEAN_temp(i).P_atm(k,:)   =   mean(temp(20*k-19:20*k,1));     % [Pa]
        F16_CLEAN_temp(i).T_atm(k,:)   =   mean(temp(20*k-19:20*k,2));     % [K]
        F16_CLEAN_temp(i).rho_atm(k,:) =   mean(temp(20*k-19:20*k,3));     % [kg/m^3]
        F16_CLEAN_temp(i).V_air(k,:)   =   mean(temp(20*k-19:20*k,4));     % [m/s]
        F16_CLEAN_temp(i).q_pitot(k,:) =   mean(temp(20*k-19:20*k,5));     % [Pa]
        F16_CLEAN_temp(i).AOA(k,:)     =   mean(temp(20*k-19:20*k,23));    % [degrees]
        F16_CLEAN_temp(i).N_force(k,:) =   mean(temp(20*k-19:20*k,24));    % [N]
        F16_CLEAN_temp(i).A_force(k,:) =   mean(temp(20*k-19:20*k,25));    % [N]
        F16_CLEAN_temp(i).M_pitch(k,:) =   mean(temp(20*k-19:20*k,26));    % [Nm]
        F16_CLEAN_temp(i).P_valve(k,:) =   mean(temp(20*k-19:20*k,7:22));  % [Pa]

        F16_CLEAN_temp(i).ERR_P_atm(k,:)   =   2*std(temp(20*k-19:20*k,1));     % [Pa]
        F16_CLEAN_temp(i).ERR_T_atm(k,:)   =   2*std(temp(20*k-19:20*k,2));     % [K]
        F16_CLEAN_temp(i).ERR_rho_atm(k,:) =   2*std(temp(20*k-19:20*k,3));     % [kg/m^3]
        F16_CLEAN_temp(i).ERR_V_air(k,:)   =   2*std(temp(20*k-19:20*k,4));     % [m/s]
        F16_CLEAN_temp(i).ERR_q_pitot(k,:) =   2*std(temp(20*k-19:20*k,5));     % [Pa]
        F16_CLEAN_temp(i).ERR_AOA(k,:)     =   2*std(temp(20*k-19:20*k,23));    % [degrees]
        F16_CLEAN_temp(i).ERR_N_force(k,:) =   2*std(temp(20*k-19:20*k,24));    % [N]
        F16_CLEAN_temp(i).ERR_A_force(k,:) =   2*std(temp(20*k-19:20*k,25));    % [N]
        F16_CLEAN_temp(i).ERR_M_pitch(k,:) =   2*std(temp(20*k-19:20*k,26));    % [Nm]
        F16_CLEAN_temp(i).ERR_P_valve(k,:) =   2*std(temp(20*k-19:20*k,7:22));  % [Pa]
    end
    %figure
    %plot(F16_CLEAN_temp(i).N_force)
    %title(F16_CLEAN_temp(i).group)
end

% create structure for F16_CLEAN Data
F16_CLEAN = struct('P_atm',[],'T_atm',[],'rho_atm',[],'V_air',[],'q_pitot',[],'AOA',[],'N_force',[],'A_force',[],'M_pitch',[],'P_valve',[]);

if numFile>0
    F16_CLEAN.P_atm      =   vertcat(F16_CLEAN_temp(:).P_atm);
    F16_CLEAN.T_atm      =   vertcat(F16_CLEAN_temp(:).T_atm);
    F16_CLEAN.rho_atm    =   vertcat(F16_CLEAN_temp(:).rho_atm);
    F16_CLEAN.V_air      =   vertcat(F16_CLEAN_temp(:).V_air);
    F16_CLEAN.q_pitot    =   vertcat(F16_CLEAN_temp(:).q_pitot);
    F16_CLEAN.AOA        =   vertcat(F16_CLEAN_temp(:).AOA);
    F16_CLEAN.N_force    =   vertcat(F16_CLEAN_temp(:).N_force);
    F16_CLEAN.A_force    =   vertcat(F16_CLEAN_temp(:).A_force);
    F16_CLEAN.M_pitch    =   vertcat(F16_CLEAN_temp(:).M_pitch);
    F16_CLEAN.P_valve    =   vertcat(F16_CLEAN_temp(:).P_valve);

    F16_CLEAN_ERR.P_atm      =   mean(vertcat(F16_CLEAN_temp(:).ERR_P_atm));
    F16_CLEAN_ERR.T_atm      =   mean(vertcat(F16_CLEAN_temp(:).ERR_T_atm));
    F16_CLEAN_ERR.rho_atm    =   mean(vertcat(F16_CLEAN_temp(:).ERR_rho_atm));
    F16_CLEAN_ERR.V_air      =   mean(vertcat(F16_CLEAN_temp(:).ERR_V_air));
    F16_CLEAN_ERR.q_pitot    =   mean(vertcat(F16_CLEAN_temp(:).ERR_q_pitot));
    F16_CLEAN_ERR.AOA        =   mean(vertcat(F16_CLEAN_temp(:).ERR_AOA));
    F16_CLEAN_ERR.N_force    =   mean(vertcat(F16_CLEAN_temp(:).ERR_N_force));
    F16_CLEAN_ERR.A_force    =   mean(vertcat(F16_CLEAN_temp(:).ERR_A_force));
    F16_CLEAN_ERR.M_pitch    =   mean(vertcat(F16_CLEAN_temp(:).ERR_M_pitch));
    F16_CLEAN_ERR.P_valve    =   mean(vertcat(F16_CLEAN_temp(:).ERR_P_valve));
else
    F16_CLEAN_ERR = 0;
end

% repeat input for loaded F16

F16_LOADED_temp = dir(strcat(direc,'/F16_LOADED*'));

% save the number of files as a variable for ease of use
numFile = size(F16_LOADED_temp,1);

% Read input for data files
for i = 1:numFile
    temp = csvread(strcat(direc,'/',F16_LOADED_temp(i).name),1,0);
    F16_LOADED_temp(i).group  =   str2double(F16_LOADED_temp(i).name(13:14));
    for k = 1:30
        F16_LOADED_temp(i).P_atm(k,:)   =   mean(temp(20*k-19:20*k,1));     % [Pa]
        F16_LOADED_temp(i).T_atm(k,:)   =   mean(temp(20*k-19:20*k,2));     % [K]
        F16_LOADED_temp(i).rho_atm(k,:) =   mean(temp(20*k-19:20*k,3));     % [kg/m^3]
        F16_LOADED_temp(i).V_air(k,:)   =   mean(temp(20*k-19:20*k,4));     % [m/s]
        F16_LOADED_temp(i).q_pitot(k,:) =   mean(temp(20*k-19:20*k,5));     % [Pa]
        F16_LOADED_temp(i).AOA(k,:)     =   mean(temp(20*k-19:20*k,23));    % [degrees]
        F16_LOADED_temp(i).N_force(k,:) =   mean(temp(20*k-19:20*k,24));    % [N]
        F16_LOADED_temp(i).A_force(k,:) =   mean(temp(20*k-19:20*k,25));    % [N]
        F16_LOADED_temp(i).M_pitch(k,:) =   mean(temp(20*k-19:20*k,26));    % [Nm]
        F16_LOADED_temp(i).P_valve(k,:) =   mean(temp(20*k-19:20*k,7:22));  % [Pa]

        F16_LOADED_temp(i).ERR_P_atm(k,:)   =   2*std(temp(20*k-19:20*k,1));     % [Pa]
        F16_LOADED_temp(i).ERR_T_atm(k,:)   =   2*std(temp(20*k-19:20*k,2));     % [K]
        F16_LOADED_temp(i).ERR_rho_atm(k,:) =   2*std(temp(20*k-19:20*k,3));     % [kg/m^3]
        F16_LOADED_temp(i).ERR_V_air(k,:)   =   2*std(temp(20*k-19:20*k,4));     % [m/s]
        F16_LOADED_temp(i).ERR_q_pitot(k,:) =   2*std(temp(20*k-19:20*k,5));     % [Pa]
        F16_LOADED_temp(i).ERR_AOA(k,:)     =   2*std(temp(20*k-19:20*k,23));    % [degrees]
        F16_LOADED_temp(i).ERR_N_force(k,:) =   2*std(temp(20*k-19:20*k,24));    % [N]
        F16_LOADED_temp(i).ERR_A_force(k,:) =   2*std(temp(20*k-19:20*k,25));    % [N]
        F16_LOADED_temp(i).ERR_M_pitch(k,:) =   2*std(temp(20*k-19:20*k,26));    % [Nm]
        F16_LOADED_temp(i).ERR_P_valve(k,:) =   2*std(temp(20*k-19:20*k,7:22));  % [Pa]
    end
end

% create structure for F16_LOADED Data
F16_LOADED = struct('P_atm',[],'T_atm',[],'rho_atm',[],'V_air',[],'q_pitot',[],'AOA',[],'N_force',[],'A_force',[],'M_pitch',[],'P_valve',[]);

if numFile>0
    F16_LOADED.P_atm      =   vertcat(F16_LOADED_temp(:).P_atm);
    F16_LOADED.T_atm      =   vertcat(F16_LOADED_temp(:).T_atm);
    F16_LOADED.rho_atm    =   vertcat(F16_LOADED_temp(:).rho_atm);
    F16_LOADED.V_air      =   vertcat(F16_LOADED_temp(:).V_air);
    F16_LOADED.q_pitot    =   vertcat(F16_LOADED_temp(:).q_pitot);
    F16_LOADED.AOA        =   vertcat(F16_LOADED_temp(:).AOA);
    F16_LOADED.N_force    =   vertcat(F16_LOADED_temp(:).N_force);
    F16_LOADED.A_force    =   vertcat(F16_LOADED_temp(:).A_force);
    F16_LOADED.M_pitch    =   vertcat(F16_LOADED_temp(:).M_pitch);
    F16_LOADED.P_valve    =   vertcat(F16_LOADED_temp(:).P_valve);

    F16_LOADED_ERR.P_atm      =   mean(vertcat(F16_LOADED_temp(:).ERR_P_atm));
    F16_LOADED_ERR.T_atm      =   mean(vertcat(F16_LOADED_temp(:).ERR_T_atm));
    F16_LOADED_ERR.rho_atm    =   mean(vertcat(F16_LOADED_temp(:).ERR_rho_atm));
    F16_LOADED_ERR.V_air      =   mean(vertcat(F16_LOADED_temp(:).ERR_V_air));
    F16_LOADED_ERR.q_pitot    =   mean(vertcat(F16_LOADED_temp(:).ERR_q_pitot));
    F16_LOADED_ERR.AOA        =   mean(vertcat(F16_LOADED_temp(:).ERR_AOA));
    F16_LOADED_ERR.N_force    =   mean(vertcat(F16_LOADED_temp(:).ERR_N_force));
    F16_LOADED_ERR.A_force    =   mean(vertcat(F16_LOADED_temp(:).ERR_A_force));
    F16_LOADED_ERR.M_pitch    =   mean(vertcat(F16_LOADED_temp(:).ERR_M_pitch));
    F16_LOADED_ERR.P_valve    =   mean(vertcat(F16_LOADED_temp(:).ERR_P_valve));
else
    F16_LOADED_ERR = 0;
end

% repeat input for 787

B787_temp = dir(strcat(direc,'/787*'));

% save the number of files as a variable for ease of use
numFile = size(B787_temp,1);

% Read input for data files
for i = 1:numFile
    temp = csvread(strcat(direc,'/',B787_temp(i).name),1,0);
    B787_temp(i).group  =   str2double(B787_temp(i).name(6:7));
    for k = 1:30
        B787_temp(i).P_atm(k,:)   =   mean(temp(20*k-19:20*k,1));     % [Pa]
        B787_temp(i).T_atm(k,:)   =   mean(temp(20*k-19:20*k,2));     % [K]
        B787_temp(i).rho_atm(k,:) =   mean(temp(20*k-19:20*k,3));     % [kg/m^3]
        B787_temp(i).V_air(k,:)   =   mean(temp(20*k-19:20*k,4));     % [m/s]
        B787_temp(i).q_pitot(k,:) =   mean(temp(20*k-19:20*k,5));     % [Pa]
        B787_temp(i).AOA(k,:)     =   mean(temp(20*k-19:20*k,23));    % [degrees]
        B787_temp(i).N_force(k,:) =   mean(temp(20*k-19:20*k,24));    % [N]
        B787_temp(i).A_force(k,:) =   mean(temp(20*k-19:20*k,25));    % [N]
        B787_temp(i).M_pitch(k,:) =   mean(temp(20*k-19:20*k,26));    % [Nm]
        B787_temp(i).P_valve(k,:) =   mean(temp(20*k-19:20*k,7:22));  % [Pa]

        B787_temp(i).ERR_P_atm(k,:)   =   2*std(temp(20*k-19:20*k,1));     % [Pa]
        B787_temp(i).ERR_T_atm(k,:)   =   2*std(temp(20*k-19:20*k,2));     % [K]
        B787_temp(i).ERR_rho_atm(k,:) =   2*std(temp(20*k-19:20*k,3));     % [kg/m^3]
        B787_temp(i).ERR_V_air(k,:)   =   2*std(temp(20*k-19:20*k,4));     % [m/s]
        B787_temp(i).ERR_q_pitot(k,:) =   2*std(temp(20*k-19:20*k,5));     % [Pa]
        B787_temp(i).ERR_AOA(k,:)     =   2*std(temp(20*k-19:20*k,23));    % [degrees]
        B787_temp(i).ERR_N_force(k,:) =   2*std(temp(20*k-19:20*k,24));    % [N]
        B787_temp(i).ERR_A_force(k,:) =   2*std(temp(20*k-19:20*k,25));    % [N]
        B787_temp(i).ERR_M_pitch(k,:) =   2*std(temp(20*k-19:20*k,26));    % [Nm]
        B787_temp(i).ERR_P_valve(k,:) =   2*std(temp(20*k-19:20*k,7:22));  % [Pa]
    end
end

% create structure for B787 Data
B787 = struct('P_atm',[],'T_atm',[],'rho_atm',[],'V_air',[],'q_pitot',[],'AOA',[],'N_force',[],'A_force',[],'M_pitch',[],'P_valve',[]);

if numFile>0
    B787.P_atm      =   vertcat(B787_temp(:).P_atm);
    B787.T_atm      =   vertcat(B787_temp(:).T_atm);
    B787.rho_atm    =   vertcat(B787_temp(:).rho_atm);
    B787.V_air      =   vertcat(B787_temp(:).V_air);
    B787.q_pitot    =   vertcat(B787_temp(:).q_pitot);
    B787.AOA        =   vertcat(B787_temp(:).AOA);
    B787.N_force    =   vertcat(B787_temp(:).N_force);
    B787.A_force    =   vertcat(B787_temp(:).A_force);
    B787.M_pitch    =   vertcat(B787_temp(:).M_pitch);
    B787.P_valve    =   vertcat(B787_temp(:).P_valve);

    B787_ERR.P_atm      =   mean(vertcat(B787_temp(:).ERR_P_atm));
    B787_ERR.T_atm      =   mean(vertcat(B787_temp(:).ERR_T_atm));
    B787_ERR.rho_atm    =   mean(vertcat(B787_temp(:).ERR_rho_atm));
    B787_ERR.V_air      =   mean(vertcat(B787_temp(:).ERR_V_air));
    B787_ERR.q_pitot    =   mean(vertcat(B787_temp(:).ERR_q_pitot));
    B787_ERR.AOA        =   mean(vertcat(B787_temp(:).ERR_AOA));
    B787_ERR.N_force    =   mean(vertcat(B787_temp(:).ERR_N_force));
    B787_ERR.A_force    =   mean(vertcat(B787_temp(:).ERR_A_force));
    B787_ERR.M_pitch    =   mean(vertcat(B787_temp(:).ERR_M_pitch));
    B787_ERR.P_valve    =   mean(vertcat(B787_temp(:).ERR_P_valve));
else
    B787_ERR = 0;
end

end