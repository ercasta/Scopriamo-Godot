
.. _Il Cavaliere Miaogico:

Il Cavaliere Miaogico
==================================

Per questo esercizio ti serve il progetto di base :download:`Il Cavaliere Miaogico <files/Il Cavaliere Miaogico.zip>`

I passaggi dell'esercizio sono:

- Far muovere il gattino a destra e sinistra 
- Animazioni!
- Modifichiamo il livello 
- Camera! 
- Alieni!
- Colpire il nemico 

.. TIP:: Aiutati con il :ref:`ComeSiFa` !

Far muovere il gattino a destra e sinistra
------------------------------------------------------
Vogliamo far muovere il gattino a destra e a sinistra

.. HINT:: Ecco come fare

    All'interno dello script del personaggio, puoi fare: ::
    
        ### COMPLETA QUI
        var destra = Input.is_action_pressed("ui_right") 
        var sinistra = Input.is_action_pressed("ui_left")
        
        if destra:
            vai_a_destra() 
        if sinistra:
            vai_a_sinistra() 


Animazioni!
------------------------------------------------------
Vogliamo far "camminare" il gattino in maniera più realistica, usando un'animazione

.. HINT:: Ecco come fare

    All'interno dello script del personaggio, nelle funzioni ``vai_a_destra`` e ``vai_a_sinistra`` puoi fare: ::

        ### COMPLETA QUI
        $Animazioni.play("camminata")
        $Animazioni.set_flip_h(true) # true o false dipende dal lato verso cui è rivolto il personaggio.

Modifichiamo il livello
------------------------------------------------------
Vogliamo creare un livello molto più grande, per far andare in giro il nostro gattino.

Per questo passo, guarda il :ref:`ComeSiFa` !

Camera!
------------------------------------------------------
Ora che il livello è più grande, ci serve qualcosa per inquadrare il personaggio. Proprio come in una partita di calcio, ci serve una telecamera! 

Per questo passo, guarda il :ref:`ComeSiFa` !


Alieni!
------------------------------------------------------
Al gattino serve qualche degno avversario. Nel ``Livello`` c'è un nodo ``Alieni`` con uno script da completare...



.. HINT:: Ecco come fare! 

    Usiamo un'istruzione ``for``, che è come il ``ripeti N volte`` di Scratch: ::

        for i in range(quanti):
            # fai qualcosa
            crea_alieno(i)


Colpire il nemico
------------------------------------------------------
Per colpire il nemico, innanzitutto dobbiamo collegare il segnale del nostro ``Slash`` come mostrato nel :ref:`ComeSiFa`

Poi dobbiamo scrivere del codice: ::

    func _on_Slash_body_entered(body):
        if "Alieno" in body.name:
            body.morto()
            queue_free()
