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


% Inizializzo la colonna per il calcolo della coppia rms richiesta al motore
catalogo_riduttori(:,9) = zeros(length(catalogo_riduttori(:,1)),1); 
% Inizializzo la colonna per la verifica del rispetto del limite di velocità all'albero di ingresso
catalogo_riduttori(:,10) = zeros(length(catalogo_riduttori(:,1)),1);    % Limite massimo
catalogo_riduttori(:,11) = zeros(length(catalogo_riduttori(:,1)),1);    % Limite nominale

for k5 = 1:length(catalogo_riduttori)
    riduttore.tau = 1/catalogo_riduttori(k5,1); % Rapporto di trasmissione
    riduttore.T2B = catalogo_riduttori(k5,2); % Coppia massima all'albero lento [Nm]
    riduttore.T2M = catalogo_riduttori(k5,3); % Coppia media all'albero lento [Nm]
    riduttore.N1max = catalogo_riduttori(k5,4); % Velocità massima albero veloce [rpm]
    riduttore.N1nom = catalogo_riduttori(k5,5); % Velocità nominale albero veloce [rpm]
    riduttore.etaD = catalogo_riduttori(k5,6); % Rendimento moto diretto [%]
    riduttore.etaR = catalogo_riduttori(k5,7); % Rendimento moto retrogrado [%]
    riduttore.Im = catalogo_riduttori(k5,8); % Momento di inerzia all'albero veloce [kg*m^2]

    riduttore.eta = riduttore.etaD*(riduttore.P2 > 0) + riduttore.etaR^-1*(riduttore.P2 <= 0); % Rendimento
    motore.C = motore.C_a + motore.cv*CB.fp/riduttore.tau + (motore.Im + riduttore.Im)*CB.fpp./riduttore.tau^2 + ...
                riduttore.tau*riduttore.T2./riduttore.eta; % Coppia totale
    catalogo_riduttori(k5,9) = rms(motore.C);
    catalogo_riduttori(k5,10) = max(abs(riduttore.V2))/riduttore.tau*simulation.safety*30/pi <= riduttore.N1max; % Limite massimo
    catalogo_riduttori(k5,11) = ...
        (mean(abs(riduttore.V2))/riduttore.tau*simulation.safety*30/pi <= riduttore.N1nom)*(riduttore.DC >= 60) + ...
            1*(riduttore.DC < 60); % Limite nominale

    % Affinché siano esclusi i riduttori per i quali sarebbe superato il limite di velocità si modifica la coppia rms
    catalogo_riduttori(k5,9) = catalogo_riduttori(k5,9)./catalogo_riduttori(k5,10)./catalogo_riduttori(k5,11);
    % In questo modo tali riduttori hanno una coppia tendente a infinito, che li porterà ad essere esclusi dalla selezione successiva
end

[~, index] = min(catalogo_riduttori(:,9)); % Trovo il riduttore con la coppia rms minima
riduttore.tau = catalogo_riduttori(index,1); % Rapporto di trasmissione
riduttore.T2B = catalogo_riduttori(index,2); % Coppia massima all'albero lento [Nm]
riduttore.T2M = catalogo_riduttori(index,3); % Coppia media all'albero lento [Nm]
riduttore.N1max = catalogo_riduttori(index,4); % Velocità massima albero veloce [rpm]
riduttore.N1nom = catalogo_riduttori(index,5); % Velocità nominale albero veloce [rpm]
riduttore.etaD = catalogo_riduttori(index,6); % Rendimento moto diretto [%]
riduttore.etaR = catalogo_riduttori(index,7); % Rendimento moto retrogrado [%]
riduttore.eta = riduttore.etaD*(riduttore.P2 > 0) + riduttore.etaR^-1*(riduttore.P2 <= 0); % Rendimento
riduttore.Im = catalogo_riduttori(index,8); % Momento di inerzia all'albero veloce [kg*m^2]

clear index

