
extends Node2D

const SPEED = 10000.0

func _ready():
	pass

func _on_Area2D_body_enter( body ):
#	body.do_win()
	
	var pos = get_global_pos()
	for c in get_node("Area2DWin").get_overlapping_areas():
		if c.get_parent() == body:
			continue
		var ppos = c.get_global_pos()
		var dir = (ppos - pos).normalized()
		c.get_parent().apply_impulse(Vector2(), dir * SPEED)
		c.get_parent().set_linear_velocity(dir * 1000.0)
		print(dir * SPEED)

func turn_on_light(l):
	for i in range(0, l):
		get_node("lights").get_child(i).show()
		get_node("particles").get_child(i).set_emitting(true)