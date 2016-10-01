function [T052, P052] = fan_turbine(T05m, P05m, wdot_f, fmax_ratio)

    [Ta, Pa, M_inf, CPR, FPR, byp_ratio, bl_ratio, f_ratio, fab_ratio, ...
        d, f, c, p, b, t, ft, ab, fn, cn, tm] = inputs();

    gamma_ft = 1.33;
    cp_ft = (8.314/28.8) * (gamma_ft / (gamma_ft - 1));
    eff_ft = 0.92;

    T052 = T05m - (wdot_f / ((1 + f_ratio) * cp_ft));
    
    eff_ft = ((T052/T05m) - 1) / (((T052/T05m)^(1/eff_ft)) - 1);
    P052 = P05m * (1 + ((T052/T05m)-1)/eff_ft)^(gamma_ft/(gamma_ft - 1));

end