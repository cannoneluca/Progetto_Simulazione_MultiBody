% vettore.m
% La funzione permette di calcolare la lunghezza e l'angolo di un vettore
% a partire dalle coordinate del punto iniziale e finale.

function [v,z,f] = vettore(p1,p2)
    % Calcolo della lunghezza del vettore
    z = sqrt((p2.x - p1.x)^2 + (p2.y - p1.y)^2);
    
    % Calcolo dell'angolo del vettore
    f = atan2(p2.y - p1.y, p2.x - p1.x);
    
    % Creazione della struttura del vettore
    v.z = z;
    v.f = f;
end