
extends Area2D

const FORCE = 500.0

func _ready():
	pass

func _on_impulse_body_enter( body ):
	body.set_linear_velocity(Vector2(0, -1).rotated(get_rot())*FORCE)
	body.input_hold_time = 0.5
