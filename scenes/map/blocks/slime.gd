
extends Area2D

func _ready():
	pass

func _on_slime_body_enter( body ):
	body.SPEED_MULTIPLIER = 0.5
	var r = randi() % 3
	if r == 0:
		get_node("SamplePlayer").play("PisadaAgua_1")
	if r == 1:
		get_node("SamplePlayer").play("PisadaAgua_2")
	if r == 2:
		get_node("SamplePlayer").play("PisadaAgua_3")
