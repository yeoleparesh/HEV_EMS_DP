load('UDDS_drive_cycle.mat')          %load the drive cycle (P_dem,v,t)            
ts = 1;                               %time step
P_dem = P_dem*1000;                   %Power demand KW to W
subplot(2,1,1);
plot(t,P_dem)                       
title('Power demand')
subplot(2,1,2);
plot(t,v)
title('Desired velocity')

fl_wt_en = 0.001; %no. of grams consumed per unit energy consumption
Pb_Max = 30000;        % [W] Maximum engine power
Pm_Max = 15000;        % [W] Maximum motor power
Q_batt = 18000;        % [As] Battery capacity
U_oc = 320;            % [V] Open ciruit voltage of the battery
SOC_min = 0.3;         % Lower SOC limit
SOC_max = 0.8;         % Upper SOC limit
SOC_grid = linspace(SOC_min,SOC_max,80)';   %SOC grid

% DP
V = zeros(ns,N);            %Value function
V(:,N) = 0;                 %Boundary condition   
for i = N-1:-1:1            %Iterate through time vector
    for j = 1:ns            %Iterate through SOC grid
     lb = max([(((SOC_max-SOC_grid(j))*Q_batt*V_oc)/-ts),-Pb_max, P_dem(i)-Pe_max]);          %lower bound P_batt
     ub = min([(((SOC_min-SOC_grid(j))*Q_batt*V_oc)/-ts),Pb_max, P_dem(i)]);                 %Upper bound P_batt
     P_batt_grid = linspace(lb,up,250);      %P_batt grid 
     P_eng = P_dem(i) - P_batt_grid;         %P_eng at for P_batt_grid
     c2g = (time_step * alpha* P_eng)./(calc_eng_eff(P_eng)); %costtogo
     SOC_next = SOC_grid(j) - (ts .* P_batt_grid ./ (Q_batt*V_oc));
     V_nxt = interp1(SOC_grid,V(:,i+1),SOC_next);
     [V(j,i), k] = min([c2g + V_nxt]);
     u_opt(j,i) = P_batt_grid(k); 
    end
end

[Pb_07, Pe_07, FC_07, SOC_07]= RUN_HEV(0.7);
[Pb_05, Pe_05, FC_05, SOC_05]= RUN_HEV(0.5);
[Pb_03, Pe_03, FC_03, SOC_03]= RUN_HEV(0.3);
plot(SOC_07)
hold on;
plot(SOC_05)
plot(SOC_03)
title('SOC')
legend('SOC 0.3','SOC 0.5','SOC 0.7')