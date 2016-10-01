function [ Tef, Pef, ue ] = fan_nozzle( T02, P02)

    [Ta, Pa, M_inf, CPR, FPR, byp_ratio, bl_ratio, f_ratio, fab_ratio, ...
        d, f, c, p, b, t, ft, ab, fn, cn, tm] = inputs();

    cpfn = 8314/28.8*1.4/(1.4-1);
    Pef = Pa;
    Tef = T02*(1-0.97*(1-(Pef/P02)^(0.4/1.4)));
    ue = sqrt(2*cpfn*T02*0.97*(1-(Pef/P02)^(0.4/1.4)));

end