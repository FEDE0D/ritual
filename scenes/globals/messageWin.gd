
extends Control

func show_win(winner):
	get_node("Label").set_text(winner.i_prefijo)
	get_node("TextureFrame/AnimationPlayer").play("show")

func _on_Button_pressed():
	Stats.reset()
	get_tree().change_scene("res://scenes/screens/intro.scn")
