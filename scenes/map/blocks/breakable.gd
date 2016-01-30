
extends StaticBody2D

const DAMAGE = 0.35
var health = 1.0

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if get_node("Area2D").get_overlapping_bodies().size() > 0:
		health = max(health - DAMAGE*delta, 0.0)
		set_opacity(health)
		if health <= 0.0:
			queue_free()

func _on_Area2D_body_enter( body ):
	health = max(health - DAMAGE, 0.0)
	set_opacity(health)
	if health <= 0.0:
		queue_free()
