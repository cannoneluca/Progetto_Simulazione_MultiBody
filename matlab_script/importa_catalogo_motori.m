% importa_catalogo_motori.m

% Importa il catalogo motori contenuto nel file motori.csv

catalogo_motori = importdata('../media/motori.csv', ';').data;
catalogo_motori(:,9) = catalogo_motori(:,9)*1e-4;

% Segue descrizione dei campi che compongono la tabella ottenuta:
% 1) Coppia di stallo di picco [Nm]: 
%   la coppia massima che il motore può esercitare da fermo per un periodo di tempo limitato
% 2) Coppia alla massima velocità [Nm]: 
%   la coppia che il motore può esercitare alla massima velocità
% 3) Coppia di stallo continua [Nm]:
%   la coppia che il motore può esercitare da fermo per un periodo di tempo indefinito
% 4) Coppia nominale [Nm]:
%   la coppia che il motore può esercitare alla velocità nominale per un periodo di tempo indefinito
% 5) Velocità massima per coppia massima [rpm]:
%   la velocità massima alla quale il motore può esercitare la coppia di stallo di picco
% 6) Velocità nominale [rpm]:
%   la velocità alla quale il motore può esercitare la coppia nominale
% 7) Velocità massima [rpm]:
%   la velocità massima che il motore può raggiungere
% 8) COstante di coppia [Nm/A]:
%   la coppia che il motore può esercitare per ogni Ampere di corrente assorbita
% 9) Inerzia [kg*m^2]:
%   l'inerzia del rotore del motore, che influenza la risposta dinamica del motore stesso
% 10) Resistenza [Ohm]:
%   la resistenza elettrica del motore, che influisce sulla corrente assorbita
