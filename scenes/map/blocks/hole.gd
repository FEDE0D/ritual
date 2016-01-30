
extends Area2D

func _ready():
	pass

func _on_hole_body_enter( body ):
	body.do_fall()
