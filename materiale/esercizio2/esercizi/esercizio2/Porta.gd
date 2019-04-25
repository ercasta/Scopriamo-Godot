extends Area2D

# La "export" serve per rendere visibile questa variabile
# nell'editor
export(String,FILE,"*.tscn") var scena_destinazione


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Porta_body_entered(body):
	if "Personaggio" in body.name:
		get_tree().change_scene(scena_destinazione)
		