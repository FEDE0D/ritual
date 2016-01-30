
extends Area2D

func _ready():
	pass

func _on_slime_body_enter( body ):
	body.SPEED_MULTIPLIER = 0.5
