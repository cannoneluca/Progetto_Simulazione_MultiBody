OAD.alfa = AD.f(1) - AO.f(1); % [rad] Angolo compreso tra i membri AD e OF, costante

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
    z3*cos(f3) + z4*cos(x(2)) + z5*cos(x(1) + OAD.alfa) + z6*cos(x(3)) + x(4)*cos(f7) + z8*cos(f8) + z9*cos(f9)
    z3*sin(f3) + z4*sin(x(2)) + z5*sin(x(1) + OAD.alfa) + z6*sin(x(3)) + x(4)*sin(f7) + z8*sin(f8) + z9*sin(f9)
];

%% Analisi di posizione

% Ciclo for per la soluzione delle equazioni di chiusura in ogni configurazione del sistema
x0 = [AO.f(1), BA.f(1), DE.f(1), EF.z(1)];  % Vettore dei valori di guess iniziale per le incognite

for k1 = 1:simulation.samples

    x = fsolve(@(x) chiusura(x, AO.z, OC.z, CB.z, BA.z, AD.z, DE.z, FG.z, GC.z, ...
        OC.f, CB.f(k1), EF.f, FG.f, GC.f), x0, simulation.fsolve_options);

    x0 = x; % Aggiorna il valore di guess iniziale per la prossima iterazione
    
    CB.x(k1,1) = C.x + CB.z*cos(CB.f(k1,1));
    CB.y(k1,1) = C.y + CB.z*sin(CB.f(k1,1));
    AO.f(k1,1) = x(1);
    BA.f(k1,1) = x(2);
    BA.x(k1,1) = C.x + CB.z*cos(CB.f(k1,1)) + BA.z/2*cos(BA.f(k1,1));
    BA.y(k1,1) = C.y + CB.z*sin(CB.f(k1,1)) + BA.z/2*sin(BA.f(k1,1));
    AD.f(k1,1) = AO.f(k1,1) + OAD.alfa;
    D.x = O.x + AO.z*cos(AO.f(k1) + pi) + AD.z*cos(AD.f(k1));
    D.y = O.y + AO.z*sin(AO.f(k1) + pi) + AD.z*sin(AD.f(k1));
    OAD.f(k1,1) = vettore(O,D).f;
    OAD.x(k1,1) = OAD.z*cos(OAD.f(k1,1));
    OAD.y(k1,1) = OAD.z*sin(OAD.f(k1,1));
    EF.z(k1,1) = x(4);
    E.x(k1,1) = F.x - EF.z(k1,1);
    DE.f(k1,1) = x(3);
    DE.x(k1,1) = F.x - EF.z(k1,1) - DE.z/2*cos(DE.f(k1,1));
    DE.y(k1,1) = F.y - DE.z/2*sin(DE.f(k1,1));
end

%% Analisi di velocità

AO.fp = deriv3(AO.f,simulation.time);
CB.fp = deriv3(CB.f,simulation.time);
CB.xp = deriv3(CB.x,simulation.time);
CB.yp = deriv3(CB.y,simulation.time);
BA.fp = deriv3(BA.f,simulation.time);
BA.xp = deriv3(BA.x,simulation.time);
BA.yp = deriv3(BA.y,simulation.time);
AD.fp = AO.fp;
OAD.fp = AO.fp;
OAD.xp = deriv3(OAD.x,simulation.time);
OAD.yp = deriv3(OAD.y,simulation.time);
DE.fp = deriv3(DE.f,simulation.time);
DE.xp = deriv3(DE.x,simulation.time);
DE.yp = deriv3(DE.y,simulation.time);
E.xp = deriv3(E.x,simulation.time);

%% Analisi di accelerazione

AO.fpp = deriv3(AO.fp,simulation.time);
CB.fpp = deriv3(CB.fp,simulation.time);
CB.xpp = deriv3(CB.xp,simulation.time);
CB.ypp = deriv3(CB.yp,simulation.time);
BA.fpp = deriv3(BA.fp,simulation.time);
BA.xpp = deriv3(BA.xp,simulation.time);
BA.ypp = deriv3(BA.yp,simulation.time);
AD.fpp = AO.fpp;
OAD.fpp = AO.fpp;
OAD.xpp = deriv3(OAD.xp,simulation.time);
OAD.ypp = deriv3(OAD.yp,simulation.time);
DE.fpp = deriv3(DE.fp,simulation.time);
DE.xpp = deriv3(DE.xp,simulation.time);
DE.ypp = deriv3(DE.yp,simulation.time);
E.xpp = deriv3(E.xp,simulation.time);

%% Studio della cinematica del pacco

% Il pattino incontra il pacco dopo una certa frazione di corsa,
% specifica nel file di setup. Calcoliamo quindi la posizione iniziale
% del pacco in funzione della corsa del pattino

% Si studia la posizione del punto del pacco in basso a sinistra

E.PMS = max(E.x);
E.PMI = min(E.x);
EF.corsa = E.PMS - E.PMI; % [m] Lungghezza della corsa del pattino 

pacco.y = E.y - pacco.side/2; % [m] Posizione iniziale del pacco
pacco.x(1,1) = E.PMI + simulation.p*EF.corsa; % [m] Posizione iniziale del pacco

for k2 = 2:simulation.samples
    % Si calcola la posizione del pacco in funzione della corsa del pattino
    % trascurando gli effetti della sua inerzia
    if(E.x(k2) < pacco.x(k2-1))
        pacco.x(k2,1) = pacco.x(k2-1,1);
    else
        pacco.x(k2,1) = E.x(k2);
    end
    % Si calcola l'accelerazione del pacco in funzione dell'accelerazione del
end

pacco.xp = deriv3(pacco.x,simulation.time); % [m/s] Velocità del pacco
pacco.xpp = deriv3(pacco.xp,simulation.time); % [m/s^2] Accelerazione del pacco
grafico_cinematica_pacco();
grafico_cinematica_pattino();
clear x x0 k1 k2 chiusura;