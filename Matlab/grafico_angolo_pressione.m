figure(simulation.pressure_angle_id);
title("Angolo di pressione della camma");
plot(camma.alfa, camma.theta);
line([0 camma.alfa(end)],[camma.theta_max_S camma.theta_max_S]);
line([0 camma.alfa(end)],[camma.theta_min_D camma.theta_min_D]);
xlabel("Angolo della camma [rad]");
ylabel("Angolo di pressione [rad]");
xlim([0 camma.alfa(end)]);

legend("Angolo di pressione", "Limite in fase di salita", "Limite in fase di discesa");