function [Tec, Pec, uec] = combined_nozzle( T07, P07)

    [Ta, Pa, M_inf, CPR, FPR, byp_ratio, bl_ratio, f_ratio, fab_ratio, ...
        d, f, c, p, b, t, ft, ab, fn, cn, tm] = inputs();

    cpcn = 8314 / 28.8 * 1.37/(1.37-1);
    Pec = Pa;
    Tec = T07 * (1 - 0.95*(1-(Pec/P07)^(0.37/1.37)));
    uec = sqrt(2*cpcn*T07*0.95*(1-(Pec/P07)^(0.37/1.37)));

end
