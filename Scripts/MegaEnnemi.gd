extends KinematicBody2D

var velocite = Vector2()
export var vitesse = 50
export var vie = 3
export (PackedScene) var balle
export (PackedScene) var missile
onready var canon = $Corps/Canon
onready var corps = $Corps

# Called when the node enters the scene tree for the first time.
func _ready():
	fire()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if vie < 1:
		queue_free()
		GlobalScript.restantEnnemi = GlobalScript.restantEnnemi - 1

func _physics_process(delta):
	var dir = GlobalScript.joueurpos - global_position #direction du joueur
	corps.rotation = dir.angle() #rotation entre -3 et 3
	velocite = Vector2(vitesse,0).rotated(corps.rotation) #doit utiliser la rotation du corps sinon utilise les axes
	velocite = move_and_slide(velocite)


func _on_Area2D_body_entered(body):
	if body.is_in_group("Balle"):
		vie = vie - 1
		get_tree().queue_delete(body) #efface la balle qui l'a touché

func fire():
	var m = missile.instance()
	var b = balle.instance()
	var b2 = balle.instance()
	m.creer(canon.global_position,corps.rotation)
	b.creer(canon.global_position,corps.rotation - 0.4) #balle 1
	b2.creer(canon.global_position,corps.rotation + 0.4) #balle 2
	get_parent().add_child(m)
	get_parent().add_child(b)
	get_parent().add_child(b2)

func _on_Timer_timeout():
	fire()
