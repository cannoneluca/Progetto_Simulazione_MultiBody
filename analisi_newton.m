% analisi_newton.m

% Il programma permette di avere una stima delle forze scambiate sulle coppie
% rotoidali che costituiscono il meccanismo articolato

% Il sistema di equazioni è ottenuto applicando la seconda legge della dinamica ai corpi
% rigidi che compongono il meccanismo articolato, nello specifico i corpi OAD, BA, CB e DE

% Essendo questi considerati privi di massa in questa fase dello studio, le equazoni si traducono
% in uno studio di equilibrio statico

% Si procede alla soluzione del sistema di equazioni in forma matriciale. Nella matrice A che
% andiamo a scrivere si presenta la matrice dei coefficienti delle 11 incognite, in ordine:

% F_Ox, F_Oy, F_Ax, F_Ay, F_Bx, F_By, F_Cx, F_Cy, F_Dx, F_Dy, F_Ey

% che inizializziamo:

force.F_Ox(simulation.samples,1) = 0;
force.F_Oy(simulation.samples,1) = 0;
force.F_Ax(simulation.samples,1) = 0;
force.F_Ay(simulation.samples,1) = 0;
force.F_Bx(simulation.samples,1) = 0;
force.F_By(simulation.samples,1) = 0;
force.F_Cx(simulation.samples,1) = 0;
force.F_Cy(simulation.samples,1) = 0;
force.F_Dx(simulation.samples,1) = 0;
force.F_Dy(simulation.samples,1) = 0;
force.F_Ey(simulation.samples,1) = 0;

% Le equazioni da cui sono ricavate sono in ordine:
% 1) Equilibrio alla traslazione lungo x del corpo OAD
% 2) Equilibrio alla traslazione lungo y del corpo OAD
% 3) Equilibrio alla traslazione lungo x del corpo BA
% 4) Equilibrio alla traslazione lungo y del corpo BA
% 5) Equilibrio alla rotazione rispetto al polo B del corpo BA
% 6) Equilibrio alla traslazione lungo x del corpo CB
% 7) Equilibrio alla traslazione lungo y del corpo CB
% 8) Equilibrio alla rotazione rispetto al polo C del corpo CB
% 9) Equilibrio alla traslazione lungo x del corpo DE
% 10) Equilibrio alla traslazione lungo y del corpo DE
% 11) Equilibrio alla rotazione rispetto al polo E del corpo DE

% la soluzione del sistema avviene in un ciclo for:

for k4 = 1:simulation.samples
    % La matrice A è la matrice dei coefficienti delle incognite, che in questo caso sono le forze
    % scambiate sulle coppie rotoidali che costituiscono il meccanismo articolato

    matA=  [1 0 1 0 0 0 0 0 1 0 0; 
            0 1 0 1 0 0 0 0 0 1 0;
            0 0 1 0 1 0 0 0 0 0 0;
            0 0 0 1 0 1 0 0 0 0 0;
            0 0 (-BA.z*sin(BA.f(k4))) (BA.z*cos(BA.f(k4))) 0 0 0 0 0 0 0;
            0 0 0 0 1 0 1 0 0 0 0; 
            0 0 0 0 0 1 0 1 0 0 0;
            0 0 0 0 (CB.z*sin(CB.f(k4))) (-CB.z*cos(CB.f(k4))) 0 0 0 0 0;
            0 0 0 0 0 0 0 0 1 0 0;
            0 0 0 0 0 0 0 0 0 -1 1;
            0 0 0 0 0 0 0 0 DE.z*sin(DE.f(k4)) -DE.z*cos(DE.f(k4)) 0];

% La matrice B è la matrice dei termini noti, che in questo caso sono le forze esterne

    matB = [0 0 0 0 0 0 0 force.C(k4) force.Fr(k4) 0 0]';
    matC = matA\matB;

    force.F_Ox(k4) = matC(1);
    force.F_Oy(k4) = matC(2);
    force.F_Ax(k4) = matC(3);
    force.F_Ay(k4) = matC(4);
    force.F_Bx(k4) = matC(5);
    force.F_By(k4) = matC(6);
    force.F_Cx(k4) = matC(7);
    force.F_Cy(k4) = matC(8);
    force.F_Dx(k4) = matC(9);
    force.F_Dy(k4) = matC(10);
    force.F_Ey(k4) = matC(11);
end

clear matA matB matC k4
