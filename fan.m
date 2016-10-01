function [T02, P02, wdot_f, delta_d] = fan(T01,P01)

    [Ta, Pa, M_inf, CPR, FPR, byp_ratio, bl_ratio, f_ratio, fab_ratio, ...
        d, f, c, p, b, t, ft, ab, fn, cn, tm] = inputs();

    cb1 = 245; %N * s / kg
    gamma_f = 1.4;
    eff_f =  (FPR ^((gamma_f - 1)/gamma_f) - 1)/ ( (FPR^((gamma_f - 1)/(gamma_f * .9))) - 1);
    cp_f = (8.314/28.8) * (gamma_f / (gamma_f - f)); %kJ/kg K

    delta_d = cb1 * M_inf^2 * (Pa/101.325) * byp_ratio^1.5;
    
    P02 = P01 * FPR;
    T02 = T01 * (1 + ((1/eff_f) * ((FPR)^((gamma_f - 1)/gamma_f) -1)));
    wdot_f = (1 + byp_ratio) * cp_f * (T02-T01);

end