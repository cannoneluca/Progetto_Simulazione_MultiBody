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

%% Figura per l'animazione
figure(simulation.animation_fig_id);
title("Animazione del meccanismo");
axis equal;
axis([-0.4 1 -0.2 0.8]);
grid off;
hold on;
xlabel("x [m]");
ylabel("y [m]");

%% Creazione degli handler per l'animazione
h7 = line([E.x(1) F.x(1)], [E.y(1) F.y(1)], 'color', color.telaio, 'LineWidth', 2);
h8 = line([F.x(1) G.x(1)], [F.y(1) G.y(1)], 'color', color.telaio, 'LineWidth', 2);
h9 = line([G.x(1) C.x(1)], [G.y(1) C.y(1)], 'color', color.telaio, 'LineWidth', 2);
h2 = line([O.x(1) C.x(1)], [O.y(1) C.y(1)], 'color', color.telaio, 'LineWidth', 2);

h1 = line([A.x(1) O.x(1)], [A.y(1) O.y(1)], 'color', color.AO, 'LineWidth', 2);
h3 = line([C.x(1) B.x(1)], [C.y(1) B.y(1)], 'color', color.CB, 'LineWidth', 2);
h4 = line([B.x(1) A.x(1)], [B.y(1) A.y(1)], 'color', color.BA, 'LineWidth', 2);
h5 = line([A.x(1) D.x(1)], [A.y(1) D.y(1)], 'color', color.AD, 'LineWidth', 2);
h6 = line([D.x(1) E.x(1)], [D.y(1) E.y(1)], 'color', color.DE, 'LineWidth', 2);
h10 = line([E.x(1) E.x(1)], [E.y(1) + 0.05 E.y(1) - 0.05], 'color', color.DE, 'LineWidth', 2);
h11 = rectangle('Position',[pacco.x(1) pacco.y pacco.side pacco.side], 'FaceColor', color.pacco, 'EdgeColor', color.pacco, 'LineWidth', 2);

%% Animazione

movie = moviein(simulation.samples);
for k2 = 1:simulation.samples
    % Aggiorna le posizioni dei punti
    set(h2, 'XData', [O.x C.x], 'YData', [O.y C.y]);
    set(h8, 'XData', [F.x G.x], 'YData', [F.y G.y]);
    set(h9, 'XData', [G.x C.x], 'YData', [G.y C.y]);
    set(h1, 'XData', [A.x(k2) O.x], 'YData', [A.y(k2) O.y]);
    set(h3, 'XData', [C.x B.x(k2)], 'YData', [C.y B.y(k2)]);
    set(h7, 'XData', [E.x(k2) F.x], 'YData', [E.y(k2) F.y]);
    set(h6, 'XData', [D.x(k2) E.x(k2)], 'YData', [D.y(k2) E.y(k2)]);
    set(h4, 'XData', [B.x(k2) A.x(k2)], 'YData', [B.y(k2) A.y(k2)]);
    set(h5, 'XData', [A.x(k2) D.x(k2)], 'YData', [A.y(k2) D.y(k2)]);
    set(h10, 'XData', [E.x(k2) E.x(k2)], 'YData', [E.y(k2) + 0.05 E.y(k2) - 0.05]);
    set(h11, 'Position', [pacco.x(k2) pacco.y pacco.side pacco.side]);
    % Aggiorna la figura
    drawnow;
    
    % Salva il frame per il filmato
    movie(:, k2) = getframe(simulation.animation_fig_id);
end

clear h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11;