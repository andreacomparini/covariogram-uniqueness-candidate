# Il covariogramma dalla ricostruzione geometrica al problema aperto tridimensionale

Versione 1 — 8 ottobre 2026.

Il problema guida è stabilire se ogni corpo convesso tridimensionale sia determinato dal volume delle sue sovrapposizioni con tutte le proprie copie traslate. Nel piano la risposta è positiva; in tre dimensioni è nota per i poliedri, mentre la domanda generale resta aperta nello stato dell'arte consultato. Dalla dimensione quattro esistono controesempi. Il percorso seguente conduce dalle definizioni ai due principali approcci, geometrico e analitico, e alla proposta di una stima di stabilità uniforme.

I riferimenti R rimandano al [registro bibliografico](../bibliografia/registro.md). Le prove elementari e la formulazione del programma di ricerca sono sviluppate qui; le proposte non sono risultati nuovi dimostrati.

## 1. L'oggetto e le sue ambiguità

Un corpo convesso è un insieme compatto convesso con interno non vuoto. Per un corpo K in ℝⁿ definiamo

\[
g_K(h)=|K\cap(K+h)|
=\int_{\mathbb R^n}\mathbf1_K(x)\mathbf1_K(x-h)\,dx.
\]

Le barre indicano il volume n-dimensionale. In un quadrato di lato a, una traslazione di coordinate (s,t) lascia un'area comune

\[
g_K(s,t)=(a-|s|)_+(a-|t|)_+,
\qquad z_+=\max(z,0).
\]

Il dato dipende da direzione e distanza. Sostituirlo con una media sulle direzioni cambia il problema e perde informazioni.

Il valore g_K(0) è il volume. Inoltre g_K(h)=g_K(-h), e traslare K non cambia g_K. Anche K e -K hanno lo stesso covariogramma. L'unicità corretta è pertanto modulo traslazioni e inversione rispetto a un punto, non modulo rotazioni arbitrarie: le direzioni dei dati sono fissate.

La chiusura di {h:g_K(h)>0} è K-K. Quest'ultimo è il corpo differenza: contiene tutti i vettori tra due punti di K. Se h_K(u)=max{x·u:x∈K} è la funzione di supporto, allora

\[
h_{K-K}(u)=h_K(u)+h_K(-u).
\]

Conosciamo così le larghezze, ma non separiamo i due addendi. Il problema consiste anche nel recuperare l'asimmetria perduta.

**Esercizi.** Calcolare g_K per un parallelepipedo rettangolo. Verificare direttamente l'invarianza per traslazione e inversione. Costruire due figure con le stesse larghezze senza presumere che abbiano lo stesso covariogramma: uguaglianza dei supporti e uguaglianza dei valori sono condizioni diverse.

## 2. Dalle corde alla soluzione nel piano

La storia parte dalla geometria integrale e dalla probabilità geometrica. Il lavoro di Nagel del 1993 collega il covariogramma alle distribuzioni delle lunghezze delle corde per direzione e dimostra l'unicità per i poligoni convessi [R01](https://doi.org/10.2307/3214779). Conservare la direzione è essenziale: aggregare tutte le corde in un'unica distribuzione elimina informazione.

