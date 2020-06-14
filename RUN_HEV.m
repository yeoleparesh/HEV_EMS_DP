function [P_batt_act, P_eng_act, FC_act, SOC_act]=RUN_HEV(SOC_init,N,SOC_grid,u_opt,P_dem)
    SOC_act(1) = SOC_init;
    ts =1;
    U_oc = 320;
    fl_wt_en = 0.001;
    Q_batt = 18000;
    for i = 1:N-1
        P_batt_act(i) = interp1(SOC_grid,u_opt(:,i),SOC_act(i));
        P_eng_act(i) = P_dem(i) - P_batt_act(i);
        FC_act(i) = (ts*fl_wt_en*P_eng_act(i))/(eng_eff(P_eng_act(i))); 
        SOC_act(i+1) = SOC_act(i) - ((ts*P_batt_act(i))/(Q_batt*U_oc));       
    end
end 