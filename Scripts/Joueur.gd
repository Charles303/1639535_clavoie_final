extends KinematicBody2D

export (PackedScene) var balle
export var vitesse = 100
var velocite = Vector2()
onready var canon = $canon

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_input():
	var avance = Input.is_action_pressed("avance")
	var recule = Input.is_action_pressed("arriere")
	var gauche = Input.is_action_pressed("gauche")
	var droite = Input.is_action_pressed("droite")
	var shoot = Input.is_action_just_pressed("shoot")
	
	if avance:
		velocite = Vector2(vitesse,0).rotated(rotation)
	if recule:
		velocite = Vector2(vitesse,0).rotated(rotation - 3)
	if gauche:
		velocite = Vector2(vitesse,0).rotated(rotation - 1.5)
	if droite:
		velocite = Vector2(vitesse,0).rotated(rotation + 1.5)
	if shoot:
		var b = balle.instance()
		b.creer(canon.global_position,rotation)
		get_parent().add_child(b)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	get_input()
	var dir = get_global_mouse_position() - global_position
	if dir.length() > 10:
		rotation = dir.angle() #rotation entre -3 et 3
		velocite = move_and_slide(velocite)
	var collision = move_and_collide(velocite*delta)
