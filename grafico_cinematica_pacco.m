% grafico_cinematica_pacco.m

% Stampa posizione, velocità e accelerazione del pacco
% in funzione del tempo

figure(simulation.pacco_fig_id);

subplot(3,1,1);
plot(simulation.time, pacco.x, 'color', color.pacco, 'LineWidth', 2);
title("Posizione del pacco");
xlabel("Tempo [s]");
ylabel("Posizione [m]");
grid on;

subplot(3,1,2);
plot(simulation.time, pacco.xp, 'color', color.pacco, 'LineWidth', 2);
title("Velocità del pacco");
xlabel("Tempo [s]");
ylabel("Velocità [m/s]");
grid on;

subplot(3,1,3);
plot(simulation.time, pacco.xpp, 'color', color.pacco, 'LineWidth', 2);
title("Accelerazione del pacco");
xlabel("Tempo [s]");
ylabel("Accelerazione [m/s^2]");
grid on;
