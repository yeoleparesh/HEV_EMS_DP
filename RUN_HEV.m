function [P_batt_act, P_eng_act, FC_act, SOC_act] = RUN_HEV(SOC_init)
    SOC_act(1) = SOC_init;
    for i = 1:N-1
        P_batt_act(i) = interp1(SOC_grid,u_opt(:,i),SOC_sim(i));
        P_eng_act(i) = P_dem(i) - P_batt_act(i);
        FC_act(i) = (ts*fl_wt_en*P_eng_act(i))/(eng_eff(P_eng_act(i))); 
        SOC_act(i+1) = SOC_act(i) - ((ts*P_batt_act(i))/(Q_batt*U_oc));       
    end
end 