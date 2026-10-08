# Controllo Lean della prova candidata

Aggiornamento: 9 ottobre 2026.

**Esito: formalizzazione parziale. Il teorema di unicità del covariogramma non è ancora formalizzato né certificato.** Il progetto contiene 33 teoremi espliciti con prove controllate dal kernel, senza lacune ammesse e senza assiomi matematici aggiunti. Sono lemmi di supporto e deduzioni condizionali; alcuni assumono precisamente le identità che restano da ricavare dai corpi convessi.

Il problema di riferimento del [quaderno](../ricerca/rigidita-scambi-covariogramma.tex) è: se K è un corpo C⁹₊ in R³ e L è un corpo convesso arbitrario con lo stesso covariogramma, allora L è una traslazione di K oppure di −K. **Nel codice non c'è ancora un enunciato di questo teorema con definizioni di corpo convesso e covariogramma.** Non è stata dimostrata né assunta una sua versione astratta chiamata “unicità”.

## Risultati controllati

| File | Contenuto provato | Limite del controllo |
|---|---|---|
| [Algebra.lean](CovariogramCheck/Algebra.lean) | Recupero di una coppia da somma e prodotto; rapporto logaritmico; scelta dell'ordine; coefficiente del nucleo alle differenze finite. | Le identità di somma e prodotto sono ipotesi. |
| [AnalyticChoice.lean](CovariogramCheck/AnalyticChoice.lean) | Se il prodotto di due funzioni analitiche è nullo su un aperto preconnesso, uno dei fattori è identicamente nullo. | Va ancora applicato ai rami sulla sfera mediante carte o estensione radiale. |
| [ZeroAllocation.lean](CovariogramCheck/ZeroAllocation.lean) | Uno zero semplice di un prodotto appartiene a un solo fattore; esclusività della scelta analitica globale. | Analiticità, identità del prodotto e semplicità degli zeri sono premesse esplicite. |
| [LogKernel.lean](CovariogramCheck/LogKernel.lean) | Normalizzazione esatta del logaritmo e stima uniforme del resto cubico. | Si verifica una stima con costante 36 e soglia τ ≥ 4M, sufficiente per il limite; non la costante 20 del quaderno. |
| [KernelSeries.lean](CovariogramCheck/KernelSeries.lean) | Sommabilità dei resti, loro somma tendente a zero, separazione delle serie convergenti e linearizzazione della somma logaritmica. | Le altezze degli zeri devono essere limitate e gli inversi dei quadrati delle parti reali sommabili. |
| [RealParts.lean](CovariogramCheck/RealParts.lean) | Sostituzione delle parti reali con un modello a distanza limitata: la somma delle differenze pesate tende a zero. | Positività delle parti reali, sommabilità degli inversi dei quadrati, errore limitato e pesi di modulo ≤ 1 sono premesse. |
| [WeightedErrors.lean](CovariogramCheck/WeightedErrors.lean) | Un errore che tende a zero produce una media tendente a zero per pesi positivi, sommabili, di massa limitata e singolarmente infinitesimi; stima delle medie firmate. | Queste proprietà non sono ancora ricavate in Lean per i pesi specifici del quaderno. |
| [LimitTransport.lean](CovariogramCheck/LimitTransport.lean) | Esistenza di un parametro comune da limiti e resti assegnati; limite del modulo; passaggio da scelte locali di segno a un orientamento globale quasi ovunque. | La formula asintotica e i limiti agli estremi sono assunti, non ricavati da integrali di Laplace. |
| [MeasureConclusion.lean](CovariogramCheck/MeasureConclusion.lean) | Da somma, prodotto e trasporto del rapporto logaritmico segue l'uguaglianza globale, diretta o scambiata, delle densità e delle misure definite da esse. Include il caso di rapporto identicamente nullo. | Non identifica queste misure con le misure di area dei corpi, né applica l'unicità di Minkowski. |

Il numero dei lemmi non misura la percentuale di dimostrazione completata. Gli obblighi geometrici ancora aperti sono sostanziali.

## Un risultato analitico concreto

Scrivendo

\[
R_{x,y}(\tau)=\log\frac{x^2+(\tau-y)^2}{x^2+(\tau+y)^2},
\]

Lean verifica, per x ≠ 0, |y| ≤ M, τ > 0 e τ ≥ 4M,

\[
\left|R_{x,y}(\tau)+\frac{4\tau y}{x^2+\tau^2}\right|
\le \frac{36M^3\tau}{(x^2+\tau^2)^2}
\le \frac{36M^3}{\tau x^2}.
\]

Se gli xₙ sono non nulli, |yₙ| ≤ M e Σ 1/xₙ² è finita, verifica quindi la sommabilità dei resti e

\[
\sum_n R_{x_n,y_n}(\tau)
+4\tau\sum_n\frac{y_n}{x_n^2+\tau^2}\longrightarrow0.
\]

Il maggiorante della somma è O(1/τ), più debole dell'O(1/τ²) del quaderno ma sufficiente per questo passaggio. La sostituzione delle parti reali è inoltre verificata usando

\[
\left|\frac{\tau}{x^2+\tau^2}-\frac{\tau}{a^2+\tau^2}\right|
\le D\left(\frac1{x^2}+\frac1{a^2}\right),
\quad |x-a|\le D,\quad x,a,\tau>0,
\]

