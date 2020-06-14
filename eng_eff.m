function eff = eng_eff(P_eng)
    a =  5e-08;
    b = -6e-06;
    c = 2.6e-04;
    d = -5.8e-03;
    e = 6.8e-02;
    f = 2.6e-05;
    x = P_eng/1000;                   % W to KW
    eff = a*x.^5 + b*x.^4 + c*x.^3 + d*x.^2 + e*x + f;
end