function [ T07, P07, gammanm ] = nozzle_mixer(T06, P06, T02, P02)

    [Ta, Pa, M_inf, CPR, FPR, byp_ratio, bl_ratio, f_ratio, fab_ratio, ...
        d, f, c, p, b, t, ft, ab, fn, cn, tm] = inputs();
    
    if ~ab
        fab_ratio = 0;
    end

    T07 = ((1+f_ratio+fab_ratio)*T06+byp_ratio*T02)/(1+f_ratio+fab_ratio+byp_ratio);

    gammanm = 1.44-1.39*10^-4*T07 + 3.57*10^-8*T07^2;

    P07 = (P02^(byp_ratio) * P06^(1+f_ratio+fab_ratio) * ...
        (T07^(1+f_ratio+fab_ratio+byp_ratio)/(T02^(byp_ratio)*...
        T06^(1+f_ratio+fab_ratio)))^(gammanm/(gammanm-1)))...
        ^(1/(1+f_ratio+fab_ratio+byp_ratio))*0.8;

end