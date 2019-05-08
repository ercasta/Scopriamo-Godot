extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var scena_corrente
var scena_precedente
var punto_destinazione

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func cambia_scena(destinazione):
	call_deferred("_cambia_scena_differito", destinazione)
		
func _cambia_scena_differito(scena_destinazione):
    # Adesso possiamo cambiare la scena
	var root = get_tree().get_root()
	# questo è il modo per recuperare la scena attuale
	scena_precedente = root.get_child(root.get_child_count() - 1)
	scena_precedente.free() #cancella la scena, non ci serve più
	
	# Carica la nuova scena
	var nuova_scena_caricata = ResourceLoader.load(scena_destinazione)

	# Instance the new scene.
	var nuova_scena = nuova_scena_caricata.instance()

	scena_corrente = scena_destinazione # la nuova scena corrente è quella verso cui stiamo andando
	get_tree().get_root().add_child(nuova_scena)
	get_tree().set_current_scene(nuova_scena)
	