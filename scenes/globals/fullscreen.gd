
extends Node

func _ready():
	set_process_input(true)

func _input(event):
	if Input.is_action_pressed("fullscreen"):
		OS.set_window_fullscreen(not OS.is_window_fullscreen())


