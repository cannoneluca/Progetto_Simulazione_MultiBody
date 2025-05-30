% analisi_dinamica.m

% Implementa l'analisi dinamica del cinematismo applicando il principio dei lavori virtuali
% partendo dai risultati dell'analisi cinematica

% Le forze, espresse in Newton, sono raccolte in una struttra
% Ciascuna ha il nome coincidente con la coppia rotoidale su cui sono applicate
% Tutte le forze sono scomposte nelle due componenti parallele al sistema di riferimento

% La coppia applicata alla manovella è indicata con C

% Calcolo della forza di attrito radente associata alc ontatto tra il pacco e il telaio
force.R = pacco.m*simulation.g*simulation.f_cou; % [N] Forza di attrito

% Modelliamo l'impatto come una forza applicata all'handler. 
% Consideriamo l'impatto della durata limitata e la forza pari alla velocità
% raggiunta alla fine dell'urto, moltiplicata per la massa del pacco e
% diviso per il tempo di urto generato.

% L'istante di tempo corrispondente all'inizio dell'impatto è il momento in
% cui il pacco ha una velocità maggiore di 0:

impact.duration = 0.1; %[s] Durata dell'urto
[~,impact.start] = max(pacco.xp > 0);
impact.start_time = simulation.time(impact.start);
[~,impact.end] = min(abs(simulation.time - (impact.start_time + impact.duration)));
impact.end_time = simulation.time(impact.end);
impact.end_speed = pacco.xp(impact.end);

force.impact = impact.end_speed/impact.duration*pacco.m;

% La forza applciata al manipolatore è somma di 3 componenti
% 1) Attrito, presente solo se il pacco ha velocità positiva
% 2) Forza dell'urto: presente solo per la durata dell'urto
% 3) Forza di inerzia: dopo l'urto, presente solo per accelerazione e
% velocità del pacco positive
% 4) Inerzia del manipolatore

force.Fr = (pacco.xp > 0).*(force.R) + ...
            ((simulation.time > impact.start_time).*(simulation.time < impact.end_time))*force.impact + ...
            (simulation.time > impact.end_time).*(pacco.xp > 0).*pacco.xpp*pacco.m.*(pacco.xpp > 0) + ...
            E.m*E.xpp;

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

clear impact