function [Ta, Pa, M_inf, CPR, FPR, byp_ratio, bl_ratio, f_ratio, fab_ratio, d, f, c, p, b, t, ft, ab, fn, cn, tm] = inputs()

    % 9 input values
    Ta = 220; % K, ambient temperature ask the users to input these
    Pa = 10; % kPa, ambient pressure
    M_inf = 1.5; % freestream Mach number
    CPR = 30; % compression pressure ratio
    FPR = 1.2; % fan pressure ratio
    byp_ratio = 2; % bypass ratio
    bl_ratio = 0.1; % bleed ratio
    f_ratio = 0.018; % fuel ratio : mdot_f/mdot_a
    fab_ratio = 0.01; % fuel ratio : afterburner (mdot_fab/mdot_a)

    % 13 components
    d = true; % diffuser
    f = true; % bypass fan
    c = true; % compressor
    p = true; % fuel pump
    b = true; % main combustor/burner
    t = true; % turbine - runs compressor and fuel pump
    tm = true; % turbine mixer   
    ft = true; % fan turbine - to run the fan
    ab = true; % afterburner
    fn = true; % fan nozzle - indicates separate core and fan nozzles
    cn = true; % combined nozzle - replaces core and fan nozzles
end

%     INPUTS FOR SUBSONIC COMMERCIAL AIRLINER, GROUND ROLL
%     Ta = 298; % K, ambient temperature ask the users to input these
%     Pa = 101.3; % kPa, ambient pressure
%     M_inf = 0; % freestream Mach number
%     CPR = 50; % compression pressure ratio
%     FPR = 2; % fan pressure ratio
%     byp_ratio = 11; % bypass ratio
%     bl_ratio = 0.05; % bleed ratio
%     f_ratio = 0.124; % fuel ratio : mdot_f/mdot_a
%     fab_ratio = 0.01; % fuel ratio : afterburner (mdot_fab/mdot_a)
%     TURNED ON: d, f, c, p, b, t, tm, ft, cn, nm, ab

%     INPUTS FOR SUBSONIC COMMERCIAL AIRLINER, HIGH ALTITUDE CRUISE
%     Ta = 229; % K, ambient temperature ask the users to input these
%     Pa = 30.1; % kPa, ambient pressure
%     M_inf = 0.85; % freestream Mach number
%     CPR = 50; % compression pressure ratio
%     FPR = 1.8; % fan pressure ratio
%     byp_ratio = 5; % bypass ratio
%     bl_ratio = 0.05; % bleed ratio
%     f_ratio = 0.075; % fuel ratio : mdot_f/mdot_a
%     fab_ratio = 0.023; % fuel ratio : afterburner (mdot_fab/mdot_a)
%     TURNED ON: d, f, c, p, b, t, ft, cn, tm, nm, ab

%     INPUTS FOR SUPERSONIC BUSINESS JET, GROUND ROLL
%     Ta = 277; % K, ambient temperature ask the users to input these
%     Pa = 82.9; % kPa, ambient pressure
%     M_inf = 0; % freestream Mach number
%     CPR = 30; % compression pressure ratio
%     FPR = 1.2; % fan pressure ratio
%     byp_ratio = 2; % bypass ratio
%     bl_ratio = 0.05; % bleed ratio
%     f_ratio = 0.0166; % fuel ratio : mdot_f/mdot_a
%     fab_ratio = 0; % fuel ratio : afterburner (mdot_fab/mdot_a)
%     TURNED OFF: ab, n, fn

%     INPUTS FOR SUPERSONIC BUSINESS JET, HIGH ALTITUDE CRUISE
%     Ta = 216; % K, ambient temperature ask the users to input these
%     Pa = 11.6; % kPa, ambient pressure
%     M_inf = 1.5; % freestream Mach number
%     CPR = 50; % compression pressure ratio
%     FPR = 1; % fan pressure ratio
%     byp_ratio = 0; % bypass ratio
%     bl_ratio = 0.05; % bleed ratio
%     f_ratio = 0.0182; % fuel ratio : mdot_f/mdot_a
%     fab_ratio = 0; % fuel ratio : afterburner (mdot_fab/mdot_a)
%     TURNED ON: d, c, p, b, t, n, tm