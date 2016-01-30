
extends RigidBody2D

export(float, EASE) var ease_slow_down = 0.5

# MOVEMENT
const IMPULSE = 512.0
const MAX_SPEED = 256.0
const FRICTION = 0.87

# POWERS
const PUSH_FORCE = 1000.0
var SPEED_MULTIPLIER = 1.0

export(String) var i_left = "ui_left"
export(String) var i_right = "ui_right"
export(String) var i_up = "ui_up"
export(String) var i_down = "ui_down"
export(String) var i_action1 = "p1_action1"
export(String) var i_action2 = "p1_action2"
export(String) var i_action3 = "p1_action3"

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	# MOVEMENT
	var vel = Vector2()
	if Input.is_action_pressed(i_left):
		vel.x = -1
	if Input.is_action_pressed(i_right):
		vel.x = 1
	if Input.is_action_pressed(i_up):
		vel.y = -1
	if Input.is_action_pressed(i_down):
		vel.y = 1
	
	
	if vel != Vector2():
		apply_impulse(Vector2(), vel * IMPULSE * ease(SPEED_MULTIPLIER, ease_slow_down) * delta)
		if get_linear_velocity().length() > MAX_SPEED: 
			set_linear_velocity(get_linear_velocity().normalized() * MAX_SPEED)
	else:
		set_linear_velocity(get_linear_velocity() * FRICTION)
	

	# ACTIONS
	if Input.is_action_pressed(i_action1) and true:
		power_push()
	elif Input.is_action_pressed(i_action2) and true:
		power_slow()
	elif Input.is_action_pressed(i_action3) and true:
		print("action 3")
	
	# EFFECTS
	if SPEED_MULTIPLIER < 1.0:
		SPEED_MULTIPLIER = min(SPEED_MULTIPLIER +delta * 0.5, 1.0)
		print(SPEED_MULTIPLIER)

func power_push():
	var pos = get_global_pos()
	for c in get_node("Area2D").get_overlapping_areas():
		var ppos = c.get_global_pos()
		var dir = (ppos - pos).normalized()
		#c.get_parent().apply_impulse(Vector2(), dir * PUSH_FORCE)
		c.get_parent().set_linear_velocity(dir * PUSH_FORCE)

func power_slow():
	for c in get_node("Area2D").get_overlapping_areas():
		c.get_parent().SPEED_MULTIPLIER = 0.25