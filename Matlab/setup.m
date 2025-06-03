% setup.m

% Il file permette di configurare l'ambiente di lavoro per il progetto

%% Pulizia dell'ambiente di lavoro

clearvars; % Elimina le variabili presenti nel workspace
close all % Chiude tutte le figure aperte
clc % Pulisce la finestra dei comandi

%% Impostaziooni della simulazione

% In questo caso si sceglie di simulare il meccanismo solo per un giro di manovella
% dato che questa si muove di moto circolare uniforme

simulation.omega  = 70/30*pi;      % [rad/s]   Velocità angolare della manovella
simulation.samples = 100;   % [adim.]   Campioni per un giro di manovella
simulation.g = 9.81;        % [m/s^2]   Accelerazione di gravità
simulation.f_cou = 0.01;    % [adim.]   Coefficiente di attrito radente tra pacco e telaio
simulation.p = 0.07;        % [adim.]   Frazione della corsa totale percorsa a vuoto (senza scatola)
simulation.H = 0.55;         % [m]       Corsa del pattino desiderata
simulation.prec = 0.001;    % [m]       Precisione con cui eseguire dimensionamenti
simulation.safety = 1.2;    % [adim]    COefficiente di sicurezza utilizzato nei dimensionamenti

% Vettore degli istanti campionati
simulation.time = ...
(0 : 2*pi/simulation.omega/simulation.samples : 2*pi*(simulation.samples - 1)/simulation.omega/simulation.samples)';

%% Dati della traccia

O.x = 0.00;  O.y = 0.00; % Coordinate del punto O
A.x =-0.10;  A.y = 0.20; % Coordinate del punto A
B.x = 0.20;  B.y = 0.15; % Coordinate del punto B
C.x = 0.20;  C.y = 0.10; % Coordinate del punto C
D.x = 0.00;  D.y = 0.60; % Coordinate del punto D
E.x = 0.3464;  E.y = 0.40; % Coordinate del punto E

pacco.m = 20;       % [kg]      Massa del pacco
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
% J_x:  è il momento d'inerzia rispetto al centro


% I membri sono inizializzati tutti alla posizione che hanno nella traccia
% Le lunghezze sono in seguito arrotondate alla precisione impostata

AO = vettore(A,O); % Vettore AO: bilanciere
AO.z = round(AO.z/simulation.prec)*simulation.prec; % Lunghezza del membro AO
OC = vettore(O,C); % Vettore OC: telaio
CB = vettore(C,B); % Vettore CB: manovella
CB.z = round(CB.z/simulation.prec)*simulation.prec; % Lunghezza del membro CB
BA = vettore(B,A); % Vettore BA: biella
BA.z = round(BA.z/simulation.prec)*simulation.prec; % Lunghezza del membro BA
AD = vettore(A,D); % Vettore AD: bilanciere
AD.z = round(AD.z/simulation.prec)*simulation.prec; % Lunghezza del membro AD
OAD = vettore(O,D); % Vettore OAD: bilanciere
OAD.z = round(OAD.z/simulation.prec)*simulation.prec; % Lunghezza del membro OAD
DE = vettore(D,E); % Vettore DE: biella
DE.z = round(DE.z/simulation.prec)*simulation.prec; % Lunghezza del membro DE
EF = vettore(E,F); % Vettore EF: telaio
EF.z = round(EF.z/simulation.prec)*simulation.prec; % Lunghezza del membro EF
FG = vettore(F,G); % Vettore FG: telaio
FG.z = round(FG.z/simulation.prec)*simulation.prec; % Lunghezza del membro FG
GC = vettore(G,C); % Vettore GC: telaio
GC.z = round(GC.z/simulation.prec)*simulation.prec; % Lunghezza del membro GC

% Si calcola il vettore della fase della manovella per ogni istante di campionamento
CB.f = simulation.time*simulation.omega; % Velocità angolare della manovella
CB.fp =deriv3(CB.f, simulation.time); % Velocità angolare della manovella
% Si aumenta l'inclinazione della manovella per cominciare l'animazione con la semicorsa positiva
CB.f = CB.f + pi;

%% Utilità

simulation.fsolve_options = optimset('Display','off'); % Opzioni per il solver dei sistemi lineari
simulation.animation_fig_id = 1; % ID della figura per l'animazione
simulation.pacco_fig_id = 2; % ID della figura per la cinematica del pacco
simulation.coppia_plv_id = 3;
simulation.pattino_fig_id = 4; % ID della figura per la cinematica del pattno
simulation.camma_fig_id = 5; % ID della figura della camma
simulation.pressure_angle_id = 6; % ID della figura dell'angolo di pressione della camma
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
material.sigma = 660e6; % [MPa] Resistenza allo snervamento

% Impostiamo i parametri che simulino la presenza di un motore quando ancora non sarà determinato

motore.Im = 0.005; % [Kg*m^2] Momento di inerzia del motore (prova)
motore.cv = 0.0005; % [Kg*m^2/s] Coefficiente di attrito viscoso
motore.ca = 0.2; % [Nm] % Coppia di attrito intrinseca del motore
% Coppia di attrito intrinseca del motore, sempre opposta alla rotazione
motore.C_a = ((CB.fp > 0) - (CB.fp <= 0))*motore.ca;

% Attribuisco una massa al punto E che rappresena la massa del manipolatore
% che vi è attaccato

E.m = 1; % [Kg] Massa del manipolatore