e la convergenza dominata per le serie. Non si differenzia una serie infinita.

## Obblighi ancora non formalizzati

1. Definizioni geometriche in R³ e collegamento tra uguaglianza dei covariogrammi, corpo differenza, luminosità e identità delle trasformate di Fourier–Laplace.
2. Risultati spettrali di Bianchi per K ∈ C⁹₊: esistenza, analiticità globale, localizzazione, semplicità e completezza dei rami di zeri. Anche la loro applicazione al concorrente L e la parametrizzazione sferica vanno formalizzate.
3. Fattorizzazione di Hadamard per funzioni intere di ordine al più uno; prodotto degli zeri accoppiati, esponenziale residuo, passaggio ai logaritmi sull'asse immaginario e confronto con i limiti di Laplace. Il file Hadamard di mathlib trovato durante l'ispezione riguarda un altro teorema, quello delle tre rette.
4. Lemma sul concorrente arbitrario: regolarità C¹,¹ del supporto, misura di area senza parte singolare, sviluppo quadratico quasi ovunque, asintotica delle sezioni anche nel caso degenere e positività delle pendenze ottenuta dal prodotto delle trasformate.
5. Formula di Cauchy per le proiezioni e iniettività della trasformata del coseno sulle misure pari, per ottenere l'identità di somma delle densità.
6. Collegamento fra le asintotiche effettive degli zeri e tutte le ipotesi dei lemmi sulle serie; massa tendente a uno dei pesi specifici; riscalamento comune e trattamento dei termini eccezionali. Le ipotesi generali dei lemmi sono esplicite e non vengono confuse con queste applicazioni.
7. Identificazione delle misure definite dalle densità con le misure di area; teorema di unicità di Minkowski; conclusione in termini di traslazioni e riflessioni dei corpi.

I punti 2–7 non sono stati introdotti come assiomi per ottenere una falsa certificazione dell'enunciato finale. Alcuni strumenti necessari esistono in mathlib (per esempio il teorema di Rademacher), ma le applicazioni al problema non sono ancora state scritte. L'ispezione della libreria non costituisce una prova esaustiva dell'assenza di tutti i risultati elencati.

## Ripetere il controllo

Nell'ambiente locale già preparato:

```bash
cd formalizzazione
./check.sh
```

Lo script compila il progetto, rielabora tutti i sorgenti con gli avvisi trattati come errori, controlla gli assiomi transitivamente utilizzati e salva:

- [build.log](verifica/build.log): compilazione Lake;
- [kernel.log](verifica/kernel.log): verifica diretta di ogni sorgente;
- [axioms.log](verifica/axioms.log): audit e tipi di tre conclusioni principali;
- [sources.sha256](verifica/sources.sha256): impronte dei sorgenti verificati;
- [versions.txt](verifica/versions.txt): data UTC, versione del compilatore e revisione mathlib.

[Audit.lean](Audit.lean) esamina tutti i teoremi nel namespace `CovariogramCheck`, inclusi quelli ausiliari generati dalle tattiche. Fallisce se trova assiomi diversi da `propext`, `Classical.choice` e `Quot.sound`, le usuali basi classiche di Lean/mathlib. Questo esclude anche dipendenze da `sorryAx` o da assiomi matematici introdotti appositamente. `autoImplicit = false` evita parametri impliciti generati accidentalmente da nomi non dichiarati. I lemmi restano condizionati dalle ipotesi presenti nei loro tipi: un audit degli assiomi non elimina quelle ipotesi.

## Ambiente

- Lean **4.24.0**, commit `797c613eb9b6d4ec95db23e3e00af9ac6657f24b`, distribuzione ufficiale per macOS arm64.
- mathlib tag **v4.24.0**, commit `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`.
- Binari locali in `../.tools/lean/lean-4.24.0-darwin_aarch64/bin`; mathlib in `../.tools/mathlib4`.
- Le dipendenze di mathlib sono fissate nel manifest; `.lake/packages` condivide la loro cartella locale tramite collegamento simbolico.
- L'installazione non modifica il profilo della shell o l'ambiente globale. Lo script di controllo non richiede accesso alla rete dopo la preparazione.

Le istruzioni per un nuovo checkout sono nel [README principale](../README.md#lean). Lo script cerca Lean/Lake nel `PATH`, accetta in alternativa `LEAN_BIN` e conserva il percorso locale come ripiego. Verifica la versione 4.24.0 e la revisione esatta di mathlib prima della compilazione. Il repository mathlib è una dipendenza locale da scaricare nel percorso documentato; il solo `lake-manifest.json` non ne scarica una copia su un computer nuovo. La procedura su una macchina nuova non è ancora stata verificata.

## Formula corretta per una comunicazione esterna

“La proposta è accompagnata da una formalizzazione Lean di alcuni lemmi analitici e delle deduzioni finali sulle densità. La derivazione delle ipotesi geometriche e spettrali dall'uguaglianza dei covariogrammi e il teorema completo non sono ancora formalizzati.”

Non sarebbe corretto scrivere “la dimostrazione dell'unicità è verificata in Lean”. La successiva revisione di Bianchi rimane necessaria per valutare la prova candidata, e non può essere sostituita dall'audit parziale qui registrato.
