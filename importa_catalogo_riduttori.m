% importa_catalogo_riduttori.m

% Creea una struttura contenente i modelli di riduttori da analizzare
% forniti durante il corso

% Le informazioni relative ai singoli modelli sono distribuite su 6 colonne:

% 1) Rapporto di trasmissione
% 2) Coppia massima all'albero lento [Nm]
% 3) Coppia media all'albero lento [Nm]
% 4) Velocità massima all'albero veloce [rpm]
% 5) Velocità nominale all'albero veloce [rpm]
% 6) Rendimento [%]
% 7) Momento di inerzia all'albero veloce [kg*m^2]

i = [4 5 7 10]';

catalogo_riduttori(:,1) = [i;i;i;i;i];
catalogo_riduttori(:,2) = [35 38 31 34 79 75 79 60 248 240 220 204 432 460 420 400 1200 1200 1100 900];
catalogo_riduttori(:,3) = [26 30 23 18 60 63 65 45 180 180 178 144 348 375 336 330 1100 1100 1050 690];
% catalogo_riduttori(:,4) = [90 90 90 85 190 190 190 150 575 575 575 500 1050 1125 1050 1050 2750 2750 2750 2250];
catalogo_riduttori(:,4) = [ones(8,1)*6000; ones(12,1)*3000];
catalogo_riduttori(:,5) = [3500 3500 4000 4000 2500 2500 3000 3000 2000 2000 2500 2500 2000 2000 2500 2500 1500 1500 2000 2000];
catalogo_riduttori(:,6) = ones(20,1)*0.97;
catalogo_riduttori(:,7) = [0.41 0.38 0.37 0.36 0.84 0.77 0.71 0.69 3.55 3.21 2.94 2.75 8.51 7.31 6.33 5.71 29.11 22.31 17.52 14.32]*1e-4;
