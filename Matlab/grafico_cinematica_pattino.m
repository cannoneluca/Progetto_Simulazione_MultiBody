% grafico_cinematica_pattino.m

% Stampa posizione, velocità e accelerazione del pattino E
% in funzione del tempo

figure(simulation.pattino_fig_id);

subplot(3,1,1);
plot(simulation.time, E.x - E.PMI, 'color', color.DE, 'LineWidth', 2);
hold on;
plot(simulation.time, simulation.H*ones(length(simulation.time)));
title("Posizione del pattino");
xlabel("Tempo [s]");
ylabel("Posizione [m]");
axis([0 simulation.time(end) 0 1.1*simulation.H ]);
grid on;
legend("","Corsa richiesta");
hold off;

subplot(3,1,2);
plot(simulation.time, E.xp, 'color', color.DE, 'LineWidth', 2);
title("Velocità del pattino");
xlabel("Tempo [s]");
ylabel("Velocità [m/s]");
grid on;

subplot(3,1,3);
plot(simulation.time, E.xpp, 'color', color.DE, 'LineWidth', 2);
title("Accelerazione del pattino");
xlabel("Tempo [s]");
ylabel("Accelerazione [m/s^2]");
grid on;
