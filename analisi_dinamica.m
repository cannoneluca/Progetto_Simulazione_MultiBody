% analisi_dinamica.m

% Implementa l'analisi dinamica del cinematismo applicando il principio dei lavori virtuali
% partendo dai risultati dell'analisi cinematica

% Le forze, espresse in Newton, sono raccolte in una struttra
% Ciascuna ha il nome coincidente con la coppia rotoidale su cui sono applicate
% Tutte le forze sono scomposte nelle due componenti parallele al sistema di riferimento

% La coppia applicata alla manovella è indicata con C

% Calcolo della forza di attrito radente associata alc ontatto tra il pacco e il telaio
force.R = pacco.m*simulation.g*simulation.f_cou; % [N] Forza di attrito
force.Fr = (pacco.xp > 0).*((force.R) + pacco.xpp*pacco.m.*(pacco.xpp > 0)) ...
    + E.m*E.xpp;

% La forza ottenuta presenta una componente impulsiva causata dall'inerzia
% del pacco. Si decide di filtrare i dati ai fini di avere componenti meno
% sovradimensionati
% 
% force.Fr = smoothdata(force.Fr);
% force.Fr = smoothdata(force.Fr);
% force.Fr = smoothdata(force.Fr);

% Calcolo la coppia necessaria, trascurando eventuali attriti presenti sulle coppie rotoidali
force.C = (force.Fr.*pacco.xp)./CB.fp;

% Si valuta il momento in cui la forza resistente è massima e si procede con il
% dimensionamento dei membri in tale condizione
[~, simulation.max_stress_index] = max(force.Fr);

grafico_coppia_plv();