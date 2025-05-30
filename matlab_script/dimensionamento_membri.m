% Per il dimensionamento dei membri che compongono il cinematismo si sceglie 
% di fare riferimento alla configurazione più gravosa.

% Osservando i dati si evince che questa corrisponde al momento in cui è massima l'accelerazione
% del pacco.

% Risulta quindi utile calcolare, membro per membro, le forze che vi
% agiscono in questo istante.
% Per semplicità risulta ragionveole trascurare le componenti delle forze che agiscono
% assialmente rispetto al membro in analisi, per focalizzare il dimensionamento sulle 
% forze normali, causa del momento flettente.
% Otttenuto il carico che agisce su ciascun membro si procede al loro dimensionamento
% assumendo il materiale salvato nel workspace in fase di setup uguale in tutti i membri

% Si calcola quindi il carico agente su ciascun membro
% le forze normali sono salvate nella struttura del membro, con il nome del
% punto su cui agiscono. Si calcola l'andamento del momento flettente Mf, e
% si ricava la sezione designata. 

% Il dimensionamento è svolto considerando il carico di tipo statico,
% trascurando quindi i carichi distribuiti e le inerzie del sistema

% La sezione viene scelta da una tabella, ricavata da un catalogo delle
% scatolati in acciaio

%% Scomposizione delle forze
% Calcolo delle componenti normali e parallele a ciascun membro delle reazioni vincolari scambiate

for k7 = 1:simulation.samples
    y(1,1) = force.F_Cx(k7);
    y(2,1) = force.F_Cy(k7);
    x = rot(CB.f(k7))*y;
    CB.F_Cx(k7) = x(1);
    CB.F_Cy(k7) = x(2);

    y(1,1) = force.F_Bx(k7);
    y(2,1) = force.F_By(k7);
    x = rot(CB.f(k7))*y;
    CB.F_Bx(k7) = x(1);
    CB.F_By(k7) = x(2);

    y(1,1) = -force.F_Bx(k7);
    y(2,1) = -force.F_By(k7);
    x = rot(BA.f(k7))*y;
    BA.F_Bx(k7) = x(1);
    BA.F_By(k7) = x(2);

    y(1,1) = -force.F_Ax(k7);
    y(2,1) = -force.F_Ay(k7);
    x = rot(BA.f(k7))*y;
    BA.F_Ax(k7) = x(1);
    BA.F_Ay(k7) = x(2);

    y(1,1) = -force.F_Ox(k7);
    y(2,1) = -force.F_Oy(k7);
    x = rot(AO.f(k7))*y;
    AO.F_Ox(k7) = x(1);
    AO.F_Oy(k7) = x(2);

    y(1,1) = -force.F_Ax(k7);
    y(2,1) = -force.F_Ay(k7);
    x = rot(AO.f(k7))*y;
    AO.F_Ax(k7) = x(1);
    AO.F_Ay(k7) = x(2);

    y(1,1) = -force.F_Ax(k7);
    y(2,1) = -force.F_Ay(k7);
    x = rot(AD.f(k7))*y;
    AD.F_Ax(k7) = x(1);
    AD.F_Ay(k7) = x(2);

    y(1,1) = -force.F_Dx(k7);
    y(2,1) = -force.F_Dy(k7);
    x = rot(AD.f(k7))*y;
    AD.F_Dx(k7) = x(1);
    AD.F_Dy(k7) = x(2);

    y(1,1) = -force.F_Dx(k7);
    y(2,1) = -force.F_Dy(k7);
    x = rot(DE.f(k7))*y;
    DE.F_Dx(k7) = x(1);
    DE.F_Dy(k7) = x(2);

    y(1,1) = -force.Fr(k7);
    y(2,1) = force.F_Ey(k7);
    x = rot(DE.f(k7))*y;
    DE.F_Ex(k7) = x(1);
    DE.F_Ey(k7) = x(2);
end

%% Dimensionamento del membro CB:
% Discretizziamo l membro CB in n punti, distanti l'uno dall'altro
% la precisione di simulazione. Si valuterà il momento flettente per ciascuno
% di questi punti

