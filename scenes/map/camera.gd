
extends Camera2D

onready var tween = get_node("Tween")

func _ready():
	pass

func zoom_in(player):
	tween.interpolate_property(self, "position", get_global_pos(), player.get_global_pos(), 0.5, tween.TRANS_LINEAR, tween.EASE_IN_OUT, 0.0)
	tween.interpolate_property(self, "zoom", get_zoom(), Vector2(.25, .25), 0.5, tween.TRANS_SINE, tween.EASE_IN_OUT, 0.0)
	tween.start()