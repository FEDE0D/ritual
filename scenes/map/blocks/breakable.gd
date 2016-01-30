
extends StaticBody2D

const DAMAGE = 0.35
var health = 1.0

func _ready():
	pass

func _on_Area2D_body_enter( body ):
	health = max(health - DAMAGE, 0.0)
	set_opacity(health)
	if health <= 0.0:
		queue_free()
