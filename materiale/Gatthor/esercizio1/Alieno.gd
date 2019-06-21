extends KinematicBody2D


export (int) var run_speed = 100
export (int) var gravity = 2000

const SALUTE_BASE = 3
var salute = 3
var vivo = true
var schienato = false

var velocity = Vector2(run_speed,0)

func morto():
	salute = salute - 1	
	if salute <= 0:
		hide()
		$CollisionShape2D.disabled=true
		vivo = false
		$Rinasci.start()

func toccato(body):
	if schienato:
		$CollisionShape2D.disabled=true
		$Rinasci.start()
	else:
		body.morto()
		
func flippalo():
	if not schienato:
		var tween = $Tween
		schienato = true
		tween.interpolate_property(self, "rotation", 0, deg2rad(180), 0.5, Tween.TRANS_BACK, Tween.EASE_OUT, 0)
		tween.start()
		$Rigirati.start()
		
func _ready():
	$AnimatedSprite.set_flip_h(false)
	$AnimatedSprite.play("default")
	schienato = false
	rinasci()


func _physics_process(delta):
	velocity.y += gravity * delta
	var vel_precedente = velocity.x
	if schienato:
		velocity.x=0
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
	global_position = Vector2(50,-100)
	velocity = Vector2(run_speed,0)
	$CollisionShape2D.disabled=false
	call_deferred("show")
	
func _on_Rinasci_timeout():
	$Rigirati.stop()
	self.rotation=0
	self.schienato=false
	rinasci()

func rigirati():
	var tween = $Tween
	tween.interpolate_property(self, "rotation", deg2rad(180), 0, 0.5, Tween.TRANS_BACK, Tween.EASE_IN, 0)
	tween.start()
	schienato=false
	
func _on_Rigirati_timeout():
	rigirati()
