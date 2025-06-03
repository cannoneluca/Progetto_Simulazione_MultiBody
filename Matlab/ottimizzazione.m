% ottmizzazione.m

% Il file modifica la lunghezza del membro CB affinché
% la corsa del pattino sia pari a H. Si propone un approccio di tipo
% analitico, supponendo che esiste un rapporto di proporzionalità diretta tra la corsa
% dello spingitore e la lunghezza della manovella CB.

disp("La corsa del pattino attualmente è: " + EF.corsa);

CB.z = CB.z * simulation.H / EF.corsa; % Nuova lunghezza della manovella

% Arrotonda per eccesso la lunghezza della manovella per garantire la corsa
% minima richiesta
CB.z = ceil(CB.z/simulation.prec)*simulation.prec;
analisi_cinematica();

% Si reitera il calcolo finché non è soddisfatta la condizione desiderata,
% nei limiti della precisione del progetto

if((EF.corsa < simulation.H - simulation.prec) + ( EF.corsa > simulation.H + simulation.prec))
    ottimizzazione;
else
    disp("La corsa del pattino attualmente è: " + EF.corsa);
end
