% Per il progetto si è scelto di considerare, per la realizzazione dei singoli
% membri l'utilizzo di profilati scatolati in acciao, largamente in uso.

% Il catalogo è composto da 5 colonne:
% 1) Lato       [m]     Lunghezza del lato
% 2) Spessore   [m]     Spessore della parete
% 3) Area       [m^2]   Area della sezione
% 4) Inerzia    [m^4]   Momento di inerzia principale della sezione
% 5) Wf         [m^4]   Momento di resistenza a flessione

spessore = [0.002 0.003 0.004];
lato = 0.03:0.01:0.10;

catalogo_sezioni(length(lato)*length(spessore), 5) = 0;

for k1 = 0:1:length(lato)-1
    for k2 = 0:1:length(spessore)-1
        i = k1*length(spessore) + k2 + 1;
        catalogo_sezioni(i,1) = lato(k1+1);
        catalogo_sezioni(i,2) = spessore(k2+1);
        catalogo_sezioni(i,3) = 4*lato(k1+1)*spessore(k2+1) - 4*spessore(k2+1)^2;
        catalogo_sezioni(i,4) = (lato(k1+1)^4 - (lato(k1+1)-2*spessore(k2+1))^4)/12;
        catalogo_sezioni(i,5) = (lato(k1+1)^4 - (lato(k1+1)-2*spessore(k2+1))^4)/(6*lato(k1+1));
    end
    clear k2
end


clear spessore lato k1