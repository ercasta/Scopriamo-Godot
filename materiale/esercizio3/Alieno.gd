extends KinematicBody2D


export (int) var run_speed = 100
export (int) var gravity = 2000

const SALUTE_BASE = 3
var salute = 3
var vivo = true

var velocity = Vector2(run_speed,0)

func morto():
	salute = salute - 1
	if salute <= 0:
		hide()
		vivo = false
		$Rinasci.start()
	
func _ready():
	$AnimatedSprite.set_flip_h(false)
	$AnimatedSprite.play("default")


func _physics_process(delta):
	if vivo == false:
		$CollisionShape2D.disabled=true
	else:
		$CollisionShape2D.disabled=false
	velocity.y += gravity * delta
	var vel_precedente = velocity.x
	velocity = move_and_slide(velocity, Vector2(0, -1))
	if get_slide_count()>0:
		for i in range(get_slide_count()):
			if "Personaggio" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.morto()
				
	if is_on_wall():
		velocity.x = -1*vel_precedente
		if velocity.x < 0:
			$AnimatedSprite.set_flip_h(true)
		

func rinasci():
	salute = SALUTE_BASE
	vivo = true
	global_position = Vector2(randi()%1600 - 800,200)
	velocity = Vector2(run_speed,0)
	$CollisionShape2D.disabled=false
	show()
	
func _on_Rinasci_timeout():
	rinasci()
