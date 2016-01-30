
extends GridContainer


func _ready():
	for c in get_children():
		c.get_node("ButtonUp").connect("pressed", c.get_node("TextureFrame"), "up")
		c.get_node("ButtonDown").connect("pressed", c.get_node("TextureFrame"), "down")

