extends KinematicBody2D

var vitesse = 500
var velocite = Vector2()
var direction
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	var collision = move_and_collide(velocite*delta)

func creer(pos,dir):
	position = pos
	direction = dir
	velocite = Vector2(vitesse,0).rotated(direction)
