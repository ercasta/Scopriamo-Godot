extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func scuoti():
	var tween = $Tween
	tween.interpolate_property(self, "offset", Vector2(0,1), Vector2(0,0), 0.2, Tween.TRANS_SINE, Tween.EASE_OUT, 0)
	tween.start()
	tween.interpolate_property(self, "offset", Vector2(0,-1), Vector2(0,0), 0.2, Tween.TRANS_SINE, Tween.EASE_OUT, 0)
	tween.start()
	pass
