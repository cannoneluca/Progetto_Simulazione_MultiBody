% dimensionamento_motore.m

% Dimensionamento del motore a partire dai risultati dell'analisi cinematica e dinamica
% del cinematismo e dalla scelta del riduttore.

% navighiamo il catalogo in ordine di coppia crescente finché non troviamo il motore che soddisfi i requisiti necessari
% legati alla coppia e alla velocità


motore.OK = false; % Modifichiamo questo parametro quando il motore rispetta tutti i requisiti
motore.V = CB.fp/riduttore.tau; % Velocità angolare del motore

for k6 = 1:length(catalogo_motori)
    if(motore.OK == false)
        motore.OK = true; % Assumiamo che il motore soddisfi i requisiti
        motore.ID = catalogo_motori(k6,1);
        motore.Peak_Stall_Torque = catalogo_motori(k6,2); % [Nm]
        motore.Max_Speed_Torque = catalogo_motori(k6,3); % [Nm]
        motore.Cont_Stall_Torque = catalogo_motori(k6,4); % [Nm] 
        motore.Rated_Torque = catalogo_motori(k6,5); % [Nm]
        motore.Max_Torque_Speed = catalogo_motori(k6,6)*pi/30; % [rad/s]
        motore.Rated_Speed = catalogo_motori(k6,7)*pi/30; % [rad/s]
        motore.Max_Speed = catalogo_motori(k6,8)*pi/30; % [rad/s]
        motore.KT = catalogo_motori(k6,9); %[Nm/A]
        motore.Im = catalogo_motori(k6,10); % [Kg*m^2]
        motore.R = catalogo_motori(k6,11); % [Ohm]
        
        % ricalcoliamo la coppia richiesta al motore con l'inerzia del motore scelto
        motore.C = motore.C_a + motore.cv*CB.fp/riduttore.tau + (motore.Im + riduttore.Im)*CB.fpp./riduttore.tau^2 + ...
                riduttore.tau*riduttore.T2./riduttore.eta; % Coppia totale

        % vettore delle velocità con cui campionare le curve caratteristiche
        motore.omega = 0:round(motore.Max_Speed/simulation.safety);

        % calcoliamo la coppia continua ammessa dal motore per ogni velocità, considerando un fattore di sicurezza del 20%

        motore.coppia_continua = interp1([0 motore.Max_Speed/simulation.safety], ...
         [motore.Cont_Stall_Torque/simulation.safety ...
         (motore.Rated_Torque - (motore.Cont_Stall_Torque - motore.Rated_Torque)/(motore.Rated_Speed)*(motore.Max_Speed - motore.Rated_Speed))/simulation.safety], ...
         motore.omega);

        motore.coppia_picco = interp1([0 motore.Max_Torque_Speed/simulation.safety motore.Max_Speed/simulation.safety+1 motore.Max_Speed/simulation.safety+2 ], ... % 
        [motore.Peak_Stall_Torque/simulation.safety motore.Peak_Stall_Torque/simulation.safety motore.Max_Speed_Torque/simulation.safety 0], motore.omega); %motore.Max_Speed_Torque 0


        if(rms(motore.C) > motore.coppia_continua(round(abs(mean(motore.V)))+ 1*(round(abs(mean(motore.V))) == 0)))
            motore.OK = false;
        end

        if(round(mean(motore.V)) > motore.Rated_Speed)
            motore.OK = false;
        end

        if(max(abs(motore.V))>motore.Max_Speed)
            motore.OK = false;
        end

        for k7 = 1:length(motore.V)
            if(motore.C(k7) > motore.coppia_picco(round(motore.V(k7)+ 1*(round(abs(mean(motore.V))) == 0))));
                motore.OK = false;
            end
        end

    end
end
