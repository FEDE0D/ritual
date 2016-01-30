
extends RigidBody2D

const PUSH_FORCE = 500.0
const TIMER = 0.01
var time = 0.0

var free = false

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	time += delta
	if time > TIMER and not free:
		free = true
		get_node("AnimationPlayer").play("free")

func _on_flecha_body_enter( body ):
	free = true
	get_node("AnimationPlayer").play("free")
	if body.get_name().begins_with("player"):
		var pos = get_global_pos()
		var ppos = body.get_global_pos()
		var dir = (ppos - pos).normalized()
		body.set_linear_velocity(dir * PUSH_FORCE)
		body.soltar_item()
