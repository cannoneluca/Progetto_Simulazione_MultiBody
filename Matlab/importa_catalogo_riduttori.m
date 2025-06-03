% importa_catalogo_riduttori.m
clear catalogo_riduttori
% Crea una struttura contenente i modelli di riduttori da analizzare
% forniti durante il corso

% Le informazioni relative ai singoli modelli sono distribuite su 6 colonne:

% 1) Rapporto di trasmissione
% 2) Coppia massima all'albero lento [Nm]
% 3) Coppia media all'albero lento [Nm]
% 4) Velocità massima all'albero veloce [rpm]
% 5) Velocità nominale all'albero veloce [rpm]
% 6) Rendimento moto diretto[%]
% 7) Rendimento moto retrogrado [%]
% 7) Momento di inerzia all'albero veloce [kg*m^2]

i = [16 20 28 40 50 70 100]';

catalogo_riduttori(:,1) = [i;i;i;i;i];
catalogo_riduttori(:,2) = [35 35 35 35 38 31 34 75 79 75 79 75 79 64 240 248 240 248 240 220 204 460 432 460 432 460 420 400 1200 1200 1200 1200 1200 1100 900];
catalogo_riduttori(:,3) = [26 28 25 26 28 23 18 63 63 63 60 63 65 45 180 180 180 180 180 178 144 375 375 375 348 375 336 330 1100 1100 1100 1100 1100 1050 690];
catalogo_riduttori(:,4) = [ones(14,1)*6000; ones(21,1)*3000];
catalogo_riduttori(:,5) = [ones(6,1)*4000; 5000; ones(6,1)*3000; 3500; ones(6,1)*2500; 3000; ones(14,1)*3000;  ];
catalogo_riduttori(:,6) = ones(length(catalogo_riduttori(:,1)),1)*0.95;
catalogo_riduttori(:,7) = (2 - 1./catalogo_riduttori(:,6));
catalogo_riduttori(:,8) = [ones(6,1)*0.45; 0.46; 0.76; 0.76; 0.71; 0.7; 0.68; 0.68; 0.66; 1.89; 1.72; 1.71; 1.31*ones(4,1); 7.71; 7.23; 7.11; 5.7; 5.7; 5.3; 5.3; 11.31; 10.7; 10.4; 8.71; ones(3,1)*8.65]*1e-4;

clear i;