CB.Wf = max(abs(force.C)/material.sigma*simulation.safety);

% Si inserisce il termine di "(catalogo_sezioni(:,6) < CB.Wf)" così da
% scegliere esclusivamente le sezione con modulo di resistenza a flessione
% maggiore di quello richiesto
[~, index] = min(abs(catalogo_sezioni(:,6) + (catalogo_sezioni(:,6) < CB.Wf) - CB.Wf) + 1*(catalogo_sezioni(:,6) < CB.Wf));

CB.area         = catalogo_sezioni(index,4);    % [m^2] Area della sezione
CB.Wf           = catalogo_sezioni(index,6);    % [m^3] Modulo di resistenza a flessione

if((max(abs(CB.F_Bx)./CB.area) + max(abs(force.C)./CB.Wf))*simulation.safety > material.sigma)
    index = index + 2;
end

% Si demanda al calcolo manuale la verifica della sezione al carico
% combinato dovuto alla presenza di un carico assiale in concomitanza al
% momento flettente

CB.lato_lungo   = catalogo_sezioni(index,1);    % [m] Lato lungo
CB.lato_corto   = catalogo_sezioni(index,2);    % [m] Lato corto
CB.spessore     = catalogo_sezioni(index,3);    % [m] Spessore
CB.area         = catalogo_sezioni(index,4);    % [m^2] Area della sezione
CB.Wf           = catalogo_sezioni(index,6);    % [m^3] Modulo di resistenza a flessione
CB.m            = CB.area*material.rho*CB.z;    % [kg] Massa del membro
CB.J            = (CB.m*CB.z^2)/12; % Momento d'inerzia rispetto al centro di massa
CB.J_C          = (CB.m*CB.z^2)/3; % Momento d'inerzia rispetto al CIR

%% Dimensionamento del membro DE:

% In questa analisi il momento flettente è nullo, quindi si dovrebbe dimensionare il membro
% esclusivamente a trazione. La sezione ha un modulo di resistenza a flessione di due 
% ordini di grandezza superiore a quello richiesto per il momento di inerzia del pezzo
% quando l'accelerazione angolare è massima

DE.area = max(DE.F_Dx)./material.sigma*simulation.safety; 
[~, index] = min(abs(catalogo_sezioni(:,4) - DE.area));

DE.lato_lungo   = catalogo_sezioni(index,1);    % [m] Lato lungo
DE.lato_corto   = catalogo_sezioni(index,2);    % [m] Lato corto
DE.spessore     = catalogo_sezioni(index,3);    % [m] Spessore
DE.area         = catalogo_sezioni(index,4);    % [m^2] Area della sezione
DE.Wf           = catalogo_sezioni(index,6);    % [m^3] Modulo di resistenza a flessione
DE.m            = DE.area*material.rho*DE.z;    % [kg] Massa del membro
DE.J            = (DE.m*DE.z^2)/12; % Momento d'inerzia rispetto al centro di massa

%% Dimensionamento del membro BA:

% In questa analisi il momento flettente è nullo, quindi si dovrebbe dimensionare il membro
% esclusivamente a trazione. La sezione ha un modulo di resistenza a flessione di due 
% ordini di grandezza superiore a quello richiesto per il momento di inerzia del pezzo
% quando l'accelerazione angolare è massima

BA.area = max(BA.F_Bx)./material.sigma*simulation.safety; 
[~, index] = min(abs(catalogo_sezioni(:,4) - BA.area));

BA.lato_lungo   = catalogo_sezioni(index,1);    % [m]   Lato lungo
BA.lato_corto   = catalogo_sezioni(index,2);    % [m]   Lato corto
BA.spessore     = catalogo_sezioni(index,3);    % [m]   Spessore
BA.area         = catalogo_sezioni(index,4);    % [m^2] Area della sezione
BA.Wf           = catalogo_sezioni(index,6);    % [m^3] Modulo di resistenza a flessione
BA.m            = BA.area*material.rho*BA.z;    % [kg]  Massa del membro
BA.J            = (BA.m*BA.z^2)/12;             % [Kg*m^2] Momento d'inerzia rispetto al centro di massa

%% Dimensionamento del membro OAD

