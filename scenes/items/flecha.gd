
extends RigidBody2D

const PUSH_FORCE = 500.0
var TIMER = 0.01
var time = 0.0

var es_corta = true
var empuja = false
var ralentiza = false
var vision = false

var free = false

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if es_corta:
		time += delta
		if time > TIMER and not free:
			free = true
			get_node("AnimationPlayer").play("free")

func _on_flecha_body_enter( body ):
	if body.get_name().begins_with("player"):
		body.soltar_item()
		hacer(body)
#	free = true
#	get_node("AnimationPlayer").play("free")
	queue_free()

func hacer(player):
	if empuja:
		var pos = get_global_pos()
		var ppos = player.get_global_pos()
		var dir = (ppos - pos).normalized()
		player.set_linear_velocity(dir * PUSH_FORCE)
	elif ralentiza:
		player.SPEED_MULTIPLIER = 0.0
	elif vision:
		player.target /= 2
		player.target = max(player.target, 0.5)
