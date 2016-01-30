
extends Area2D

func _ready():
	pass

func _on_hole_body_enter( body ):
	get_node("graphics/Sprite1").hide()
	body.do_fall()
