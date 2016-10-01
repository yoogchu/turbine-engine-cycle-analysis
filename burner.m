function [T04, P04, f_max] = burner(T03, P03)

    [Ta, Pa, M_inf, CPR, FPR, byp_ratio, bl_ratio, f_ratio, fab_ratio, ...
        d, f, c, p, b, t, ft, ab, fn, cn, tm] = inputs();

    eff_b = .99;
    gamma_b = 1.33;
    cp_b = (8.314/28.8) * (gamma_b / (gamma_b - 1));
    BPR = .98; % burner pressure ratio

    T04 = ((T03*(1-bl_ratio)) + ((eff_b * f_ratio * 43150)/cp_b)) / (1 + f_ratio - bl_ratio);

    P04 = P03 * (BPR);

    Tmax0 = 1300;
    bmax = .12;
    c_bl = 700;
    T04_max =  Tmax0 + c_bl * (bl_ratio/bmax)^(.5);
 
    if T04 > T04_max
        T04 = T04_max;
        sprintf('Max T04 exceeded. Check inputs');
    end
    
    f_max = (1-bl_ratio)*((T04_max/T03) - 1)/(((eff_b * 43150)/(cp_b * T03)) - (T04_max/T03));
    
end