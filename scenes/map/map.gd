extends Node2D

export(Color) var bg_color = Color(1, 1, 1, 1)
var ended = false

func _ready():
	Globals.set("Map", self)
	set_process_input(true)
	get_tree().set_pause(false)
	
	print("SET POWERS ACCORDING TO:")
	print(Stats.points)

	Globals.get("Transition").fadeIn()
	VisualServer.set_default_clear_color(bg_color)

func win(player):
	ended = true
#	get_tree().set_pause(true)

	Stats.player_win(player)
	get_node("Camera2D").zoom_in(player)
	Globals.get("Transition").fadeOut()

func _input(event):
	if Input.is_action_pressed("fullscreen"):
		OS.set_window_fullscreen(not OS.is_window_fullscreen())
