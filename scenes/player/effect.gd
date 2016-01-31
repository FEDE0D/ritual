
extends Node2D

func _ready():
	pass

func set_freeze():
	get_node("sprite").set_texture(preload("res://graphics/player/FreezeShot.png"))


