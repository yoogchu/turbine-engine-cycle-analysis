function [T051, P051] = turbine(T04, P04, wdot_c, fmax_ratio)

    [Ta, Pa, M_inf, CPR, FPR, byp_ratio, bl_ratio, f_ratio, fab_ratio, ...
        d, f, c, p, b, t, ft, ab, fn, cn, tm] = inputs();

    gamma_t = 1.33;
    cp_t = (8.314/28.8) * (gamma_t / (gamma_t - 1));

    Tmax0 = 1300;
    bmax = .12;
    c_bl = 700;
    
    % inlet: T04, P04 not T04_max
    % outlet: T051, P051
    T04_max =  Tmax0 + c_bl * (bl_ratio/bmax)^(.5);

    T051 = T04 - (wdot_c / ((1 + f_ratio - bl_ratio) * cp_t));
    
    eff_t =  ((T051/T04) - 1) / (((T051/T04)^(1/.92)) - 1);

    P051 = P04 * (1 + ((T051/T04)-1)/eff_t)^(gamma_t/(gamma_t - 1));

end