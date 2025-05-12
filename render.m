% render.m

% Prima di eseguire il file bisogna eseguire il file analisi_cinematica.m
% per generare i dati di input per il rendering

%% Calcolo della posizione dei punti
% La posizione dei punti è calcolata in funzione delle lunghezze dei membri
% e degli angoli di inclinazione dei membri

A.x = -AO.z.*cos(AO.f);
A.y = -AO.z.*sin(AO.f);

B.x = C.x + CB.z*cos(CB.f);
B.y = C.y + CB.z*sin(CB.f);

D.x = A.x + AD.z*cos(AD.f);
D.y = A.y + AD.z*sin(AD.f);

E.x = D.x + DE.z*cos(DE.f);
E.y = D.y + DE.z*sin(DE.f);

%% Creazione degli handler per l'animazione
h1 = line([A.x(1) O.x(1)], [A.y(1) O.y(1)], 'color', 'k', 'LineWidth', 2);
h2 = line([O.x(1) C.x(1)], [O.y(1) C.y(1)], 'color', 'k', 'LineWidth', 2);
h3 = line([C.x(1) B.x(1)], [C.y(1) B.y(1)], 'color', 'k', 'LineWidth', 2);
h4 = line([B.x(1) A.x(1)], [B.y(1) A.y(1)], 'color', 'k', 'LineWidth', 2);
h5 = line([A.x(1) D.x(1)], [A.y(1) D.y(1)], 'color', 'k', 'LineWidth', 2);
h6 = line([D.x(1) E.x(1)], [D.y(1) E.y(1)], 'color', 'k', 'LineWidth', 2);
h7 = line([E.x(1) F.x(1)], [E.y(1) F.y(1)], 'color', 'k', 'LineWidth', 2);
h8 = line([F.x(1) G.x(1)], [F.y(1) G.y(1)], 'color', 'k', 'LineWidth', 2);
h9 = line([G.x(1) C.x(1)], [G.y(1) C.y(1)], 'color', 'k', 'LineWidth', 2);




