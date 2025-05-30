% pitagora.m
% La funzione permette di calcolare la lunghezza dell'ipotenusa di un triangolo rettangolo
% a partire dai suoi cateti.

% La funzione è utilizzabile anche per vettori di cateti, in tal caso viene restituito un vettore
% delle lunghezze delle ipotenuse.

% INPUT:
% y: cateto 1
% z: cateto 2

% OUTPUT:
% x: lunghezza dell'ipotenusa

function x = pitagora(y,z)
    x = sqrt(y.^2 + z.^2);
end