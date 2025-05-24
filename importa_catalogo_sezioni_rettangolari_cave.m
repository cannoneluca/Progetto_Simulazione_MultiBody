% Rimuove eventuali catlaoghi presenti
clear catalogo_sezioni

% Per il progetto si è scelto di considerare, per la realizzazione dei singoli
% membri l'utilizzo di profilati scatolati in acciao a sezione rettangolare.

% Il catalogo è composto da 5 colonne:
% 1) Base           [m]     Lunghezza del lato corto
% 2) Altezza        [m]     Lunghezza del lato lungo
% 3) Spessore       [m]     Spessore della parete
% 4) Area           [m^2]   Area della sezione
% 5) Inerzia Jzz    [m^4]   Momento di inerzia principale della sezione
% 6) Wf             [m^3]   Momento di resistenza a flessione

campi = 6;

spessore = [0.0015 0.002];
lato_corto = [0.01 0.015 0.02];
lato_lungo = [0.02 0.03 0.03];

sezione(length(spessore)*length(lato_corto),campi) = 0;

for k1 = 0:1:length(lato_corto)-1
    for k2 = 0:1:length(spessore)-1
        i = k1*length(spessore) + k2 + 1;
        sezione(i,1) = lato_lungo(k1+1);
        sezione(i,2) = lato_corto(k1+1);
        sezione(i,3) = spessore(k2+1);
    end
    clear k2
end

catalogo_sezioni = sezione;

spessore = [0.002 0.003 ];
lato_corto = [0.02 0.03 0.025 0.02 0.02 0.03 0.04 0.03 0.04 0.06 0.02 0.04 0.05 0.06];
lato_lungo = [0.04 0.04 0.050 0.05 0.06 0.06 0.06 0.08 0.08 0.08 0.10 0.10 0.10 0.10];

sezione(length(spessore)*length(lato_corto),campi) = 0;

for k1 = 0:1:length(lato_corto)-1
    for k2 = 0:1:length(spessore)-1
        i = k1*length(spessore) + k2 + 1;
        sezione(i,1) = lato_lungo(k1+1);
        sezione(i,2) = lato_corto(k1+1);
        sezione(i,3) = spessore(k2+1);
    end
    clear k2
end

catalogo_sezioni = [catalogo_sezioni; sezione];

% Ci limitiamo ad importare la sezione di catalogo di nostro interesse

% Per ciascuna sezione calcoliamo area, momento d'inerzia e modulo di resistenza a flessione

for i = 1:length(catalogo_sezioni(:,1))
    % Calcolo dell'area
    catalogo_sezioni(i,4) = catalogo_sezioni(i,1)*catalogo_sezioni(i,2) - ...
        (catalogo_sezioni(i,1)-2*catalogo_sezioni(i,3))*(catalogo_sezioni(i,2)-2*catalogo_sezioni(i,3)); 
    
    % Calcolo del momento d'inerzia
    catalogo_sezioni(i,5) = (catalogo_sezioni(i,2)*catalogo_sezioni(i,1)^3 - ...
        (catalogo_sezioni(i,2)-2*catalogo_sezioni(i,3))*(catalogo_sezioni(i,1)-2*catalogo_sezioni(i,3))^3)/12;

    % Calcolo del modulo di resistenza a flessione
    catalogo_sezioni(i,6) = 2*catalogo_sezioni(i,5)/catalogo_sezioni(i,1);

end


clear spessore sezione lato_corto lato_lungo k1 k2 i
