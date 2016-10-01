function [T03, P03, wdot_c] = compressor(T02, P02)

    [Ta, Pa, M_inf, CPR, FPR, byp_ratio, bl_ratio, f_ratio, fab_ratio, ...
        d, f, c, p, b, t, ft, ab, fn, cn, tm] = inputs();

    gamma_c = 1.38;
    eff_c =  (CPR ^((gamma_c - 1)/gamma_c) - 1)/ ((CPR^((gamma_c - 1)/(gamma_c * .9))) - 1);
    cp_c = (8.314/28.8) * (gamma_c / (gamma_c - 1)); % kJ/ kg K

    P03 = CPR * P02;
    T03 = T02 * (1 + ( (1/eff_c) * ((CPR ^ ((gamma_c - 1)/gamma_c)) - 1)));
    wdot_c = cp_c * (T03 - T02);

end