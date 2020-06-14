function eff = eng_eff(P_eng)
    a = 5*e-08;
    b = -6*e-06;
    c = 2.6*e-04;
    d = -5.8*e-03;
    e = 6.8*e-02;
    f = 2.6*e-05;
    x = P_eng*e-03;                   % W to KW
    eff = a*x.^5 + b*x.^4 + c*x.^3 + d*x.^2 + e*x + f;
end