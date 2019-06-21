extends Node2D


var alienoScene = preload("res://Alieno.tscn") as PackedScene
var creati = 0

func crea_alieno(i):
	var alieno = alienoScene.instance()
	alieno.name="Alieno"+str(i)
	get_parent().add_child(alieno)
	
func _ready():
	$Timer.start()


func _on_Timer_timeout():
	if creati < 3:
		crea_alieno(creati)
		creati = creati + 1 
		$Timer.start()		
