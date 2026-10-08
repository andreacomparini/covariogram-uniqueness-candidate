# Il problema del covariogramma

Registro bibliografico e percorso di studio verso il problema di unicità per i corpi convessi tridimensionali.

**Paper tecnico in inglese — 9 ottobre 2026:** [Covariogram Uniqueness with One Regular Body in R³](paper/covariogram-uniqueness-candidate.tex), con quattro appendici di dimostrazioni e [supplementi separati per Lean e diagnostica](paper/README.md). È una prova candidata per il caso con primo corpo C⁹₊ e concorrente arbitrario, destinata alla revisione matematica; non è un risultato convalidato.

Aggiornamento: 8 ottobre 2026. Questa prima versione seleziona le tappe fondamentali e alcuni sviluppi recenti; non pretende di censire ogni articolo sul covariogramma. La ricerca effettuata non ha individuato una soluzione generale successiva alla rassegna del 2023.

- [Registro delle pubblicazioni](bibliografia/registro.md): riferimenti cronologici, collegamenti ai documenti originali, contributi e priorità di lettura.
- [Saggio e percorso di studio](saggi/evoluzione-e-percorso.md): definizioni, evoluzione delle idee, dimostrazioni introduttive, prerequisiti ed esercizi, proposte di ricerca distinte dai teoremi.
- [Quaderno sugli scambi antipodali](ricerca/rigidita-scambi-covariogramma.tex): criteri di unicità e proposta di dimostrazione per un corpo C⁹₊ confrontato con concorrenti convessi arbitrari, caso esplicitamente aperto nella rassegna del 2023. Il passaggio proposto usa dati quadratici quasi ovunque e una media degli scambi degli zeri della trasformata. Sono sviluppate anche ipotesi di regolarità più deboli. La proposta richiede verifica matematica e confronto bibliografico; non è una soluzione acquisita del problema generale. [Controlli algebrici](ricerca/verifica_scambi.py) e [diagnostica delle formule spettrali](ricerca/verifica_media_zeri.py).
- [Controllo Lean](formalizzazione/README.md), avviato il 9 ottobre 2026: 33 lemmi formalizzati e verifica ripetibile. La copertura è parziale: il teorema di unicità e i collegamenti geometrici e spettrali principali non sono ancora certificati.

## Come iniziare

Leggere i primi quattro capitoli del saggio e svolgere gli esercizi di base. Passare poi ai lavori R08, R09 e R12 del registro. Il capitolo sulla stabilità riprende la strategia dell'approssimazione poliedrale discussa in questa conversazione e ne esplicita il punto ancora irrisolto.

## Come aggiornare il materiale

Assegnare a ogni nuovo riferimento un identificatore R successivo, senza rinumerare gli esistenti. Registrare separatamente l'anno del preprint e quello della pubblicazione. Collegare una pagina dell'autore, arXiv o l'editore; distinguere il manoscritto dalla versione editoriale. Per modificare lo stato di un problema aperto, riportare il teorema preciso, le ipotesi e la fonte originale.

Il saggio cresce aggiungendo risultati nei capitoli pertinenti e aggiornando il percorso di lettura. Le direzioni proposte restano ipotesi di lavoro finché non sono accompagnate da una dimostrazione verificata. Questo registro non viene aggiornato automaticamente.
