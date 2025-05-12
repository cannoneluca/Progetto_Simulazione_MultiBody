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

