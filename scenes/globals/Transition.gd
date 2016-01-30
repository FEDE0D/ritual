
extends Control

func _ready():
	Globals.set("Transition", self)
	show()
	get_node("AnimationPlayer").play("fadeIn")

func fadeIn():
	get_node("AnimationPlayer").play("fadeIn")

func fadeOut():
	get_node("AnimationPlayer").play("fadeOut")


func _on_AnimationPlayer_finished():
	if get_node("AnimationPlayer").get_current_animation() == "fadeOut":
		get_tree().change_scene("res://scenes/map/map.scn")
