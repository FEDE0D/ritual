
extends Area2D

var first = false

func _ready():
	pass

func _on_hole_body_enter( body ):
	get_node("graphics/Sprite1").hide()
	body.do_fall()
	if not first:
		first = true
		get_node("SamplePlayer").play("agua_primero")
	else:
		var r = randi()%2
		if r == 0:
			get_node("SamplePlayer").play("agua1")
		elif r == 1:
			get_node("SamplePlayer").play("agua2")
