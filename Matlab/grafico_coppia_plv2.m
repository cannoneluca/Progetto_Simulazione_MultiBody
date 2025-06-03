% grafico_coppia_plv.m

% Stampa a video l'andamento della coppia resistente
% e della coppia richiesta

figure(simulation.coppia_plv_id);
close(simulation.coppia_plv_id);
figure(simulation.coppia_plv_id);

plot(simulation.time,force.C);
hold on
plot(simulation.time,force.C2);
hold off

title("Risultati PLV");
xlabel("Tempo [s]");
ylabel("Coppia in C [N] [Nm]");

legend("Senza masse","Con masse");