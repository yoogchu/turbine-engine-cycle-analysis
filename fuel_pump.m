function [wdot_p] = fuel_pump(P03)

    [Ta, Pa, M_inf, CPR, FPR, byp_ratio, bl_ratio, f_ratio, fab_ratio, ...
        d, f, c, p, b, t, ft, ab, fn, cn, tm] = inputs();
    
    if ~ab
        fab_ratio = 0;
    end
    
    deltaP = 550; %kPa, deltaP = Pf2 - Pf2, the change in pressure across the pump
    Pf1 = 104; %kPa
    density = 780; %kg/m^3
    eff_p = 0.35;
    gamma_p = 1.4;
    cpp = (8.314/28.8) * (gamma_p / (gamma_p - 1));

    Ppumpexit = P03 + deltaP;
    deltaPpump = Ppumpexit - Pf1;
    
    wdot_p = (f_ratio+fab_ratio)*deltaPpump/(eff_p*density);

end