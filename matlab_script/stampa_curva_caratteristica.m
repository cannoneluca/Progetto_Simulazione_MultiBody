% stampa_curva_caratteristica.m

% Funzione che permette di stampare a video
% la curva caratteristica di un determinato motore, fornendo in ingresso l'indice
% a catalogo del motore di interesse

% Stampa la curva caratteristica del motore di indice 'indice'
% a catalogo, fornendo in ingresso l'indice a catalogo del motore di interesse
% e il catalogo dei motori

figure(simulation.motor_plot_id + motore.ID);

peak_torque = line([0 catalogo_motori(motore.ID, 6) catalogo_motori(motore.ID, 8) catalogo_motori(motore.ID, 8)], ...
    [catalogo_motori(motore.ID, 2) catalogo_motori(motore.ID, 2) catalogo_motori(motore.ID, 3) 0]);
set(peak_torque, 'Color', 'r', 'LineWidth', 2);
rated_torque = line([0 catalogo_motori(motore.ID, 7)], [catalogo_motori(motore.ID, 4) catalogo_motori(motore.ID, 5)]);
set(rated_torque, 'Color', 'b', 'LineWidth', 2);

hold on
plot(motore.V, motore.C)
plot(mean(motore.V),rms(motore.C),'d')
xlabel("Velocità [rpm]");
ylabel("Coppia [Nm]");

legend("Limite coppia massima","Limite coppia media","Curva di lavoro","Punto di lavoro");