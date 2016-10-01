function[Te, Pe, ue] = nozzle(T06, P06)

    [Ta, Pa, M_inf, CPR, FPR, byp_ratio, bl_ratio, f_ratio, fab_ratio, ...
        d, f, c, p, b, t, ft, ab, fn, cn, tm] = inputs();

    eff_n = 0.95;
    gamma_n = 1.35;
    cp_n = (8.314/28.8) * (1.35/0.35) * 1000; % J/ kg K

    Pe = Pa;
    Te = T06 * (1 - 0.95*(1-(Pe/P06)^(0.35/1.35)));
    ue = sqrt(2 * cp_n * T06 * 0.95 * (1 - (Pe/P06)^(0.35/1.35)));

end