Il piano offre due laboratori distinti. Un poligono ha un numero finito di lati e vertici; un corpo liscio richiede informazioni di curvatura. Bianchi affronta il caso poligonale nel 2002 [R03](https://people.dimai.unifi.it/bianchi/lavori/bianchi_cov_poligons_AAP_rivista.pdf). Bianchi, Segala e Volčič trattano nello stesso anno corpi planari C² con curvatura positiva [R04](https://people.dimai.unifi.it/bianchi/lavori/bianchi_segala_volcic_covariogram_c2_JDG_rivista.pdf).

Queste tappe conducono alla conferma completa della congettura planare da parte di Averkov e Bianchi, pubblicata nel 2009 [R08](https://arxiv.org/abs/0711.0572). Per comprenderla conviene chiedersi quali informazioni locali siano ricavate dal dato e come venga assicurata la compatibilità delle ricostruzioni lungo tutto il bordo. La soluzione planare è una prova da studiare, non uno schema trasferibile senza modifiche alla dimensione tre.

**Obiettivo di lettura.** Per ciascun lemma distinguere: ipotesi sul corpo; informazione estratta dal covariogramma; uso della dimensione due; passaggio dalla conoscenza locale al corpo intero. Una tabella di questi quattro elementi è più utile di un semplice riassunto della prova.

## 3. Perché la dimensione cambia il problema

Una costruzione rende visibile il fallimento dell'unicità nelle dimensioni alte. Per corpi A e B in spazi separati, Fubini dà

\[
g_{A\times B}(u,v)=g_A(u)g_B(v).
\]

Poiché g_B=g_{-B}, i corpi A×B e A×(-B) hanno gli stessi dati. Se entrambi i fattori sono privi di simmetria centrale, la riflessione di un solo fattore non equivale a una traslazione o all'inversione dell'intero corpo. I controesempi possono comparire in dimensione quattro scegliendo due fattori planari. Questa direzione è sviluppata da Bianchi nel lavoro del 2005 [R05](https://people.dimai.unifi.it/bianchi/lavori/bozze_bianchi_matheron_conje_JLMS.pdf).

In tre dimensioni una decomposizione in fattori di dimensioni positive coinvolge un fattore unidimensionale, cioè un intervallo, che è centralmente simmetrico. Il meccanismo precedente non dà quindi un controesempio 3D. Questo spiega l'interesse della dimensione tre, ma non dimostra l'unicità: escludere una costruzione non esclude tutti i possibili meccanismi.

**Esercizio.** Dimostrare la formula di prodotto, poi controllare perché la sola riflessione di un fattore non simmetrico è una vera ambiguità quando anche l'altro fattore non è simmetrico.

## 4. La soluzione poliedrale tridimensionale

Nel 2009 Bianchi dimostra che un poliedro convesso tridimensionale è determinato dal covariogramma fra tutti i corpi convessi, salvo le ambiguità usuali [R09](https://arxiv.org/abs/0805.1605). La struttura finita di facce, spigoli, vertici e coni di supporto permette di organizzare la ricostruzione.

Un oggetto ausiliario è il covariogramma incrociato

\[
g_{A,B}(h)=|A\cap(B+h)|.
\]

Esso confronta due insiemi diversi. Il lavoro sulle coppie di poligoni e sui coni planari classifica alcune ambiguità e fornisce strumenti usati nella prova tridimensionale [R10](https://arxiv.org/abs/0805.1805).

Il lettore deve imparare a passare dalla geometria della sovrapposizione ai dati di facce e coni. Prima della lettura completa di R09 sono necessari: piani di supporto, facce esposte, coni normali e tangenti, somme di Minkowski, proiezioni e geometria elementare dei poliedri. La domanda da annotare per ogni passaggio è se esso richieda un numero finito di facce o ammetta una formulazione per un bordo continuo.

## 5. La seconda lingua del problema è Fourier

Adottando la convenzione con esponenziale exp(-2πi x·ξ), il teorema di convoluzione dà

\[
g_K=\mathbf1_K*\mathbf1_{-K},\qquad
\widehat{g_K}(\xi)=|\widehat{\mathbf1_K}(\xi)|^2.
\]

Il problema geometrico equivale quindi a recuperare una funzione indicatrice convessa dal modulo della sua trasformata. La fase manca. Il vincolo di convessità è una parte dell'informazione disponibile, non una garanzia automatica di recupero.

Per corpi sufficientemente regolari, il lavoro Fourier–Laplace di Bianchi del 2016 usa l'estensione complessa della trasformata, il comportamento asintotico dei suoi zeri e informazioni geometriche del bordo. La determinazione è affermata nella classe di corpi sufficientemente regolari; non va estesa senza prova a concorrenti arbitrari [R15](https://arxiv.org/abs/1312.7816).

La trasformata estesa è

\[
F_K(z)=\int_K e^{-2\pi i z\cdot x}\,dx,
\qquad z\in\mathbb C^n.
\]

La compattezza di K consente di derivare sotto l'integrale sui compatti complessi: F_K è intera. Studiare i suoi zeri e la fattorizzazione introduce l'analisi complessa in più variabili. R15 collega l'irriducibilità anche al problema di Pompeiu.

**Preparazione.** Prima imparare convoluzione, trasformata, inversione e Plancherel. Poi integrali oscillanti e fase stazionaria, curvatura del bordo e infine funzioni intere di più variabili. Per il primo ingresso nel tema, l'analisi complessa avanzata può attendere.

## 6. Continuità diretta e ostacolo inverso

La continuità è dimostrabile senza risolvere l'unicità. Per indicatori f e q, che assumono valori 0 e 1,

\[
|f(x)f(x-h)-q(x)q(x-h)|
\leq |f(x)-q(x)|+|f(x-h)-q(x-h)|.
\]

Integrando otteniamo

\[
\|g_K-g_L\|_\infty\leq2|K\triangle L|.
\]

La convergenza di Hausdorff di corpi convessi a un corpo convesso con interno non vuoto implica convergenza degli indicatori quasi ovunque: i punti interni ed esterni stabilizzano la loro appartenenza e il bordo ha misura nulla. Un insieme limitato comune permette di usare la convergenza dominata. Segue |K_j△K|→0, dunque la convergenza uniforme dei covariogrammi.

Se P_j→K e Q_j→L sono approssimazioni poliedrali e g_K=g_L, abbiamo soltanto

\[
\|g_{P_j}-g_{Q_j}\|_\infty\to0.
\]

L'unicità esatta per i poliedri non dice quanto siano vicini P_j e Q_j. Confondere continuità diretta e stabilità inversa è il passaggio errato da evitare.

R12 sviluppa algoritmi fortemente consistenti da dati rumorosi nelle situazioni note di unicità. Questo è distinto da una stima uniforme esplicita dell'errore geometrico in funzione dell'errore nei dati [R12](https://arxiv.org/abs/1003.4486).

## 7. Un lemma di compattezza e il suo limite

Questa sezione sviluppa un argomento matematico condizionale, non attribuisce un nuovo teorema alla letteratura.

Fissiamo 0<r<R e la famiglia compatta

\[
\mathcal C_{r,R}=\{K:B_r(0)\subseteq K\subseteq B_R(0),\ K\text{ convesso compatto}\}.
\]

La compattezza segue dal teorema di selezione di Blaschke e dalla chiusura dei vincoli. Definiamo

\[
d_*(K,L)=\inf_{a\in\mathbb R^n,\ \sigma=\pm1}
d_H(K,a+\sigma L).
\]

Su questa famiglia, assumiamo g_K=g_L⇒d_*(K,L)=0. Allora esiste un modulo uniforme ω(t)→0 con

\[
d_*(K,L)\leq\omega(\|g_K-g_L\|_\infty).
\]

**Prova.** Definiamo ω(t) come il supremo di d_* sulle coppie con errore nei covariogrammi ≤t. Se non tendesse a zero, avremmo coppie K_j,L_j con errore nei dati tendente a zero e d_*≥ε>0. Per compattezza estraiamo limiti K,L. La continuità dà g_K=g_L; l'ipotesi di unicità dà K=a+σL. Usando questo stesso a e σ per le successioni, d_*(K_j,L_j)≤d_H(K_j,a+σL_j)→0, contraddizione.

Viceversa un modulo tendente a zero implica l'unicità, applicando la stima alle coppie con dati identici, o usando ogni t>0 nella formulazione per errore ≤t. Sulle famiglie compatte queste due proprietà sono dunque equivalenti. La prova fornisce un modulo astratto, non un esponente né una costante calcolabile.

Per i poliedri 3D con al massimo N vertici, e con i vincoli r,R, la famiglia resta compatta: rappresentiamo ciascun poliedro come inviluppo convesso di N punti, ripetendone alcuni se necessario, ed estraiamo limiti dei punti. Il limite ha ancora al massimo N vertici e contiene B_r. L'unicità di R09 dà pertanto un modulo ω_{N,r,R}.

**Problema di ricerca proposto.** Ottenere un controllo valido indipendentemente da N. Se riuscisse per ogni r,R, l'approssimazione poliedrale porterebbe all'unicità generale 3D. È una riformulazione sostanziale del problema, non una scorciatoia già risolta. Per approssimare corpi che toccano i limiti dei vincoli si può lavorare con r'<r e R'>R, evitando un problema artificiale di normalizzazione.

## 8. Sviluppi laterali e recenti

I dati parziali costituiscono una domanda distinta: R07 studia dove sia sufficiente conoscere il covariogramma per ricavare proprietà o unicità in classi specifiche [R07](https://arxiv.org/abs/math/0702892).

La sostituzione del volume con una valutazione genera nuovi problemi: R14 tratta covariogrammi associati anche a larghezza e altre quantità. Risultati e controesempi dipendono dalla valutazione scelta [R14](https://arxiv.org/abs/1307.1529).

Il caso discreto non è una copia del continuo. R13 ottiene risultati con condizioni aggiuntive e famiglie di controesempi per insiemi reticolari planari convessi nel senso reticolare [R13](https://arxiv.org/abs/1011.5530). Una rappresentazione a voxel può introdurre ambiguità che non dimostrano nulla sul problema continuo.

Il preprint del 2025 di Bianchi, Burchard e Lin studia condizioni di stretta concavità dei covariogrammi incrociati [R17](https://arxiv.org/abs/2508.03887). È uno sviluppo della struttura analitica del dato, non una dimostrazione dell'unicità universale.

In fisica, R06 mette in relazione il covariogramma di una finestra nello spazio interno di un modello cut-and-project con autocorrelazione e diffrazione dei quasicristalli [R06](https://arxiv.org/abs/math/0610411). Lo spazio della finestra non coincide necessariamente con lo spazio fisico. Anche qui la convessità e la completezza dei dati delimitano la portata dell'unicità.

## 9. Percorso di studio con verifiche di comprensione

Le tappe sono ordinate per dipendenza, non per un calendario fisso. Si avanza quando si riesce a svolgere il compito indicato.

| Tappa | Strumenti da studiare | Compito che verifica la comprensione | Letture collegate |
|---|---|---|---|
| 1 | Misura di Lebesgue, Fubini, convergenza dominata, indicatori | Dimostrare formula di prodotto e stima con la differenza simmetrica | Capitoli 1, 3, 6 |
| 2 | Convessità, separazione, funzione di supporto, somme di Minkowski, distanza di Hausdorff | Ricavare K-K dal dato e spiegare quale asimmetria resta ignota | R02, R03 |
| 3 | Proiezioni, corde, geometria integrale, Brunn–Minkowski | Distinguere informazioni direzionali e medie; comprendere le ambiguità | R01, R07 |
| 4 | Geometria dei poligoni e bordi regolari | Annotare dove le prove planari usano la dimensione due | R04, R05, R08 |
| 5 | Facce esposte, coni normali e tangenti, geometria poliedrale | Ricostruire la catena di lemmi che porta dai dati locali al poliedro | R10, R09 |
| 6 | Convoluzione, Fourier, inversione, Plancherel | Derivare l'identità del modulo e le ambiguità di fase | R12 |
| 7 | Compattezza di Blaschke e continuità degli operatori inversi | Riprodurre la prova del modulo astratto e individuare l'ipotesi di unicità | Capitolo 7, R12 |
| 8 | Geometria differenziale, curvature, integrali oscillanti, fase stazionaria | Leggere quali ipotesi di regolarità sono usate nella via analitica | R04, R15 |
| 9 | Funzioni intere di più variabili, zeri e fattorizzazioni | Comprendere il ruolo degli zeri complessi senza confonderli con il solo modulo reale | R15 |

Per i manuali di preparazione si possono usare *Convex Bodies: The Brunn–Minkowski Theory* di Rolf Schneider e *Geometric Tomography* di Richard J. Gardner per geometria convessa e ricostruzione; un corso di analisi reale e Fourier per le tappe 1 e 6; un corso di geometria differenziale e analisi asintotica per la tappa 8. Questi sono riferimenti di studio, distinti dagli articoli originali del registro; scegliere edizione e capitoli in funzione delle conoscenze già possedute.

## 10. Come trasformare lo studio in una domanda di ricerca

La prima attività utile è una lettura quantitativa di R09. Per ogni lemma registrare quali parametri governano l'argomento: numero di facce, angoli, dimensioni minime delle facce, vicinanza a simmetrie, raggio interno ed esterno. Non presumere che ogni parametro sia necessario: alcuni potrebbero appartenere alla prova, anziché al fenomeno.

Una seconda attività è scegliere una famiglia parametrica limitata. Cercare una stima d_*≤Ct^α in quella famiglia può isolare il meccanismo di stabilità. Una degenerazione dell'esponente o della costante non costituisce un controesempio all'unicità; mostra soltanto il limite della stima o del metodo.

Un possibile approccio analitico consiste nel perturbare la funzione di supporto di un corpo regolare e studiare la prima variazione del covariogramma. Bisognerebbe stabilire quali perturbazioni siano invisibili al primo ordine e come controllare i termini successivi. Un nucleo non banale della linearizzazione non implica non unicità del problema non lineare; l'iniettività della linearizzazione, da sola, non dà una stima uniforme in uno spazio infinito-dimensionale. Servono spazi funzionali e controlli del resto precisati.

Gli esperimenti numerici possono cercare coppie molto diverse con dati molto vicini, ma vanno accompagnati da stime dell'errore di discretizzazione. Una coppia numerica non prova uguaglianza esatta; una ricerca senza esempi non prova unicità.

## 11. Il problema guida e il prossimo risultato verificabile

Il problema principale scelto è:

\[
K,L\subset\mathbb R^3\text{ corpi convessi},\quad g_K=g_L
\quad\Longrightarrow\quad L=a+K\text{ oppure }L=a-K?
\]

La rassegna R16 conferma il divario tra il caso poliedrale, le classi regolari e il caso generale [R16](https://people.dimai.unifi.it/bianchi/lavori/covariogram_survey14.pdf). La soluzione per corpi C² con curvatura positiva in 3D sarebbe già una tappa distinta; la riduzione a quella classe richiederebbe un proprio argomento.

Il prossimo risultato circoscritto da cercare è una stima quantitativa in una famiglia poliedrale controllata, con dipendenze esplicite. Il criterio per considerarla un progresso verso il problema generale è capire se tali dipendenze sopravvivano quando il numero dei vertici cresce e il bordo approssima un corpo arbitrario.

## Registro delle revisioni

| Data | Versione | Contenuto |
|---|---|---|
| 8 ottobre 2026 | 1 | Registro di 17 lavori; evoluzione storica; identità fondamentali; prova di continuità; lemma condizionale di stabilità; percorso di studio e domande di ricerca. |

Gli aggiornamenti futuri aggiungeranno risultati verificati nei capitoli pertinenti, mantenendo identificabili ipotesi, limiti delle prove e problemi ancora aperti.
