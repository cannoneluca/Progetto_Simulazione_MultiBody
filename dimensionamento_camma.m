% dimensionamento_camma.m

% Dimensionamento di una camma che permette il moto del pattino E garantito dal
% cinematismo articolato

% Per prima cosa si importa i vettori della cinematica del pattino:
% posizione, velocità e accelerazione

camma.x = E.x - min(E.x);
camma.alfa = (0:2*pi/length(camma.x):2*pi*(length(camma.x)-1)/length(camma.x))';
camma.xp = deriv3(camma.x,simulation.time);
camma.xpp = deriv3(camma.xp, simulation.time);

camma.theta_max_S = pi/6; 
camma.theta_min_D = -pi/4;
camma.Rr = 0.10; % [m] raggio della rotella

camma.Rb = max(camma.xp./(tan(camma.theta_max_S.*(camma.xp > 0) + camma.theta_min_D.*(camma.xp < 0))) - camma.x)*simulation.safety; % [m] raggio della camma
camma.Rb = ceil(camma.Rb/simulation.prec)*simulation.prec; % [m] raggio base della camma

camma.theta = camma.xp./(camma.Rb + camma.x);
camma.r = camma.Rb + camma.x;

% Calcolo della posizione effettiva della rotella sotto forma di coordinate polari
camma.op = sqrt(camma.Rr^2 + camma.r.^2 - 2*camma.Rr.*camma.r.*cos(camma.theta));
camma.fi = camma.alfa + asin(camma.Rr./camma.op).*sin(camma.theta);

% Calcolo la curvatura locale della camma
camma.rho = (camma.xp.^2 + camma.r.^2).^(3/2)./(camma.xp.^2.*(1 - camma.xpp) + 2*camma.xp.^2);
camma.rho = camma.rho - camma.Rr;
