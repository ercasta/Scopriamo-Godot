extends KinematicBody2D


export (int) var velocita_corsa = 300
export (int) var velocita_salto = -800
export (int) var forza_di_gravita = 2000

var velocita = Vector2()
var sta_camminando = false
var morto = false

# carico già in memoria l'onda d'urto
const SLASH = preload("res://Slash.tscn")

func _ready():
	$Animazioni.set_flip_h(false) #giro il personaggio dall'altra parte

func lancia_slash():
	var slash = SLASH.instance()
	get_parent().add_child(slash)
	# Devo prendere la posizione nel mondo di gioco del "punto attacco"
	slash.position = $PuntoAttacco.global_position
	if $Animazioni.flip_h:
		slash.imposta_direzione(-1)

func vai_a_destra():
	velocita.x += velocita_corsa

	#Completa qui! (2 righe)
	
	# Fine

	sta_camminando = true

	#gira il "punto" da cui parte l'attacco
	if sign($PuntoAttacco.position.x) == -1:
		$PuntoAttacco.position.x *= -1

func vai_a_sinistra():
	velocita.x -= velocita_corsa

	#Completa qui! (2 righe)


	# Fine

	sta_camminando = true

	if sign($PuntoAttacco.position.x) == 1:
		$PuntoAttacco.position.x *= -1

func get_input():
	velocita.x = 0

	#just pressed: vuol dire appena premuto. E' diverso rispetto a quando si tiene premuto ("is_action_pressed")
	var salta = Input.is_action_just_pressed('salta')
	var attacca = Input.is_action_just_pressed('attacca')

	if salta and is_on_floor():
		#sta_saltando = true
		velocita.y = velocita_salto
		$Animazioni.play("fermo")
		sta_camminando = false

	### COMPLETA QUI
	var destra =  null  #completa qui! ...
	var sinistra = null  #completa qui! ...

	if destra:
		# fai qualcosa qui
		pass

	if sinistra:
		# fai qualcosa qui
		pass

	## Fine

	if not (sinistra or destra):
		sta_camminando = false
	if attacca:
		$Animazioni.play("attacco")
		sta_camminando = false
		lancia_slash()

	if not sta_camminando and $Animazioni.animation == "camminata":
		$Animazioni.stop()
		$Animazioni.play("fermo")

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
				morto()


func _on_AnimatedSprite_animation_finished():
	$Animazioni.play("fermo")
	sta_camminando=false


func _on_Rinasci_timeout():
	global_position = Vector2(600,10)
	velocita = Vector2(0,0)
	$CollisionShape2D.disabled=false
	morto = false
	show()
