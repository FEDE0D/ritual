
extends CanvasLayer

func _ready():
	get_node("Panel").hide()

func show_timer():
	get_node("Panel").show()
	get_node("Panel/Label").start_timer()

func update_stats():
	get_node("TextureFrame").update_stats()
	get_node("TextureFrame1").update_stats()
	get_node("TextureFrame2").update_stats()
	get_node("TextureFrame3").update_stats()
