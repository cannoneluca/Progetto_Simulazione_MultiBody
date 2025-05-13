% analisi_dinamica.m

% Implementa l'analisi dinamica del cinematismo applicando il principio dei lavori virtuali
% partendo dai risultati dell'analisi cinematica

% Le forze, espresse in Newton, sono raccolte in una struttra
% Ciascuna ha il nome coincidente con la coppia rotoidale su cui sono applicate
% Tutte le forze sono scomposte nelle due componenti parallele al sistema di riferimento

% Le coppie invece sono 

% Calcolo della forza di attrito radente associata alc ontatto tra il pacco e il telaio
force.R = pacco.m*simulation.g*simulation.f_cou; % [N] Forza di attrito
force.E_pacco_x = (pacco.xp > 0)*(force.R) + pacco.xpp*pacco.m;
