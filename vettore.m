% vettore.m
% La funzione permette di calcolare la lunghezza e l'angolo di un vettore
% a partire dalle coordinate del punto iniziale e finale.

% INPUT:
% p1: punto iniziale del vettore
% p2: punto finale del vettore

% OUTPUT:
% v: struttura che contiene la lunghezza e l'angolo del vettore
% v.z: lunghezza del vettore
% v.f: angolo del vettore in radianti

function v = vettore(p1,p2)
    % Calcolo della lunghezza del vettore
    v.z = sqrt((p2.x - p1.x)^2 + (p2.y - p1.y)^2);
    
    % Calcolo dell'angolo del vettore
    v.f = atan2(p2.y - p1.y, p2.x - p1.x);
end