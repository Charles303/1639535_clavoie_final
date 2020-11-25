extends KinematicBody2D

export (PackedScene) var balle
export var vitesse = 100
export var pcvie = 100 #vie en pourcentage
var velocite = Vector2()
onready var canon = $Corps/canon
onready var sonTir = $shootSound
onready var corps = $Corps
onready var colcoprs = $collisioncorps
onready var vielabel = $vielabel
onready var labelennemis = $ennemis
var dir

# Called when the node enters the scene tree for the first time.
func _ready():
	var strnbvie = str(pcvie)
	vielabel.set_text("Vie % : " + strnbvie)


func get_input():
	var avance = Input.is_action_pressed("avance")
	var recule = Input.is_action_pressed("arriere")
	var gauche = Input.is_action_pressed("gauche")
	var droite = Input.is_action_pressed("droite")
	var shoot = Input.is_action_just_pressed("shoot")
	
	if avance:
		velocite = Vector2(vitesse,0).rotated(corps.rotation) #doit utiliser la rotation du corps sinon utilise les axes
	if recule:
		velocite = Vector2(vitesse,0).rotated(corps.rotation - 3)
	if gauche:
		velocite = Vector2(vitesse,0).rotated(corps.rotation - 1.5)
	if droite:
		velocite = Vector2(vitesse,0).rotated(corps.rotation + 1.5)
	if shoot:
		var b = balle.instance()
		b.creer(canon.global_position,corps.rotation)
		get_parent().add_child(b)
		sonTir.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pcvie < 1:
		get_tree().change_scene("res://Scenes/GameOver.tscn")
	labelennemis.set_text("Ennemis : " + str(GlobalScript.restantEnnemi))
	GlobalScript.joueurpos = corps.global_position
func _physics_process(delta):
	get_input()
	dir = get_global_mouse_position() - global_position
	if dir.length() > 10:
		corps.rotation = dir.angle() #rotation entre -3 et 3
		colcoprs.rotation = dir.angle() #change la rotation du corps et celle de sa zone de collision
		velocite = move_and_slide(velocite)
	var collision = move_and_collide(velocite*delta)
