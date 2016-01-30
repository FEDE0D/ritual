
extends CanvasLayer

func _ready():
	get_node("Panel").hide()

func show_timer():
	get_node("Panel").show()
	get_node("Panel/Label").start_timer()
