extends KinematicBody2D


export (int) var velocita_corsa = 300
export (int) var velocita_salto = -800
export (int) var forza_di_gravita = 2000

var velocita = Vector2()
var sta_camminando = false
var morto = false

# carico già in memoria l'onda d'urto
const SLASH = preload("res://Slash.tscn")
const AREAMARTELLO = preload("res://AreaMartello.tscn")

func _ready():
	$Sprite.set_flip_h(false) #giro il personaggio dall'altra parte
	$Sprite.frame=5
	$AreaMartello.collision_layer=0
	$AreaMartello.collision_mask=0
	
func lancia_slash():
	var slash = SLASH.instance()
	get_parent().add_child(slash)
	# Devo prendere la posizione nel mondo di gioco del "punto attacco"
	slash.position = $PuntoAttacco.global_position
	if $Sprite.flip_h:
		slash.imposta_direzione(-1)

func martella():
	var area_martello = AREAMARTELLO.instance()
	get_parent().add_child(area_martello)
	area_martello.position = $PuntoAttacco.global_position

		
func vai_a_destra():
	velocita.x += velocita_corsa

	#Completa qui! (2 righe)
	$AnimationPlayer.play("camminata")
	$Sprite.set_flip_h(false) # true o false dipende dal lato verso cui è rivolto il personaggio.
	# Fine

	sta_camminando = true

	#gira il "punto" da cui parte l'attacco
	if sign($PuntoAttacco.position.x) == -1:
		$PuntoAttacco.position.x *= -1
		#gira pure l'area del martello
		$AreaMartello.position.x *= -1
	

func vai_a_sinistra():
	velocita.x -= velocita_corsa

	#Completa qui! (2 righe)
	$AnimationPlayer.play("camminata")
	$Sprite.set_flip_h(true) # true o false dipende lato verso cui è rivolto il personaggio.

	# Fine

	sta_camminando = true

	if sign($PuntoAttacco.position.x) == 1:
		$PuntoAttacco.position.x *= -1
		#gira pure l'area del martello
		$AreaMartello.position.x *= -1

func get_input():
	velocita.x = 0

	#just pressed: vuol dire appena premuto. E' diverso rispetto a quando si tiene premuto ("is_action_pressed")
	var salta = Input.is_action_just_pressed('salta')
	var attacca = Input.is_action_just_pressed('attacca')

	if salta and is_on_floor():
		#sta_saltando = true
		velocita.y = velocita_salto
		$AnimationPlayer.play("fermo")
		sta_camminando = false

	### COMPLETA QUI
	var destra = Input.is_action_pressed("ui_right")
	var sinistra = Input.is_action_pressed("ui_left")
	
	if destra:
	    vai_a_destra()
	if sinistra:
    	vai_a_sinistra()

	## Fine

	if not (sinistra or destra):
		sta_camminando = false
	if attacca:
		$AnimationPlayer.play("attacco")
		sta_camminando = false
		#lancia_slash()

	if not sta_camminando and $AnimationPlayer.get_current_animation()=="camminata" and $AnimationPlayer.is_playing():
		$AnimationPlayer.stop()
		$AnimationPlayer.play("fermo")

func morto():
	hide()
	morto = true
	$CollisionShape2D.disabled=true
	$Rinasci.start()

func _physics_process(delta):
	if not morto:
		get_input()
	velocita.y += forza_di_gravita * delta
	#if sta_saltando and is_on_floor():
	#	sta_saltando = true
	velocita = move_and_slide(velocita, Vector2(0, -1))
	if get_slide_count()>0:
		for i in range(get_slide_count()):
			if "Alieno" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.toccato(self) #toccato




func _on_Rinasci_timeout():
	global_position = Vector2(0,-300)
	velocita = Vector2(0,0)
	$CollisionShape2D.disabled=false
	morto = false
	show()


func _on_AnimationPlayer_animation_finished(anim_name):
#	$AnimationPlayer.play("fermo")
	if anim_name=="camminata" and not sta_camminando:
		 $AnimationPlayer.play("fermo")

	if anim_name=="attacco":
		$AreaMartello.collision_layer=0
		$AreaMartello.collision_mask=0
		$Camera2D.offset=Vector2(0,0)

func _on_AreaMartello_body_entered(body):
	if "Alieno" in body.name:
		body.flippalo()
	 # Replace with function body.
