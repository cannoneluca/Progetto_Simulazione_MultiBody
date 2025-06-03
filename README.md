# Progetto_Simulazione_MultiBody
Repository con il progetto del corso di simulazione multybody AA. 2024/2025
La cartella si compone di 4 sottocartelle, dedicate alle diverse sezioni del progetto.

## Cartella Matlab
La cartella Matlab contiene tutti gli script matlab utilizzati per il dimensionamento del sistema. Contiene un file "main.m" che, quando eseguito, permette di richiamare in ordine le altre sezioni di codice previste.

## Cartella Adams
La cartella Adams contiene il file binario su cui è stata salvata la simulazione del sistema.
Nel modello è predisposta sia la fase di ottimizzazione del segmento CB, sia la simulazione del
sistema camma-punteria.

## Cartella media
La cartella media contiene tutti i file esportati dalle simulazioni utilizzati per la presentazione che riassume i punti salienti della progettazione

## Cartella Simscape
La cartella Simscape contiene la simulazione simscape multibody del sistema. Alcuni dei blocchi che la costituiscono fanno riferimento agli output degli script matlab, perciò prima di simulare il sistema p richiesta l'esecuzione del programma main.

## Workspace

Al termine del comando "main" nel workspace troviamo diverse variabili, tutte organizzate in strutture:

### Coppie cinematiche
Le variabili A, B, C, D, E, F, G sono ricavate dalla traccia del progetto e sono utili a determinare la lunghezza dei membri. SOno composte da due campi: x e y, corrispondenti alle coordinate cartesiane dei punti.

### Membri
Le variabili CB, BA, AO, OB, AD, DE, EF, FG, GC rappresentano i vettori delle equazioni di chiusura. Entrambi sono composti da due campi: modulo z e fase f. Uno dei due è un vettroe che rappresenta i valori assunti durante il corso della simulazione.
I vettori sono stati scelti affinché abbiano solo uno dei due parametri variabili nel tempo.
I membri del telaio (OC, FG, GC) sono fissi, quindi non variano. I campi sono:
- z     : [m]   modulo del membro
- f     : [rad] fase del membro, che rappresenta la posizione angolare del membro rispetto al sistema di riferimento
- x     : [m]       coordinata x del centro di massa
- y     : [m]       coordinata y del centro di massa
- xp    : [m/s]     velocità x del centro di massa
- yp    : [m/s]     velocità y del centro di massa
- fp    : [rad/s]   velocità angolare del membro
- xpp   : [m/s^2]   accelerazione x del centro di massa
- ypp   : [m/s^2]   accelerazione y del centro di massa
- fpp   : [rad/s^2] accelerazione angolare del membro
- F_?x  : [N]       forza applicata lungo l'asse x nel punto ?
- F_?y  : [N]       forza applicata lungo l'asse y nel punto ?
- Wf    : [N/m^2]   modulo di resistenza a flessione della sezione
- area  : [m^2]     area della sezione
- lato_lungo : [m]   lato lungo della sezione
- lato_corto : [m]   lato corto della sezione
- spessore : [m]     spessore della parete della sezione
- massa : [kg]      massa del membro
- J     : [kg*m^2]  momento d'inerzia del membro attorno al centro di massa
- J_?   : [kg*m^2]  momento d'inerzia del membro attorno all'asse passante per il punto ?

### Membro OAD
Il membro OAD è usato per poter dimensionare la sezione del membro, utile a causa della sua geometria.

### Camma
La struttura camma contiene le informazioni principali ottenute dal dimensionamento della camma. I campi sono:

- x     : la posizione de pattino assumendo come riferimento il punto morto inferiore raggiunto dal  pattino (punto E)
- alfa          : [rad]     vettore degli angoli su cui viene campionato il raggio della camma
- xp            : [m/s]     vettore della velocità del pattino
- xpp           : [m/s^2]   vettore dell'accelerazione del pattino
- theta_max_S   : [rad]     angolo di pressione ammesso in salita (traslazione x positiva)
- theta_max_D   : [rad]     angolo di pressione ammesso in discesa (traslazione x negativa)
- Rr            : [m]       raggio della rotella
- Rb            : [m]       raggio base
- theta         : [rad]     angolo di pressione durante il funzionamento
- r             : [m]       raggio
- op            : [m]       raggio reale della camma, considerando il raggio della rotella
- fi            : [rad]     angolo effettivo della camma, considerando il raggio della rotella
- rho           : [m]       raggio di curvatura
- m             : [kg]      massa
- J             : [kg*m^2]  momento d'inerzia della camma attorno al centro di massa

### Catalogo motori
La struttura catalogo_motori contiene le informazioni sui motori utilizzati per il dimensionamento del sistema. I campi sono descritti accuratamente nel file "importa_catalogo_motori.m".

### Catalogo riduttori
La struttura catalogo_riduttori contiene le informazioni sui riduttori utilizzati per il dimensionamento del sistema. I campi sono descritti accuratamente nel file "importa_catalogo_riduttori.m".

