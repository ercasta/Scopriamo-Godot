.. _ComeSiFa:

**********************
Come si fa
**********************

Questa sezione spiega come fare delle cose specifiche in Godot. 


Fare qualcosa se un tasto è premuto
================================================

Per fare qualcosa quando si preme un tasto, bisogna innanzitutto configurare un'azione nel menu ``Progetto->Impostazioni Progetto->Mappa Input``:

.. figure:: img/Mappa_Input.png
   :alt: Mappa Input

Si scrive il nome dell'azione e si preme su ``Aggiungi``:

.. figure:: img/aggiungi_azione.png
   :alt: Aggiungi Azione

Poi si specifica il tasto:

.. figure:: img/aggiungi_tasto.png
   :alt: Aggiungi Tasto

.. figure:: img/premi_tasto.png
   :alt: Premi un Tasto

Infine, si può usare l'azione nel codice: ::

    var colpisci = Input.is_action_pressed('colpisci')
    if colpisci:
        # fai qualcosa

.. IMPORTANT:: ci sono due funzioni simili: ``Input.is_action_pressed`` e ``Input.is_action_just_pressed``. La prima 
    serve per controllare se il tasto è premuto. La seconda per controllare se è stato **appena** premuto. La prima funzione va 
    bene ad esempio per i tasti freccia, perchè finchè il tasto è premuto, il personaggio si sposta. La seconda va bene per quando
    si attacca: ogni volta che viene premuto il tasto, il personaggio attacca 


Animazioni!
================================================

In Godot per fare le animazioni si usano i Nodi di tipo `AnimatedSprite`. 

Ad esempio per il gioco del Cavaliere Miaogico, usiamo il nodo `Animazioni`:

.. figure:: img/animazione/nodo_animazione.png
   :alt: Il nodo `Animazioni`

Cliccando sul nodo, possiamo vedere che una delle sue proprietà si chiama `Frames`. I `Frames` sono un pò come i costumi di Scratch, ma possono essere raggruppati in animazioni diverse. Cliccando sulla parte bassa della finestra di Godot, sulla parola `SpriteFrames`, vengono visualizzate tutte le animazioni presenti.
Ad esempio per il gioco del Cavaliere Miaogico, ci sono animazioni diverse per l'attacco e la camminata; ognuna ha i suoi costumi:

.. figure:: img/animazione/frames.png
   :alt: Il frames

Per far partire un'animazione usiamo le funzioni `play()` e `stop()`. Ad esempio, nello script del Personaggio: ::

    $Animazioni.play("camminata")
    $Animazioni.set_flip_h(true)

.. NOTE:: la funzione `set_flip_h(true)` serve per riflettere orizzontalmente l'animazione. Serve per poter usare la stessa animazione sia quando il Personaggio è rivolto verso destra che verso sinistra.

Aggiungere una "Camera"
================================================

La ``Camera`` serve per inquadrare sempre il personaggio anche se il livello è più grande dello schermo

Per prima cosa bisogna aggiungere un nodo ``Camera2d`` al personaggio:

.. figure:: img/camera/camera.png
   :alt: Nodo Camera2d

Poi si configurano le opzioni. ``Current`` va impostato a ``On`` se si vuole che la ``Camera`` sia attiva. I ``Limiti`` servono per fare in modo che la ``Camera`` non inquadri mai oltre il bordo del livello. In questo esempio sono impostati a mano:

.. figure:: img/camera/camera_opzioni.png
   :alt: Opzioni Camera


Disegnare il livello
================================================

Per disegnare il livello bisogna agire sul nodo `TileMap` (letteralmente vuol dire "mappa di piastrelle"):

.. figure:: img/tilemap/nodo.png
   :alt: Nodo TileMap

Selezionando il nodo `TileMap` appaiono tante piastrelle diverse utilizzabili

.. NOTE:: le piastrelle le abbiamo preparate noi. Per prepararle bisogna fare un pò di passaggi, che spiegheremo in un altro "come si fa". 

.. figure:: img/tilemap/seleziona-tile.png
   :alt: Seleziona Piastrella

Dopo aver selezionato una piastrella:

- con il tastro sinistro si aggiunge la piastrella al livello
- con il tasto destro si cancella

il tasto sinistro / destro si possono anche tenere premuti, per essere più veloci.


Usare i "segnali"
================================================

In Godot alcuni nodi hanno la possibilità di mandare dei "segnali", che sono un pò come i messaggi di Scratch.
In Godot però i messaggi non vengono inviati a tutti gli altri nodi. Bisogna collegarli. Per farlo, bisogna andare nella sezione "Nodo" del nodo. Ad esempio per il gioco del Cavaliere Miaogico, usiamo il nodo `Slash`

.. figure:: img/slash/seleziona_nodo.png
   :alt: Il nodo `Slash`

Scegliamo il segnale che ci interessa: `body_entered`, che vuol dire che un altro oggetto (in questo caso un nemico) è "entrato" nello slash (o viceversa):

.. figure:: img/slash/segnale.png
   :alt: Il segnale `body_entered`

E lo colleghiamo a una funzione. Godot è così gentile da creare per noi una funzione con un nome appropriato:

.. figure:: img/slash/metodo.png
   :alt: La scelta della funzione.

Infine possiamo fare qualcosa nella funzione, ad esempio: ::

    func _on_Slash_body_entered(body):
        if "Alieno" in body.name:
            body.morto()
            queue_free()



Scegliere la scena iniziale
================================================
I giochi in Godot sono organizzati in scene. Quando premiamo il tasto "play", Godot fa partire la scena iniziale.
La scena iniziale si imposta dal menù `Progetto -> Impostazioni Progetto`>:

.. figure:: img/selezione_scena_iniziale/impostazioni_progetto.png
   :alt: Il menù `Impostazioni progetto`

La scena iniziale si sceglie nella sezione `Run`:

.. figure:: img/selezione_scena_iniziale/scena_iniziale.png
   :alt: Il menù `Run`
