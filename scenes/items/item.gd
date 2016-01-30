
extends Area2D

func _ready():
	pass

func _on_item_body_enter( body ):
	if body.has_method("agarrar_item"):
		if body.agarrar_item(get_node("Sprite").get_texture()):
			queue_free()
