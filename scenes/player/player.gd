
extends RigidBody2D

export(float, EASE) var ease_slow_down = 0.5

# MOVEMENT
const IMPULSE = 512.0
const MAX_SPEED = 128.0
const FRICTION = 0.5

# POWERS
const PUSH_FORCE = 500.0
var SPEED_MULTIPLIER = 1.0

export(String) var i_left = "ui_left"
export(String) var i_right = "ui_right"
export(String) var i_up = "ui_up"
export(String) var i_down = "ui_down"
export(String) var i_action1 = "p1_action1"
export(String) var i_action2 = "p1_action2"
export(String) var i_action3 = "p1_action3"

# NODES
onready var light = get_node("Light2D")

# LEVEL
onready var points = Stats.points[get_name()]
var target = 0

func _ready():
	set_fixed_process(true)
	if points == 0:
		target = 1
	elif points == 1:
		target = 0.75
	elif points >= 2:
		target = 0.5
	target *= 0.5
	light.set_scale(Vector2(target, target))

func _fixed_process(delta):
	
	# MOVEMENT
	var vel = Vector2()
	var sprite = get_node("graphics/Sprite1")
	if not Globals.get("Map").ended:
		if Input.is_action_pressed(i_left):
			vel.x = -1
			sprite.set_frame(1)
		if Input.is_action_pressed(i_right):
			vel.x = 1
			sprite.set_frame(2)
		if Input.is_action_pressed(i_up):
			vel.y = -1
			sprite.set_frame(3)
		if Input.is_action_pressed(i_down):
			vel.y = 1
			sprite.set_frame(0)
	
	if vel != Vector2() and SPEED_MULTIPLIER > 0.75:
		apply_impulse(Vector2(), vel * IMPULSE * ease(SPEED_MULTIPLIER, ease_slow_down) * delta)
		if get_linear_velocity().length() > MAX_SPEED: 
			set_linear_velocity(get_linear_velocity().normalized() * MAX_SPEED)
	else:
		set_linear_velocity(get_linear_velocity() * FRICTION)
	
	# ACTIONS
	if Input.is_action_pressed(i_action1) and Stats.points[get_name()]>=0:
		power_push()
	elif Input.is_action_pressed(i_action2) and Stats.points[get_name()]>1:
		power_slow()
	elif Input.is_action_pressed(i_action3) and true:
		power_light()
	
	# EFFECTS
	# SPEED COOLDOWN
	if SPEED_MULTIPLIER < 1.0:
		SPEED_MULTIPLIER = min(SPEED_MULTIPLIER +delta * 0.5, 1.0)
		print(SPEED_MULTIPLIER)
	
	# LIGHT COOLDOWN
	if light.get_scale().x >= target and not Input.is_action_pressed(i_action3):
		light.set_scale(light.get_scale() - Vector2(1, 1)*delta)
		if light.get_scale().x < target:
			light.set_scale(Vector2(target, target))
	
	# LIGHT MIX
	var energy = 1.0
	var areas = get_node("Area2D").get_overlapping_areas()
	for c in areas:
		if c.get_name() != "Area2DWin":
			energy = c.get_parent().get_node("Light2D").get_energy()
			if energy < 2.0:
				energy = min(energy + delta, 2.0)
				c.get_parent().get_node("Light2D").set_energy(energy)
				light.set_energy(energy)
	energy = light.get_energy()
	if areas.size() <= 0 and energy > 1.0:
		energy = max(energy - delta, 1.0)
		light.set_energy(energy)
	

func power_push():
	var pos = get_global_pos()
	for c in get_node("Area2D").get_overlapping_areas():
		var ppos = c.get_global_pos()
		var dir = (ppos - pos).normalized()
		c.get_parent().set_linear_velocity(dir * PUSH_FORCE)

func power_slow():
	for c in get_node("Area2D").get_overlapping_areas():
		if c.get_parent().get_name() != "middle":
			c.get_parent().SPEED_MULTIPLIER = 0.0

func power_light():
	var scale = light.get_scale()
	if scale.x < target*2:
		light.set_scale(scale + Vector2(target*2, target*2)/60.0)
		if light.get_scale().x > target*2:
			light.set_scale(Vector2(target*2, target*2))

func do_win():
	Globals.get("Map").win(self)
