function [T01, T02, T03, T04, T051, T05m, T052, T06, Te, Tef, T07, Tec, P01, P02, P03, P04, P051, P05m, P052, P06, Pe, Pef, P07, u_inf, ue, uef, ST, TSFC, wdot_f, wdot_c, wdot_t,wdot_ft, wdot_p, eff_pr, eff_th, eff_o, f_max, fab_max] = outputs()

    [Ta, Pa, M_inf, CPR, FPR, byp_ratio, bl_ratio, f_ratio, fab_ratio, ...
        d, f, c, p, b, t, ft, ab, fn, cn, tm] = inputs();

    % FIXING USER INPUTS
    
    if fn % if core nozzle is on, fan nozzle should also be on
        n = true;
    else
        n = false;
    end
    
    if cn % if combined nozzle is on, nozzle mixer should also be on
        nm = true;
    else
        nm = false;
    end
    
    if ~f % fan does not exist
       ft = false;
       fn = false;
       cn = false;
       nm = false;
       sprintf('Fan off, therefore: fan turbine, fan nozzle, combined nozzle, nozzle mixer off')
    end
    
    if ~c % ramjet
        f = false;
        fn = false;
        t = false;
        tm = false;
        nm = false;
        cn = false;
        ab = false;
        sprintf('Ramjet, therefore: no compressor, no fan, no fan turbine, no turbine, no turbine mixer, no nozzle mixer, no combined mixer, no afterburner')
    end
    
    b = true;
    p = true;
    
    % CALCULATIONS
    
    if d % diffuser exists
        [T01, P01] = diffuser();
        % expected: T01 = 319, P01 = 32.63 - use P01 = 33.62
        % actual: T01 = 319, P01 = 33.62
    else
        T01 = Ta;
        P01 = Pa;
    end

    if f % fan exists
        [T02, P02, wdot_f, delta_d] = fan(T01,P01);
        % expected: T02 = 338, P02 = 39.15, wdot_f = 57.62
        % actual: T02 = 338, P02 = 39.15, wdot_f = 57.62
    else
        T02 = T01;
        P02 = P01;
        wdot_f = 0;
        delta_d = 0;
        byp_ratio = 0;
    end

    if c % compressor exists
        [T03, P03, wdot_c] = compressor(T02, P02);
        % expected: T03 = 956.9, P03 = 1175, wdot_c = 648.8
        % actual: T03 = 956.9, P03 = 1175, wdot_c = 648.8
    else
        T03 = T02;
        P03 = P02;
        wdot_c = 0;
    end

    if b % burner exists
        [T04, P04, f_max] = burner(T03, P03);
        % expected: T04 = 1658, P04 = 1151, f_max = 0.0254
        % actual: T04 = 1658, P04 = 1151, f_max = 0.0282, T04_max = 1939
    else
        T04 = T03;
        P04 = P03;
        f_max = 0;
    end
    
    if t % turbine exists
        [T051, P051] = turbine(T04, P04, wdot_c, f_max);
        wdot_t = wdot_c;
        % expected: T051 = 1050, P051 = 155.9
        % actual: T051 = 1051, P051 = 155.9
    else
        T051 = T04;
        P051 = P04;
        wdot_t = 0;
    end

    if tm % turbine mixer exists
        [T05m, P05m] = turbine_mixer(T03, T051, P051, f_max);
        % expected: T05m = 1041, P05m = 156.1
        % actual: T05m = 1042, P05m = 156.17
    else
        T05m = T051;
        P05m = P051;
    end

    if ft % fan turbine exists
        [T052, P052] = fan_turbine(T05m, P05m, wdot_f, f_max);
        wdot_ft = wdot_f;
        % expected: T052 = 992.6, P052 = 126.6
        % actual: T052 = 993.6, P052 = 126.67
    else
        T052 = T05m;
        P052 = P05m;
        wdot_ft = 0;
    end

    if ab % afterburner exists
        [T06, P06, fab_max] = afterburner(T052, P052, f_max);
        % expected: T06 = 1321, P06 = 122.8, fab_max = 0.0377
        % actual: T06 = 1322, P06 = 122.87, fab_max = 0.0380
    else
        T06 = T052;
        P06 = P052;
        fab_ratio = 0;
        fab_max = 0;
    end

    if n % core nozzle exists
        [Te, Pe, ue] = nozzle(T06, P06);
        % expected: Te = 721.3, Pe = 10, ue = 1156
        % actual: Te = 721.66, Pe = 10, ue = 1156.5
    else
        Te = T06;
        Pe = P06;
        ue = 0;
    end

    if fn % fan nozzle exists
        [Tef, Pef, uef] = fan_nozzle(T02, P02);
        % expected: Tef = 232.1, Pef = 10, uef = 462.6
        % actual: Tef = 232.13, Pef = 10, uef = 462.55
    else
        Tef = 0;
        Pef = 0;
        uef = 0;
    end

    if nm % nozzle mixer exists
        [T07, P07, gamma_nm] = nozzle_mixer(T06, P06, T02, P02);
        % expected: T07 = 671.8, P07 = 107.2, gamma_nm = 1.36
        % actual: T07 = 672.17, P07 = 107.29, gamma_nm = 1.36
    else
        T07 = 0;
        P07 = 0;
        gamma_nm = 0;
    end

    if cn % combined nozzle exists
        [Tec, Pec, uec] = combined_nozzle(T07, P07);
        % expected: Tec = 370, uec = 803.4
        % actual: Tec = 370.03, uec = 803.69, Pec = 10
    else
        Tec = 0;
        Pec = 0;
        uec = 0;
    end
    
    if p % fuel pump exists
        wdot_p = fuel_pump(P03);
        % expected: wdot_p = 0.17
        % actual: wdot_p = 0.1662
    end
    
    u_inf = M_inf * (1.4 * 8314/28.8 * Ta)^(0.5);
    
    % expected: ST = 0.618 (separate), 0.937 (combined), eff_th = 49.7 (separate)
    % actual: ST = 0.6183 (separate), 0.9379 (combined), eff_th = 0.4978 (separate)
    if cn
        ST = ((1 + f_ratio + fab_ratio + byp_ratio) * uec - (1+byp_ratio)*u_inf - delta_d)/1000;
        eff_pr = (2 * ST * 1000) / (u_inf * ( (1+f_ratio+fab_ratio+byp_ratio)*(uec/u_inf)^2 - (1+byp_ratio)));
        eff_th = (.5 * u_inf^2 * ((1+f_ratio+fab_ratio+byp_ratio)*(uec/u_inf)^2 - (1+byp_ratio))) / ((f_ratio + fab_ratio) * 43150000);
    else
        ST = ((1 + f_ratio + fab_ratio) * ue + (byp_ratio * uef) - (1+byp_ratio) * u_inf - delta_d) / 1000;
        eff_pr = (2 * ST * 1000)/ (u_inf * ( (byp_ratio * (uef/u_inf)^2) + ((1 + f_ratio + fab_ratio) * (ue/u_inf)^2) - (1+byp_ratio)));
        eff_th = (.5 * (byp_ratio * (uef/u_inf)^2 + (1+f_ratio+fab_ratio)*(ue/u_inf)^2 - (1+byp_ratio)) * u_inf^2) / ((f_ratio + fab_ratio) * 43150000);
    end
    
    % expected: TSFC = 0.0453 (separate), 0.0299 (combined)
    % actual: TSFC = 0.0453 (separate), 0.0299 (combined)
    TSFC = (f_ratio + fab_ratio)/ST;
    
    % expected: eff_o = 22.9 (separate), 34.7 (combined)
    % actual: eff_o = 0.2289 (separate), 0.3472 (combined)
    eff_o = eff_pr * eff_th;
   
    % WRITE TO TEXT FILE
     
    outVar = [T01, T02, T03, T04, T051, T05m, T052, T06, Te, Tef, T07, Tec,...
        P01, P02, P03, P04, P051, P05m, P052, P06, Pe, Pef, P07, ...
        u_inf, ue, uef, uec, ST, TSFC, wdot_f, wdot_c, wdot_t,wdot_ft, wdot_p,...
        eff_pr, eff_th, eff_o, f_max, fab_max, gamma_nm];
    outNames = {'T01', 'T02', 'T03', 'T04', 'T051', 'T05m', 'T052', 'T06',...
        'Te', 'Tef', 'T07', 'Tec', 'P01', 'P02', 'P03', 'P04', 'P051', ...
        'P05m', 'P052', 'P06', 'Pe', 'Pef', 'P07', 'u_inf', 'ue', 'uef', ...
        'uec', 'T/mdot_a', 'TSFC', 'wdot_f', 'wdot_c', 'wdot_t',...
        'wdot_ft', 'wdot_p', 'eff_pr', 'eff_th', 'eff_o', 'f_max', 'fab_max', 'gamma_nm'};
    outDescr = {'Diffuser Exhaust Temperature', 'Fan Exhaust Temperature', 'Compressor Exhaust Temperature', ...
        'Burner Exhaust Temperature', 'Turbine Exhaust Temperature', 'Turbine Mixer Exhaust Temperature', ...
        'Fan Turbine Exhaust Temperature', 'Afterburner Exhaust Temperature', 'Core Nozzle Exhaust Temperature', ...
        'Fan Nozzle Exhaust Temperature', 'Nozzle Mixer Exhaust Temperature', 'Combined Nozzle Exhaust Temperature', ...
        'Diffuser Exhaust Pressure', 'Fan Exhaust Pressure', 'Compressor Exhaust Pressure', 'Burner Exhaust Pressure', ...
        'Turbine Exhaust Pressure', 'Turbine Mixer Exhaust Pressure', 'Fan Turbine Exhaust Pressure', 'Afterburner Exhaust Pressure', ...
        'Core Nozzle Exhaust Pressure', 'Fan Nozzle Exhaust Pressure', 'Nozzle Mixer Exhaust Pressure', ...
        'Freestream Velocity', 'Core Nozzle Exit Velocity', 'Fan Nozzle Exit Velocity', 'Combined Nozzle Exit Velocity', ...
        'Specific Thrust', 'Thrust Specific Fuel Consumption', 'Work done on Fan', 'Work done on Compressor', ...
        'Work done by Turbine', 'Work done by Fan Turbine', 'Work done by Fuel Pump', ...
        'Propulsive Efficiency', 'Thermal Efficiency', 'Overall Efficiency', 'Maximum Burner Fuel Ratio', 'Maximum Afterburner Fuel Ratio','Gamma Nozzle Mixer'};
    outUnits = {'K','K','K','K','K','K','K','K','K','K','K','K','kPa','kPa','kPa','kPa','kPa','kPa','kPa','kPa','kPa','kPa','kPa', ...
        'm/s','m/s','m/s','m/s','kN s/kg', 'kg/kN s','kJ/kg','kJ/kg','kJ/kg','kJ/kg','kJ/kg','','','','','',''};
    outFile = fopen('output.txt', 'w');
    fprintf(outFile, 'Cycle Analysis outputs \r\n \r\n');
    
    for i = 1: length(outVar)
        if i == 13 || i == 24
            fprintf(outFile, '\r\n');
        end
        fprintf(outFile, '%-12.8s %-12.6s %-12.6s %-12.40s \r\n', outNames{i}, num2str(outVar(i)), outUnits{i}, outDescr{i});
    end
    
    fclose(outFile);
end