
extends RigidBody2D

func _ready():
	pass

func _on_flecha_body_enter( body ):
	get_node("AnimationPlayer").play("free")
