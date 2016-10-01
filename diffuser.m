function [T01, P01] = diffuser()

    [Ta, Pa, M_inf, CPR, FPR, byp_ratio, bl_ratio, f_ratio, fab_ratio, ...
        d, f, c, p, b, t, ft, ab, fn, cn, tm] = inputs();

    gamma_d = 1.4;
    eff_d = .92;

    if M_inf > 1 && M_inf < 5
        r_d = 1 - 0.075*(M_inf-1)^1.35;
    else
        r_d = 1;
    end
    
    T01 = Ta * (1+ ((gamma_d - 1)/2) * M_inf^2);
    P01 = Pa * (1+ (eff_d * ((gamma_d - 1)/2)) * M_inf^2) .^ (gamma_d / (gamma_d - 1));

    P01 = P01 * r_d;
end