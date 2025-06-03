% analisi_dinamica.m

% Implementa l'analisi dinamica del cinematismo applicando il principio dei lavori virtuali
% partendo dai risultati dell'analisi cinematica e da quelli del dimensionamento dei singoli membri

% I membri, questa volta dotati di massa, contribuiscono alla variazione della coppia
% da applicare alla manovella

% Si considerano sia i termini dovuti all'inerzia sia quelli dovuti alla forza peso

force.C2 = (CB.J_C.*CB.fpp.*CB.fp + ...
    BA.J.*BA.fpp.*BA.fp + BA.m.*BA.xpp.*BA.xp + BA.m.*BA.ypp.*BA.yp + BA.m*simulation.g*BA.yp + ...
    DE.J.*DE.fpp.*DE.fp + DE.m.*DE.xpp.*DE.xp + DE.m.*DE.ypp.*DE.yp + DE.m*simulation.g*DE.yp + ...
    OAD.J_O.*OAD.fpp.*OAD.fp + OAD.m*simulation.g*OAD.yp + ...
    force.Fr.*E.xp)./CB.fp;