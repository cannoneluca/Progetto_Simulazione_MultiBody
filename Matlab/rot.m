% rot.m

% la funzione rot.m permette di determinare la matrice di rotazione associata
% all'angolo di rotazione fornito come input

% INPUT:
%   alfa: angolo di rotazione antioraria in radianti
% OUTPUT:
%   A: matrice di rotazione associata ad alfa

function A = rot(alfa)
    A = [cos(alfa) sin(alfa); (-sin(alfa)) cos(alfa)];
end

