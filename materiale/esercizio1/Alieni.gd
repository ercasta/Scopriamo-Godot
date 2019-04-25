extends Node2D


const ALIENO = preload("res://Alieno.tscn")

func crea_alieno(i):
	var alieno = ALIENO.instance()
	alieno.name="Alieno"+str(i)
	get_parent().call_deferred("add_child",alieno)
	alieno.rinasci()

func crea_alieni(quanti):
	for i in range(quanti):
		# fai qualcosa
		pass
	
func _ready():
	crea_alieni(3)
	
