
extends RigidBody2D

export(float, EASE) var ease_slow_down = 0.5

# MOVEMENT
const IMPULSE = 512.0
const MAX_SPEED = 256.0
const FRICTION = 0.5

const INPUT_HOLD_TIMER = 1.0
var input_hold_time = 0.0

var vel = Vector2()

# POWERS
const PUSH_FORCE = 500.0
var SPEED_MULTIPLIER = 1.0
const LIGHT_MIX_MAX = 1.5

var item = false

const GOD_TIMER = 2.0
var god_time = -2.0

export(bool) var p_light = true
export(bool) var p_push = false
export(bool) var p_slow = false
export(bool) var p_god = false

export(String) var i_left = "ui_left"
export(String) var i_right = "ui_right"
export(String) var i_up = "ui_up"
export(String) var i_down = "ui_down"
export(String) var i_action1 = "p1_action1"
export(String) var i_action2 = "p1_action2"
export(String) var i_action3 = "p1_action3"

var can_shoot = true
const SHOOT_TIMER = 0.25
var shoot_time = 0.0

const ITEM_TIMER = 1.0
var item_time = 0.0


# NODES
onready var light = get_node("Light2D")
onready var labelPower = get_node("LabelPower")

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

func post_ready():
	p_push = true
	if p_push:
		labelPower.set_text("PUSH")
	elif p_slow:
		labelPower.set_text("SLOW")
	elif p_god:
		labelPower.set_text("GOD")
	labelPower.hide()

func _fixed_process(delta):
	
	# MOVEMENT
	var vel = Vector2()
	var sprite = get_node("graphics/Sprite1")
	if not Globals.get("Map").ended and input_hold_time <= 0.0:
		if Input.is_action_pressed(i_left):
			vel.x = -1
			sprite.set_frame(1)
		elif Input.is_action_pressed(i_right):
			vel.x = 1
			sprite.set_frame(2)
		else:
			vel.x = 0
		if Input.is_action_pressed(i_up):
			vel.y = -1
			sprite.set_frame(3)
		elif Input.is_action_pressed(i_down):
			vel.y = 1
			sprite.set_frame(0)
		else:
			vel.y = 0
	
	if vel != Vector2() and SPEED_MULTIPLIER > 0.75:
		apply_impulse(Vector2(), vel * IMPULSE * ease(SPEED_MULTIPLIER, ease_slow_down) * delta)
		if get_linear_velocity().length() > MAX_SPEED: 
			set_linear_velocity(get_linear_velocity().normalized() * MAX_SPEED)
	else:
		set_linear_velocity(get_linear_velocity() * FRICTION)
	
	# ACTIONS
	if Input.is_action_pressed(i_action1) and p_light:
		power_push()
	if Input.is_action_pressed(i_action2):
		if can_shoot:
			if shoot_time <= 0:
				can_shoot = false
				shoot()
		if p_push:
			labelPower.show()
			power_push()
		elif p_slow:
			labelPower.show()
			power_slow()
		elif p_god and god_time <= -2.0:
			labelPower.show()
			power_god()
	else:
		can_shoot = true
		labelPower.hide()
	
	# EFFECTS
	# SPEED COOLDOWN
	if SPEED_MULTIPLIER < 1.0:
		SPEED_MULTIPLIER = min(SPEED_MULTIPLIER +delta * 0.5, 1.0)
		print(SPEED_MULTIPLIER)
	
	# LIGHT COOLDOWN
	if light.get_scale().x >= target and not Input.is_action_pressed(i_action3):
		light.set_scale(light.get_scale() - Vector2(1, 1)*delta*0.25)
		if light.get_scale().x < target:
			light.set_scale(Vector2(target, target))
	
	# GOD COOLDOWN
	if god_time > -2.0:
		god_time = max(god_time - delta, -2.0)
		if god_time <= 0:
			get_node("AnimationPlayer").stop(true)
			get_node("AnimationPlayer").seek(0, true)
	
	# LIGHT MIX
	var energy = 1.0
	var areas = get_node("Area2D").get_overlapping_areas()
	for c in areas:
		if c.get_name() != "Area2DWin":
			energy = c.get_parent().get_node("Light2D").get_energy()
			if energy < LIGHT_MIX_MAX:
				energy = min(energy + delta, LIGHT_MIX_MAX)
				c.get_parent().get_node("Light2D").set_energy(energy)
				light.set_energy(energy)
	energy = light.get_energy()
	if areas.size() <= 0 and energy > 1.0:
		energy = max(energy - delta, 1.0)
		light.set_energy(energy)
		
	# INPUT TIMER
	if input_hold_time > 0.0:
		input_hold_time = max(input_hold_time - delta, 0.0)
		if input_hold_time == 0:
			get_node("graphics").set_scale(Vector2(1, 1))
			get_node("AnimationPlayer").play("flash")
	
	# SHOOT TIMER
	if shoot_time > 0.0:
		shoot_time = max(shoot_time - delta, 0.0)
		
	# ITEM TIMER
	if item_time > 0.0:
		item_time = max(item_time - delta, 0.0)

func power_light():
	var scale = light.get_scale()
	if scale.x < target*2:
		light.set_scale(scale + Vector2(target*2, target*2)/60.0)
		if light.get_scale().x > target*2:
			light.set_scale(Vector2(target*2, target*2))

func power_push():
	var pos = get_global_pos()
	for c in get_node("Area2D").get_overlapping_areas():
#		#if c.p_god and c.god_time > 0.0:
#		#	return
		var ppos = c.get_global_pos()
		var dir = (ppos - pos).normalized()
		c.get_parent().set_linear_velocity(dir * PUSH_FORCE)
		c.get_parent().soltar_item()

func power_slow():
	return
	for c in get_node("Area2D").get_overlapping_areas():
		if c.has_pro("p_god") and c.p_god and c.god_time > 0.0:
			return
		if c.get_parent().get_name() != "middle":
			c.get_parent().SPEED_MULTIPLIER = 0.0

func power_god():
	god_time = GOD_TIMER
	get_node("AnimationPlayer").play("god")

func do_fall():
	input_hold_time = 1.0
	get_node("AnimationPlayer").play("fall")

func do_win():
	Globals.get("Map").win(self)

func shoot():
	shoot_time = SHOOT_TIMER
	var dir = Vector2()
	if get_node("graphics/Sprite1").get_frame() == 3:
		dir = Vector2(0, -1)
	elif get_node("graphics/Sprite1").get_frame() == 0:
		dir = Vector2(0, 1)
	elif get_node("graphics/Sprite1").get_frame() == 1:
		dir = Vector2(-1, 0)
	elif get_node("graphics/Sprite1").get_frame() == 2:
		dir = Vector2(1, 0)
		
	var f = preload("res://scenes/items/flecha_corta.scn").instance()
	if item:
		f = preload("res://scenes/items/flecha.scn").instance()
	Globals.get("Map").add_flecha(f)
	f.add_collision_exception_with(self)
	f.set_global_pos(get_global_pos() + dir*10.0)
	f.set_linear_velocity(dir * 500.0)
	f.set_rot(dir.angle()+deg2rad(90))
	print(dir)

func agarrar_item(tex):
	if input_hold_time <= 0.0:
		item = true
		get_node("graphics/item").set_texture(tex)

func soltar_item():
	if item:
		var i = preload("res://scenes/items/heart.scn").instance()
		Globals.get("Map").add_item(i)
		i.set_global_pos(get_global_pos())
		input_hold_time = INPUT_HOLD_TIMER
		get_node("AnimationPlayer").play("flash")