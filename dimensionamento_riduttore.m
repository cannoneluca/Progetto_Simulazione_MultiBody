% dimensionamento_riduttore.m

% Programma per il dimensionamento del riduttore interposto tra la manovella
% e l'attuatore.

% Per il dimensionamento consideriamo la coppia all'albero lento (d'uscita) quella da 
% applicare alla manovella.

riduttore.V2 = CB.fp;
riduttore.V2 = round(riduttore.V2);
riduttore.T2 = force.C2;        % [Nm] Coppia all'albero lento
riduttore.P2 = force.C2.*CB.fp; % [W] Potenza all'albero lento
riduttore.DC = sum(riduttore.P2 ~= 0)./length(riduttore.P2)*100; % [W] Potenza media

riduttore.shock_ncicli = [0 1000 1500 2000 3000 4000 5000 6000 10000];  % catalogo
riduttore.shock_fs = [1 1 1.1 1.25 1.55 1.75 1.82 1.9 2.1];             % da catalogo
riduttore.nclicli = ...
    riduttore.shock_ncicli(1):riduttore.shock_ncicli(end); % [1/h]
riduttore.fs = ... 
    interp1(riduttore.shock_ncicli, riduttore.shock_fs, riduttore.nclicli);
riduttore.fs = riduttore.fs(ceil(mean(riduttore.V2)));

riduttore.T2B = max(riduttore.T2)*simulation.safety*riduttore.fs; % [Nm] Coppia massima
riduttore.T2B = ceil(riduttore.T2B);    % arrotonda per eccesso
riduttore.T2M = (trapz(simulation.time, abs(riduttore.V2.*riduttore.T2.^3))/ ...
                 trapz(simulation.time, abs(riduttore.V2))).^(1/3); % [Nm] Coppia media
riduttore.T2M = ceil(riduttore.T2M*simulation.safety*(riduttore.DC >= 60));    % arrotonda per eccesso
riduttore.T2M = riduttore.T2M + riduttore.T2B*(riduttore.DC < 60); % [Nm] Coppia media
    
[~,index] = min(catalogo_riduttori(:,2) - riduttore.T2B + 100*(catalogo_riduttori(:,2) < riduttore.T2B));
riduttore.tau = catalogo_riduttori(index,1); % Rapporto di trasmissione
riduttore.etaD = catalogo_riduttori(index,6); % Rendimento moto diretto
riduttore.etaR = 2 - 1/riduttore.etaD; % Rendimento moto retrogrado
riduttore.N1max = catalogo_riduttori(index,4); % [rpm] Velocità massima albero veloce
riduttore.N1nom = catalogo_riduttori(index,5); % [rpm] Velocità nominale albero veloce


