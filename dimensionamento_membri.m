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

% La sezione viene scelta da una tabella, ricavata da un catalogo delle
% scatolati in acciaio

% Per il membro CB:
y(1,1) = force.F_Cx(simulation.max_stress_index);
y(2,1) = force.F_Cy(simulation.max_stress_index);

x = rot(CB.f(simulation.max_stress_index))*y;

CB.F_Cx = x(1);
CB.F_Cy = x(2);
 
y(1,1) = force.F_Bx(simulation.max_stress_index);
y(2,1) = force.F_By(simulation.max_stress_index);

x = rot(CB.f(simulation.max_stress_index))*y;

CB.F_Bx = x(1);
CB.F_By = x(2);

CB.l = (0:simulation.prec:CB.z)';
CB.Mf = force.C(simulation.max_stress_index) - CB.l*CB.F_Cy;
CB.Wf = max(abs(CB.Mf)/material.sigma*simulation.safety);

[~, index] = min(abs(catalogo_sezioni(:,3) - CB.Wf));

CB.lato = catalogo_sezioni(index,1);
CB.spessore = catalogo_sezioni(index,2);
CB.area = catalogo_sezioni(index,3);
CB.Wf = catalogo_sezioni(index,5);
CB.m = CB.area*material.rho*CB.z;
CB.J_C = (CB.m*CB.z^2)/12; % Momento d'inerzia rispetto al CIR

% Dimensionamento del membro DE:

y(1,1) = -force.F_Dx(simulation.max_stress_index);
y(2,1) = -force.F_Dy(simulation.max_stress_index);

x = rot(DE.f(simulation.max_stress_index))*y;

DE.F_Dx = x(1);
DE.F_Dy = x(2);
 
y(1,1) = -force.Fr(simulation.max_stress_index);
y(2,1) = force.F_Ey(simulation.max_stress_index);

x = rot(DE.f(simulation.max_stress_index))*y;

DE.F_Ex = x(1);
DE.F_Ey = x(2);

% [~, index] = min(abs(catalogo_sezioni(:,3) - CB.Wf));
index = 1;

DE.lato = catalogo_sezioni(index,1);
DE.spessore = catalogo_sezioni(index,2);
DE.area = catalogo_sezioni(index,3);
DE.Wf = catalogo_sezioni(index,5);
DE.m = DE.area*material.rho*DE.z;
DE.J = (DE.m*DE.z^2)/12; % Momento d'inerzia rispetto al CIR

% Per il membro BA:

y(1,1) = -force.F_Bx(simulation.max_stress_index);
y(2,1) = -force.F_By(simulation.max_stress_index);

x = rot(BA.f(simulation.max_stress_index))*y;

BA.F_Bx = x(1);
BA.F_By = x(2);

y(1,1) = -force.F_Ax(simulation.max_stress_index);
y(2,1) = -force.F_Ay(simulation.max_stress_index);

x = rot(BA.f(simulation.max_stress_index))*y;

BA.F_Ax = x(1);
BA.F_Ay = x(2);

BA.area = BA.F_Ax/material.sigma*simulation.safety;

[~, index] = min(abs(catalogo_sezioni(:,3) - BA.area));

BA.lato = catalogo_sezioni(index,1);
BA.spessore = catalogo_sezioni(index,2);
BA.area = catalogo_sezioni(index,3);
BA.Wf = catalogo_sezioni(index,5);
BA.m = BA.area*material.rho*BA.z;
BA.J = (BA.m*BA.z^2)/12; % Momento d'inerzia rispetto al Centro di massa

% Per il membro OAD si considera il membro rettificato, con applicate esclusivamente
% le forze lungo x:

y(1,1) = -force.F_Ox(simulation.max_stress_index);
y(2,1) = -force.F_Oy(simulation.max_stress_index);

x = rot(AO.f(simulation.max_stress_index))*y;

AO.F_Ox = x(1);
AO.F_Oy = x(2);

y(1,1) = -force.F_Ox(simulation.max_stress_index);
y(2,1) = -force.F_Oy(simulation.max_stress_index);

y(1,1) = -force.F_Ax(simulation.max_stress_index);
y(2,1) = -force.F_Ay(simulation.max_stress_index);

x = rot(AO.f(simulation.max_stress_index))*y;

AO.F_Ax = x(1);
AO.F_Ay = x(2);



y(1,1) = -force.F_Ax(simulation.max_stress_index);
y(2,1) = -force.F_Ay(simulation.max_stress_index);

x = rot(AD.f(simulation.max_stress_index))*y;

AD.F_Ax = x(1);
AD.F_Ay = x(2);

y(1,1) = -force.F_Dx(simulation.max_stress_index);
y(2,1) = -force.F_Dy(simulation.max_stress_index);

x = rot(AD.f(simulation.max_stress_index))*y;

AD.F_Dx = x(1);
AD.F_Dy = x(2);

OAD.z = AO.z + AD.z;
OAD.l = (0:simulation.prec:OAD.z)';
OAD.Mf = AO.F_Oy.*OAD.l - AD.F_Ay.*(OAD.l - AO.z).*(OAD.l > AO.z);

OAD.Wf = max(OAD.Mf)/material.sigma*simulation.safety;

[~, index] = min(abs(catalogo_sezioni(:,3) - OAD.Wf));

OAD.lato = catalogo_sezioni(index,1);
OAD.spessore = catalogo_sezioni(index,2);
OAD.area = catalogo_sezioni(index,3);
OAD.Wf = catalogo_sezioni(index,5);
OAD.m = OAD.area*material.rho*(AO.z + AD.z);
OAD.J_O = (OAD.m*OAD.z^2)/3; % Momento d'inerzia rispetto al CIR

AO.lato = OAD.lato;
AO.spessore = OAD.spessore;
AO.area = OAD.area;
AO.Wf = OAD.Wf;
AO.m = AO.area*material.rho*AO.z;
AO.J_O = (AO.m*AO.z^2)/3; % Momento d'inerzia rispetto al CIR

AD.lato = OAD.lato;
AD.spessore = OAD.spessore;
AD.area = OAD.area;
AD.Wf = OAD.Wf;
AD.m = AD.area*material.rho*AD.z;
AD.J = (AD.m*AD.z^2)/12; % Momento d'inerzia rispetto al centro di massa

% Per tale dimensionamento si sono trascurati gli effetti dovuti alla presenza di intagli
% per poter ospitare le coppie rotoidali

clear index x y