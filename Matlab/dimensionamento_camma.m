% dimensionamento_camma.m

%% Dimensionamento
% Dimensionamento di una camma che permette il moto del pattino E garantito dal
% cinematismo articolato

% Per prima cosa si importa i vettori della cinematica del pattino:
% posizione, velocità e accelerazione

camma.x = E.x - min(E.x);
camma.alfa = (0:2*pi/length(camma.x):2*pi*(length(camma.x)-1)/length(camma.x))';
camma.xp = deriv3(camma.x,simulation.time);
camma.xpp = deriv3(camma.xp, simulation.time);

camma.theta_max_S = pi/6;   % Angolo di pressione ammesso nella fase di salita
camma.theta_min_D = -pi/2;  % Angolo di pressione ammesso nella fase di discesa
% Limite meno stringente dato che in discesa non sono applicate forze alla
% punteria
camma.Rr = 0.1; % [m] raggio della rotella

% Calcolo del raggio di base minimo richiesto per limitare l'angolo di
% pressione
camma.Rb = max(camma.xp./(tan(camma.theta_max_S.*(camma.xp > 0) + camma.theta_min_D.*(camma.xp < 0))) - camma.x)*simulation.safety; % [m] raggio della camma

% Determiniamo il raggio base scegliendo il massimo valore di quelli
% ottenuti. Il risultato è arrotondato alla precisione scelta per la
% simulazione
camma.Rb = ceil(camma.Rb/simulation.prec)*simulation.prec; % [m] raggio base della camma

% Calcolo angolo di pressione per verifica
camma.theta = camma.xp./(camma.Rb + camma.x);
camma.r = camma.Rb + camma.x;

% Calcolo della posizione effettiva della rotella sotto forma di coordinate polari
% Il calcolo tiene in considerazioni il raggio della rotella, fin'ora
% considerato nullo
camma.op = sqrt(camma.Rr^2 + camma.r.^2 - 2*camma.Rr.*camma.r.*cos(camma.theta));
camma.fi = camma.alfa + asin(camma.Rr./camma.op).*sin(camma.theta);

% Calcolo la curvatura locale della camma
camma.rho = (camma.xp.^2 + camma.r.^2).^(3/2)./(camma.xp.^2.*(1 - camma.xpp) + 2*camma.xp.^2);
camma.rho = camma.rho - camma.Rr;

%% Esportazione del risultato
export = fopen("../media/camma.csv",'wt');

fprintf(export, '%4.3f,\t %6.4f\n', [0 0]');
fprintf(export, '%4.3f,\t %6.4f\n', [simulation.time  (camma.r-camma.Rb)]');
fprintf(export, '%4.3f,\t %6.4f\n', [0 0]');

fclose(export);
clear export ans
%% Stampa dei risultati
figure(simulation.camma_fig_id);
polarplot(camma.alfa,camma.r);
hold on;
polarplot(camma.fi,camma.op);
title("Profilo della camma");
legend("traiettoria della rotella","profilo effettivo");

%% Calcoli di analisi

% Calcolo della massa della camma considerando lo spessore pari alla metà
% della larghezza del pacco
camma.m = (mean(camma.r))^2*pi*pacco.side*material.rho/2;
% Calcolo dell'inerzia
camma.J = 0.5*camma.m*mean(camma.r);
