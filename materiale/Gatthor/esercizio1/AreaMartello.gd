extends Area2D


var vel = Vector2()
var direzione = 1

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func imposta_direzione(dir):
	direzione = dir
	if dir < 0:
		$Animazione.flip_h = true
		
	
func _physics_process(delta):
	vel.x = VELOCITA * delta * direzione
	translate(vel)
	$Animazione.play("default")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Slash_body_entered(body):
    if "Alieno" in body.name:
	    body.flippalo()
	    queue_free()