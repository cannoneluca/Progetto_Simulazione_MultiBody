% Script per la visualizzazione dell'errore della funzione
% fsolve usata per la risoluzione delle configurazioni cinematiche

figure(simulation.error_fig_id);
plot(simulation.time,simulation.error(1,:));
hold on;
plot(simulation.time,simulation.error(2,:));
plot(simulation.time,simulation.error(3,:));
plot(simulation.time,simulation.error(4,:));

xlabel('Tempo [s]');
ylabel('Errore [m]');
title('Errore di chiusura"');
grid on;
legend('Errore 1','Errore 2','Errore 3','Errore 4');
