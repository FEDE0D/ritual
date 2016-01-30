
extends Control

func _ready():
	pass

func _on_Button_pressed():
	Stats.reset()
	get_tree().change_scene("res://scenes/screens/intro.scn")