% Per il dimensionamento del membro OAD si considerano i segmenti OA e AD paralleli.
% Applichiamo  invariate le sollecitazione ai capi, in tal caso non è soddisfatto l'equilibrio in statica
% ma lo accettiamo come approssimazione

% Verificato che i valori massimi delle singole forze occorrono negli stesi istanti di tempo 
% si calcola il momento flettente massimo come combinazione lineare di questi valori

% Senza prestare attenzione all'andamento del momento flettente, consci del fatto che si sta
% dimensionando nel peggiore caso possibile, si procede con il dimensionamento
OAD.z = AO.z + AD.z;
OAD.l = (0:simulation.prec:OAD.z)';
OAD.Mf = max(AO.F_Oy).*OAD.l - max(AD.F_Ay).*(OAD.l - AO.z).*(OAD.l > AO.z);

OAD.Wf = max(abs(OAD.Mf))/material.sigma*simulation.safety;
[~, index] = min(abs((catalogo_sezioni(:,6) + ((catalogo_sezioni(:,6) < OAD.Wf))) - OAD.Wf));

OAD.area         = catalogo_sezioni(index,4);    % [m^2] Area della sezione
OAD.Wf           = catalogo_sezioni(index,6);    % [m^3] Modulo di resistenza a flessione

if((max(abs(AO.F_Ox)./OAD.area) + max(abs(OAD.Mf)./OAD.Wf))*simulation.safety > material.sigma)
    index = index + 2;
end

% Si demanda al calcolo manuale la verifica della sezione alla coesistenza
% del momento flettente e del carico assiale sul membro
OAD.lato_lungo   = catalogo_sezioni(index,1);    % [m]   Lato lungo
OAD.lato_corto   = catalogo_sezioni(index,2);    % [m]   Lato corto
OAD.spessore     = catalogo_sezioni(index,3);    % [m]   Spessore
OAD.area         = catalogo_sezioni(index,4);    % [m^2] Area della sezione
OAD.Wf           = catalogo_sezioni(index,6);    % [m^3] Modulo di resistenza a flessione
OAD.m            = OAD.area*material.rho*OAD.z;  % [kg]  Massa del membro
OAD.J            = (OAD.m*OAD.z^2)/12;           % [Kg*m^2] Momento d'inerzia rispetto al centro di massa
OAD.J_O          = (OAD.m*OAD.z^2)/3;            % [Kg*m^2] Momento d'inerzia rispetto al centro di massa

AO.lato_lungo   = catalogo_sezioni(index,1);    % [m]   Lato lungo
AO.lato_corto   = catalogo_sezioni(index,2);    % [m]   Lato corto
AO.spessore     = catalogo_sezioni(index,3);    % [m]   Spessore
AO.area         = catalogo_sezioni(index,4);    % [m^2] Area della sezione
AO.Wf           = catalogo_sezioni(index,6);    % [m^3] Modulo di resistenza a flessione
AO.m            = AO.area*material.rho*AO.z;    % [kg]  Massa del membro
AO.J            = (AO.m*AO.z^2)/12;             % [Kg*m^2] Momento d'inerzia rispetto al centro di massa
AO.J_O          = (AO.m*AO.z^2)/3;              % [Kg*m^2] Momento d'inerzia rispetto al CIR

AD.lato_lungo   = catalogo_sezioni(index,1);    % [m]   Lato lungo
AD.lato_corto   = catalogo_sezioni(index,2);    % [m]   Lato corto
AD.spessore     = catalogo_sezioni(index,3);    % [m]   Spessore
AD.area         = catalogo_sezioni(index,4);    % [m^2] Area della sezione
AD.Wf           = catalogo_sezioni(index,6);    % [m^3] Modulo di resistenza a flessione
AD.m            = AD.area*material.rho*AD.z;    % [kg]  Massa del membro
AD.J            = (AD.m*AD.z^2)/12;             % [Kg*m^2] Momento d'inerzia rispetto al centro di massa

% Per tale dimensionamento si sono trascurati gli effetti dovuti alla presenza di intagli
% per poter ospitare le coppie rotoidali

clear index x y k7