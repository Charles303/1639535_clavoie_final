extends KinematicBody2D

var velocite = Vector2()
export var vitesse = 100
export (PackedScene) var balle
onready var canon = $Corps/Canon
onready var corps = $Corps
var joueur = load("res://Scenes/Joueur.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	fire()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var dir = GlobalScript.joueurpos - global_position #direction du joueur
	corps.rotation = dir.angle() #rotation entre -3 et 3
	

func _on_Area2D_body_entered(body):
	if body.is_in_group("Balle"):
		queue_free()
		GlobalScript.restantEnnemi = GlobalScript.restantEnnemi - 1

func fire():
	var b = balle.instance()
	b.creer(canon.global_position,corps.rotation)
	get_parent().add_child(b)


func _on_Timer_timeout():
	fire()
