extends KinematicBody2D

var velocite = Vector2()
export var vitesse = 50
export var vie = 2
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
	m.creer(canon.global_position,corps.rotation)
	get_parent().add_child(m)

func _on_Timer_timeout():
	fire()
