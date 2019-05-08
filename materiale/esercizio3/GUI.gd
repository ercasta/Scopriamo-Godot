extends MarginContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Personaggio_energia_modificata(nuovo_valore):
	$HBoxContainer/Energia/MarginContainer/Sfondo/Valore.text = str(nuovo_valore)
	$HBoxContainer/Energia/TextureProgress.value=nuovo_valore
	pass # Replace with function body.
