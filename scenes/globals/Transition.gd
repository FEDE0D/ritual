
extends CanvasLayer

func _ready():
	Globals.set("Transition", self)
	get_node("AnimationPlayer").play("fadeIn")

func fadeIn():
	get_node("AnimationPlayer").play("fadeIn")

func fadeOut():
	get_node("AnimationPlayer").play("fadeOut")

func fadeOutWhite():
	get_node("AnimationPlayer").play("fadeOutWhite")


func _on_AnimationPlayer_finished():
	if get_node("AnimationPlayer").get_current_animation().begins_with("fadeOut"):
		if Globals.get("Map").winner != null:
			if Stats.points[Globals.get("Map").winner.get_name()] >= 3: # gano WINNER
				get_node("MessageWin").show_win(Globals.get("Map").winner)
				get_node("SamplePlayer").play("Triunfo")
			else: # seguir jugando
				get_tree().change_scene("res://scenes/map/map.scn")
		else: # todos perdieron, reset
			Stats.reset()
			get_node("MessageGameOver/AnimationPlayer").play("show")
