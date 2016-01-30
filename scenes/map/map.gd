extends Node2D

var ended = false

func _ready():
	Globals.set("Map", self)
	set_process_input(true)
	get_tree().set_pause(false)
	
	print("SET POWERS ACCORDING TO:")
	print(Stats.points)

	Globals.get("Transition").fadeIn()

func win(player):
	ended = true
#	get_tree().set_pause(true)
	Stats.player_win(player)
	Globals.get("Transition").fadeOut()

func _input(event):
	if Input.is_action_pressed("fullscreen"):
		OS.set_window_fullscreen(not OS.is_window_fullscreen())
