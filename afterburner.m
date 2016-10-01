function [T06, P06, fab_max] = afterburner(T052, P052, f_max)

    [Ta, Pa, M_inf, CPR, FPR, byp_ratio, bl_ratio, f_ratio, fab_ratio, ...
        d, f, c, p, b, t, ft, ab, fn, cn, tm] = inputs();

    eff_ab = 0.96;
    gamma_ab = 1.32;
    cp_ab = (8.314/28.8) * (gamma_ab / (gamma_ab - 1));
    T06_max = 2200;
    ABPR = 0.97; % afterburner pressure ratio

    T06 = ((1+f_ratio)*T052 + ((eff_ab*fab_ratio*43150)/cp_ab)) / (1+f_ratio+fab_ratio);

    if T06 > T06_max
        T06 = T06_max;
    end

    P06 = P052 * (ABPR);

    fab_max = (1+f_max)*((T06_max/T052) - 1)/(((eff_ab * 43150)/(cp_ab * T052)) - (T06_max/T052));
    
end