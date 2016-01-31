
extends Area2D

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	for c in get_overlapping_bodies():
		c.MAX_SPEED_MULTIPLIER = 0.5

func _on_slime_body_enter( body ):
	var r = randi() % 3
	if r == 0:
		get_node("SamplePlayer").play("PisadaAgua_1")
	if r == 1:
		get_node("SamplePlayer").play("PisadaAgua_2")
	if r == 2:
		get_node("SamplePlayer").play("PisadaAgua_3")
