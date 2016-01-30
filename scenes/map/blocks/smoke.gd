
extends Area2D

func _ready():
	pass

func _on_smoke_body_enter( body ):
	get_node("Particles2D").set_emitting(true)
#	get_node("AnimationPlayer").play("free")
#	body.SPEED_MULTIPLIER = 0.0
	body.inverse_time = 4.0
