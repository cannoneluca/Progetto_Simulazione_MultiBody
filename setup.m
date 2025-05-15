% setup.m

% Il file permette di configurare l'ambiente di lavoro per il progetto

%% Pulizia dell'ambiente di lavoro

clearvars; % Elimina le variabili presenti nel workspace
close all % Chiude tutte le figure aperte
clc % Pulisce la finestra dei comandi

%% Impostaziooni della simulazione

% In questo caso si sceglie di simulare il meccanismo solo per un giro di manovella
% dato che questa si muove di moto circolare uniforme

simulation.omega  = 1;      % [rad/s]   Velocità angolare della manovella
simulation.samples = 1000;  % [adim.]   Campioni per un giro di manovella
simulation.g = 9.81;        % [m/s^2]   Accelerazione di gravità
simulation.f_cou = 0.01;    % [adim.]   Coefficiente di attrito radente tra pacco e telaio
simulation.p = 0.25;        % [adim.]   Frazione della corsa totale percorsa a vuoto (senza scatola)
simulation.H = 0.5;         % [m]       Corsa del pattino desiderata
simulation.prec = 0.01;      % [m] Precisione con cui eseguire dimensionamenti
simulation.safety = 1.2;

% Vettore degli istanti campionati
simulation.time = ...
(0 : 2*pi/simulation.omega/simulation.samples : 2*pi*(simulation.samples - 1)/simulation.omega/simulation.samples)';

%% Dati della traccia

O.x = 0.00;  O.y = 0.00; % Coordinate del punto O
A.x =-0.10;  A.y = 0.20; % Coordinate del punto A
B.x = 0.20;  B.y = 0.15; % Coordinate del punto B
C.x = 0.20;  C.y = 0.10; % Coordinate del punto C
D.x = 0.00;  D.y = 0.60; % Coordinate del punto D
E.x = 0.40;  E.y = 0.40; % Coordinate del punto E

pacco.m = 1;       % [kg]      Massa del pacco
pacco.side = 0.20;  % [m]      Lato del pacco
% Si sceglie arbitrariamente la posizione dei punti F e G

F.x = 0.70;  F.y = 0.40; % Coordinate del punto F
G.x = 0.70;  G.y = 0.10; % Coordinate del punto G

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
CB.fp =deriv3(CB.f, simulation.time); % Velocità angolare della manovella
% Si aumenta l'inclinazione della manovella per cominciare l'animazione con la semicorsa positiva
CB.f = CB.f + pi;

%% Utilità

simulation.fsolve_options = optimset('Display','off'); % Opzioni per il solver dei sistemi lineari
simulation.animation_fig_id = 1; % ID della figura per l'animazione
simulation.motor_plot_id = 100; % ID della figura che ospita la curva caratteristica del motore
% Ad ogni motore corrispinde un ID diverso, sommando a 100 l'ID del motore

color.CB = "#EDB120"; % Colore del membro CB
color.BA = "#4DBEEE"; % Colore del membro BA
color.AO = "#A2142F"; % Colore del membro AO
color.AD = "#A2142F"; % Colore del membro AD
color.DE = "#0072BD"; % Colore del membro DE
color.telaio = "#FFFFFF"; % Colore del telaio
color.pacco = "#7E2F8E"; % Colore del pacco

% si considera per il dimensionamento dei singoli membri un singoo materiale,
% in questo caso del comune acciaio.
% Si è scelto l'acciaio C45 perché si presta alle applicazioni in cuui i componenti sono chiamati
% a subire carichi di tipo dimamico, laddove sia richiesta robustezza e flessibilità

material.name = "Acciao al carbonio C45";
material.E = 210e9;   % [GPa] Modulo di Young
material.rho = 7870; % [kg/m^3] Densità
material.sigma = 300e6; % [MPa] Resistenza allo snervamento

% Impostiamo i parametri che simulino la presenza di un motore quando ancora non sarà determinato

motore.Im = 0.005; % [Kg*m^2] Momento di inerzia del motore (prova)
motore.cv = 0.0005; % [Kg*m^2/s] Coefficiente di attrito viscoso
motore.ca = 0.2; % [Nm] % Coppia di attrito intrinseca del motore
% Coppia di attrito intrinseca del motore, sempre opposta alla rotazione
motore.C_a = ((CB.fp > 0) - (CB.fp <= 0))*motore.ca;




