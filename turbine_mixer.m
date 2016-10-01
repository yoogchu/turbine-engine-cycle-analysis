function [T05m, P05m] = turbine_mixer(T03, T051, P051, fmax_ratio)

    [Ta, Pa, M_inf, CPR, FPR, byp_ratio, bl_ratio, f_ratio, fab_ratio, ...
        d, f, c, p, b, t, ft, ab, fn, cn, tm] = inputs();

    gamma_tm = 1.34;

    T05m = ((1+f_ratio)*T051 + bl_ratio*T03)/(1+f_ratio+bl_ratio);
    
    P05m = (P051^(bl_ratio) * P051^(1+f_ratio) * ...
        (T05m^(1+f_ratio+bl_ratio) / (T03^(bl_ratio)*T051^(1+f_ratio)))...
        ^(gamma_tm/(gamma_tm-1)))^(1/(1+f_ratio+bl_ratio));

end