### Catalogo sezioni 
La struttura catalogo_sezioni contiene le informazioni sulle sezioni utilizzate per il dimensionamento del sistema. I campi sono descritti accuratamente nel file "importa_catalogo_sezioni_rettangolari_cave.m".

### Color
La struttura color contiene le informazioni sui colori utilizzati per la visualizzazione del render del sistema

### force
La struttura force contiene le informazioni sulle forze del sistema. I campi sono:
- R      : [N]       forza di attrito
- impact : [N]       forza di impatto
- C      : [N*m]     coppia alla manovella
- F_?x   : [N]       componente x della forza scambiata nel punto ?
- F_?y   : [N]       componente y della forza scambiata nel punto ?
- C2     : [N*m]     coppia alla manovella considerando l'inerzia dei membri

### Material
La struttura material contiene le informazioni sul materiale utilizzato per il dimensionamento del sistema. I campi sono:
- name : nome del materiale
- rho  : [kg/m^3] densità
- E    : [Pa]     modulo di Young
- sigma: [Pa]   tensione di snervamento

### Motore
La struttura motore contiene le informazioni sul motore utilizzato per il dimensionamento del sistema. I campi sono:
- Imp : [kg*m^2] momento d'inerzia
- cv  : [N*m*s/rad]   coefficiente di attrito viscoso
- ca  : [N*m]         coppia di attrito
- C_a : [N*m]         coppia di attrito in funzione della velocità
- C   : [N*m]         coppia richiesta
- OK  : [bool]        True se il motore è idoneo, False altrimenti
- V   : [rad/s]         velocità angolare
- ID : [int]      identificativo del motore (posizione nel catalogo)
- Peak_Stall_Torque : [N*m]     coppia di stallo di picco
- Max_Speed_Torque  : [N*m]     coppia massima a velocità massim
- Cont_Stall_Torque : [N*m]     coppia di stallo continua
- Rated_Torque      : [N*m]     coppia nominale
- Max_Torque_Speed  : [N*m]     velocità massima a cui è disponibile la coppia massima
- Rated_Speed       : [rpm]     velocità nominale
- Max_Speed         : [rpm]     velocità massima
- KT                : [N*m/A]   costante di coppia
- R                 : [Ohm]     resistenza elettrica
- omega             : [rpm]     Vettore delle velocità a cui è campionata la curva carattestica
- coppia_continua   : [N*m]     curva carattestica della coppia continua del motore
- coppia_picco      : [N*m]     curva carattestica della coppia di picco del motore

### Pacco
La struttura pacco contiene le informazioni sul pacco da movimentare. I campi sono:
- m                 : [kg]      massa del pacco
- side              : [m]       lato del pacco per il rendering
- y                 : [m]       coordinata y del lato inferiore del pacco
- x                 : [m]       coordinata x del lato più vicino all'origine del pacco
- xp                : [m/s]     velocità del pacco
- xpp               : [m/s^2]   accelerazione del pacco

### Riduttore
La struttura riduttore contiene le informazioni sul riduttore scelto per il sistema in seguito al dimensionamento. I campi sono:
- V2                : [rad/s]   velocità angolare dell'albero lento
- T2                : [Nm]      coppia dell'albero lento
- P2                : [W]       potenza dell'albero lento
- DC                : [adim]    duty cycle del riduttore
- shock_ncicli      : [cicli/h] frequenze notevoli a cui è campionato il grafico del fattore di servizio
- shock_fs          : [adim]    fattore di servizio del riduttore
- ncicli            : [cicli/h] frequenze a cui è campionato il grafico del fattore di servizio
- fs                : [adim]    fattore di servizio del riduttore
- T2B               : [Nm]      coppia massima ammessa all'albero lento
- T2M               : [Nm]      coppia media ammessa all'albero lento
- tau               : [adim]    rapporto di trasmissione del riduttore
- N1max             : [rpm]     velocità massima dell'albero veloce
- N1nom             : [rpm]     velocità nominale dell'albero veloce
- etaD              : [adim]    rendimento del riduttore in moto diretto
- etaR              : [adim]    rendimento del riduttore in moto retrogrado
- Im                : [kg*m^2]  momento d'inerzia dell'albero veloce
- eta               : [adim]    vettore del rendimento del riduttore istante per istante

### Simulation
La struttura contiene tutte le informazioni necessarie per la simulazione del sistema. I campi sono:
- omega             : [rad/s] velocità angolare della manovella CB
- samples           : [adim] numero di campioni della simulazione
- g                 : [m/s^2] accelerazione di gravità
- f_cou             : [adim] coefficiente di attrito tra pacco e piano
- p                 : [adim] Porzione della corsa a cui è posizionato il pacco
- H                 : [m] lunghezza della corsa richiesta
- precision         : [adim] precisione del progetto
- safety            : [adim] fattore di sicurezza del progetto
- time              : [s] vettore degli istanti della simulazione
- fsolve_options    : opzioni per la funzione fsolve
 A corredo si trovano gli indici relative alle singole figure
