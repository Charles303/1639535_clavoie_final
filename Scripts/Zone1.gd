extends Node




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalScript.restantEnnemi == 0:
		get_tree().change_scene("res://Scenes/Zone2.tscn")
		GlobalScript.restantEnnemi = 5
