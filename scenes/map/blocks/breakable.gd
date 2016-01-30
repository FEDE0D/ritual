
extends StaticBody2D

const DAMAGE = 0.35
var health = 1.0
var drops_item = false

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if get_node("Area2D").get_overlapping_bodies().size() > 0 and health > 0:
		health = max(health - DAMAGE*10*delta, 0.0)
		set_opacity(health)
		if health <= 0.0:
			romper()

func _on_Area2D_body_enter( body ):
	if health > 0:
		health = max(health - DAMAGE, 0.0)
		set_opacity(health)
		if health <= 0.0:
			romper()

func romper():
	BreakableSnd.play_sound()
	if drops_item:
		Globals.get("Map").item_tomado()
		BreakableSnd.play_sound_item()
	
	queue_free()


