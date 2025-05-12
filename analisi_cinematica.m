OAD = AD.f - AO.f; % [rad] Angolo compreso tra i membri AD e OF, costante

% per conoscere la posizione dei singoli membri per ogni configurazione del sistema
% si risolve un sistema ottenuto attraverso le equazioni di chiusura del sistema

% le maglie individuate per la risoluzione del problema sono:
% 1) AO + OC + CB + BA = 0
% 2) BC + CA + AD + DE + EF + FG + GC = 0
% Il sistema di equazioni è ottenuto proiettando le chiusure su gli assi di riferimento principali x e y

% Le incognite sono racchiuse nel vettore x:
% x(1): inclinazione del membro AO
% x(2): inclinazione del membro BA
% x(3): inclinazione del membro DE
% x(4): lunghezza del membro EF

chiusura = @(x,z1,z2,z3,z4,z5,z6,z8,z9,f2,f3,f7,f8,f9)[
    z1*cos(x(1)) + z2*cos(f2) + z3*cos(f3) + z4*cos(x(2))
    z1*sin(x(1)) + z2*sin(f2) + z3*sin(f3) + z4*sin(x(2))
    z3*cos(f3) + z4*cos(x(2)) + z5*cos(x(1) + OAD) + z6*cos(x(3)) + x(4)*cos(f7) + z8*cos(f8) + z9*cos(f9)
    z3*sin(f3) + z4*sin(x(2)) + z5*sin(x(1) + OAD) + z6*sin(x(3)) + x(4)*sin(f7) + z8*sin(f8) + z9*sin(f9)
];

% Ciclo for per la soluzione delle equazioni di chiusura in ogni configurazione del sistema
x0 = [AO.f, BA.f, DE.f, EF.z];  % Vettore dei valori di guess iniziale per le incognite

for k1 = 1:simulation.samples

    x = fsolve(@(x) chiusura(x, AO.z, OC.z, CB.z, BA.z, AD.z, DE.z, FG.z, GC.z, ...
        OC.f, CB.f(k1), EF.f, FG.f, GC.f), x0, fsolve_options);

    x0 = x; % Aggiorna il valore di guess iniziale per la prossima iterazione
    
    AO.f(k1) = x(1);
    BA.f(k1) = x(2);
    AD.f(k1) = AO.f(k1) + OAD;
    DE.f(k1) = x(3);
    EF.z(k1) = x(4);
end
