% setup.m

% Il file permette di configurare l'ambiente di lavoro per il progetto

%% Pulizia dell'ambiente di lavoro

clear workspace % Elimina le variabili presenti nel workspace
close all % Chiude tutte le figure aperte
clc % Pulisce la finestra dei comandi

%% Impostaziooni della simulazione

% In questo caso si sceglie di simulare il meccanismo solo per un giro di manovella
% dato che questa si muove di moto circolare uniforme

simulation.omega  = 1;      % [rad/s]   Velocità angolare della manovella
simulation.samples = 100;   % [adim.]   Campioni per un giro di manovella
simulation.M = 1;           % [kg]      Massa del pacco
simulation.g = 9.81;        % [m/s^2]   Accelerazione di gravità
simulation.f_cou = 0.01;    % [adim.]   Coefficiente di attrito radente tra pacco e telaio
simulation.p = 0.25;        % [adim.]   Frazione della corsa totale percorsa a vuoto (senza scatola)

% Vettore degli istanti campionati
simulation.time = ...
0 : 2*pi/simulation.omega/simulation.samples : 2*pi*(simulation.samples - 1)/simulation.omega/simulation.samples;


%% Dati della traccia

O.x = 0.00;  O.y = 0.00; % Coordinate del punto O
A.x =-0.10;  A.y = 0.20; % Coordinate del punto A
B.x = 0.20;  B.y = 0.15; % Coordinate del punto B
C.x = 0.20;  C.y = 0.10; % Coordinate del punto C
D.x = 0.40;  D.y = 0.60; % Coordinate del punto D
E.x = 0.40;  E.y = 0.40; % Coordinate del punto E

% Si sceglie arbitrariamente la posizione dei punti F e G

F.x = 1.00;  F.y = 0.40; % Coordinate del punto F
G.x = 1.00;  G.y = 0.00; % Coordinate del punto G


%% Inizializzazione variabili dei membri

% Ogni vettore ha delle proprietà:
% z:    è la sua lunghezza, qualora fosse costante il campo è un valore, se fosse variabile il campo è un vettore
% f:    è l'inclinazione rispetto all'asse x, qualora fosse costante il campo è un valore, se fosse variabile il campo è un vettore
% zp:   presente se il vettore ha lunghezza variabile, è la velocità con cui varia tale dimensione
% fp:   presente se il vettore ha fase variabile, è la velocità angolare con cui varia tale dimensione
% zpp:  presente se il vettore ha lunghezza variabile, è l'accelerazione con cui varia tale dimensione
% fpp:  presente se il vettore ha fase variabile, è l'accelerazione con cui varia tale dimensione
% m:    è la massa del membro, qualora questo non sia considerato privo di massa
% J:    è il momento d'inerzia rispetto al centro di massa del membro, qualora questo non sia considerato puntiforme

% I membri sono inizializzati tutti alla posizione che hanno nella traccia, così da facilitare l'analisi cinematica

AO = vettore(A,O); % Vettore AO: bilanciere
OC = vettore(O,C); % Vettore OC: telaio
CB = vettore(C,B); % Vettore CB: manovella
BA = vettore(B,A); % Vettore BA: biella
AD = vettore(A,D); % Vettore AD: bilanciere
DE = vettore(D,E); % Vettore DE: biella
EF = vettore(E,F); % Vettore EF: telaio
FG = vettore(F,G); % Vettore FG: telaio
GC = vettore(G,C); % Vettore GC: telaio

% Si calcola il vettore della fase della manovella per ogni istante di campionamento
CB.f = simulation.time*simulation.omega; % Velocità angolare della manovella









